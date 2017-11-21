//
//  Playground.m
//  Playground
//
//  Created by XueXin Tsai on 2016/10/27.
//  Copyright © 2016年 XueXin Tsai. All rights reserved.
//

#import "Playground.h"
#import "Player.h"
@implementation Playground
-(void)start{       //若要在此收到結果, 見圖. 回傳可以進行運算更多結果
    
    NSLog(@"hello");
    NSLog(@"你好");
    
    Player * Elaine = [[Player alloc] init];    //宣告Elaine物件種類
    Elaine.hp = 1000;           //輸入物件資料
    Elaine.xp = 2000;
    Elaine.skill = @[@"FIREBALL", @"FREEZEN", @"RUN"];
    
    [Elaine perform:@"FIREBALL"];       //藉由輸入字串啟動內容
    
    Player * Clara = [[Player alloc]init];
    Clara.hp = 500;
    Clara.xp = 200;
    Clara.skill = @[@"Flying",@"Swim", @"Climb"];
    
    
    
    [self sayHello];

}

-(void) calBMIWithHeight:(int)height    //height, weight 皆為區域變數
                   heavy:(int)weight{
    double b = weight/pow(height/100.0,2);  //pow(x,y) 求x的y次方, 運算用到小數點, 會讓算的結果變成浮點數

 
    
    
    
}


-(void) sayHello{
    NSLog(@"你好, 午安");






}


@end
