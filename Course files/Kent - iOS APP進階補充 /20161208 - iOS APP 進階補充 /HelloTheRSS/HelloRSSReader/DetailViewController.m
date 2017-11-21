//
//  DetailViewController.m
//  HelloRSSReader
//
//  Created by Kent Liu on 2016/3/9.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import "DetailViewController.h"
#import "NewsItem.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *detailWebView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
//        self.detailDescriptionLabel.text = [self.detailItem description];
        
        NewsItem *newsItem = _detailItem;
        
        // Change navitationbar title to new title.
        self.title = newsItem.title;
        
        // Show detail info on web view.
        NSURL *url = [NSURL URLWithString:newsItem.link];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [_detailWebView loadRequest:request];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
