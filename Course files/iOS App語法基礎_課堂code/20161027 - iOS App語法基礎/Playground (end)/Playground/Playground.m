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
    // Practice 3
    double applePrice= 30.0;
    double ipodPrice= 12000.0;
    double cookiePrice= 70.0;
    double ipodTax= 0.085;
    double cookieTax= 0.05;
    double appleCount= 20;
    double cookieCount= 10.0;
    double ipodCount= 5.0;
    double apple= applePrice*appleCount;
    double cookie= cookieCount*cookiePrice*(1+cookieTax);
    double ipod= ipodPrice*ipodCount*(1+ipodTax);
    double total= apple+cookie+ipod;
    
    NSLog(@"%lf",total);
    
    //Practice 1
    double length= 100.0;
    double weidth=200.0;
    double area= length*weidth*0.3025;
    
    NSLog(@"%lf",area);
    
    
    //Practice 4
    
    double priceFrist= 100000.0;
    double interestRate= 1.08;
    double year= 6;
    double priceLast= priceFrist*pow(interestRate, year);
    
    NSLog(@"%lf", priceLast);
    
    
    //Practice 5
    double x= pow(9.0,2);
    double y= pow(1.0,2);
    double distance= sqrt(x+y);
    
    NSLog(@"%lf", distance);
    
    
    //practice 2
    
    int car=0;
    int passenger=0;
    
    if(passenger==4){
        car=passenger/4;
    }
    if(passenger==9){
        car=passenger/9+1;
    }
    if(passenger==51){
        car=passenger/4+1;
    }
    //        if(passenger%4==0){
    //            car= passenger/4;
    //        }
    //        else{
    //            car= passenger/4+1;}
    
    // practice 9
    
    int checkAge= 0;
    -(bool)checkAge:(int)checkage{
        if checkAge> 18{
            return YES;}
        else{
            return NO;}
    }
    
    bool result=[self checkAge:19];
    
    
    // practice 10
    
    
    -(double)toC:(double)tmpF{
        double tmpC=(tmpF-32)*50.0/90.0;
        return tmpC;
    }
    
    double result= [self tmpF:100];
    
    // practice (1101 AP10401)
    
    -(double)bacWithAlcohol:(int) gender:(bool)isBoy heavy:(double)weight hour:(double)time{
        double waterPercentage=0.0;
        if (isBoy==YES){
            waterPercentage= 0.58;
            deAlcohol= 0.015;
        }else{
            waterPercentage=0.49;
            deAlcohol= 0.017;
        }
        return (0.806*alcohol*1.2)/(waterPercentage*weight)-(deAlcohol*time);
    }
    
    //practice 6
    
    int i= 0
    while(i<101){
        i++;
    }
    
    //practice 7  ->> ask
    
    for(x=0, x<101, x++){
        x= x+1;
    }
    
    
    //practice 8  ->>ask
    
    
    
    
    
    //practice 16
    NSArray* numb = @[@50,@70,@80,@66,@15,@91,@100];
    // NSNumber*foo = @10 -> OJC數字物件生產
    int totalArray= 0;
    for(int i=0; i<numb count;i++){
        NSNumber*a=numbers[i];
        int b=[a intValue];
        totalArray=totalArray+b;
    }
    //方法2
    int totalArray2= 0;
    for(NSNumber*a in numbrs){
        int b=[a intValue];
        totalArray2 = totalArray2+b;
    }
    
    //practice 17
    
    NSArray*name1 = @[@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸"];
    NSArray*name2 = @[@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥"];
    for(NSString*a in name1){
        for(NSString*b in name2);
        NSString*result= [a StringByAppendingString:b];
    }
    NSLog(@"%@",result);
    
    //practice 12
    
    NSString*password = @[];
    
    -(bool)checkPassword:(NSString)password{
        if([password.length]>8||[password containsString:@"&"]){
            return ture;}
        else if([password.length]>8||[password containsString:@"*"]){
            return ture;}
        else if([password.length]>8||[password containsString:@"#"]){
            return ture;}
        else if([password.length]>8||[password containsString:@"$"]){
            return ture;}
        else if([password.length]>8||[password containsString:@"~"]){
            return ture;}
        else {
            return false;
        }
    }
    
    //practice 13
    
    NSString*nameList = @[];
    int namescount = [nameList count];
    -(NSString*)choiceLuckyOne:(int)luckyNumber{
        int luckynumber= arc4random_uniform(namescount);
        NSstring luckyOne = nameList[luckynumber];
        return luckyOne;
    }
    
    
    
    
    //practice 14
    
    -(NSString)formPassword:(int)random{
        
    }
    
    //practice 15
    -(NSArray)fromOdd:(NSArray)odd{
        NSString*arrayX = X[n];
        int arrrayValue = [arrayValue intValue];
        if(arryaValue%2!=0)
            }
    
    
    
    
    
    


}
@end
