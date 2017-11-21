//
//  HelloAnimationViewController.m
//  HelloAnimation
//
//  Created by Liu Kent on 2011/5/2.
//  Copyright 2011年 SoftArt Laboratory. All rights reserved.
//

#import "HelloAnimationViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation HelloAnimationViewController

- (void)dealloc
{
    [view1 release];
    [view2 release];   
    
    [animatedImageView release];
    
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

    view1.frame=CGRectMake(0,0,view1.frame.size.width, view1.frame.size.height);
    
    [self.view addSubview:view1];
    
    view2.frame=CGRectMake(0,0,view2.frame.size.width, view2.frame.size.height);    

    [self.view addSubview:view2];  
    
    // Prepare animatedImageView
    
    [animatedImageView setAnimationImages:[NSArray arrayWithObjects:
                                           [UIImage imageNamed:@"cat1.jpg"],
                                           [UIImage imageNamed:@"cat2.jpg"],
                                           [UIImage imageNamed:@"cat3.jpg"], nil]];
    [animatedImageView setAnimationRepeatCount:0];
    [animatedImageView setAnimationDuration:2];
    [animatedImageView startAnimating];
    
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

- (IBAction) switch1Pressed {
    if(bView1Animating==YES)
        return;
    
    // Start animation block.
    [UIView beginAnimations:nil context:NULL];
    
    // Animation settings.
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(view1AnimationDidStop)];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
						   forView:view1
							 cache:YES];    
    
    
    if(bView1IsHide==NO)
    {
        CGRect rectFrame=[view1 frame];
        rectFrame.origin.y-=rectFrame.size.height;
        [view1 setFrame:rectFrame];
        bView1IsHide=YES;
    }
    else
    {
        CGRect rectFrame=[view1 frame];
        rectFrame.origin.y+=rectFrame.size.height;
        [view1 setFrame:rectFrame];
        bView1IsHide=NO;
    }        
    
    //[viewControlPanel setTransform:CGAffineTransformMakeTranslation(CONTROL_PANEL_HIDE_X-CONTROL_PANEL_SHOW_X,0)]; 
    
    // End animation block.
    [UIView commitAnimations];  	
    
	bView1Animating = YES;    
    
    
}

-(void)view1AnimationDidStop
{
	bView1Animating = NO;
}

- (IBAction) switch2Pressed {
    if(bView2Animating==YES)
        return;
    
	CATransition *transition = [CATransition animation];
	transition.duration = 1.5;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
    transition.type=kCATransitionPush;    
    if(bView2IsHide==NO)
        transition.subtype=kCATransitionFromRight;
    else
        transition.subtype=kCATransitionFromLeft;

	bView2Animating = YES;
	transition.delegate = self;
	
	[view2.layer addAnimation:transition forKey:nil];
	
    if(bView2IsHide==NO)
    {
        [view2 setHidden:YES];
        bView2IsHide=YES;
    }
    else
    {
        [view2 setHidden:NO];
        bView2IsHide=NO;
    }	
    
      
}

-(void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
	bView2Animating = NO;
    
}



@end
