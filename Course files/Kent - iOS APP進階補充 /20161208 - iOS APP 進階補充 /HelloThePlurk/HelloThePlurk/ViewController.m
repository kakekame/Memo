//
//  ViewController.m
//  HelloThePlurk
//
//  Created by Kent Liu on 2015/9/9.
//  Copyright (c) 2015年 Kent Liu. All rights reserved.
//

#import "ViewController.h"

#define PLURK_API_KEY @"uE5WO7i2ORKH8qJE7gLcMKSBUOthrhbR"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicatorView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginBtnPressed:(id)sender {
    
    NSString *login = _loginTextField.text;
    NSString *password = _passwordTextField.text;
    
    NSString *urlString=[NSString stringWithFormat:@"https://www.plurk.com/API/Users/login?api_key=%@&username=%@&password=%@",PLURK_API_KEY,login,password];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    // Prepare NSURLSession
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    [_loadingIndicatorView startAnimating];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error)
        {
            NSLog(@"Error: %@",error.description);
        }
        else
        {
            NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"JSON: %@",content);
            
            // Parse JSON
            NSDictionary *datas = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSDictionary *userInfo = datas[@"user_info"];
            NSNumber *karma = userInfo[@"karma"];
            
            NSString *message = nil;
            if(datas[@"error_text"] != nil)
            {
                message = datas[@"error_text"];
            }
            else
            {
                message = @"Login Successfully.";
            }
            
            // Show Result to User with UI Queue/Thread.
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                [_loadingIndicatorView stopAnimating];
                
                NSString *karmaString = [NSString stringWithFormat:@"Karma: %f",karma.doubleValue];
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:karmaString message:message preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:ok];
                [self presentViewController:alert animated:true completion:nil];
                
            });
            // ...
            
        }
        
    }];
    
    [task resume];
    
    
}
- (IBAction)publishBtnPressed:(id)sender {
    
    
    NSString *content = _contentTextField.text;
    
//    NSString *encodedContent = [content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *encodedContent = [content stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSLog(@"%@ ===> %@",content,encodedContent);
    
    NSString *urlString=[NSString stringWithFormat:@"http://www.plurk.com/API/Timeline/plurkAdd?api_key=%@&content=%@&qualifier=shares&lang=tr_ch",PLURK_API_KEY,encodedContent];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    // Prepare NSURLSession
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    [_loadingIndicatorView startAnimating];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error)
        {
            NSLog(@"Error: %@",error.description);
        }
        else
        {
            NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"JSON: %@",content);
            
            // Parse JSON
            NSDictionary *datas = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
//            NSDictionary *userInfo = datas[@"user_info"];
//            NSNumber *karma = userInfo[@"karma"];
            
            NSString *message = nil;
            if(datas[@"error_text"] != nil)
            {
                message = datas[@"error_text"];
            }
            else
            {
                message = @"Publish Successfully.";
            }
            
            // Show Result to User with UI Queue/Thread.
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                [_loadingIndicatorView stopAnimating];
                
//                NSString *karmaString = [NSString stringWithFormat:@"Karma: %f",karma.doubleValue];
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Publish" message:message preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:ok];
                [self presentViewController:alert animated:true completion:nil];
                
            });
            // ...
            
        }
        
    }];
    
    [task resume];
    
    
    
}

@end




