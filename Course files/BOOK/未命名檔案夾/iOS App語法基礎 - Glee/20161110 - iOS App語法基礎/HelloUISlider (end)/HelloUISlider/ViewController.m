//
//  ViewController.m
//  HelloUISlider
//
//  Created by XueXin Tsai on 2016/11/10.
//  Copyright © 2016年 XueXin Tsai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)choosenColor:(UISlider *)sender {
    if (sender == self.redSlider) {
        NSLog(@"紅色被動了");
    } else if(sender == self.greenSlider) {
        NSLog(@"綠色被動了");
    } else {
        NSLog(@"藍色被動了");
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
