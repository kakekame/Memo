//
//  ViewController.m
//  HelloAlertController
//
//  Created by 123APP on 2016/11/21.
//  Copyright © 2016年 com.glee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)notifyWithoutTextField:(UIButton *)sender {
    // 準備警告視窗
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"注意！" message:@"今天會有地震" preferredStyle:UIAlertControllerStyleAlert];
    // 準備警告視窗上面的按鈕
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"使用者按下了取消鍵");
    }];
    // 準備警告視窗上的確認鍵
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"使用者按下了確認鍵");
    }];
    // 將按鈕加到警告視窗上
    [alert addAction:cancel];
    [alert addAction:confirm];
    // 顯示警告視窗
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)notifyWithTextField:(UIButton *)sender {
    // 準備警告視窗
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"注意！" message:@"請輸入帳號密碼以繼續動作" preferredStyle:UIAlertControllerStyleAlert];
    //** 在警告視窗上加入文字框做為帳號
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull usernameTextField) {
        usernameTextField.placeholder = @"請輸入帳號";
    }];
    //** 在警告視窗上加入第二個文字框做為密碼
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull passwordTextField) {
        // 保護使用者輸入的文字，不被旁人偷看
        passwordTextField.secureTextEntry = YES;
        // 預留文字
        passwordTextField.placeholder = @"請輸入密碼";
    }];

    // 準備警告視窗上面的按鈕
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"使用者按下了取消鍵");
    }];
    // 準備警告視窗上的確認鍵
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"使用者按下了確認鍵");
        // 拿取使用者在警告視窗上所輸入的文字
        // 首先，先取得帳號文字框
        UITextField * usernameField = alert.textFields[0];
        // 也拿到密碼文字框
        UITextField * pwdField = alert.textFields[1];
        // 將帳號文字框中的文字取出
        NSString * username = usernameField.text;
        // 將密碼文字框內的文字取出
        NSString * password = pwdField.text;
        // 印出結果
        NSLog(@"使用者輸入的帳號是:%@，密碼是:%@",username,password);
    }];
    // 將按鈕加到警告視窗上
    [alert addAction:cancel];
    [alert addAction:confirm];
    // 顯示警告視窗
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
