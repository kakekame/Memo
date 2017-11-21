//
//  Player.h
//  Playground
//
//  Created by XueXin Tsai on 2016/11/9.
//  Copyright © 2016年 XueXin Tsai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
@property int hp;//玩家的生命值
@property int xp;//玩家的經驗值
@property NSArray * skills; //技能樹

//發動技能的方法，會帶入要發動的技能名稱

-(void)perform:(NSString*)skill;
@end
