//
//  MyTableViewCell.h
//  HelloImageTableView
//
//  Created by XueXin Tsai on 2016/11/30.
//  Copyright © 2016年 XueXin Tsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *imageTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@end
