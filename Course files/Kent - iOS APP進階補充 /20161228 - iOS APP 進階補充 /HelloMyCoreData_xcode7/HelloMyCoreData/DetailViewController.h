//
//  DetailViewController.h
//  HelloMyCoreData
//
//  Created by Kent Liu on 2016/6/29.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

