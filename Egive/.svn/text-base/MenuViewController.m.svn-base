//
//  MenuViewController.m
//  Egive
//
//  Created by sino on 15/8/4.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "Constants.h"
#import "MenuViewController.h"
#import "EnterpriseViewController.h" //机构信息
#import "IndividualUserController.h"    //个人信息
#import "HomeViewController.h"  //主页
#import "LoginViewController.h" //登入页面
#import "GirdViewController.h"  //点击行善
#import "RankListViewController.h"  //排行榜
#import "ActivityViewController.h"  //意赠资讯
#import "AboutGridViewController.h" //关于意赠
#import "InformationController.h"   //讯息中心
#import "MyDonationViewController.h"    //我的捐款
#import "SettingViewController.h"   //设定
#import "GirdViewPagedController.h"
#import <Social/Social.h>
#import "ShowMenuView.h"
#import "NSString+RegexKitLite.h"
#import "UIKit+AFNetworking.h"
#import "UIView+ZJQuickControl.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "WeiboSDK.h"
#import "EmailItemProvider.h"
#import "MemberZoneViewController.h"
#import "InformationModel.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface MenuViewController ()<FBSDKSharingDelegate>{
    NSArray * _dataArray;
    NSArray * _titleArray;
    NSArray * _imageArray;
    UIScrollView * _menuScroll;
    UIView * _menuView;
    UIImageView * _menuImage;
    UIImageView * _donationImage;
    UIButton * _messageButton;
    
    BOOL _isLogin;
}
@property (strong, nonatomic) EGGetAndSaveShoppingCartResult * shoppItem;
@property (strong, nonatomic) LoginViewController * loginVc;
@property (strong, nonatomic) MemberModel * item;
@property (copy, nonatomic) NSMutableDictionary * shopCartDict;
@property (copy, nonatomic) NSMutableDictionary * shareDict;
@property (copy, nonatomic) NSMutableArray * dataInboxArray;
@property (strong, nonatomic) UILabel * menuLabel;
@property (strong, nonatomic) UILabel * menuDonation;
@property (strong, nonatomic) UILabel * buttonTitle;
@property (strong, nonatomic) UIButton * iconButton;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    
    _titleArray = @[EGLocalizedString(@"MenuView_homeButton_title", nil),EGLocalizedString(@"MenuView_aboutButton_title", nil),EGLocalizedString(@"MenuView_girdButton_title", nil),EGLocalizedString(@"MenuView_rankingButton_title", nil),EGLocalizedString(@"MenuView_InformationButton_title", nil),EGLocalizedString(@"MenuView_myDonationButton_title", nil),EGLocalizedString(@"MenuView_shareButton_title", nil),EGLocalizedString(@"MenuView_settingButton_title", nil)];
    
    _imageArray = @[@"menu_home@2x.png",
                    @"menu_about@2x.png",
                    @"menu_case_list@2x.png",
                    @"menu_ranking@2x.png",
                    @"menu_event@2x.png",
                    @"menu_my_donation@2x.png",
                    @"menu_share@2x.png",
                    @"menu_settings@2x.png"];
    
    _isHidden = 1;
    _loginVc = [[LoginViewController alloc] init];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults objectForKey:@"EGIVE_MEMBER_MODEL"]) {
        NSMutableDictionary *m = [[standardUserDefaults objectForKey:@"EGIVE_MEMBER_MODEL"] mutableCopy];
        
        MemberModel * model = [[MemberModel alloc] init];
        [model setValuesForKeysWithDictionary:m];
        [ShowMenuView sharedInstance].member = model;
        
        MyLog(@"%@",m);
        _item = model;
        MyLog(@"%@",_item.ProfilePicURL);
    }

//    _shareDict = [ShowMenuView getUserInfo];
//    _item = _shareDict[@"LoginName"];
    
    _shopCartDict = [ShowMenuView getIsSaveShoppingCart];
    
    
    [self showUserInfo];
    __weak typeof(self) weakSelf = self;
    [_loginVc setAction:^(LoginViewController *vc) {
        
        [weakSelf showUserInfo];
        [weakSelf GetAndSaveShoppingCart];
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeInboxCountAction) name:@"changeInboxCount" object:nil];
   
    [self requestInboxMsgData];
}
#pragma mark - 创建底部菜单按钮
- (void)createFooterButton{
    
    //目录
    _menuImage = [self.view addImageViewWithFrame:CGRectMake(0, ScreenSize.height-60, ScreenSize.width/2, 60) image:@"footer_menu@2x.png"];
    _menuImage.userInteractionEnabled = YES;
    [_menuImage addImageViewWithFrame:CGRectMake(50, 37, 18, 18) image:@"footer_menu_icon@2x.png"];
    
    _menuLabel = [_menuImage addLabelWithFrame:CGRectMake(80, 36, 50, 20) text:EGLocalizedString(@"MenuView_menuLabel_title", nil)];
    _menuLabel.font  = [UIFont systemFontOfSize:14];
    _menuLabel.textColor = [UIColor whiteColor];
    
    UIView * menuTapView = [[UIView alloc] initWithFrame:CGRectMake(0, 35, ScreenSize.width/2, 25)];
    [_menuImage addSubview:menuTapView];
    
    UITapGestureRecognizer * menuTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuAction)];
    [menuTapView addGestureRecognizer:menuTap];
    
    //立即捐款
    _donationImage = [self.view addImageViewWithFrame:CGRectMake(ScreenSize.width/2, ScreenSize.height-60, ScreenSize.width/2, 60) image:@"footer_donation@2x.png"];
    _donationImage.userInteractionEnabled = YES;
    [_donationImage addImageViewWithFrame:CGRectMake(20, 37, 18, 18) image:@"footer_cart_icon@2x.png"];
    
    _menuDonation = [_donationImage addLabelWithFrame:CGRectMake(50, 36, 100, 20) text:EGLocalizedString(@"MenuView_donationLabel_title", nil)];
    _menuDonation.font  = [UIFont systemFontOfSize:14];
    _menuDonation.textColor = [UIColor colorWithRed:70.0/255.0 green:180.0/255.0 blue:4.0/255.0 alpha:1];
    
    UIView * donationTapView = [[UIView alloc] initWithFrame:CGRectMake(0, 35, ScreenSize.width/2, 25)];
    donationTapView.userInteractionEnabled = YES;
    [_donationImage addSubview:donationTapView];
    
    UITapGestureRecognizer * donationTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(donationAction)];
    [donationTapView addGestureRecognizer:donationTap];
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _appLang = [EGUtility getAppLang];
    

}

- (void)createMenuUI{
    
    _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenSize.height, ScreenSize.width, 300)];
    _menuView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.view addSubview:_menuView];

     [self showUserInfo]; //显示用户登录状态信息
    
    __weak typeof(self) weakSelf = self;
    _messageButton = [_menuView addImageButtonWithFrame:CGRectMake(ScreenSize.width-55, 5, 45, 45) title:EGLocalizedString(@"MenuView_messageButton_title", nil) backgroud:@"menu_messenger@2x.png" action:^(UIButton *button) {
        
        InformationController * vc = [[InformationController alloc] init];
        [weakSelf setPageJumpAction:vc];
        
    }];
    _messageButton.titleEdgeInsets = UIEdgeInsetsMake(60, 0, 0, 0);
    _messageButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [_messageButton setTitleColor:[UIColor colorWithRed:110.0/255.0 green:50.0/255.0 blue:140.0/255.0 alpha:1] forState:UIControlStateNormal];
    
    
    //讯息中心绿色个数标示
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenSize.width-25, 10, 20, 20)];
    _messageLabel.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:180.0/255.0 blue:4.0/255.0 alpha:1];
    _messageLabel.layer.cornerRadius = 10;
    _messageLabel.layer.masksToBounds=YES;
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.font = [UIFont systemFontOfSize:10];
    _messageLabel.textColor = [UIColor whiteColor];
    _messageLabel.hidden=YES;
    [_menuView addSubview:_messageLabel];
    
//    UILabel * messageLabel = [messageView addLabelWithFrame:CGRectMake(0, 5, 20, 10) text:@"99+"];
//    messageLabel.textAlignment = NSTextAlignmentCenter;
//    messageLabel.font = [UIFont systemFontOfSize:10];
//    messageLabel.textColor = [UIColor whiteColor];

    _menuScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, ScreenSize.width, 220)];
    _menuScroll.backgroundColor = [UIColor whiteColor];
    [_menuView addSubview:_menuScroll];
    
    
    for (int i = 0; i < _imageArray.count; i ++) {
        
        _iconButton = [_menuScroll addImageButtonWithFrame:CGRectMake(i%4*((ScreenSize.width-40)/4+8)+20, i/4*100+20, 45, 45) title:nil backgroud:_imageArray[i] action:^(UIButton *button) {
            
            if (button.tag == 80) {
                HomeViewController * vc = [[HomeViewController alloc] init];
                [self setPageJumpAction:vc];

            }else if (button.tag == 81){
                
                AboutGridViewController * vc = [[AboutGridViewController alloc] init];
                [self setPageJumpAction:vc];

            }else if (button.tag == 82){

                GirdViewController * vc = [[GirdViewController alloc] init];
                [self setPageJumpAction:vc];

            }else if (button.tag == 83){
                
                RankListViewController * vc = [[RankListViewController alloc] init];
                [self setPageJumpAction:vc];
                
            }else if (button.tag == 84){
                
                ActivityViewController * vc = [[ActivityViewController alloc] init];
                [self setPageJumpAction:vc];
                
            }else if (button.tag == 85){

                MyDonationViewController * vc = [[MyDonationViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
//                [self setPageJumpAction:vc];
                
            }else if (button.tag == 86){
               
                [self shareSystem];
                
            }else if (button.tag == 87){

                SettingViewController * vc = [[SettingViewController alloc] init];
                [self setPageJumpAction:vc];
            }

        }];
        _iconButton.tag = 80 +i;

        _buttonTitle = [_menuScroll addLabelWithFrame:CGRectMake(i%4*((ScreenSize.width-40)/4+7)+20, i/4*100+65, 48, 25) text:_titleArray[i]];
        _buttonTitle.tag = 90 +i;
        _buttonTitle.font = [UIFont systemFontOfSize:12];
        _buttonTitle.textAlignment = NSTextAlignmentCenter;
        _buttonTitle.textColor = [UIColor colorWithRed:110.0/255.0 green:50.0/255.0 blue:140.0/255.0 alpha:1];
        if ([EGUtility getAppLang] == 3) {
            if (i==1) {
                _buttonTitle.frame = CGRectMake(i%4*((ScreenSize.width-40)/4+7)+20, i/4*100+65, 55,25);
            }
            if (i == 2 || i == 4 || i == 5) {
               
                _buttonTitle.frame = CGRectMake(i%4*((ScreenSize.width-40)/4+7)+20, i/4*100+65, 55,40);
                _buttonTitle.numberOfLines = 2;
            }
        }
        if (i == 5) {
            //我的捐款绿色个数标示
            _donationsView = [[UIView alloc] initWithFrame:CGRectMake(30, 5, 18, 18)];
            _donationsView.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:180.0/255.0 blue:4.0/255.0 alpha:1];
            _donationsView.layer.cornerRadius = 9;
            [_iconButton addSubview:_donationsView];
            
            NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
            EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
      
            _donationsLabel = [_donationsView addLabelWithFrame:CGRectMake(0, 4, 18, 10) text:[NSString stringWithFormat:@"%ld",item.NumberOfItems]];
            _donationsLabel.textAlignment = NSTextAlignmentCenter;
            _donationsLabel.font = [UIFont systemFontOfSize:11];
            _donationsLabel.textColor = [UIColor whiteColor];

            MyLog(@"_donationsLabel:%@",_donationsLabel.text);
            if (item.NumberOfItems < 1) {
                
                self.donationsView.hidden = YES;
                
            }else{
                
                self.donationsView.hidden = NO;
                
            }
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCount) name:@"changeCount" object:nil];
        }
    }
}

//显示信息个数的通知
-(void)changeInboxCountAction{

    if ([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"MsgInboxCount"]] integerValue]>0) {
        _messageLabel.hidden=NO;
    }
    else{
        _messageLabel.hidden=YES;
    }
    _messageLabel.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"MsgInboxCount"]];
}
- (void)changeCount{
    
    NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
    EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
    MyLog(@"*************%ld",item.NumberOfItems);
    _donationsLabel.text = [NSString stringWithFormat:@"%ld",item.NumberOfItems];
    MyLog(@"_donationsLabel:%@",_donationsLabel.text);
}

//根据语言设置字体的位置
- (void)updateLangString{
    
     _menuLabel.text = EGLocalizedString(@"MenuView_menuLabel_title", nil);
     _menuDonation.text = EGLocalizedString(@"MenuView_donationLabel_title", nil);
     _topTitle.text = EGLocalizedString(@"MenuView_topTitle", nil);
     NSArray * arr= @[EGLocalizedString(@"MenuView_homeButton_title", nil),EGLocalizedString(@"MenuView_aboutButton_title", nil),EGLocalizedString(@"MenuView_girdButton_title", nil),EGLocalizedString(@"MenuView_rankingButton_title", nil),EGLocalizedString(@"MenuView_InformationButton_title", nil),EGLocalizedString(@"MenuView_myDonationButton_title", nil),EGLocalizedString(@"MenuView_shareButton_title", nil),EGLocalizedString(@"MenuView_settingButton_title", nil)];
    for (int i = 0; i < arr.count; i ++) {
        UILabel * label = (UILabel *)[_menuScroll viewWithTag:90+i];
        if ([EGUtility getAppLang] == 3) {
            if (i==1) {
                label.frame = CGRectMake(i%4*((ScreenSize.width-40)/4+7)+20, i/4*100+65, 55,25);
            }
            if (i == 2 || i == 4 || i == 5) {
                
                label.frame = CGRectMake(i%4*((ScreenSize.width-40)/4+7)+20, i/4*100+65, 55,40);
                label.numberOfLines = 2;
            }
        }

        if ([EGUtility getAppLang] != 3) {
            
        label.frame = CGRectMake(i%4*((ScreenSize.width-40)/4+7)+20, i/4*100+65, 48, 25);
            
        }
        
        label.text = arr[i];
    }
    [_messageButton setTitle:EGLocalizedString(@"MenuView_messageButton_title", nil) forState:UIControlStateNormal];
    
    
}

#pragma mark - 用户登入状态显示
- (void)showUserInfo{
    

//    _shareDict = [ShowMenuView getUserInfo];
//    _item = _shareDict[@"LoginName"];
    _userName.text = @"";

    if (_item != nil) {
        
        _logOutView.hidden = YES;
        _logintView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-80, 80)];
        _logintView.hidden = NO;
        [_menuView addSubview:_logintView];
        _iconImage = [_logintView addImageViewWithFrame:CGRectMake(15, 10, 55, 55) image:nil];
        _iconImage.layer.cornerRadius =55/2;
        _iconImage.layer.masksToBounds = YES;
        
        
        
//        //判断Documents 中是否存在该图片
//        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@", [self documentFolderPath],@"test.jpg"]]) {
//            [_iconImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [self documentFolderPath],@"test.jpg"]]];
//            
//        }else{
//           
//            
//            if ([_item.Sex isEqualToString:@"M"] || [_item.ChiNameTitle isEqualToString:@"R"]) {
//                _iconImage.image = [UIImage imageNamed:@"donor_detail_male@2x.png"];
//                if (![_item.MemberType isEqualToString:@"P"]){
//                    _iconImage.image = [UIImage imageNamed:@"donor_list_company@2x.png"];
//                }
//            }else{
//                _iconImage.image = [UIImage imageNamed:@"donor_detail_female@2x.png"];
//            }
//        }

        if ([_item.ProfilePicURL isEqualToString:@""] || _item.ProfilePicURL == nil){
            if ([_item.Sex isEqualToString:@"M"] || [_item.ChiNameTitle isEqualToString:@"R"]){
                NSString *urlString = [NSString stringWithFormat:@"%@%@",SITE_URL,@"/Images/default_m.jpg"];
                NSURL *url = [NSURL URLWithString:urlString];
                [_iconImage sd_setImageWithURL:url placeholderImage:nil];
               
                
                MyLog(@"%@",_iconImage);
                
                
            }else if (![_item.MemberType isEqualToString:@"P"]){
                    //_iconImage.image = [UIImage imageNamed:@"donor_list_company@2x.png"];
                 NSString *urlString = [NSString stringWithFormat:@"%@%@",SITE_URL,@"/Images/default_c.png"];
                    NSURL *url = [NSURL URLWithString:urlString];
                    [_iconImage sd_setImageWithURL:url placeholderImage:nil];
                
            }else if ([_item.Sex isEqualToString:@"F"] || [_item.ChiNameTitle isEqualToString:@"M"]){
                 NSString *urlString = [NSString stringWithFormat:@"%@%@",SITE_URL,@"/Images/default_f.jpg"];
                //_iconImage.image = [UIImage imageNamed:@"donor_detail_female@2x.png"];
                NSURL *url = [NSURL URLWithString:urlString];
                [_iconImage sd_setImageWithURL:url placeholderImage:nil];
                
            }
        }else{
            
            NSURL *url = [NSURL URLWithString:SITE_URL];
            url = [url URLByAppendingPathComponent:_item.ProfilePicURL];
            [_iconImage sd_setImageWithURL:url placeholderImage:nil];
            
        }
        _userName = [_logintView addLabelWithFrame:CGRectMake(80, 10, 120, 25) text:nil];
        _userName.font = [UIFont systemFontOfSize:14];
//        _userName.text = [NSString stringWithFormat:@"%@ %@",_item.EngFirstName,_item.EngLastName];
        _userName.text = _item.LoginName;
        MyLog(@"_userName.text = _item.LoginName;");
        [_logintView addImageViewWithFrame:CGRectMake(220, 10, 25, 25) image:@"menu_arrow@2x.png"];
        

        if ([_item.MemberType isEqualToString:@"P"]) {
             _donationsLable = [_logintView addLabelWithFrame:CGRectMake(80, 40, 90, 40) text:EGLocalizedString(@"ENG", nil)];

        }else{
            _donationsLable = [_logintView addLabelWithFrame:CGRectMake(80, 40, 90, 40) text:EGLocalizedString(@"QENG", nil)];

        }
        _donationsLable.numberOfLines= 2;
        _donationsLable.font = [UIFont systemFontOfSize:12];
        _donationsLable.textColor = [UIColor grayColor];

        _donMoney = [_logintView addLabelWithFrame:CGRectMake(160, 48, 80, 25) text:nil];
        _donMoney.textColor = [UIColor colorWithRed:70.0/255.0 green:180.0/255.0 blue:4.0/255.0 alpha:1];
        _donMoney.textAlignment = NSTextAlignmentRight;
        _donMoney.font = [UIFont systemFontOfSize:14];
        
        [self GetMemberTotalDonationAmountData:_item.MemberID];
        
        [_logintView addImageViewWithFrame:CGRectMake(ScreenSize.width-65, 5, 1, 70) image:@"case_separ_line@2x.png"];
        
    }else{
        _logintView.hidden = YES;
        _logOutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-80, 80)];
        _logOutView.hidden = NO;
        _logintView.userInteractionEnabled = YES;
        [_menuView addSubview:_logOutView];
        _iconImage = [_logOutView addImageViewWithFrame:CGRectMake(15, 15, 55, 55) image:nil];
        _iconImage.layer.cornerRadius = 55/2;
        _iconImage.layer.masksToBounds = YES;
        //用户头像
        if ([_item.ProfilePicURL isEqualToString:@""] || _item.ProfilePicURL == nil){
            //_iconImage.image = [UIImage imageNamed:@"menu_profile_pic_empty@2x.png"];
            if ([_item.Sex isEqualToString:@"M"] || [_item.ChiNameTitle isEqualToString:@"R"]){
                NSString *urlString = [NSString stringWithFormat:@"%@%@",SITE_URL,@"/Images/default_m.jpg"];
                NSURL *url = [NSURL URLWithString:urlString];
                [_iconImage sd_setImageWithURL:url placeholderImage:nil];
               
                //_iconImage.image = [UIImage imageNamed:@"donor_detail_male@2x.png"];
                if (![_item.MemberType isEqualToString:@"P"]){
                    //_iconImage.image = [UIImage imageNamed:@"donor_list_company@2x.png"];
                NSString *urlString = [NSString stringWithFormat:@"%@%@",SITE_URL,@"/Images/default_c.png"];
                    NSURL *url = [NSURL URLWithString:urlString];
                    [_iconImage sd_setImageWithURL:url placeholderImage:nil];
                    
                }
                
            }else if ([_item.Sex isEqualToString:@"F"] || [_item.ChiNameTitle isEqualToString:@"M"]){
                //_iconImage.image = [UIImage imageNamed:@"donor_detail_female@2x.png"];
                 NSString *urlString = [NSString stringWithFormat:@"%@%@",SITE_URL,@"/Images/default_f.jpg"];
                NSURL *url = [NSURL URLWithString:urlString];
                [_iconImage sd_setImageWithURL:url placeholderImage:nil];
               
            }else{
            
               _iconImage.image = [UIImage imageNamed:@"menu_profile_pic_empty@2x.png"];
            
               }
               [_logOutView addSubview:_iconImage];
            
        }
        _topTitle = [_logOutView addLabelWithFrame:CGRectMake(85, 25, 150, 30) text:EGLocalizedString(@"MenuView_topTitle", nil)];
        _topTitle.hidden = NO;
        _topTitle.textColor = [UIColor colorWithRed:70.0/255.0 green:180.0/255.0 blue:4.0/255.0 alpha:1];
        _topTitle.userInteractionEnabled = YES;
        _topTitle.font = [UIFont systemFontOfSize:16];

        [_logOutView addImageViewWithFrame:CGRectMake(225, 25, 30, 30) image:@"menu_arrow@2x.png"];
        
        [_logOutView addImageViewWithFrame:CGRectMake(ScreenSize.width-65, 5, 1, 70) image:@"case_separ_line@2x.png"];

    }
    //登入点击事件
    _topTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-65, 80)];
    _topTitleView.hidden = NO;
    _topTitleView.userInteractionEnabled = YES;
    [_menuView addSubview:_topTitleView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_topTitleView addGestureRecognizer:tap];

}
- (void)updateIcon{
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults objectForKey:@"EGIVE_MEMBER_MODEL"]) {
        NSMutableDictionary *m = [[standardUserDefaults objectForKey:@"EGIVE_MEMBER_MODEL"] mutableCopy];
        MemberModel * model = [[MemberModel alloc] init];
        [model setValuesForKeysWithDictionary:m];
        [ShowMenuView sharedInstance].member = model;
        _item = model;
    }

//    //判断Documents 中是否存在该图片
//    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@", [self documentFolderPath],@"test.jpg"]]) {
//        [_iconImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [self documentFolderPath],@"test.jpg"]]];
//    }else{
//        if ([_item.Sex isEqualToString:@"M"] || [_item.ChiNameTitle isEqualToString:@"R"]) {
//            _iconImage.image = [UIImage imageNamed:@"donor_detail_male@2x.png"];
//            if (![_item.MemberType isEqualToString:@"P"]){
//                _iconImage.image = [UIImage imageNamed:@"donor_list_company@2x.png"];
//            }
//        }else{
//            _iconImage.image = [UIImage imageNamed:@"donor_detail_female@2x.png"];
//        }
//    }
//    MyLog(@"%@",_item.ProfilePicBase64String);

    if ([_item.ProfilePicURL isEqualToString:@""] || _item.ProfilePicURL == nil){
        
        _iconImage.image = [UIImage imageNamed:@"menu_profile_pic_empty@2x.png"];
        if (![_item.MemberType isEqualToString:@"P"]){
            NSString *urlString = [NSString stringWithFormat:@"%@%@",SITE_URL,@"/Images/default_c.png"];
            NSURL *url = [NSURL URLWithString:urlString];
            [_iconImage sd_setImageWithURL:url placeholderImage:nil];
            //_iconImage.image = [UIImage imageNamed:@"donor_list_company@2x.png"];
            
        }else{
            
        if ([_item.Sex isEqualToString:@"M"] || [_item.ChiNameTitle isEqualToString:@"R"]) {
            //_iconImage.image = [UIImage imageNamed:@"donor_detail_male@2x.png"];
            NSString *urlString = [NSString stringWithFormat:@"%@%@",SITE_URL,@"/Images/default_m.jpg"];
            NSURL *url = [NSURL URLWithString:urlString];
            [_iconImage sd_setImageWithURL:url placeholderImage:nil];
            }else{
          NSString *urlString = [NSString stringWithFormat:@"%@%@",SITE_URL,@"/Images/default_f.jpg"];
            NSURL *url = [NSURL URLWithString:urlString];
            [_iconImage sd_setImageWithURL:url placeholderImage:nil];
            //_iconImage.image = [UIImage imageNamed:@"donor_detail_female@2x.png"];
            }
        }
        
    }else{
        
        NSURL *url = [NSURL URLWithString:SITE_URL];
        url = [url URLByAppendingPathComponent:_item.ProfilePicURL];
        [_iconImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"menu_profile_pic_empty@2x.png"]];
        
       
    }
    
//    if (![_item.ProfilePicURL isEqualToString:@""] || _item.ProfilePicURL != nil) {
//        NSURL *url = [NSURL URLWithString:@"http://www.egiveforyou.com"];
//        url = [url URLByAppendingPathComponent:_item.ProfilePicURL];
//        [_iconImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"menu_profile_pic_empty@2x.png"]];
//        _iconImage.contentMode = UIViewContentModeScaleAspectFit;
//    }else{
//    
//        if ([_item.Sex isEqualToString:@"M"] || [_item.ChiNameTitle isEqualToString:@"R"]) {
//            _iconImage.image = [UIImage imageNamed:@"donor_detail_male@2x.png"];
//            if (![_item.MemberType isEqualToString:@"P"]){
//                _iconImage.image = [UIImage imageNamed:@"donor_list_company@2x.png"];
//            }
//        }else{
//            _iconImage.image = [UIImage imageNamed:@"donor_detail_female@2x.png"];
//        }
//
//    }

}
#pragma mark 从文档目录下获取Documents路径
- (NSString *)documentFolderPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}
//点击登入事件方法
- (void)tapAction{
    

//    MemberModel * item = [_shareDict objectForKey:@"LoginName"];
    if (_item != nil) {
        
        if ([_item.MemberType isEqualToString:@"P"]){
            
//            IndividualUserController * vc = [[IndividualUserController alloc] init];
//            vc.memberTotalDonationAmount = _donMoney.text;
//            [self setPageJumpAction:vc];
            MemberZoneViewController *vc = [[MemberZoneViewController alloc] initWithNibName:@"MemberZoneViewController" bundle:nil];
            
                 vc.memberTotalDonationAmount = _donMoney.text;
                  [self setPageJumpAction:vc];
        
        }else{
            EnterpriseViewController * vc = [[EnterpriseViewController alloc] init];
             vc.memberTotalDonationAmount = _donMoney.text;
            [self setPageJumpAction:vc];
        }
    }else
        
    [self.navigationController pushViewController:_loginVc animated:YES];
}

#pragma mark - 请求登录后用户状态信息(会员的捐款总额)
- (void)GetMemberTotalDonationAmountData:(NSString *)memberId{
    MyLog(@"memberId ===== %@",memberId);
    NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetMemberTotalDonationAmount xmlns=\"egive.appservices\"><MemberID>%@</MemberID></GetMemberTotalDonationAmount></soap:Body></soap:Envelope>",memberId];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    //    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        //        MyLog(@"%@", operation.request.allHTTPHeaderFields);
        //
        //        // 服务器给我们返回的包得头部信息
        //        MyLog(@"%@", operation.response);
        
        _dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary * dict1 = [NSString parseJSONStringToNSDictionary:_dataString];
        _donMoney.text = [NSString stringWithFormat:@"$%@",dict1[@"Amt"]];

        NSMutableDictionary * donationAmountDict = [ShowMenuView getDonationAmount];
        if (dict1[@"Amt"] != nil) {
            [donationAmountDict setObject:dict1[@"Amt"] forKey:@"shopItem"];
        }

        
        //        MyLog(@"%@",str);
        
        // 返回的数据
        //        MyLog(@"success = %@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        MyLog(@"%@", operation.request.allHTTPHeaderFields);
        // 服务器给我们返回的包得头部信息
        MyLog(@"%@", operation.response);
        // 返回的数据
        MyLog(@"success = %@", error);
    }];
    
    [operation start];
}

- (NSString *)jSONStringToNSDictionary:(NSString *)JSONString {
    NSRange r;
    while ((r = [JSONString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound){
        JSONString = [JSONString stringByReplacingCharactersInRange:r withString:@""];
        
    }
    return JSONString;
}


#pragma mark - Menu显示与隐藏
//点击菜单按钮执行方法
- (void)menuAction{
    
    _isHidden *= -1;
    [UIView animateWithDuration:0.3 animations:^{
        if (_isHidden == -1) {
            _menuImage.frame = CGRectMake(0, ScreenSize.height-360, ScreenSize.width/2, 60);
            _donationImage.frame = CGRectMake(ScreenSize.width/2, ScreenSize.height-360, ScreenSize.width/2, 60);
            _menuView.frame = CGRectMake(0, ScreenSize.height-300, ScreenSize.width, 300);
        }else{
            _menuImage.frame = CGRectMake(0, ScreenSize.height-60, ScreenSize.width/2, 60);
            _donationImage.frame = CGRectMake(ScreenSize.width/2, ScreenSize.height-60, ScreenSize.width/2, 60);
            _menuView.frame = CGRectMake(0, ScreenSize.height, ScreenSize.width, 300);
            
        }
    } completion:^(BOOL finished){
        
    }];
    
}

- (void)donationAction {
    
    MyDonationViewController * vc = [[MyDonationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

//点击页面跳转方法
- (void)setPageJumpAction:(ViewController *)vc {
    [self.navigationController pushViewController:vc animated:YES];
//    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
//    [menuController setRootController:navController animated:YES];
}

-(void)shareSystem{
   
    NSString * conten = @"";
    NSString * subject = @"";
    if ([EGUtility getAppLang]==1) {
//        NSString *string = @"「網絡相連　善心相傳」\n請即下載 Egive 意贈慈善基金應用程式\n<Apps store & Google Play  Mobile & Pad apps Logo & Link>\n\n意贈慈善基金\nEgive For You Charity Foundation\n電話: (852) 2210 2600\n電郵: info@egive4u.org>";
        
        NSString *string = @"Egive 意贈「嶄新慈善募捐平台」\n善心體現「網絡相連．善心相傳」\n\n官方網頁\nwww.egive4u.org\n\n手機應用程式\nhttp://www.egive4u.org/mobileappinstall.html\n\n意贈慈善基金\nEgive For You Charity Foundation\n電話: (852) 2210 2600\n電郵: info@egive4u.org";
        conten = string;
        subject = @"Egive 意贈「嶄新慈善募捐平台」";
        
    }else if ([EGUtility getAppLang] ==2){
//        NSString *string = @"Egive 意贈慈善基金應用程式\n「網絡相連　善心相傳」請即下載 Egive 意贈慈善基金應用程式\n<Apps store & Google Play  Mobile & Pad apps Logo & Link>意赠慈善基金\n\nEgive For You Charity Foundation\n电話: (852) 2210 2600\n电邮: info@egive4u.org";
//        
         NSString *string = @"Egive 意赠「崭新慈善募捐平台」\n善心体现「网络相连．善心相传」\n\n官方网页\nwww.egive4u.org\n\n手机应用程序\nhttp://www.egive4u.org/mobileappinstall.html\n\n意赠慈善基金\nEgive For You Charity Foundation\n电话: (852) 2210 2600\n电邮: info@egive4u.org";
        conten = string;
        subject = @"Egive 意赠「崭新慈善募捐平台」";
        
    }else{
//        NSString *string = @"\"Be Link Up Net with Love\"\nDownload Egive Mobile App Now!\n<Apps store & Google Play Mobile & Pad apps Logo & Link>\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org";
        
        NSString *string = @"Egive - O2O Charity Platform.\n\"Be Link Up Net with Love\"\n\nOfficial Website:\nwww.egive4u.org\n\nMobile App:\nhttp://www.egive4u.org/mobileappinstall.html\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org";
        conten = string;
        subject = @"Egive - O2O Charity Platform";
    }

    //__weak typeof(self) weakSelf = self;
    [MenuViewController shareToSocialNetworkWithSubject:subject content:conten url:SITE_URL image:nil]; // Example
//    UIActivityViewController *activityViewController =
//    [[UIActivityViewController alloc] initWithActivityItems:@[conten]
//                                      applicationActivities:nil];
//    [self.navigationController presentViewController:activityViewController
//                                            animated:YES
//                                          completion:^{
//                                              // ...
//                                          }];
//    activityViewController.excludedActivityTypes = @[UIActivityTypePrint];
//    [activityViewController setValue:subject forKey:@"subject"];
//   
//    [self.navigationController pushViewController:activityViewController animated:YES];
    
    
//    NSURL *url = [NSURL URLWithString:@"http://getsharekit.com"];
//    SHKItem *item = [SHKItem URL:url title:@"ShareKit is Awesome!" contentType:SHKURLContentTypeWebpage];
//    
//    // ShareKit detects top view controller (the one intended to present ShareKit UI) automatically,
//    // but sometimes it may not find one. To be safe, set it explicitly
//    [SHK setRootViewController:self];
//    
//    // Display the action sheet
//    if (NSClassFromString(@"UIAlertController")) {
//        
//        //iOS 8+
//        SHKAlertController *alertController = [SHKAlertController actionSheetForItem:item];
//        [alertController setModalPresentationStyle:UIModalPresentationPopover];
//        UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
//        popPresenter.barButtonItem = self.toolbarItems[1];
//        [self presentViewController:alertController animated:YES completion:nil];
//        
//    } else {
//        
//        //deprecated
//        SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
//        [actionSheet showFromToolbar:self.navigationController.toolbar];
//    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    MyLog(@"buttonIndex = %ld",buttonIndex);
    if (buttonIndex == 1) {
        [self.navigationController pushViewController:_loginVc animated:YES];
    }
    
}

- (void)saveShoppingCartItem:(NSString *)caseId
{
    EGSaveShoppingCartItemRequest *request = [[EGSaveShoppingCartItemRequest alloc] init];
    request.MemberID = _item.MemberID;
    request.CookieID = @"";
    request.CaseID = caseId;
    request.DonateAmt = 0;
    request.IsChecked = 1;
    
    //    __weak __typeof(self)weakself = self;
    
    [EGMyDonationRequestAdapter saveShoppingCartItem:request success:^(NSString *result) {
        
    } failure:^(NSError *error) {
        MyLog(@"%@",error);
    }];
}

- (void)GetAndSaveShoppingCart{
    
    EGGetAndSaveShoppingCartRequest *request = [[EGGetAndSaveShoppingCartRequest alloc] init];
    request.lang = 1;
    request.LocationCode = @"HK";
    request.DonateWithCharge = YES;
    request.MemberID = _item.MemberID;
    request.CookieID = @"";
    request.StartRowNo = 1;
    request.NumberOfRows = 10;
    
    //    __weak __typeof(self)weakSelf = self;
    [EGMyDonationRequestAdapter getGetAndSaveShoppingCart:request success:^(EGGetAndSaveShoppingCartResult *result) {
        
        _donationsLabel.text = [NSString stringWithFormat:@"%ld",result.NumberOfItems];
        _shoppItem = result;
        MyLog(@"_donationsLabel:%@",_donationsLabel.text);
//        NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
//        if (result != nil) {
//           [shopCartDict setObject:result forKey:@"shopItem"];
//        }
//        _donationsLabel.text = [NSString stringWithFormat:@"%ld",result.NumberOfItems];
        
    } failure:^(NSError *error) {
        MyLog(@"%@",error);
    }];
    
}

//请求消息个数
-(void)requestInboxMsgData{
    
   // [self showLoadingAlert];
    long lang = [EGUtility getAppLang];
    NSString *Apptoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"GetendpointArn"];
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetMailBoxMsg xmlns=\"egive.appservices\"><Lang>%ld</Lang><MsgTp>%@</MsgTp><maxOccurs>30</maxOccurs><minOccurs>0</minOccurs><AppToken>%@</AppToken></GetMailBoxMsg></soap:Body></soap:Envelope>",lang,@"",Apptoken
     ];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml" forHTTPHeaderField:@"Content-Type"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        //        MyLog(@"%@", operation.request.allHTTPHeaderFields);
        //        // 服务器给我们返回的包得头部信息
        //                MyLog(@"%@", operation.response);
        //        返回的数据
        //        MyLog(@"success = %@",responseObject);
        
        //[self removeLoadingAlert];
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        MyLog(@"dataString = %@", dataString);
        
        NSDictionary * dict = [NSString parseJSONStringToNSDictionary:dataString];
        
        MyLog(@"%@",dict);
        
     
        
        MyLog(@"%@",dict[@"MsgList"]);
        
        
            NSArray * listArray = dict[@"MsgList"];
    
        if (listArray.count >99) {
            _messageLabel.text=@"99+";
            
        }else{
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSArray * arr=[user objectForKey:@"HaveReadID"];
            if (((int)listArray.count-(int)arr.count)>0) {
                _messageLabel.hidden=NO;
                _messageLabel.text=[NSString stringWithFormat:@"%lu",listArray.count-arr.count];
            }
            else{
                _messageLabel.hidden=YES;
                _messageLabel.text=[NSString stringWithFormat:@"%d",0];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        MyLog(@"%@", operation.request.allHTTPHeaderFields);
        // 服务器给我们返回的包得头部信息
        MyLog(@"%@", operation.response);
        // 返回的数据
        MyLog(@"success = %@", error);
        //[self removeLoadingAlert];
    }];
    
    [operation start];
    
}

- (void)showLoadingAlert
{
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.progressHUD = [MBProgressHUD showHUDAddedTo:app.window animated:NO];
    [app.window addSubview:self.progressHUD];
    self.progressHUD.dimBackground = YES;
}

- (void)removeLoadingAlert
{
    
    [self.progressHUD hide:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+ (void)shareToSocialNetworkWithSubject:(NSString*)subject content:(NSString*)content url:(NSString*)url image:(UIImage*)image {
    MyLog(@"[shareToSocialNetworkWithSubject] subject=>%@ \ncontent=>%@ \nurl=>%@ \nimage=>%@", subject, content, url, image);
    
    UIAlertController * view = [UIAlertController alertControllerWithTitle:EGLocalizedString(@"意赠慈善基金", nil) message:EGLocalizedString(@"MenuView_shareButton_title", nil) preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIViewController* top = [UIApplication sharedApplication].keyWindow.rootViewController;
//    __weak typeof(self) weakSelf = self;
    
    UIAlertAction* fb = [UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        [view dismissViewControllerAnimated:YES completion:nil];
        
        MyLog(@"Facebook");
        if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
            // TODO: publish content.
            MyLog(@"TODO: publish content");
            if (image != nil) {
                FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
                photo.image = image;
                photo.userGenerated = YES;
                FBSDKSharePhotoContent *sdkcontent = [[FBSDKSharePhotoContent alloc] init];
                sdkcontent.photos = @[photo];
                if (url != nil)
                    sdkcontent.contentURL = [NSURL URLWithString:url];
                UIViewController* top = [UIApplication sharedApplication].keyWindow.rootViewController;
                [FBSDKShareDialog showFromViewController:top withContent:sdkcontent delegate:nil];
            } else if (url != nil) {
                FBSDKShareLinkContent *sdkcontent = [[FBSDKShareLinkContent alloc] init];
                sdkcontent.contentURL = [NSURL URLWithString:url];
                sdkcontent.contentTitle = subject;
                sdkcontent.contentDescription = content;
                
                UIViewController* top = [UIApplication sharedApplication].keyWindow.rootViewController;
                [FBSDKShareDialog showFromViewController:top withContent:sdkcontent delegate:nil];
            } else {
                FBSDKShareLinkContent *sdkcontent = [[FBSDKShareLinkContent alloc] init];
                sdkcontent.contentURL = [NSURL URLWithString:@"http://www.egive4u.org"];
                sdkcontent.contentTitle = subject;
                sdkcontent.contentDescription = content;
                
                UIViewController* top = [UIApplication sharedApplication].keyWindow.rootViewController;
                [FBSDKShareDialog showFromViewController:top withContent:sdkcontent delegate:nil];
            }
        } else {
            
            FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
            [loginManager logInWithPublishPermissions:@[@"publish_actions"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                
                if (error != nil) {
                    MyLog(@"error %@", error);
                }
                MyLog(@"TODO: publish content after grant permission");

                if (image != nil) {
                    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
                    photo.image = image;
                    photo.userGenerated = YES;
                    FBSDKSharePhotoContent *sdkcontent = [[FBSDKSharePhotoContent alloc] init];
                    sdkcontent.photos = @[photo];
                    if (url != nil)
                    sdkcontent.contentURL = [NSURL URLWithString:url];
                    UIViewController* top = [UIApplication sharedApplication].keyWindow.rootViewController;
                    [FBSDKShareDialog showFromViewController:top withContent:sdkcontent delegate:nil];
                } else if (url != nil) {
                    
                    FBSDKShareLinkContent *sdkcontent = [[FBSDKShareLinkContent alloc] init];
                    sdkcontent.contentURL = [NSURL URLWithString:url];
                    sdkcontent.contentTitle = subject;
                    sdkcontent.contentDescription = content;
                    
                    UIViewController* top = [UIApplication sharedApplication].keyWindow.rootViewController;
                    [FBSDKShareDialog showFromViewController:top withContent:sdkcontent delegate:nil];
                } else {
                    FBSDKShareLinkContent *sdkcontent = [[FBSDKShareLinkContent alloc] init];
                    sdkcontent.contentURL = [NSURL URLWithString:@"http://www.egive4u.org"];
                    sdkcontent.contentTitle = subject;
                    sdkcontent.contentDescription = content;
                    
                    UIViewController* top = [UIApplication sharedApplication].keyWindow.rootViewController;
                    [FBSDKShareDialog showFromViewController:top withContent:sdkcontent delegate:nil];
                }
            }];
        }
    }];
    
    
    
    UIAlertAction* wb = [UIAlertAction actionWithTitle:EGLocalizedString(@"Weibo", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [view dismissViewControllerAnimated:YES completion:nil];
        MyLog(@"Weibo");
        
        AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
        authRequest.redirectURI = @"http://www.sino.com";
        authRequest.scope = @"all";
        
        WBMessageObject *message = [WBMessageObject message];
        
//        if (image != nil) {
//            WBImageObject *wbimage = [WBImageObject object];
//            wbimage.imageData = UIImagePNGRepresentation(image);//[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_1" ofType:@"jpg"]];
//            message.imageObject = wbimage;
//        } else if (url != nil) {
//            WBWebpageObject *webpage = [WBWebpageObject object];
//            webpage.objectID = @"identifier1";
//            webpage.title = subject;
//            webpage.description = [NSString stringWithFormat:content, [[NSDate date] timeIntervalSince1970]];
//            webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
//            webpage.webpageUrl = @"http://sina.cn?a=1";
//            message.mediaObject = webpage;
//        } else {
//            FBSDKShareLinkContent *sdkcontent = [[FBSDKShareLinkContent alloc] init];
//            sdkcontent.contentURL = [NSURL URLWithString:@"http://www.egive4u.org"];
//            sdkcontent.contentTitle = subject;
//            sdkcontent.contentDescription = content;
//            
//            UIViewController* top = [UIApplication sharedApplication].keyWindow.rootViewController;
//            [FBSDKShareDialog showFromViewController:top withContent:sdkcontent delegate:nil];
//        }

        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = @"identifier1";
        webpage.title = subject;
        webpage.description = content;
    
    
        if (image != nil) {
            webpage.thumbnailData = UIImageJPEGRepresentation(image, 0.8);
            
//            WBImageObject *WBImageimage = [WBImageObject object];
//            WBImageimage.imageData =UIImagePNGRepresentation(image);
//            message.imageObject = WBImageimage;
//            MyLog(@"%@",WBImageimage);
            
       }
        webpage.webpageUrl=@"http://www.egive4u.org";
        message.mediaObject = webpage;
        message.text = content;
        
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:myDelegate.wbtoken];
        request.userInfo = @{@"ShareMessageFrom": @"MenuViewController",
                             @"Other_Info_1": [NSNumber numberWithInt:123],
                             @"Other_Info_2": @[@"obj1", @"obj2"],
                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}
                             };
        //request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
        [WeiboSDK sendRequest:request];
    }];
    
    
    
    
    NSURL *whatsappURL = [NSURL URLWithString:[NSString stringWithFormat:@"whatsapp://send?text=%@",
//                                               [content stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]
                                               CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)content, NULL, (__bridge CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)))
                                               ]];
    
    UIAlertAction* wa = [UIAlertAction actionWithTitle:@"WhatsApp" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [view dismissViewControllerAnimated:YES completion:nil];
        [[UIApplication sharedApplication] openURL: whatsappURL];
    }];
    

    UIAlertAction* other = [UIAlertAction actionWithTitle:EGLocalizedString(@"Register_org_otherButton", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        [view dismissViewControllerAnimated:YES completion:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"other" object:nil];
        
        EmailItemProvider *email = [EmailItemProvider new];
        email.subject = subject;
        email.body = content;
        
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[email] applicationActivities:nil];
        activityViewController.excludedActivityTypes = @[UIActivityTypePrint];
        [activityViewController setValue:subject forKey:@"subject"];
        
        UIViewController* top = [UIApplication sharedApplication].keyWindow.rootViewController;
        [top presentViewController:activityViewController animated:YES completion:nil];
        
        
    }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:EGLocalizedString(@"取消", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [view dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [view addAction:fb];
    [view addAction:wb];
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
        [view addAction:wa];
    }
    [view addAction:other];
    [view addAction:cancel];
    
    MyLog(@"share [top presentViewController:view animated:YES completion:nil];");
    
    dispatch_async(dispatch_get_main_queue(), ^ {
        
        [top presentViewController:view animated:YES completion:nil];
        
    });
    

    
}

#pragma mark -
#pragma Facebook Share Delegate

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results{
    
    
    MyLog(@"%@",results);
    
    
}
- (void)sharerDidCancel:(id<FBSDKSharing>)sharer{
    
    
    
    
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error{
    
    MyLog(@"%@",error);
    
    
}

#pragma mark -
#pragma WBHttpRequestDelegate

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = NSLocalizedString(@"收到网络回调", nil);
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",result]
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = NSLocalizedString(@"请求异常", nil);
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",error]
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
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
