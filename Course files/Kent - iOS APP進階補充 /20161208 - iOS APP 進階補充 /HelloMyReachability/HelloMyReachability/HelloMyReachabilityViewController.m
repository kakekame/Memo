//
//  HelloMyReachabilityViewController.m
//  HelloMyReachability
//
//  Created by Liu Kent on 2011/4/1.
//  Copyright 2011年 SoftArt Laboratory. All rights reserved.
//

#import "HelloMyReachabilityViewController.h"

@implementation HelloMyReachabilityViewController

- (void)dealloc
{
    [viewStatus release];
    [viewInternetStatus release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:kReachabilityChangedNotification 
                                                  object:nil];
    
    [googleReach stopNotifier];
    [googleReach release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(googleReach==nil)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkReachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        
        googleReach=[[Reachability reachabilityWithHostName:@"google.com"] retain];
        [googleReach startNotifier];
    }
}

- (void) networkReachabilityChanged:(NSNotification*)note
{
    //Reachability *curReach=[note object];
    
    NetworkStatus netStatus = [[note object] currentReachabilityStatus];
    
    NSLog(@"Net Status: %d",netStatus);
    
    switch (netStatus) {
        case NotReachable:
            [viewStatus setBackgroundColor:[UIColor redColor]];
            break;
        case ReachableViaWiFi:
            [viewStatus setBackgroundColor:[UIColor blueColor]];
            break;            
        case ReachableViaWWAN:
            [viewStatus setBackgroundColor:[UIColor greenColor]];
            break;   
            
        default:
            break;
    }
    

}

- (IBAction) checkInternetStatus  
{
    NetworkStatus netStatus=[[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
 
    switch (netStatus) {
        case NotReachable:
            [viewInternetStatus setBackgroundColor:[UIColor redColor]];
            break;
        case ReachableViaWiFi:
            [viewInternetStatus setBackgroundColor:[UIColor blueColor]];
            break;            
        case ReachableViaWWAN:
            [viewInternetStatus setBackgroundColor:[UIColor greenColor]];
            break;   
            
        default:
            break;
    }   
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
