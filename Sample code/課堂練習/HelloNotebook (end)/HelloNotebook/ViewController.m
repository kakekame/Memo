//
//  ViewController.m
//  HelloNotebook
//
//  Created by XueXin Tsai on 2016/11/29.
//  Copyright © 2016年 XueXin Tsai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
// 收藏筆記的一個陣列
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray * notes;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    // 從 NSUserDefaults 的 singleton 裡讀資料
    NSArray * data = [userDefaults objectForKey:@"notesData"];
    if (data) {
        //        如果從 userDefaults 讀出來的資料不為空值，而且筆數大於 0
        self.notes = [NSMutableArray arrayWithArray:data];
    } else {
        self.notes = [[NSMutableArray alloc] init];
    }
    
    //selector帶入方法名要用 "@selector()" 
    // 把自己向通知中心註冊，聽到 updateNote 的口號就做某件事
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(renewTableView) name:@"updateNote" object:nil];

    [self.tableView reloadData];
}

-(void)renewTableView {
    
}

- (IBAction)insertNewNote:(UIBarButtonItem *)sender {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"請填入筆記的標題" message:@"請輸入" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"在此輸入標題";
    }];
    
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 取得使用者在文字框上輸入的內容
        UITextField * field = alert.textFields[0];
        NSString * text = field.text;
        [self.notes addObject:text];
        // 把 notes 陣列存到 NSUserDefaults
        // 首先取得自己App的專屬 NSUserDefaults
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        // 把資料(Objective-C物件或是Swift物件)存入到 UserDefaults
        [userDefaults setObject:self.notes forKey:@"notesData"];
        // 超級、無敵、非常重要的一步：存入東西後要同步
        [userDefaults synchronize];
        // 重點：重新整理 tableView
        [self.tableView reloadData];
    }];
    
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.notes[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //先砍資料
        [self.notes removeObjectAtIndex:indexPath.row];
        // 首先取得自己App的專屬 NSUserDefaults
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        // 把資料(Objective-C物件或是Swift物件)存入到 UserDefaults
        [userDefaults setObject:self.notes forKey:@"notesData"];
        // 超級、無敵、非常重要的一步：存入東西後要同步
        [userDefaults synchronize];
        //再砍畫面
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
