//
//  HelloAnimationViewController.h
//  HelloAnimation
//
//  Created by Liu Kent on 2011/5/2.
//  Copyright 2011年 SoftArt Laboratory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelloAnimationViewController : UIViewController {
    
    IBOutlet UIView *view1;
    IBOutlet UIView *view2;    
    
    IBOutlet UIImageView *animatedImageView;
    
    BOOL bView1IsHide;
    BOOL bView2IsHide;    
    
    BOOL bView1Animating;
    BOOL bView2Animating;    
    
}

- (IBAction) switch1Pressed;
- (IBAction) switch2Pressed;

@end
