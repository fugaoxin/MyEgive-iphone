//
//  HomeViewController.m
//  Egive
//
//  Created by sino on 15/7/20.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "Constants.h"
#import <QuartzCore/QuartzCore.h>
#import "HomeViewController.h"
#import "MyDonationViewController.h"
#import "UIView+ZJQuickControl.h"
#import "HomeTableViewCell.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "NSString+RegexKitLite.h"
#import "DMScrollingTicker.h"
#import "InformationController.h"
#import "LoginViewController.h"
#import "MyAttentionViewController.h"
#import "MyDonationViewController.h"
#import "ActivityViewController.h"
#import "ProReportController.h"
#import "GirdViewController.h"

#import "EncourageOthersController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

#define ScreenSize [UIScreen mainScreen].bounds.size
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *l;
    NSMutableArray *sizes;
    DMScrollingTicker * _scrollingTicker;
    LPScrollingTickerLabelItem *_adlabel;
    UIView * _topView;
    UIView * _headerView;
    NSDictionary * _amtCountdict;
    UILabel * _cartCount;
    BOOL _isSwap;
    NSArray * _titleArray;
    NSArray * _imageArray;
    
    UIView * _menuView;
    UIImageView * _menuImage;
    UIImageView * _donationImage;
    int _isHidden;
    NSMutableArray * _speakerArray;
    NSMutableArray * _dataArray;
    NSMutableArray * _adArray;
    NSTimer * _timer;
    NSTimer * _timerView;
    NSTimer * _timerBannerAd;
    NSTimer * _pushTimer;
    int _timerFlag;
    int _timerFlagBannerAd;
    UIView * _dotView;
    NSDictionary * _typeImageDict;
    NSString *currentAdURL;
    MyAttentionViewController * MyAttentionViewvc;
    LoginViewController * LoginViewloginvc;
    
    NSMutableArray * CateImageSortarray;
    NSMutableDictionary *CateImageSortdict;
    NSArray *KeyCateArray;
    UIButton * _messageButton;
    
   
    
}
@property (copy, nonatomic) NSMutableDictionary * shareDict;
@property (copy, nonatomic) NSMutableArray * ShoppingCartArr;
@property (strong, nonatomic) MemberModel * item;
@property (strong, nonatomic)UITableView * tableView;
@property (copy, nonatomic) NSMutableArray * caseIDarr;
@property (strong, nonatomic) UIImageView * cellShowImage;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    NSMutableArray *controllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
//    MyLog(@"%ld",controllers.count);
    
     _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.width/3)];
    [self.view addSubview:_headerView];
    
    _cellShowImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.width/4*3)];
    //判断用户是否登入，如登入获取：MemberID
    _shareDict = [ShowMenuView getUserInfo];
    _item = _shareDict[@"LoginName"];
    
// _ShoppingCartArr = [ShowMenuView getIsSaveShoppingCart];
    
    _ShoppingCartArr = [[NSMutableArray alloc] init];
    NSArray * arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"isCartItem"];
    if (arr) {
        [_ShoppingCartArr addObjectsFromArray:arr];
    }
    
    
    _caseIDarr = [[NSMutableArray alloc] init]; //购物车中的caseID
    _speakerArray = [[NSMutableArray alloc] init];
    _timerFlag = 0;
    _timerFlagBannerAd = 0;
    _typeImageDict = @{
                       @"O":@"comment_list_type_others.png",//其他
                       @"S":@"comment_list_type_education@2x.png",//助学
                       @"E":@"comment_list_type_elder@2x.png",//助老
                       @"M":@"comment_list_type_medical@2x.png",//助医
                       @"P":@"comment_list_type_poverty@2x.png",//扶贫
                       @"U":@"comment_list_type_emergency@2x.png",//紧急援助
                       @"A":@"comment_list_type_case_list@2x.png"//意赠行动
                       };

    CateImageSortarray = [[NSMutableArray alloc] initWithObjects:@"O",@"S",@"E",@"M",@"P",@"U",@"A",nil];
    CateImageSortdict = [[NSMutableDictionary alloc] init];
    [CateImageSortdict setObject:@"O" forKey:@"key1"];
    [CateImageSortdict setObject:@"S" forKey:@"key2"];
    [CateImageSortdict setObject:@"E" forKey:@"key3"];
    [CateImageSortdict setObject:@"M" forKey:@"key4"];
    [CateImageSortdict setObject:@"P" forKey:@"key5"];
    [CateImageSortdict setObject:@"U" forKey:@"key6"];
    [CateImageSortdict setObject:@"A" forKey:@"key7"];
    
    
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 30, 30);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"header_message.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
//    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftButton.frame = CGRectMake(0, 0, 85,50);
//    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
//    [leftButton setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
//    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    self.navigationItem.leftBarButtonItem = leftItem;


    _navImage = [self.navigationController.navigationBar addImageViewWithFrame:CGRectMake(ScreenSize.width/2-35, 0, 70, 50) image:@"header_logo@2x.png"];
    
    // 左上角粒鼻屎
    _dotView = [[UIView alloc] initWithFrame:CGRectMake(44, 7, 8, 8)];
    _dotView.layer.cornerRadius = 4;
    _dotView.layer.masksToBounds = YES;
    _dotView.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    [self.navigationController.navigationBar addSubview:_dotView];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"MsgInboxCount"] integerValue] == 0){
        _dotView.hidden=YES;
        
    }else{
        _dotView.hidden=NO;
        
    }

    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_cart.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    
    //购物车数量
    _cartCount = [self.navigationController.navigationBar addLabelWithFrame:CGRectMake(ScreenSize.width-30, 18, 18, 18) text:nil];
    _cartCount.layer.cornerRadius = 9;
    _cartCount.layer.masksToBounds = YES;
    _cartCount.hidden = YES;
    _cartCount.textAlignment = NSTextAlignmentCenter;
    _cartCount.font = [UIFont systemFontOfSize:11];
    _cartCount.textColor = [UIColor whiteColor];
    _cartCount.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];

    
    _adArray = [[NSMutableArray alloc] init];
    //定时切换cell中紫色view的数据
    _timerView = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerViewAction) userInfo:nil repeats:YES];
    _isSwap = YES;
    
    _pushTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(pushPro) userInfo:nil repeats:YES];

    
    [self requestSpeakerData];
    [self requestBannerAd];
    [self createTopViewUI];
    [self createTable];
    [self createFooterButton];
    [self createMenuUI];
    
   MyAttentionViewvc = [[MyAttentionViewController alloc] init];
  LoginViewloginvc = [[LoginViewController alloc] initWithToggleViewController:MyAttentionViewvc];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proAction) name:@"isProReport" object:nil];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeInboxCountAction) name:@"changeInboxCount" object:nil];
   
}

//收到推送通知跳转到对应页面
-(void)proAction{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults objectForKey:@"msgType"]) {
        if ([[standardUserDefaults objectForKey:@"msgType"] isEqualToString:@"P"]) {
            ProReportController * vc = [[ProReportController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([[standardUserDefaults objectForKey:@"msgType"] isEqualToString:@"A"]){
            
            ActivityViewController * vc = [[ActivityViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([[standardUserDefaults objectForKey:@"msgType"] isEqualToString:@"N"]){
            
            GirdViewController * vc = [[GirdViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([[standardUserDefaults objectForKey:@"msgType"] isEqualToString:@"R"]){
            
            GirdViewController * vc = [[GirdViewController alloc] init];
            vc.isSucPush = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([[standardUserDefaults objectForKey:@"msgType"] isEqualToString:@"S"]){
            
            MyDonationViewController * vc = [[MyDonationViewController alloc] init];
            vc.isByPush = YES;
            [self.navigationController pushViewController:vc animated:YES];

        }
        
    }else{
            
    }

}


-(void)pushPro{
     //[self proAction];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([[standardUserDefaults objectForKey:@"ispush"] isEqualToString:@"1"]) {
        
        [standardUserDefaults setObject:@"0" forKey:@"ispush"];
        [standardUserDefaults synchronize];
        
        [self proAction];
        
    }
}

- (void)timerViewAction{
    
    
    if (_isSwap) {
        _isSwap = NO;
        
    }else{
        _isSwap = YES;
    }
//    NSArray *indexPaths = [_tableView indexPathsForVisibleRows];
//    [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [_tableView reloadData];
    
}

- (void)rightAction {
    
    MyDonationViewController * vc = [[MyDonationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)leftAction {
    InformationController * vc = [[InformationController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//    InformationController * vc = [[InformationController alloc] init];
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
//    [menuController setRootController:navController animated:YES];
}

- (void)createTopViewUI{
    
    
    _speaker = [self.view addLabelWithFrame:CGRectMake(40, 64,ScreenSize.width-40,25) text:nil];
    _speaker.font = [UIFont systemFontOfSize:11];
    _speaker.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    _speaker.userInteractionEnabled = YES;
    
    UIView * nullView = [[UIView alloc] initWithFrame:CGRectMake(40, 64,ScreenSize.width-40,25)];
//    nullView.alpha= 0;
    nullView.userInteractionEnabled = YES;
    [self.view addSubview:nullView];
    

    
    UITapGestureRecognizer * speakerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sepeakerAction)];
    [nullView addGestureRecognizer:speakerTap];
   // _topImage = [_headerView addImageViewWithFrame:CGRectMake(0, 45, ScreenSize.width, 90) image:nil];
    //_topImage.contentMode = UIViewContentModeScaleAspectFit;
   // _topImage.userInteractionEnabled = YES;

    UIView * speakView = [[UIView alloc] initWithFrame:CGRectMake(0, 67, 30, 25)];
    speakView.backgroundColor= [UIColor whiteColor];
    [self.view addSubview:speakView];
    [self.view addImageViewWithFrame:CGRectMake(10, 67, 18, 18) image:@"header_speaker.png"];
    
     NSInteger  lang = [EGUtility getAppLang];
    if (lang == 3) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 45)];
        _topView.backgroundColor = [UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1];
        [_headerView addSubview:_topView];
        
        UILabel * moneyLabel = [_topView addLabelWithFrame:CGRectMake(10, 5, ScreenSize.width/2, 20) text:EGLocalizedString(@"HomePage_cumulativeAmount_label", nil)];
        moneyLabel.font = [UIFont systemFontOfSize:12];
        moneyLabel.textColor = [UIColor whiteColor];
        
        _totalAmt = [_topView addLabelWithFrame:CGRectMake(10, 25, ScreenSize.width/2, 20) text:@""];
        _totalAmt.font = [UIFont systemFontOfSize:13];
        _totalAmt.textColor = [UIColor whiteColor];
        
        UILabel * countLabel = [_topView addLabelWithFrame:CGRectMake(ScreenSize.width/2+10, 5, 150, 20) text:EGLocalizedString(@"HomePage_cumulative_label", @"")];
        countLabel.font = [UIFont systemFontOfSize:12];
        countLabel.textColor = [UIColor whiteColor];
        
        _totalDonorCount = [_topView addLabelWithFrame:CGRectMake(ScreenSize.width/2+10, 25, ScreenSize.width/2-80, 20) text:nil];
        _totalDonorCount.font = [UIFont systemFontOfSize:13];
        _totalDonorCount.textColor = [UIColor whiteColor];
        
//        _totalAmt.text = [NSString stringWithFormat:@"$%@",[NSString strmethodComma:_amtCountdict[@"TotalAmt"]]];
//        _totalDonorCount.text = [NSString stringWithFormat:@"%@",_amtCountdict[@"TotalDonorCount"]];
       // _topImage.frame = CGRectMake(0, 45, ScreenSize.width, 90);
        
         _topImage = [_headerView addImageViewWithFrame:CGRectMake(0, 45, ScreenSize.width, ScreenSize.width/3) image:nil];
        _topImage.contentMode = UIViewContentModeScaleAspectFill;
         _topImage.userInteractionEnabled = YES;
       
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BannerAdTap:)];
//        [_topImage addGestureRecognizer:tap];
        
    }else{
        
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 30)];
        
        _topView.backgroundColor = [UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1];
        [_headerView addSubview:_topView];
        UILabel * moneyLabel = [_topView addLabelWithFrame:CGRectMake(10, 5, 80, 20) text:EGLocalizedString(@"HomePage_cumulativeAmount_label", nil)];
        moneyLabel.font = [UIFont systemFontOfSize:12];
        moneyLabel.textColor = [UIColor whiteColor];
        
        _totalAmt = [_topView addLabelWithFrame:CGRectMake(90, 5, ScreenSize.width/2-80, 20) text:@""];
        _totalAmt.font = [UIFont systemFontOfSize:13];
        _totalAmt.textColor = [UIColor whiteColor];
        
        UILabel * countLabel = [_topView addLabelWithFrame:CGRectMake(ScreenSize.width/2+35, 5, 55, 20) text:EGLocalizedString(@"HomePage_cumulative_label", @"")];
       // countLabel.backgroundColor = [UIColor redColor];
        countLabel.font = [UIFont systemFontOfSize:12];
        countLabel.textColor = [UIColor whiteColor];
        
        _totalDonorCount = [_topView addLabelWithFrame:CGRectMake(ScreenSize.width/2+90, 5, ScreenSize.width/2-80, 20) text:@""];
        _totalDonorCount.font = [UIFont systemFontOfSize:13];
        //_totalDonorCount.backgroundColor = [UIColor greenColor];
        _totalDonorCount.textColor = [UIColor whiteColor];
//        _totalAmt.text = [NSString stringWithFormat:@"$%@",[NSString strmethodComma:_amtCountdict[@"TotalAmt"]]];
//        _totalDonorCount.text = [NSString stringWithFormat:@"%@",_amtCountdict[@"TotalDonorCount"]];
  
        _topImage = [_headerView addImageViewWithFrame:CGRectMake(0, 30, ScreenSize.width, ScreenSize.width/3) image:nil];
        //_topImage.frame=CGRectMake(0, 30, ScreenSize.width, 110);
        _topImage.userInteractionEnabled = YES;
        _topImage.contentMode = UIViewContentModeScaleAspectFill;
//        if (_adArray.count > 0) {
//            HomeModel * model = _adArray[0];
//            NSURL *url = [NSURL URLWithString:model.FilePath];
//            [_topImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Icon-1024.png"]];
//        }
        
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BannerAdTap:)];
//        [_topImage addGestureRecognizer:tap];
    }
    
//    NSURL *url = [NSURL URLWithString:@"http://www.egive4u.org/HeaderBannerImage/E6FFAF56-6D9E-4007-B17F-966620307020.jpg"];
//    [_topImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Icon-1024.png"]];
    
}

- (void)BannerAdTap:(UITapGestureRecognizer*)tap{
    
    MyLog(@"%ld",tap.view.tag);
    
    HomeModel * model = _adArray[tap.view.tag-600];
    
    MyLog(@"%@",model.RelatedImageFilePath);
    if (![model.URL isEqualToString:@""]) {
        
      BannerAdViewController * vc = [[BannerAdViewController alloc] init];
      vc.url= model.URL;
      [self.navigationController pushViewController:vc animated:YES];

        
    }else if (![model.RelatedImageFilePath isEqualToString:@""]){
        
        
        BannerAdViewController * vc = [[BannerAdViewController alloc] init];
        vc.imageurl=model.RelatedImageFilePath;
        [self.navigationController pushViewController:vc animated:YES];
        
    
    }else if(![model.RelatedVideoFilePath isEqualToString:@""]){
    
       
       NSString *videoString = [SITE_URL stringByAppendingPathComponent:[model.RelatedVideoFilePath stringByReplacingOccurrencesOfString:@"\\" withString:@"/"]];
        
        MyLog(@"%@",videoString);
        
        MPMoviePlayerViewController *mpvc = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:videoString]];
        mpvc.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
       
        
        [self presentViewController:mpvc animated:YES completion:nil];
       
        
     }

}
- (void)sepeakerAction{
    
    //支持意赠 支持意赠
    NSString *content = _speaker.text;
    
    if ([content rangeOfString:@"支持意赠"].location != NSNotFound) {
        return;
    }
    
    if([content rangeOfString:@"支持意贈"].length>0) return;
    
    HomeModel * model = _speakerArray[_timerFlag-1];
    GirdDetailViewController *vc = [[GirdDetailViewController alloc] init];
    vc.caseID = model.CaseID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 请求顶部Speaker数据
-(void)requestSpeakerData{
    
    long lang = [EGUtility getAppLang];
   
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <GetDonationBar xmlns=\"egive.appservices\"><Lang>%ld</Lang><IsFirstTimeLoading>0</IsFirstTimeLoading><UpdateTime></UpdateTime><MemberID></MemberID></GetDonationBar></soap:Body></soap:Envelope>",lang];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml" forHTTPHeaderField:@"Content-Type"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//                // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
//                MyLog(@"%@", operation.request.allHTTPHeaderFields);
//                // 服务器给我们返回的包得头部信息
//                        MyLog(@"%@", operation.response);
//              //  返回的数据
//                MyLog(@"success = %@",responseObject);
        
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary * dict = [NSString parseJSONStringToNSDictionary:dataString];
        
        NSArray * arr = dict[@"ItemList"];
        for (NSDictionary * listDict in arr) {
            HomeModel * model = [[HomeModel alloc] init];
            [model setValuesForKeysWithDictionary:listDict];
            [_speakerArray addObject:model];
        }
        [self adtimerAction];
        _timer = [NSTimer scheduledTimerWithTimeInterval:9.5 target:self selector:@selector(adtimerAction) userInfo:nil repeats:YES];
 
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


#pragma mark - 请求顶部[累积金额&累积人次]数据
-(void)requestTotalDonationInfoData{
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetTotalDonationInfo xmlns=\"egive.appservices\"/></soap:Body></soap:Envelope>"
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
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        _amtCountdict = [NSString parseJSONStringToNSDictionary:dataString];
        
        [_tableView reloadData];
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
#pragma mark - 请求广告数据
-(void)requestBannerAd{
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetAppBannerAd xmlns=\"egive.appservices\" /></soap:Body></soap:Envelope>"
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
        //                // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        //                MyLog(@"%@", operation.request.allHTTPHeaderFields);
        //                // 服务器给我们返回的包得头部信息
        //                        MyLog(@"%@", operation.response);
        //              //  返回的数据
        //                MyLog(@"success = %@",responseObject);
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSArray * arr = [NSString parseJSONStringToNSArray:dataString];
        NSString *baseURL = SITE_URL;
        
        MyLog(@"%@",arr);
        
        for (NSDictionary * adDict in arr) {
            
            MyLog(@"adDict adDict = %@", adDict);
            
            HomeModel * model = [[HomeModel alloc] init];
            [model setValuesForKeysWithDictionary:adDict];
            
//            model.URL = [adDict objectForKey:@"URL"];
           model.FilePath = [baseURL stringByAppendingPathComponent:[[adDict objectForKey:@"FilePath"] stringByReplacingOccurrencesOfString:@"\\" withString:@"/"]];
//            model.RelatedImageFilePath = [baseURL stringByAppendingPathComponent:[[adDict objectForKey:@"RelatedImageFilePath"] stringByReplacingOccurrencesOfString:@"\\" withString:@"/"]];
//            
//           model.RelatedVideoFilePath = [baseURL stringByAppendingPathComponent:[[adDict objectForKey:@"RelatedVideoFilePath"] stringByReplacingOccurrencesOfString:@"\\" withString:@"/"]];
            
            MyLog(@"model.URL = %@", model.URL);
            MyLog(@"FilePath = %@", model.FilePath);
            
            [_adArray addObject:model];
        }
        
        [self timerAction1];
        _timerBannerAd = [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(timerAction1) userInfo:nil repeats:YES];

        [_tableView reloadData];
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


#pragma mark - 请求Cell数据
-(void)requestApiData:(NSString *)memberID{
    
    [self showLoadingAlert];
   long lang = [EGUtility getAppLang];
    if (memberID == NULL) {
        memberID = @"";
    }
    MyLog(@"%@",memberID);
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCaseList xmlns=\"egive.appservices\"><Lang>%ld</Lang><Category>%@</Category><CaseTitle></CaseTitle><MemberID>%@</MemberID><StartRowNo>1</StartRowNo><NumberOfRows>12</NumberOfRows></GetCaseList></soap:Body></soap:Envelope>",lang,@"Random",memberID
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
        
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        MyLog(@"dataString = %@", dataString);
        
        NSDictionary * dict = [NSString parseJSONStringToNSDictionary:dataString];
        MyLog(@"%@",dict);
        
         _dataArray = [[NSMutableArray alloc] init];
        
       if (![dict[@"ItemList"] isEqual:[NSNull null]]){
            NSArray * listArray = dict[@"ItemList"];
            //int x = 0;
            for (NSDictionary * listDict in listArray) {
               //if (x == 120) break; // max show 12 cases
                GirdModel *  model = [[GirdModel alloc] init];
                [model setValuesForKeysWithDictionary:listDict];
                [_dataArray addObject:model];
              // x++;
            }
            

        }
        
    
//    if (![dict[@"ItemList"] isEqual:[NSNull null]]){
//        NSMutableArray *dataTempArray = [[NSMutableArray alloc] init];
//        _dataArray = [[NSMutableArray alloc] init];
//        NSArray * listArray = dict[@"ItemList"];
//        for (NSDictionary * listDict in listArray){
//            GirdModel *  model = [[GirdModel alloc] init];
//            [model setValuesForKeysWithDictionary:listDict];
//             [dataTempArray addObject:model];
//            }
//        
//        while ([_dataArray count] < 12) {
//            int r = arc4random() % [dataTempArray count];
//            GirdModel *  model = [dataTempArray objectAtIndex:r];
//            if (![_dataArray containsObject:model]){
//                
//                [_dataArray addObject:[dataTempArray objectAtIndex:r]];
//
//                
//            }
//        }
//    
//        }
        
//        NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
//        EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
        
        [self GetAndSaveShoppingCart]; //请求购物车数据
//        [self changeCount];
        
        [_tableView reloadData];
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


- (void)adtimerAction{
    HomeModel * model = _speakerArray[_timerFlag % _speakerArray.count];
    _speaker.textColor = [UIColor clearColor];
    _speaker.text = @"";
    [self.view.layer removeAllAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        _speaker.text = [NSString stringWithFormat:@"　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　%@", model.Msg];
        [_speaker sizeToFit];
        
        CGRect frame = CGRectMake(40, 64,_speaker.frame.size.width,25);
        frame.origin.x = 40;
        _speaker.frame = frame;
        [UIView beginAnimations:@"testAnimation" context:NULL];
        [UIView setAnimationDuration:9.0f];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView setAnimationRepeatCount:999];
        frame = _speaker.frame;
        frame.origin.x = -frame.size.width;
        _speaker.frame = frame;
        
        [UIView commitAnimations];
        _speaker.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    });
    
    _timerFlag ++;
}

- (void)createTable{
    NSInteger lang = [EGUtility getAppLang];
    if (lang == 3) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,90, ScreenSize.width, ScreenSize.height-85) style:UITableViewStyleGrouped];
    }else{
         _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,90, ScreenSize.width, ScreenSize.height-85) style:UITableViewStyleGrouped];
    }
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = ScreenSize.width/4*3;
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"cell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
    }
    
    if (_isSwap) {
        cell.bgView.hidden = NO;
        cell.bgView1.hidden = YES;
    }else{
        cell.bgView.hidden = YES;
        cell.bgView1.hidden = NO;
    }
    if (_dataArray.count > 0) {
        GirdModel * model = _dataArray[indexPath.row];
        if (![model.ProfilePicURL isEqualToString:@""] && model.ProfilePicURL) {
            NSURL *url = [NSURL URLWithString:SITE_URL];
            url = [url URLByAppendingPathComponent:model.ProfilePicURL];
            [cell.showImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
            cell.showImage.contentMode = UIViewContentModeScaleAspectFill;
            CGRect frame = cell.showImage.frame;
            frame.size.height = ScreenSize.width/4*3;
            cell.showImage.frame = frame;
            cell.showImage.clipsToBounds = YES;
            
//            cell.showImage.contentMode = UIViewContentModeScaleAspectFit;
//            cell.showImage.image =[self cutCellImage:cell.showImage.image];
            
        }else{
            
            [cell.showImage setImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"]];
//           cell.showImage.contentMode = UIViewContentModeScaleAspectFit;
        }
        //收藏按钮
        __weak typeof(self)weakSelf = self;
        [cell.favouriteButton setAction:^(MyBtn * button) {
            
            NSMutableDictionary * dict = [ShowMenuView getUserInfo];
            if ([dict objectForKey:@"LoginName"] != nil) {
                
                if (model.Isfavourite) {
                    
                    [weakSelf DeleteCaseFavourite:indexPath];
                    
                }else{
                    
                    [weakSelf AddCaseFavourite:indexPath];
                 
                }
            }else{

//                LoginViewController * vc = [[LoginViewController alloc] init];
//                [self.navigationController pushViewController:vc animated:YES];4
                
              MyAttentionViewController  *vc = [[MyAttentionViewController alloc] init];
               LoginViewController *loginvc = [[LoginViewController alloc] initWithToggleViewController:MyAttentionViewvc];
               
                vc.caseId = model.CaseID;
                vc.isFavouritePush = YES;
                [self.navigationController pushViewController:loginvc animated:YES];
            }
        }];
        
        cell.succeedImage.hidden = YES;
        if (model.IsSuccess) {
            cell.succeedImage.hidden = NO;
        }
        
        if (model.Isfavourite == YES) {
            cell.favouriteButton.selected = YES;
        }else{
            cell.favouriteButton.selected = NO;
        }
        
        cell.titleLabel.text = [NSString stringWithFormat:@"%@ (%@)", model.Title, model.Region];
        cell.titleLabel1.text = [NSString stringWithFormat:@"%@ (%@)", model.Title, model.Region];
        cell.progress.progress = model.Percentage/100;
        if (model.Percentage >= 100) {
             cell.proLabel.text = [NSString stringWithFormat:@"100%%"];
        }else{
            cell.proLabel.text = [NSString stringWithFormat:@"%2.f%%",model.Percentage];
        }
        cell.progressImg.hidden = model.Percentage >= 100 ? YES:NO;
        if (model.Percentage < 50) {
            //设置进度条左边的进度颜色
            [cell.progress setProgressTintColor:[UIColor colorWithRed:255/255.0 green:175/255.0 blue:35/255.0 alpha:1]];
            cell.heartImg.image = [UIImage imageNamed:@"comment_progress_heart_nor"];
            [cell.heartImg stopAnimating];
        } else if (model.Percentage < 100) {
            [cell.progress setProgressTintColor:[UIColor colorWithRed:219/255.0 green:128/255.0 blue:29/255.0 alpha:1]];
            cell.heartImg.image = [UIImage imageNamed:@"comment_progress_heart_mid"];
            [cell.heartImg stopAnimating];
        } else {
            [cell.progress setProgressTintColor:[UIColor colorWithRed:199/255.0 green:78/255.0 blue:102/255.0 alpha:1]];
            cell.heartImg.image = [UIImage imageNamed:@"comment_progress_heart_complete"];
            [cell.heartImg startAnimating];
        }
        NSMutableArray *CateArray  =[[NSMutableArray alloc] init];
        KeyCateArray  =[[NSMutableArray alloc] init];
        if ([model.Category length]>1){
            
            
            NSArray *CaArray = [model.Category componentsSeparatedByString:@","];
            
            for (int j=0; j<CaArray.count; j++){
                KeyCateArray = [CateImageSortdict allKeysForObject:CaArray[j]];
                
                [CateArray addObject:[KeyCateArray objectAtIndex:0]];
            }
            
            NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];//yes升序排列，no,降序排列
            NSArray *myary = [CateArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
            model.Category = [CateImageSortdict objectForKey:[myary objectAtIndex:0]];
            cell.typeImage.image = [UIImage imageNamed:_typeImageDict[model.Category]];
            cell.typeImage1.image = [UIImage imageNamed:_typeImageDict[model.Category]];
            
            
        }else{
            
        cell.typeImage.image = [UIImage imageNamed:_typeImageDict[model.Category]];
        cell.typeImage1.image = [UIImage imageNamed:_typeImageDict[model.Category]];
        
        }
//        cell.time.text = [NSString stringWithFormat:@"%@%@",model.RemainingValue, EGLocalizedString(model.RemainingUnit, nil)];
        
        AppLang lang = [EGUtility getAppLang];
        
        if (lang==1) { //hk
            cell.time.text = [NSString stringWithFormat:@"剩餘時間:%@ %@",model.RemainingValue,model.RemainingUnit];
        }else if (lang==2){//cn
            cell.time.text = [NSString stringWithFormat:@"剩余时间:%@ %@",model.RemainingValue,model.RemainingUnit];
        }else{
            
            if ([[NSString stringWithFormat:@"%@",model.RemainingValue] isEqualToString:@"0"]){
                
                 cell.time.text = [NSString stringWithFormat:@"%@ %@ To Go",model.RemainingValue,@"Days"];
                
            }else{
                cell.time.text = [NSString stringWithFormat:@"%@ %@ To Go",model.RemainingValue,model.RemainingUnit];
            
            }
        }
        
        
        cell.count.text = [NSString stringWithFormat:@"%@",model.DonorCount];
        cell.moneyLabel.text = [NSString stringWithFormat:@"$%@",model.Amt];
        cell.goalMoney.text = [NSString stringWithFormat:@"$%@",model.TargetAmt];

        if (ScreenSize.height == 667) {
            if (model.Percentage >= 100) {
                 cell.progressImg.frame = CGRectMake(25+100*(ScreenSize.width/320+0.15), 30,25, 25);
            }else
            cell.progressImg.frame = CGRectMake(25+model.Percentage*(ScreenSize.width/320+0.15), 30,25, 25);
        }else if (ScreenSize.height == 736)
            if (model.Percentage >= 100) {
                cell.progressImg.frame = CGRectMake(25+100*(ScreenSize.width/320+0.15), 30,25, 25);
            }else
           cell.progressImg.frame = CGRectMake(25+model.Percentage*(ScreenSize.width/320+0.2), 30,25, 25);
        else{
            if (model.Percentage >= 100) {
                cell.progressImg.frame = CGRectMake(25+100*(ScreenSize.width/320+0.15), 30,25, 25);
            }else
          cell.progressImg.frame = CGRectMake(25+model.Percentage*(ScreenSize.width/320+0.05), 30,25, 25);
        }

        [cell.button setAction:^(MyBtn * button) {
            
            if (button.selected) {
                
                UIAlertView *alertView = [[UIAlertView alloc] init];
                alertView.message = EGLocalizedString(@"alert_msg_caseHasAdded", nil);
                [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                [alertView show];
                [_tableView reloadData];
                
            }else{
             
                if ([model.RemainingValue intValue] == 0) {
                    UIAlertView *alertView = [[UIAlertView alloc] init];
                    alertView.message = EGLocalizedString(@"alert_msg_caseFinished", nil);
                    [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                    [alertView show];
                } else if (model.IsSuccess) {
                    UIAlertView *alertView = [[UIAlertView alloc] init];
                    alertView.message = EGLocalizedString(@"alert_msg_caseSuccess", nil);
                    [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                    [alertView show];
                } else{
                    [weakSelf saveShoppingCartItem:model.CaseID];
                    UIAlertView *alertView = [[UIAlertView alloc] init];
                    alertView.message = EGLocalizedString(@"alert_msg_saveShoppingCartItemSuccess", nil);
                    [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                    [alertView show];
                    [_tableView reloadData];
                }
          
            }
        }];
        
        if (model.isSelect) {
            cell.button.selected = YES;
        }else{
            cell.button.selected = NO;
        }
  
    }
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenSize.width/4*3;
}

//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSInteger  lang = [EGUtility getAppLang];
    if (lang == 3) {
       return ScreenSize.width/3+45;
    }else
    return ScreenSize.width/3+30;
}

//头部试图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSInteger  lang = [EGUtility getAppLang];
    
    if (lang == 3 && _amtCountdict.count != 0) {
        
        _totalAmt.text = [NSString stringWithFormat:@"$%@",[NSString strmethodComma:_amtCountdict[@"TotalAmt"]]];
        _totalDonorCount.text = [NSString stringWithFormat:@"%@",_amtCountdict[@"TotalViewCount"]];
        //_topImage = [_headerView addImageViewWithFrame:CGRectMake(0, 45, ScreenSize.width, 110) image:nil];
        _topImage.frame=CGRectMake(0, 45, ScreenSize.width, ScreenSize.width/3);
        _topImage.contentMode = UIViewContentModeScaleAspectFill;
        
    }else{

        if (_amtCountdict[@"TotalViewCount"] == NULL) {
            _totalDonorCount.text =@"";
        }else{
            _totalDonorCount.text = [NSString stringWithFormat:@"%@",_amtCountdict[@"TotalViewCount"]];
        }
        _totalAmt.text = [NSString stringWithFormat:@"$%@",[NSString strmethodComma:_amtCountdict[@"TotalAmt"]]];
        
    }
    
    return _headerView;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    EncourageOthersController *ee = [[EncourageOthersController alloc] init];
//    [self.navigationController pushViewController:ee animated:YES];
//    
//    return;
    if (_dataArray.count > 0) {
        GirdModel * model = _dataArray[indexPath.row];
        GirdDetailViewController * vc = [[GirdDetailViewController alloc] init];
        vc.girdMdel = model;
        vc.caseID = model.CaseID;
        vc.categoryImg = model.Category;
        vc.nameString = model.Title;
        MyLog(@"%@",model.Title);
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)timerAction1{
 
    NSInteger index = _timerFlagBannerAd % _adArray.count;
    HomeModel * model = _adArray[index];
    currentAdURL = model.URL;
   //  NSInteger lang = [EGUtility getAppLang];
//    if (lang==1) {
//        currentAdURL = [ NSString stringWithFormat:@"%@/DownloadForm.aspx?type=S&lang=1",SITE_URL];
//
//        
//    }else if (lang==2){
//         currentAdURL = [ NSString stringWithFormat:@"%@/DownloadForm.aspx?type=S&lang=2",SITE_URL];
//    
//    }else{
//        currentAdURL = [ NSString stringWithFormat:@"%@/DownloadForm.aspx?type=S&lang=3",SITE_URL];
//    
//     }

//    MyLog(@"model.FilePath = %@", model.FilePath);
    NSURL *url = [NSURL URLWithString:model.FilePath];
    
    MyLog(@"%@",url);
//        [_topImage setImageWithURLRequest:[NSURLRequest requestWithURL:url
//                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
//                                                       timeoutInterval:60.0]
//                         placeholderImage:[UIImage imageNamed:@"Icon-1024.png"]
//                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//                                      float ratio = image.size.width / image.size.height;
//                                      MyLog(@"ratio = %f", ScreenSize.width);
//                                      _topImage.frame = CGRectMake(_topImage.frame.origin.x, _topImage.frame.origin.y, ScreenSize.width, ScreenSize.width * ratio);
//                                  }
//                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//                                      // todo
//                                  }
//        ];
    
    //MyLog(@"%@",url);
    //_topImage.contentMode = UIViewContentModeScaleToFill;
    [_topImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Icon-1024.png"]];
    
//     [_topImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Icon-1024.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//         
//         
//        
//    }];
   // _topImage.image =[self cutImage:_topImage.image];
    //[_topImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Icon-1024.png"]];
    _topImage.tag = 600 + index;
    _timerFlagBannerAd++;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BannerAdTap:)];
    tap.view.tag=600+index;
    [_topImage addGestureRecognizer:tap];
    [_tableView reloadData];
}

//裁剪图片
- (UIImage *)cutImage:(UIImage*)image{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (_topImage.frame.size.width / _topImage.frame.size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * _topImage.frame.size.height / _topImage.frame.size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * _topImage.frame.size.width / _topImage.frame.size.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
    }
    return [UIImage imageWithCGImage:imageRef];
}

- (UIImage *)cutCellImage:(UIImage*)cellImage
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    if ((cellImage.size.width / cellImage.size.height) < (_cellShowImage.frame.size.width / _cellShowImage.frame.size.height)) {
        newSize.width = cellImage.size.width;
        newSize.height = cellImage.size.width * _cellShowImage.frame.size.height / _cellShowImage.frame.size.width;
        
        imageRef = CGImageCreateWithImageInRect([cellImage CGImage], CGRectMake(0, fabs(cellImage.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = cellImage.size.height;
        newSize.width = cellImage.size.height * _cellShowImage.frame.size.width / _cellShowImage.frame.size.height;
        
        imageRef = CGImageCreateWithImageInRect([cellImage CGImage], CGRectMake(fabs(cellImage.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self requestTotalDonationInfoData];
    _cartCount.hidden = NO;
    _navImage.hidden = NO;
    _messageButton.hidden=NO;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"MsgInboxCount"] integerValue] == 0){
        
        _dotView.hidden=YES;
        
    }else{
        
        _dotView.hidden=NO;
    
    }
    
    if (_item != nil){
        
        [self GetAndSaveShoppingCart];
        NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
        EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
        _cartCount.text = [NSString stringWithFormat:@"%ld",(long)item.NumberOfItems];
        [self updateIcon];
        
    }else{
        
        [self notifyUpdateMemberInfo];
    }
    
    [self requestApiData:_item.MemberID];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    _cartCount.hidden = YES;
    _navImage.hidden = YES;
    _dotView.hidden = YES;
    _messageButton.hidden=YES;
    if (self.isHidden == -1){
        
        [self menuAction];
    }
    
}

- (void)notifyUpdateMemberInfo{
    _shareDict = [ShowMenuView getUserInfo];
    _item = _shareDict[@"LoginName"];
    if (_item != nil) {
        [self GetAndSaveShoppingCart];
        NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
        EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
        _cartCount.text = [NSString stringWithFormat:@"%ld",(long)item.NumberOfItems];
        [super showUserInfo];
    }
}

#pragma mark - 收藏请求
-(void)AddCaseFavourite:(NSIndexPath *)indexPath{
    GirdModel * model = _dataArray[indexPath.row];
    NSString* caseID = model.CaseID;
    
    [self showLoadingAlert];
    
    if (_item.MemberID == NULL){
        _item.MemberID = @"";
    }
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><AddCaseFavourite xmlns=\"egive.appservices\"><CaseID>%@</CaseID><MemberID>%@</MemberID></AddCaseFavourite></soap:Body></soap:Envelope>",caseID,_item.MemberID];
    
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
        
        [self removeLoadingAlert];
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *result = [NSString captureData:dataString];
        if ([result isEqual:@"\"\""]){
            model.Isfavourite=YES;
            
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"收藏成功", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            
            [_tableView reloadData];
            
          //[self requestApiData:_item.MemberID];
            
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = result;
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
        }
        
        
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
#pragma mark - 取消收藏请求
-(void)DeleteCaseFavourite:(NSIndexPath*)indexPath{
    
    GirdModel * model = _dataArray[indexPath.row];
    NSString* caseID = model.CaseID;
    [self showLoadingAlert];
    if (_item.MemberID == NULL){
        _item.MemberID = @"";
    }
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <DeleteCaseFavourite xmlns=\"egive.appservices\"><CaseID>%@</CaseID><MemberID>%@</MemberID></DeleteCaseFavourite></soap:Body></soap:Envelope>",caseID,_item.MemberID];
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
        
        [self removeLoadingAlert];
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *result = [NSString captureData:dataString];
        if ([[NSString captureData:dataString] isEqualToString:@"\"\""]) {
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"取消成功!", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            model.Isfavourite=NO;
            [_tableView reloadData];
            //[self requestApiData:_item.MemberID];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = result;
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
        }
 
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

- (void)GetAndSaveShoppingCart{
    
    EGGetAndSaveShoppingCartRequest *request = [[EGGetAndSaveShoppingCartRequest alloc] init];
    request.lang = 1;
    request.LocationCode = @"HK";
    request.DonateWithCharge = YES;
    request.MemberID = _item.MemberID ? _item.MemberID :@"";
    NSString *cookieId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    MyLog(@"cookieId --------------->>>>>>>>%@",cookieId);
    request.CookieID = _item.MemberID ? @"" :cookieId;
    request.StartRowNo = 1;
    request.NumberOfRows = 20;
    
    //__weak __typeof(self)weakSelf = self;
    
    [EGMyDonationRequestAdapter getGetAndSaveShoppingCart:request success:^(EGGetAndSaveShoppingCartResult *result) {
        
      
        MyLog(@"%ld",(long)result.NumberOfItems);

        _cartCount.text = [NSString stringWithFormat:@"%ld",(long)result.NumberOfItems];
        if (result.NumberOfItems < 1) {

            _cartCount.hidden = YES;
            
        }else{
            _cartCount.hidden = NO;
        }
        
        NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
        if (result != nil) {
            [shopCartDict setObject:result forKey:@"shopItem"];
        }

        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCount" object: nil];
        
    } failure:^(NSError *error){
        MyLog(@"%@",error);
        
    
    }];
 
}

- (void)changeCount {

    NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
    EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
    for (GirdModel *model in _dataArray){
            //model.isSelect = NO;
        for (EGShoppingCart *obj in item.ItemList) {
            if ([model.CaseID isEqualToString:obj.CaseID]){
                model.isSelect = YES;
            }
        }
    }
    MyLog(@"%ld",(long)item.NumberOfItems);
    self.donationsLabel.text = [NSString stringWithFormat:@"%ld",(long)item.NumberOfItems];
    if (item.NumberOfItems < 1){
        self.donationsView.hidden = YES;
    }else{
        self.donationsView.hidden = NO;
    }
    [_tableView reloadData];
}

- (void)saveShoppingCartItem:(NSString *)caseId
{
    [self showLoadingAlert];
    EGSaveShoppingCartItemRequest *request = [[EGSaveShoppingCartItemRequest alloc] init];
    request.MemberID = _item.MemberID ? _item.MemberID :@"";
    NSString *cookieId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    request.CookieID = _item.MemberID ? @"" :cookieId;
    request.CaseID = caseId;
    request.DonateAmt = 500;
    request.IsChecked = 1;
    
//  __weak __typeof(self)weakself = self;
    [EGMyDonationRequestAdapter saveShoppingCartItem:request success:^(NSString *result) {
        [self removeLoadingAlert];
        [self GetAndSaveShoppingCart];
        
    } failure:^(NSError *error) {
         MyLog(@"%@",error);
        [self removeLoadingAlert];
    }];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:@"changeCount"];
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
