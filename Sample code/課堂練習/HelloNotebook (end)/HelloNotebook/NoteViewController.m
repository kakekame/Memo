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

-(void)viewWillDisappear:(BOOL)animated
{
    //先取得舊的陣列後, 再新增此筆的內容
    // 取得使用者所輸入的文字
    NSString * title = self.titleField.text;
    // 從 UserDefaults 中，拿到原本在裡面的資料
    NSArray * existData = [[NSUserDefaults standardUserDefaults] objectForKey:@"notesData"];
    NSMutableArray * array;
    if (existData != nil && existData.count > 0) {
        // 如果裡面的資料存在，而且筆數大於零
        // 就把裡面的資料放到上面的 array 陣列裡
        array = [NSMutableArray arrayWithArray:existData];
    } else {
        // 如果裡面的資料不存在，或筆數為零，將上面的 array 初始化
        array = [[NSMutableArray alloc] init];
    }
    // 將使用者輸入的文字加入到陣列中
    [array addObject:title];
    // 將陣列存入到 UserDefaults 裡
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"notesData"];
    // 同步
    [[NSUserDefaults standardUserDefaults] synchronize];
    // 呼叫口號 -> NSNotificationCenter:singleton, 用defaultCenter. object是要在此時發給物件的東西
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateNote" object:nil];
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
