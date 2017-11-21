//
//  main.m
//  HelloInt
//
//  Created by XueXin Tsai on 2016/10/24.
//  Copyright © 2016年 XueXin Tsai. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        int gleeAge = 30;
        int fatherAge = 58;
        int between = fatherAge - gleeAge;
        NSLog(@"%d",between);
        
        
        int height = 100;
        int width = 200;
        int pin = height*width*0.3025;
        NSLog(@"%d",pin);
        
        //四則運算
        int a = 6;
        int b = 4;
        int add = a+b; // 10
        int substract = a-b; // 2
        int divide = a/b;//1.5
        int multiply = a*b; // 24
        int mod = a%b;//2
        
        //浮點數型別
        double pi = 3.14159;//M_PI
        double r = 10.0;
        double cir = 2*pi*r; // 圓周長
        double area = pi*r*r; // 圓面積
        
        //浮點數進位
        double k = 9.44;
        double c = floor(k);//無條件捨去
        
        int s = 0;
        s++; // s = s+1
        s++; // s += 1 (add and assign)
        
        //產生出隨機整數
        int random = arc4random_uniform(10000); //0~9999
        
        double applePrice = 30.0;
        double appleTax = 0.0;
        double appleAmount = 20.0;
        double iPodPrice = 12000.0;
        double iPodTax = 0.085;
        double iPodAmount = 5.0;
        double cookiePrice = 70.0;
        double cookieTax = 0.05;
        double cookieAmount = 10.0;
//        商品價格 = 商品未稅金額 + 商品稅金
//                = 12000 + (12000*8.5%)
//                = 12000 * (1+8.5%)
        double apple = appleAmount*(applePrice*(1+appleTax));
        double iPod = iPodAmount*(iPodPrice*(1+iPodTax));
        double cookie = cookieAmount*(cookiePrice*(1+cookieTax));
        double total = apple+iPod+cookie;
        NSLog(@"%lf",total);
        
        
        
    }
    return 0;
}
