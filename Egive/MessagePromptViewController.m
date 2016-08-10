//
//  MessagePromptViewController.m
//  Egive
//
//  Created by sino on 15/9/12.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "MessagePromptViewController.h"
#import "UIView+ZJQuickControl.h"
#import "EGUtility.h"

#define ScreenSize [UIScreen mainScreen].bounds.size
@interface MessagePromptViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * _dataArray;
    
}
@property (strong, nonatomic) UITableView * tableView;
@end

@implementation MessagePromptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = EGLocalizedString(@"讯息提示", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.rightBarButtonItem = nil;
    _dataArray = @[EGLocalizedString(@"所有提示", nil),EGLocalizedString(@"进度报告提示", nil),EGLocalizedString(@"意赠活动提示", nil),EGLocalizedString(@"新增个案提示", nil),EGLocalizedString(@"成功筹募提示", nil)];
    
    [self createUI];
}

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createUI {

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 60;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cell";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.titleLabel.text = _dataArray[indexPath.row];
    [cell.swith setOn:TRUE];
    [cell.swith addTarget:self action:@selector(switchChanged) forControlEvents:UIControlEventValueChanged];
    return cell;
}

- (void)switchChanged{
    
    
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
