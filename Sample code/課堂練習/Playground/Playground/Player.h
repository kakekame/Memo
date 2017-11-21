//
//  Player.h
//  Playground
//
//  Created by Elaine on 2016/12/12.
//  Copyright © 2016年 XueXin Tsai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
@property int hp; //玩家生命值
@property int xp; //玩家經驗值
@property NSArray * skill; //技能樹

//發動技能的方法, 帶入要發動的技能名稱
-(void)perform:(NSString*)skill;    //撰寫物件使用方法,不用大括弧, 不寫程式碼內容,內容可以保密寫在.m

@end
