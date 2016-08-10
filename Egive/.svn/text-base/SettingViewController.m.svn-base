//
//  SettingViewController.m
//  Egive
//
//  Created by sino on 15/7/30.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCell.h"
#import "UIView+ZJQuickControl.h"
#import "CallViewController.h"
#import "MessagePromptViewController.h"
#import "MessageViewController.h"
#import "CommonProblemsViewController.h"
#import "ConditionClauseViewController.h"
#import "MyDonationViewController.h"
#import "HomeViewController.h"
#import "Constants.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface SettingViewController () {
    BOOL isSwitchLang;
}
@property (strong, nonatomic) UILabel * cartLabel;
@property (nonatomic, weak)UILabel * language;
@property (nonatomic, weak)UILabel * contactLabel;
@property (nonatomic, weak)UILabel * prompt;
@property (nonatomic, weak)UILabel * errorLabel;
@property (nonatomic, weak)UILabel * stipulation;
@property (nonatomic, weak)UILabel * version;
@end

@implementation SettingViewController

- (void)leftAction{
    if (isSwitchLang) {
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        HomeViewController * vc = [[HomeViewController alloc] init];
        [self.navigationController setViewControllers:[NSArray arrayWithObject:vc] animated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
 
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 33, 33);
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_cart@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //购物车右侧数量标示label
    NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
    EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];

    _cartLabel = [self.navigationController.navigationBar addLabelWithFrame:CGRectMake(ScreenSize.width-30, 18, 18, 18) text:[NSString stringWithFormat:@"%ld",item.NumberOfItems]];
    _cartLabel.layer.cornerRadius = 9;
    _cartLabel.layer.masksToBounds = YES;
    _cartLabel.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    _cartLabel.textAlignment = NSTextAlignmentCenter;
    _cartLabel.font = [UIFont systemFontOfSize:11];
    _cartLabel.textColor = [UIColor whiteColor];

    
    [self createTableView];
    [self createFooterButton];
    [self createMenuUI];
}
- (void)rightAction{
    
    MyDonationViewController * vc = [[MyDonationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    _cartLabel.hidden = NO;
    //购物车右侧数量标示label
    NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
    EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
    if (item.NumberOfItems < 1) {
        _cartLabel.hidden = YES;
    }else{
        _cartLabel.hidden = NO;
    }
    [super viewWillAppear:animated];
    
    [self updateLocalizedString];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    _cartLabel.hidden = YES;
}
- (void)createTableView{
    
 
//    UILabel * language = [self.view addLabelWithFrame:CGRectMake(20, 90, 40, 25) text:nil];
//    language.font = [UIFont systemFontOfSize:14];
//    language.textColor = [UIColor grayColor];
//    _language = language;
    

    
    NSArray * languageArray = @[@"Eng",@"繁",@"简"];
    NSArray * norBg = @[@"comment_segment_left_nor.png",@"comment_segment_middle_nor.png",@"comment_segment_right_nor.png"];
    NSArray * selBg = @[@"comment_segment_left_sel.png",@"comment_segment_middle_sel.png",@"comment_segment_right_sel.png",];
    __weak typeof(self) weakSelf = self;
    for (int i = 0; i < 3; i ++) {
        UIButton * button = [self.view addImageButtonWithFrame:CGRectMake(i*(ScreenSize.width-20)/3+10,90, (ScreenSize.width-20)/3, 25) title:languageArray[i] backgroud:norBg[i] action:^(UIButton *button) {
            for (int i = 0; i < 3; i ++) {
                UIButton * button = (UIButton *)[weakSelf.view viewWithTag:220+i];
                button.selected = NO;
            }
            if (button.tag == 220) {
                
                
                [weakSelf switchLang:EN];
                button.selected = YES;
                [weakSelf ChangeAppLanguageSetting:3];
                
            }else if (button.tag == 221){
                
                
                button.selected = YES;
                [weakSelf switchLang:HK];
                [weakSelf ChangeAppLanguageSetting:1];
                
                
            }else{
                
                
                button.selected = YES;
                [weakSelf switchLang:CN];
                 [weakSelf ChangeAppLanguageSetting:2];
                
            }

        }];
        button.tag = 220+i;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor colorWithRed:70.0/255.0 green:180.0/255.0 blue:4.0/255.0 alpha:1] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:selBg[i]] forState:UIControlStateSelected];
    }
    AppLang lang = [EGUtility getAppLang];
    UIButton *enBtn = (UIButton*)[self.view viewWithTag:220];
    UIButton *hkBtn = (UIButton*)[self.view viewWithTag:221];
    UIButton *cnBtn = (UIButton*)[self.view viewWithTag:222];
    
    switch (lang){
        case HK:
            hkBtn.selected = YES;
            break;
        case CN:
            cnBtn.selected = YES;
            break;
        case EN:
            enBtn.selected = YES;
            break;
        default:
            break;
    }
    

    [self.view addImageViewWithFrame:CGRectMake(10, 135, ScreenSize.width-20, 2) image:@"Line@2x.png"];
    
    
    UILabel * contactLabel = [self.view addLabelWithFrame:CGRectMake(20, 160, ScreenSize.width-40, 30) text:nil];
    contactLabel.userInteractionEnabled = YES;
    contactLabel.font = [UIFont systemFontOfSize:15];
    contactLabel.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    contactLabel.layer.cornerRadius = 3;
    contactLabel.layer.borderColor = [[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1]CGColor];
    contactLabel.layer.borderWidth = 1;
    _contactLabel  = contactLabel;
    [contactLabel addImageViewWithFrame:CGRectMake(ScreenSize.width-70, 0, 30, 30) image:@"AlbumTimeLineTipArrow@2x.png"];

    UITapGestureRecognizer * callTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callTapAction)];
    [contactLabel addGestureRecognizer:callTap];
    
    UILabel * prompt = [self.view addLabelWithFrame:CGRectMake(20, 210, ScreenSize.width-40, 30) text:nil];
    prompt.userInteractionEnabled = YES;
    prompt.font = [UIFont systemFontOfSize:15];
    prompt.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    prompt.layer.cornerRadius = 3;
    prompt.layer.borderColor = [[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1]CGColor];
    prompt.layer.borderWidth = 1;
    _prompt = prompt;

    UITapGestureRecognizer * proTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(proTapAction)];
    [prompt addGestureRecognizer:proTap];
    
    [prompt addImageViewWithFrame:CGRectMake(ScreenSize.width-70, 0, 30, 30) image:@"AlbumTimeLineTipArrow@2x.png"];
    
    UILabel * errorLabel = [self.view addLabelWithFrame:CGRectMake(20, 260, ScreenSize.width-40, 30) text:nil];
    errorLabel.userInteractionEnabled = YES;
    errorLabel.font = [UIFont systemFontOfSize:15];
    errorLabel.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    errorLabel.layer.cornerRadius = 3;
    errorLabel.layer.borderColor = [[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1]CGColor];
    errorLabel.layer.borderWidth = 1;
    _errorLabel = errorLabel;
    
    UITapGestureRecognizer * problemTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(problemTapAction)];
    [errorLabel addGestureRecognizer:problemTap];
    
    [errorLabel addImageViewWithFrame:CGRectMake(ScreenSize.width-70, 0, 30, 30) image:@"AlbumTimeLineTipArrow@2x.png"];

    UILabel * stipulation = [self.view addLabelWithFrame:CGRectMake(20, 310, ScreenSize.width-40, 30) text:nil];
    stipulation.userInteractionEnabled = YES;
    stipulation.font = [UIFont systemFontOfSize:15];
    stipulation.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    stipulation.layer.cornerRadius = 3;
    stipulation.layer.borderColor = [[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1]CGColor];
    stipulation.layer.borderWidth = 1;
    _stipulation = stipulation;
    
    UITapGestureRecognizer * stiTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stiTapAction)];
    [stipulation addGestureRecognizer:stiTap];

    
    [stipulation addImageViewWithFrame:CGRectMake(ScreenSize.width-70, 0, 30, 30) image:@"AlbumTimeLineTipArrow@2x.png"];
    
    UILabel * versions = [self.view addLabelWithFrame:CGRectMake(20, 350, 150, 25) text:@"版本 1.1"];
    versions.font = [UIFont systemFontOfSize:16];
    versions.textColor = [UIColor grayColor];
    _version = versions;
    
}

- (void)callTapAction {
    
    CallViewController * vc = [[CallViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)proTapAction {
    
//  MessagePromptViewController * vc = [[MessagePromptViewController alloc] init];
    MessageViewController * vc = [[MessageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)problemTapAction{
    
    CommonProblemsViewController * vc = [[CommonProblemsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)stiTapAction {
    
    ConditionClauseViewController * vc = [[ConditionClauseViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)switchLang:(AppLang)lang
{
    [EGUtility setAppLang:lang];
    isSwitchLang = true;
    // update
    [self updateLocalizedString];
    
}

- (void)updateLocalizedString{
    
    [self updateLangString];
    self.title = EGLocalizedString(@"Setting_Title", nil);
    if ([EGUtility getAppLang] == 3) {
        _language.frame = CGRectMake(5, 90, 60, 25);
    }else{
        _language.frame = CGRectMake(20, 90, 40, 25);
    }
    _language.text = EGLocalizedString(@"Setting_label_language", nil);
    _contactLabel.text = EGLocalizedString(@"Setting_label_title1", nil);
    _prompt.text = EGLocalizedString(@"Setting_label_title2", nil);
    _errorLabel.text = EGLocalizedString(@"Setting_label_title3", nil);
    _stipulation.text = EGLocalizedString(@"Setting_label_title4", nil);
    NSString *versionText = EGLocalizedString(@"Setting_label_version", nil);
    _version.text = [NSString stringWithFormat:@"%@ %@",versionText, [EGUtility getAppVer]];
}
//请求详细信息
#pragma mark - 请求Cell数据
-(void)ChangeAppLanguageSetting:(long)AppLang{
    
    [self showLoadingAlert];
    NSString *Apptoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"GetendpointArn"];
    
    MyLog(@"%@",Apptoken);
    
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ChangeAppLanguageSetting xmlns=\"egive.appservices\"><AppLang>%ld</AppLang><AppToken>%@</AppToken></ChangeAppLanguageSetting></soap:Body></soap:Envelope>",AppLang,Apptoken];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml" forHTTPHeaderField:@"Content-Type"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        MyLog(@"dataString = %@", dataString);
        
        NSDictionary * dict = [NSString parseJSONStringToNSDictionary:dataString];
        
        
        MyLog(@"%@",dict);
        
        [self removeLoadingAlert];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        MyLog(@"%@", operation.request.allHTTPHeaderFields);
        // 服务器给我们返回的包得头部信息
        MyLog(@"%@", operation.response);
        // 返回的数据
        MyLog(@"success = %@", error);
        [self removeLoadingAlert];
    }];
    
    [operation start];
    
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
