//
//  Playground.m
//  Playground
//
//  Created by XueXin Tsai on 2016/10/27.
//  Copyright © 2016年 XueXin Tsai. All rights reserved.
//

#import "Playground.h"

@implementation Playground
-(void)start {
    [self ppppp:@{@"咖啡":@5,@"飲料":@3}];
}


-(void)ppppp:(NSDictionary*)request{
    NSDictionary * menu = @{@"飲料":@30,@"咖啡":@65,@"水":@20};
    for (NSString * key in request.allKeys) {
        NSNumber * a = request[key];
        NSNumber * price = menu[key];
        NSLog(@"%@",a);
    }
}
@end
