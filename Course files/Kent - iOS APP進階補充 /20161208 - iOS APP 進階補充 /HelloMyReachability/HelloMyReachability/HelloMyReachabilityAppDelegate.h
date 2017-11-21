//
//  HelloMyReachabilityAppDelegate.h
//  HelloMyReachability
//
//  Created by Liu Kent on 2011/4/1.
//  Copyright 2011年 SoftArt Laboratory. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HelloMyReachabilityViewController;

@interface HelloMyReachabilityAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet HelloMyReachabilityViewController *viewController;

@end
