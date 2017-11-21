//
//  ChattingView.m
//  HelloMySendMessage
//
//  Created by Kent Liu on 2016/6/23.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import "ChattingView.h"
#import "ChattingBubbleView.h"

#define Y_PADDING 20

@interface ChattingView ()
{
    CGFloat lastChattingBubbleViewY;
    NSMutableArray *allChattingItems;
}

@end


@implementation ChattingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) addChattingItem:(ChattingItem*) item {
    
    if(!allChattingItems) {
        allChattingItems = [NSMutableArray new];
    }
    
    ChattingBubbleView *bubbleView = [[ChattingBubbleView alloc] initWithItem:item offsetY:lastChattingBubbleViewY + Y_PADDING];
    [self addSubview:bubbleView];
    
    lastChattingBubbleViewY = CGRectGetMaxY(bubbleView.frame);
    self.contentSize = CGSizeMake(self.frame.size.width, lastChattingBubbleViewY);
    
    // Scroll to bottom
    [self scrollRectToVisible:CGRectMake(0, lastChattingBubbleViewY-1, 1, 1) animated:true];
    
    // Keep the item
    [allChattingItems addObject:item];
}

- (void) layoutSubviews {
    NSLog(@"tt");
}


@end





