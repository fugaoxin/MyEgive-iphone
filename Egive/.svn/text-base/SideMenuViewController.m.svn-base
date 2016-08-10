//
//  SideMenuViewController.m
//  Egive
//
//  Created by sino on 15/7/20.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "SideMenuViewController.h"
#import "DDMenuController.h"

#import "IndividualUserController.h"
#import "EnterpriseViewController.h"

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "MyDonationViewController.h"
#import "GirdViewController.h"
#import "InformationController.h"
#import "RankListViewController.h"
#import "ActivityViewController.h"
#import "AboutGridViewController.h"
#import "SettingViewController.h"

#import "SideMunuCell.h"
#import "UIView+ZJQuickControl.h"

#define ScreenSize [UIScreen mainScreen].bounds.size

@interface SideMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray * _titleArray;
    NSArray * _imageArray;
}
@property (copy, nonatomic)NSMutableArray * dataArray;
@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1];
    
    
    _dataArray = [[NSMutableArray alloc] init];
    
    
    
    _titleArray = @[@"首頁",@"點擊行善",@"我的捐款",@"訊息中心",@"排行榜",@"意贈資訊",@"關於意贈",@"設定"];
    _imageArray = @[@"menu_home@2x.png",
                    @"menu_case_list@2x.png",
                    @"ranking_personal_others_icon@2x.png",
                    @"menu_about@2x.png",
                    @"menu_ranking@2x.png",
                    @"menu_event@2x.png",
                    @"menu_my_donation@2x.png",
                    @"menu_settings@2x.png"];
    [self createrUI];
    [self createrTopView];
    
}

- (void)createrUI{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, ScreenSize.width, ScreenSize.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.backgroundColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
}
#pragma mark 创建头部试图
- (void)createrTopView{
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenSize.width , 60)];
    topView.backgroundColor = [UIColor colorWithRed:93.0/255.0 green:94.0/255.0 blue:91.0/255.0 alpha:1];
    [self.view addSubview:topView];
    _tableView.tableHeaderView = topView;
    
    //创建用户头像
    UIImageView * iconImage = [topView addImageViewWithFrame:CGRectMake(15, 5, 50, 50) image:@"menu_profile_pic_empty@2x.png"];
    
    //添加头像点击手势
    UITapGestureRecognizer * iconTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconAction)];
    [iconImage addGestureRecognizer:iconTap];
    
    
    UILabel * topTitle = [topView addLabelWithFrame:CGRectMake(100, 15, ScreenSize.width-150, 30) text:@"成為意贈之友           >"];
    topTitle.textColor = [UIColor whiteColor];
    topTitle.font = [UIFont boldSystemFontOfSize:16];
    
    UIView * topTitleView = [[UIView alloc] initWithFrame:CGRectMake(110, 15, ScreenSize.width-150, 30)];
    topTitleView.userInteractionEnabled = YES;
    [topView addSubview:topTitleView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [topTitleView addGestureRecognizer:tap];
    
    
}

#pragma mark - 点击头像事件方法
- (void)iconAction{

    //个人用户信息
//    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//    IndividualUserController * lvcr = [[IndividualUserController alloc] init];
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:lvcr];
//    [menuController setRootController:navController animated:YES];
    
    
    //企业用户信息
    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    EnterpriseViewController * vc = [[EnterpriseViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    [menuController setRootController:navController animated:YES];
    
}

#pragma mark - 点击注册事件方法
- (void)tapAction{
    
    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    LoginViewController * lvcr = [[LoginViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:lvcr];
    [menuController setRootController:navController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"cell";
    SideMunuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[SideMunuCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    

    NSString * title = _titleArray[indexPath.row];
    cell.iconImage.image= [UIImage imageNamed:_imageArray[indexPath.row]];
    cell.titelLabel.text = title;
    cell.backgroundColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1];
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        HomeViewController * hvcr = [[HomeViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:hvcr];
        [menuController setRootController:navController animated:YES];
        
    }else if (indexPath.row == 1){

        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        GirdViewController * gvc = [[GirdViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:gvc];
        [menuController setRootController:navController animated:YES];

    }else if (indexPath.row == 2){
        
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        MyDonationViewController * gvc = [[MyDonationViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:gvc];
        [menuController setRootController:navController animated:YES];
        
    }else if (indexPath.row == 3){
 
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        InformationController * vc = [[InformationController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
        [menuController setRootController:navController animated:YES];
        
    }else if (indexPath.row == 4){
        
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        RankListViewController * vc = [[RankListViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
        [menuController setRootController:navController animated:YES];
        
    }else if (indexPath.row == 5){
        
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        ActivityViewController * vc = [[ActivityViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
        [menuController setRootController:navController animated:YES];
    
    }else if (indexPath.row == 6){
        
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        AboutGridViewController * vc = [[AboutGridViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
        [menuController setRootController:navController animated:YES];
        
    }else if (indexPath.row == 7){
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        SettingViewController * vc = [[SettingViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
        [menuController setRootController:navController animated:YES];
    }
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
