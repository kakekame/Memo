//
//  HelloMyReachabilityViewController.h
//  HelloMyReachability
//
//  Created by Liu Kent on 2011/4/1.
//  Copyright 2011年 SoftArt Laboratory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface HelloMyReachabilityViewController : UIViewController {
    Reachability *googleReach;
    
    IBOutlet UIView *viewStatus;
    
    IBOutlet UIView *viewInternetStatus;    
}

- (IBAction) checkInternetStatus ;

@end
