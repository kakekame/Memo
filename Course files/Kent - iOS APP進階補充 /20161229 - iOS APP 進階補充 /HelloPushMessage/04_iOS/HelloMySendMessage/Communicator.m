//
//  Communicator.m
//  HelloMySendMessage
//
//  Created by Kent Liu on 2016/6/17.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import "Communicator.h"
#import <AFNetworking.h>

#define BASE_URL @"http://class.softarts.cc/PushMessage"

#define SENDMESSAGE_URL [BASE_URL stringByAppendingPathComponent:@"sendMessage.php"]

#define SENDPHOTOMESSAGE_URL [BASE_URL stringByAppendingPathComponent:@"sendPhotoMessage.php"]

#define RETRIVEMESSAGES_URL [BASE_URL stringByAppendingPathComponent:@"retriveMessages2.php"]

#define UPDATEDEVICETOKEN_URL [BASE_URL stringByAppendingPathComponent:@"updateDeviceToken.php"]

#define PHOTOS_BASE_URL [BASE_URL stringByAppendingPathComponent:@"photos/"]


@implementation Communicator

static Communicator *_singletonCommunicator = nil;

+ (instancetype) sharedInstance {
    
    if(_singletonCommunicator == nil) {
        _singletonCommunicator = [Communicator new];
    }
    
    return _singletonCommunicator;
}

- (void) updateDeviceToken:(NSString*) deviceToken
                completion:(DoneHandler) doneHandler {
    
    NSDictionary *jsonObj = @{USER_NAME_KEY:MY_NAME,DEVICETOKEN_KEY:deviceToken,GROUP_NAME_KEY:GROUP_NAME};
    
    [self doPost:UPDATEDEVICETOKEN_URL
      parameters:jsonObj
      completion:doneHandler];
}

- (void) sendTextMessage:(NSString*) message
              completion:(DoneHandler) doneHandler {
    NSDictionary *jsonObj = @{USER_NAME_KEY:MY_NAME,MESSAGE_KEY:message,GROUP_NAME_KEY:GROUP_NAME};
    
    [self doPost:SENDMESSAGE_URL
      parameters:jsonObj
      completion:doneHandler];
}

- (void) retriveMessagesWithLastMessageID:(NSInteger) lastMessageID completion:(DoneHandler) doneHandler {
    NSDictionary *jsonObj = @{LAST_MESSAGE_ID_KEY:@(lastMessageID),GROUP_NAME_KEY:GROUP_NAME};
    
//    @(lastMessageID) ==> Convert to NSNumber
//    [NSNumber numberWithInt:lastMessageID];
    
    [self doPost:RETRIVEMESSAGES_URL
      parameters:jsonObj
      completion:doneHandler];
}

- (void) downloadPhotoWithFileName:(NSString*) fileName
                        completion:(DoneHandler) doneHandler {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"image/jpeg"];
    NSString *finalPhotoURLString = [PHOTOS_BASE_URL stringByAppendingPathComponent:fileName];
    [manager GET:finalPhotoURLString
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"Download OK: %ld bytes",[responseObject length]);
             doneHandler(nil,responseObject);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Download Fail: %@",error);
             doneHandler(error,nil);
         }];
}

- (void) sendPhotoMessageWithData:(NSData*)data
                       completion:(DoneHandler) doneHandler {
    NSDictionary *jsonObj = @{USER_NAME_KEY:MY_NAME,GROUP_NAME_KEY:GROUP_NAME};
    
    [self doPost:SENDPHOTOMESSAGE_URL
      parameters:jsonObj
            data:data
      completion:doneHandler];
}


#pragma mark - Shared Methods

- (void) doPost:(NSString*) urlString
     parameters:(NSDictionary*) parameters
           data:(NSData*) data
     completion:(DoneHandler) doneHandler {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // change parameters to format: "data=..."
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    // Hard code
    NSDictionary *finalParameters = @{DATA_KEY:jsonString};
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:urlString
       parameters:finalParameters
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
        [formData appendPartWithFileData:data
                                    name:@"fileToUpload"
                                fileName:@"image.jpg"
                                mimeType:@"image/jpg"];
    
            }
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              NSLog(@"do Upload Photo OK Result: %@",responseObject);
              doneHandler(nil,responseObject);
        
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              
              NSLog(@"do Upload Error: %@",error);
              doneHandler(error,nil);
        
          }];
    
}


- (void) doPost:(NSString*) urlString
     parameters:(NSDictionary*)parameters
     completion:(DoneHandler) doneHandler {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // change parameters to format: "data=..."
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    // Hard code
    NSDictionary *finalParameters = @{DATA_KEY:jsonString};
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:urlString
       parameters:finalParameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
              NSLog(@"doPOST OK Result: %@",responseObject);
              doneHandler(nil,responseObject);
              
         }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              
              NSLog(@"doPOST Error: %@",error);
              doneHandler(error,nil);
             
         }
     ];
    
}

@end











