//
//  DetailViewController.h
//  HelloCoreDataManager
//
//  Created by Kent Liu on 2016/10/5.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

