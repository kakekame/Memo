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
    NSLog(@"hello");
    [self carNum:4];
    [self carNum:9];
    [self carNum:51];
}

int car = 0;
int passenger =0;
int carNum=0;
-(void)carNum:(int)passNum{
    if (passenger%4==0) {
        car = passenger/4;
    }
    else{car = passenger/4+1;};
}


@end
