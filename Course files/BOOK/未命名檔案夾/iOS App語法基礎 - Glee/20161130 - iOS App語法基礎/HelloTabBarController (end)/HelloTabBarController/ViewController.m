//
//  ViewController.m
//  HelloTabBarController
//
//  Created by XueXin Tsai on 2016/11/30.
//  Copyright © 2016年 XueXin Tsai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property NSArray * abcde;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.abcde = @[@"1",@"2",@"3",@"4",@"5"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
