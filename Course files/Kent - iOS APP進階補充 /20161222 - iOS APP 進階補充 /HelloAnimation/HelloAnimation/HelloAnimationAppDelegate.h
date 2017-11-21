//
//  HelloAnimationAppDelegate.h
//  HelloAnimation
//
//  Created by Liu Kent on 2011/5/2.
//  Copyright 2011年 SoftArt Laboratory. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HelloAnimationViewController;

@interface HelloAnimationAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet HelloAnimationViewController *viewController;

@end
