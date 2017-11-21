//
//  ViewController.m
//  HelloTableViewAgain
//
//  Created by XueXin Tsai on 2016/11/28.
//  Copyright © 2016年 XueXin Tsai. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
//高鐵的站名陣列
@property NSArray * stops;
//高鐵的票價
@property NSArray * prices;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.stops = @[@"南港",@"台北",@"板橋",@"桃園",@"新竹"];
    self.prices = @[@220,@190,@120,@0,@90];
    
    //用程式碼的方式，在導覽列上加入新的按鈕
    //先取得每個 ViewController 都會自帶管理的 UINavigationItem
    //這個 UINavigationItem 是經由父類別 UIViewController 繼承而來的
    //修改導覽列上的文字
    self.navigationItem.title = @"這是高鐵價格，很貴吧！";
    //準備導覽列上按鈕
    UIBarButtonItem * addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pressAddButton:)];
    //放上導覽列
    self.navigationItem.rightBarButtonItems = @[addItem];
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 10;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.stops.count;
    } else {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 準備好 Cell
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.stops[indexPath.row];
    NSNumber * price = self.prices[indexPath.row];
    cell.detailTextLabel.text = [price stringValue];
    // 回傳
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 準備下一頁，記得要去 Storyboard 上取名字
    SecondViewController * secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    // 取得使用者點選到哪一個IndexPath
    // 用剛才得知的 IndexPath 得知使用者選取的站名
    NSString * name = self.stops[indexPath.row];
    // 將站名傳給下一頁的物件
    secondViewController.stopName = name;
    // 顯示下一頁
    [self showViewController:secondViewController sender:nil];
}


- (void)pressAddButton:(UIBarButtonItem *)sender {
    NSLog(@"按下了按鈕");
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
