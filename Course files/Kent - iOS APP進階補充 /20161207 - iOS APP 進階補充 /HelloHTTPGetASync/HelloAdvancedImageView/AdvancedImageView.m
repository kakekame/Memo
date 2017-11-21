//
//  AdvancedImageView.m
//  HelloAdvancedImageView
//
//  Created by Kent Liu on 2016/3/8.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import "AdvancedImageView.h"

@interface AdvancedImageView ()
{
    UIActivityIndicatorView *loadingIndicatorView;
    NSOperationQueue *downloadQueue;
}

@end


@implementation AdvancedImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    // Add support of loadingIndicatorView
    
    CGRect subViewFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    loadingIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    loadingIndicatorView.color = [UIColor blueColor];
    loadingIndicatorView.hidesWhenStopped = true;
    loadingIndicatorView.frame = subViewFrame;
    
    [self addSubview:loadingIndicatorView];
    
    return self;
}

- (void) loadImageWithURL:(NSURL*) url {
    
    // Check downloadQueue if there is any exist download is processing.
    if(downloadQueue != nil) {
        [downloadQueue cancelAllOperations];
        downloadQueue = nil;
    }
    
    // Clear exist image if exist.
    self.image = nil;
    
    // Support Cache of image file
    NSString *hashFileName = [NSString stringWithFormat:@"Cache_%ld",(unsigned long)[url hash]];
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true)[0];
    
    NSString *fullFilePathName = [cachePath stringByAppendingPathComponent:hashFileName];
    
    UIImage *cacheImage = [UIImage imageWithContentsOfFile:fullFilePathName];
    
    if(cacheImage != nil) {
        self.image = cacheImage;
        return;
    }
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
//    NSOperationQueue *queue = [NSOperationQueue currentQueue];
    downloadQueue = [NSOperationQueue new];
    
    [loadingIndicatorView startAnimating];
    
    [NSURLConnection sendAsynchronousRequest:request queue:downloadQueue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
       
        NSLog(@"response: %@",response.description);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [loadingIndicatorView stopAnimating];
        });
        
        if(connectionError) {
            NSLog(@"Error: %@",connectionError.description);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
           self.image = [UIImage imageWithData:data];
        });
        
        downloadQueue = nil;
        
        // Save data as Cache
        [data writeToFile:fullFilePathName atomically:false];
    }];
    
}


@end









