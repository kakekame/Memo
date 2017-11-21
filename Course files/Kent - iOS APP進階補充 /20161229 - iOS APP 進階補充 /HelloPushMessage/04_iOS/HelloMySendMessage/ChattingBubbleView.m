//
//  ChattingBubbleView.m
//  HelloMySendMessage
//
//  Created by Kent Liu on 2016/6/23.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import "ChattingBubbleView.h"

// Constants of UI layout
#define SIDE_PADDING_RATE       0.02
#define MAX_BUBBLE_WIDTH_RATE   0.7
#define CONTENT_MARGIN          10.0
#define BUBBLE_TALE_WIDTH       10.0
#define TEXT_FONT_SIZE          16.0

@interface ChattingBubbleView ()
{
    // Subviews
    UIImageView *chattingImageView;
    UILabel *chattingLabel;
    UIImageView *backgroundImageView;
}

@end


@implementation ChattingBubbleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype) initWithItem:(ChattingItem*)item
                      offsetY:(CGFloat) offsetY {
    // Step1: Calculate a basic frame
    self = [super initWithFrame:CGRectZero];
    self.frame = [self calculateBasicFrame:item.type offsetY:offsetY];
    
    // Step2: Calculate with Image
    CGFloat currentY = 0.0;
    
    UIImage *image = item.image;
    if(image != nil) {
        
        CGFloat x = CONTENT_MARGIN;
        CGFloat y = CONTENT_MARGIN;
        
        if(item.type == fromOthers) {
            x += BUBBLE_TALE_WIDTH;
        }
        
        CGFloat displayWidth = MIN(image.size.width,self.frame.size.width - 2* CONTENT_MARGIN - BUBBLE_TALE_WIDTH);
        CGFloat displayRatio = displayWidth / image.size.width;
        CGFloat displayHeight = image.size.height * displayRatio;
        
        CGRect displayFrame = CGRectMake(x, y, displayWidth, displayHeight);
        
        // Prepare chattingImageView
        chattingImageView = [[UIImageView alloc] initWithFrame:displayFrame];
        chattingImageView.image = image;
        chattingImageView.layer.cornerRadius = 5.0;
        chattingImageView.layer.masksToBounds = true;
        
        [self addSubview:chattingImageView];
        
        currentY = CGRectGetMaxY(displayFrame);
    }
    // Step3: Calculate with Text
    NSString *text = item.text;
    if(text != nil) {
        
        CGFloat x = CONTENT_MARGIN;
        CGFloat y = currentY + TEXT_FONT_SIZE/2;
        if(item.type == fromOthers) {
            x += BUBBLE_TALE_WIDTH;
        }
        CGRect displayFrame = CGRectMake(x, y, self.frame.size.width - 2 * CONTENT_MARGIN - BUBBLE_TALE_WIDTH, TEXT_FONT_SIZE);
        // Create Label
        chattingLabel = [[UILabel alloc] initWithFrame:displayFrame];
        chattingLabel.font = [UIFont systemFontOfSize:TEXT_FONT_SIZE];
        chattingLabel.numberOfLines = 0;
        chattingLabel.text = text;
        [chattingLabel sizeToFit];
        
        [self addSubview:chattingLabel];
        
        currentY = CGRectGetMaxY(chattingLabel.frame);
    }
    // Step4: Calculate bubble view size
    CGFloat finalHeight = currentY + CONTENT_MARGIN;
    CGFloat finalWidth = 0.0;
    
    if(chattingImageView != nil) {
        if(item.type == fromMe) {
            finalWidth = CGRectGetMaxX(chattingImageView.frame) + CONTENT_MARGIN + BUBBLE_TALE_WIDTH;
        } else {
            // fromOthers
            finalWidth = CGRectGetMaxX(chattingImageView.frame) + CONTENT_MARGIN;
        }
    }
    if(chattingLabel != nil) {
        
        CGFloat labelWidth = 0;
        if(item.type == fromMe) {
            labelWidth = CGRectGetMaxX(chattingLabel.frame) + CONTENT_MARGIN + BUBBLE_TALE_WIDTH;
        } else {
            // fromOthers
            labelWidth = CGRectGetMaxX(chattingLabel.frame) + CONTENT_MARGIN;
        }
        finalWidth = MAX(finalWidth,labelWidth);
    }
    
    CGRect selfFrame = self.frame;
    
    if(item.type == fromMe && chattingImageView == nil) {
        selfFrame.origin.x += selfFrame.size.width - finalWidth;
    }
    selfFrame.size.width = finalWidth;
    selfFrame.size.height = finalHeight;
    self.frame = selfFrame;
    
    // Step5: Handle background display
    [self prepareBackgroundImageView:item.type];
    
    return self;
}

- (void) prepareBackgroundImageView:(ChattingItemType) type {
    
    CGRect bgImageViewFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    backgroundImageView = [[UIImageView alloc] initWithFrame:bgImageViewFrame];
    
    if(type == fromMe) {
        UIImage *image = [UIImage imageNamed:@"fromMe.png"];
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 17, 28)];
        backgroundImageView.image = image;
    } else {
        // fromOthers
        UIImage *image = [UIImage imageNamed:@"fromOthers.png"];
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(14, 22, 17, 20)];
        backgroundImageView.image = image;
    }
    [self addSubview:backgroundImageView];
    [self sendSubviewToBack:backgroundImageView];
}

- (CGRect) calculateBasicFrame:(ChattingItemType)type offsetY:(CGFloat)offsetY {
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat sidePadding = screenWidth * SIDE_PADDING_RATE;
    CGFloat maxWidth = screenWidth * MAX_BUBBLE_WIDTH_RATE;
    
    CGFloat offsetX;
    
    if(type == fromMe) {
        offsetX = screenWidth - sidePadding - maxWidth;
    } else {
        // fromOthers
        offsetX = sidePadding;
    }
    
    return CGRectMake(offsetX, offsetY, maxWidth, 10);
}



@end







