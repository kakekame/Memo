//
//  ViewController.m
//  HelloHSRTableView
//
//  Created by 123APP on 2016/11/21.
//  Copyright © 2016年 com.glee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UITableViewDatasource
//要有幾個section（非必做，預設tableview就是1個ssection）
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//每一個 section 裡面要有幾個 row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

//每一個row上面的cell畫面
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 準備一個 Cell，等一下要回傳給 Tableview
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSArray * array = @[@"南港",@"台北",@"板橋",@"桃園",@"新竹"];
    cell.textLabel.text = array[indexPath.row];
    cell.detailTextLabel.text = @"準備發車";
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
