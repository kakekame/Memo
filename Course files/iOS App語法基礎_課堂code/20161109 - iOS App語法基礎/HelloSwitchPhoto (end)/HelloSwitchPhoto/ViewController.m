//
//  ViewController.m
//  HelloSwitchPhoto
//
//  Created by XueXin Tsai on 2016/11/9.
//  Copyright © 2016年 XueXin Tsai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)sydney:(UIButton *)sender {
    UIImage * aImage = [UIImage imageNamed:@"sydney.jpg"];
    self.imageView.image = aImage;
    //設定填入照片的模式
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}
- (IBAction)tokyo:(UIButton *)sender {
    UIImage * aImage = [UIImage imageNamed:@"nyc.jpg"];
    self.imageView.image = aImage;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
