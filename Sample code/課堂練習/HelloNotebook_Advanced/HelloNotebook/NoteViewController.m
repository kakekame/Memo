//
//  NoteViewController.m
//  HelloNotebook
//
//  Created by XueXin Tsai on 2016/11/29.
//  Copyright © 2016年 XueXin Tsai. All rights reserved.
//

#import "NoteViewController.h"

@interface NoteViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//離開畫面前, 將資料存回UserDefaults
-(void)viewWillDisappear:(BOOL)animated{
    //取得使用者輸入的文字
    NSString * title = self.titleField.text;
    //取得原本UserDefaults裡面的資料
    NSArray * existData = [[NSUserDefaults standardUserDefaults]objectForKey:@"notesData"];
    NSMutableArray * array;
    //如果資料存在且筆數大於零, 就把資料放到array陣列裡; 若資料為零或不存在, 就初始化
    if (existData != nil && existData.count>0) {
        array = [NSMutableArray arrayWithArray:existData];
    }else{
        array = [[NSMutableArray alloc]init];
    }
    //將使用者的文字加到陣列中
    [array addObject:title];
    //將陣列存到UserDefaults中
    [[NSUserDefaults standardUserDefaults]setObject:array forKey:@"notesData"];
    //同步
    [[NSUserDefaults standardUserDefaults]synchronize];
    //呼叫口號
    [[NSNotificationCenter defaultCenter]postNotificationName:@"updateNote" object:nil];
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
