//
//  RSSParserDelegate.h
//  HelloRSSReader
//
//  Created by Kent Liu on 2016/3/9.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsItem.h"


@interface RSSParserDelegate : NSObject <NSXMLParserDelegate>


- (NSArray*) getResults;

@end
