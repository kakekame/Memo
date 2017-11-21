//
//  Player.m
//  Playground
//
//  Created by Elaine on 2016/12/12.
//  Copyright © 2016年 XueXin Tsai. All rights reserved.
//

#import "Player.h"

@implementation Player
-(void)perform:(NSString *)skill{ //直接說入-perform會出現選項可快速進入
    //檢查receiver 身上是否有遇發動的技能名稱
    if([self.skill containsObject:skill]){
        //發動技能
        NSLog(@"Enhance %@",skill);
    }
    else{
        //如果沒有,提示找不到技能
        NSLog(@"尚未習得這項技能");
    }
}

@end
