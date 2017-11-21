//
//  NewsItem.h
//  HelloRSSReader
//
//  Created by Kent Liu on 2016/3/9.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *pubDate;
@property (nonatomic,strong) NSString *link;

@end




