//
//  ImageViewController.h
//  HelloImageTableView
//
//  Created by XueXin Tsai on 2016/11/30.
//  Copyright © 2016年 XueXin Tsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController
@property NSString * imageFileName;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
