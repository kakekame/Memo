//
//  ViewController.m
//  HelloObjCWithSwift
//
//  Created by Kent Liu on 2015/2/8.
//  Copyright (c) 2015年 Kent Liu. All rights reserved.
//

#import "ViewController.h"

#import "HelloObjCWithSwift-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    MySwiftClass *swiftObj=[[MySwiftClass alloc] init];
    
    NSString *result = [swiftObj sayHello];
    
    NSDate *resultDate = swiftObj.date;
    
    NSLog(@"%@ - %@",result,[resultDate description]);
    
    // Show message
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[resultDate description] message:result preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [alert dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
