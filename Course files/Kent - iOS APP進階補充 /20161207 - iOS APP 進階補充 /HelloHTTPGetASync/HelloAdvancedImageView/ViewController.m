//
//  ViewController.m
//  HelloAdvancedImageView
//
//  Created by Kent Liu on 2016/3/8.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import "ViewController.h"
#import "AdvancedImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AdvancedImageView *imageView1 = [[AdvancedImageView alloc] initWithFrame:CGRectMake(0, 50, 200, 200)];
    [imageView1 loadImageWithURL:[NSURL URLWithString:@"https://dl.dropbox.com/u/12116609/00_KentClass/Cat14MP.JPG"]];
    [self.view addSubview:imageView1];
    
    AdvancedImageView *imageView2 = [[AdvancedImageView alloc] initWithFrame:CGRectMake(0, 300, 200, 200)];
    [imageView2 loadImageWithURL:[NSURL URLWithString:@"https://dl.dropbox.com/u/12116609/00_KentClass/Cat-on-the-chair.jpg"]];
    [self.view addSubview:imageView2];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
