//
//  ViewController.m
//  HelloMySendMessage
//
//  Created by Kent Liu on 2016/6/17.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import "ViewController.h"
#import "Communicator.h"
#import "AppDelegate.h"
#import "ChattingView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ChatLogManager.h"

@interface ViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    Communicator *comm;
    
    NSMutableArray *incomingMessages;
    NSInteger lastMessageID;
    ChatLogManager *logManager;
    
    BOOL isRefreshing;
    BOOL shouldRefreshAgain;
    
}
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet ChattingView *chattingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    incomingMessages = [NSMutableArray new];
    logManager = [ChatLogManager new];
    
    comm = [Communicator sharedInstance];
    
    // Listen to the notification: DID_RECEIVED_REMOTE_NOTIFICATION
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doRefreshWithInfo:) name:DID_RECEIVED_REMOTE_NOTIFICATION object:nil];
    
    // Load lastMessageID from NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    lastMessageID = [defaults integerForKey:LAST_MESSAGE_ID_KEY];
    if(lastMessageID == 0) {
        lastMessageID = 1;
    }
    // For test only
//    lastMessageID = 1;

    _chattingView.backgroundColor =
    [UIColor colorWithRed:37.0/255.0 green:174.0/255.0 blue:230.0/255.0 alpha:1.0];
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    static dispatch_once_t showLatestMessagesToken;
    
    static dispatch_once_t onceToken;
    dispatch_once(&showLatestMessagesToken, ^{
        // Show latest log
        NSInteger totalCount = [logManager getTotalCount];
        NSInteger startIndex = totalCount - 20;
        if(startIndex < 0) {
            startIndex = 0;
        }
        for(NSInteger i = startIndex;i < totalCount;i++) {
            NSDictionary *tmpMessage = [logManager getMessageByIndex:i];
            [incomingMessages addObject:tmpMessage];
        }
        [self handleIncomingMessages:false];
    });
    
    // Download when VC is launched.
    [self doRefresh];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendTextBtnPressed:(id)sender {
    
    if(_inputTextField.text.length == 0) {
        return;
    }
    [_inputTextField resignFirstResponder];
    
    [comm sendTextMessage:_inputTextField.text
               completion:
     ^(NSError *error, id result) {
        
         if(error) {
             NSLog(@"* Error occur: %@",error);
             // Show Error Message to User...
         } else {
             // Download and Refresh
             [self doRefresh];
         }
         
    }];
    
}
- (IBAction)sendPhotoBtnPressed:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Choose Image Source" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self launchImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *library = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self launchImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:camera];
    [alert addAction:library];
    [alert addAction:cancel];
    [self presentViewController:alert animated:true completion:nil];
}
- (IBAction)refreshBtnPressed:(id)sender {
    
    [self doRefresh];
    
}
- (void) launchImagePickerWithSourceType:(UIImagePickerControllerSourceType) sourceType {
    
    if([UIImagePickerController isSourceTypeAvailable:sourceType] == false) {
        NSLog(@"Invalid Source Type.");
        return;
    }
    
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.sourceType = sourceType;
//    imagePicker.mediaTypes = @[@"public.image",@"public.movie"];
    imagePicker.mediaTypes = @[(NSString*)kUTTypeImage/*,(NSString*)kUTTypeMovie*/];
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:true completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    if([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
     
        UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
        
        UIImage *resizedImage = [self resizeWithImage:originalImage];
        
        NSData *imageData = UIImageJPEGRepresentation(resizedImage, 0.7);
        NSLog(@"Image Size: %f x %f,File Size: %ld",resizedImage.size.width,resizedImage.size.height,(long)imageData.length);
        
        [comm sendPhotoMessageWithData:imageData completion:^(NSError *error, id result) {
            if(error) {
                NSLog(@"* Error occur: %@",error);
                // Show Error Message to User...
            } else {
                // Download and Refresh
                [self doRefresh];
            }
        }];

    }
    [picker dismissViewControllerAnimated:true completion:nil];
}

- (UIImage*) resizeWithImage:(UIImage*) srcImage {
    
    CGFloat maxLength = 1024.0;

    
    CGSize targetSize;
    
    // No need to resize. Use original image.
    if(srcImage.size.width <= maxLength
       && srcImage.size.height <= maxLength) {
        targetSize = srcImage.size;
    } else {
        // Adjust the size
        if(srcImage.size.width >= srcImage.size.height) {
            CGFloat ratio = srcImage.size.width / maxLength;
            targetSize = CGSizeMake(maxLength, srcImage.size.height/ratio);
        } else {
            CGFloat ratio = srcImage.size.height / maxLength;
            targetSize = CGSizeMake(srcImage.size.width/ratio, maxLength);
        }
    }

    // Resize the srcImage as targetSize
    UIGraphicsBeginImageContext(targetSize);
    [srcImage drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    
    // Draw Frame
    UIImage *frameImage = [UIImage imageNamed:@"frame_01.png"];
    [frameImage drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

- (void) doRefreshWithInfo:(NSNotification*)notify {
    
//    NSDictionary *userInfo = notify.object;
    
    [self doRefresh];
}


- (void) doRefresh {
    
    if(isRefreshing == false) {
        isRefreshing = true;
    } else {
        shouldRefreshAgain = true;
        return;
    }
        
    
    
    [comm retriveMessagesWithLastMessageID:lastMessageID completion:^(NSError *error, id result) {
       
        if(error) {
            NSLog(@"* Error occur: %@",error);
            // Show Error Message to User...
            isRefreshing = false;
        } else {
            
            // Handle incoming messages.
            NSArray *messages = result[MESSAGES_KEY];
            
            if(messages.count == 0) {
                NSLog(@"No new message,then do nothing.");
                isRefreshing = false;
                return;
            }
            
            // Keep lastMessageID
            NSDictionary *lastMessage = messages.lastObject;
            lastMessageID = [lastMessage[ID_KEY] integerValue];
            
            // Save lastMessageID to NSUserDefault
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setInteger:lastMessageID forKey:LAST_MESSAGE_ID_KEY];
            [defaults synchronize];
            
            [incomingMessages addObjectsFromArray:messages];
            
            [self handleIncomingMessages:true];
        }
    }];
}

- (void) handleIncomingMessages:(BOOL)shouldSaveToLog {
    
    if(incomingMessages.count == 0) {
        isRefreshing = false;
        
        if(shouldRefreshAgain) {
            shouldRefreshAgain = false;
            [self doRefresh];
        }
        
        return;
    }
    
    NSDictionary *tmpMessage = incomingMessages.firstObject;
    [incomingMessages removeObjectAtIndex:0];
    
    // Add to logManager
    if(shouldSaveToLog) {
        [logManager addChatLog:tmpMessage];
    }
    
    NSInteger messageID = [tmpMessage[ID_KEY] integerValue];
    NSInteger messageType = [tmpMessage[TYPE_KEY] integerValue];
    NSString *senderName = tmpMessage[USER_NAME_KEY];
    NSString *message = tmpMessage[MESSAGE_KEY];
    if(messageType == 0) {
        // Text
        NSString *displayMessage = [NSString stringWithFormat:@"%@: %@ (%ld)",senderName,message,messageID];
        
        // Decide it is fromOthers or fromMe
        ChattingItem *item = [ChattingItem new];
        item.text = displayMessage;
        if([senderName isEqualToString:MY_NAME]) {
            item.type = fromMe;
        } else {
            item.type = fromOthers;
        }
        [_chattingView addChattingItem:item];
        // Move to next message
        [self handleIncomingMessages:shouldSaveToLog];
        
    } else {
        // Image
        
        UIImage *image = [ChatLogManager loadPhotoWithFileName:message];
        
        if(image != nil) {
            // Photo is cached,use it directly.
            NSString *displayMessage = [NSString stringWithFormat:@"%@: %@ (%ld)",senderName,message,messageID];
            [self addChatItemWithMessage:displayMessage
                                   image:image
                                  sender:senderName];
            
            [self handleIncomingMessages:shouldSaveToLog];
        } else {
            // Need to load from server.
            [comm downloadPhotoWithFileName:message completion:^(NSError *error, id result) {
                
                if(error) {
                    NSLog(@"* Error occur: %@",error);
                    // Show Error Message to User...
                } else {
                    NSString *displayMessage = [NSString stringWithFormat:@"%@: %@ (%ld)",senderName,message,messageID];
                    
                    [self addChatItemWithMessage:displayMessage
                                           image:[UIImage imageWithData:result]
                                          sender:senderName];
                    // Save Image as a cached file
                    [ChatLogManager savePhotoWithFileName:message data:result];
                    
                    
                }
                // Move to next message
                [self handleIncomingMessages:shouldSaveToLog];
            }];
        }
        
        
    }
}

- (void) addChatItemWithMessage:(NSString*)message image:(UIImage*) image sender:(NSString*) senderName {
    // Decide it is fromOthers or fromMe
    ChattingItem *item = [ChattingItem new];
    item.text = message;
    if([senderName isEqualToString:MY_NAME]) {
        item.type = fromMe;
    } else {
        item.type = fromOthers;
    }
    item.image = image;
    [_chattingView addChattingItem:item];
}


@end











