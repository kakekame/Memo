//
//  SecondViewController.m
//  HelloTableViewAgain
//
//  Created by XueXin Tsai on 2016/11/28.
//  Copyright © 2016年 XueXin Tsai. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UILabel *stationName;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.stationName.text = self.stopName;
}
- (IBAction)goBackToLastPage:(UIButton *)sender {
//    self.navigationController.viewControllers
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)insertNewNote {
//    UIAlertController * alert = ....

//    [alert addTextField...]
  //    UIAlertAction * action = ...
    //action --> block
    // 取得使用者在警告視窗上所輸入的文字
    // 把它加到陣列裡面去
    // 重整 TableView
    [self.tableView reloadData];
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
