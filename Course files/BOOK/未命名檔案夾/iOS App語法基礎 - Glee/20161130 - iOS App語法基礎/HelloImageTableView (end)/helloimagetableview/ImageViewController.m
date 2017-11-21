//
//  ImageViewController.m
//  HelloImageTableView
//
//  Created by XueXin Tsai on 2016/11/30.
//  Copyright © 2016年 XueXin Tsai. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()<UIScrollViewDelegate>

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 顯示圖片
    self.imageView.image = [UIImage imageNamed:self.imageFileName];
    // 設定 scrollview 的內容尺寸
    self.scrollView.contentSize = self.imageView.bounds.size;
    // 設定 scrollView 的 delegate
    self.scrollView.delegate = self;
    // 設定 scrollView 的放大比率，跟最小比率
    self.scrollView.minimumZoomScale = 0.5;
    self.scrollView.maximumZoomScale = 2.0;
    // 最一開始的放大比率
    self.scrollView.zoomScale = 1.0;
}

//要縮放哪一個 view
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
