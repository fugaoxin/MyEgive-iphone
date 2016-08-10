//
//  GirdDetailViewController.m
//  Egive
//
//  Created by sino on 15/7/27.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "Constants.h"
#import "GirdDetailViewController.h"
#import "UIView+ZJQuickControl.h"
#import "ProReportController.h"
#import "DonorsViewController.h"
#import "BlessingViewController.h"
#import "SendBlessingsViewController.h"
#import "ShareViewCell.h"
#import "ZJScreenAdaptation.h"
#import "ZJScreenAdaptationMacro.h"
#import "EGMyDonationRequestAdapter.h"
#import "MyDonationViewController.h"
#import "LoginViewController.h"
#import "baseController.h"
#import "EGUtility.h"
#import "MyAttentionViewController.h"
#import "GirdTableViewCell.h"
#import "MenuViewController.h"
#import "MBProgressHUD.h"
#import "GirdShowDetailePicViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "EGEditBlessingController.h"
#define ScreenSize [UIScreen mainScreen].bounds.size

@interface GirdDetailViewController (){
    UIView * _topTabaleView;
    UIView * _bottomTabaleView;
    UIView * _shareView;
    NSArray * _headerTitle;
    NSMutableArray * _stateArray;
    NSDictionary * _dataDict;
    UIButton * _favouriteButton;
    UIImageView * _navLeftImage;
    UIImageView * _proImag;
    UIImageView * _heartButton;
    UIButton * _shareButton;
    BOOL _isGo;
    UIFont *_font;
    NSMutableArray * galleryArray;
    NSMutableDictionary *titleDict;
    UIView * bottomView;
    UIDevice *device_;
    UIImageView * MediogalleryImg;
}

@property (copy, nonatomic) NSMutableArray * dataArray;
@property (strong, nonatomic) MemberModel * item;
@property (strong, nonatomic) UILabel * cartLabel;
@property (nonatomic, assign) UISlider *slider;
@property (nonatomic, strong)UIView *sliderView;
@property (strong, nonatomic) NSMutableDictionary *imageModelMap;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property(retain,nonatomic)NSMutableArray *picArray;
@end

@implementation GirdDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     device_=[[UIDevice alloc] init];
    // Do any additional setup after loading the view.
     [self GetCaseDetailSubtitle];
    self.title = EGLocalizedString(@"MyDonation_TapButton", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    
    _isGo = NO;//是否跳转到我的捐款
    
    //判断用户是否登入，如登入获取：MemberID
    NSMutableDictionary * dict = [ShowMenuView getUserInfo];
    _item = dict[@"LoginName"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    leftButton.transform = CGAffineTransformScale(leftButton.transform, 0.85, 0.85);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_cart@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
   
    //    __weak typeof(self) weakSelf = self;
    
    _shareButton = [self.navigationController.navigationBar addImageButtonWithFrame:CGRectMake(320-80, 5, 30, 30) title:nil backgroud:@"header_share@2x.png" action:^(UIButton *button) {
        
        NSURL *urlToShare = [NSURL URLWithString:[NSString stringWithFormat:@"%@/CaseDetail.aspx?CaseID=%@",SITE_URL,_girdMdel.CaseID]];
//        NSString *urlToShare = [NSString stringWithFormat:@"http://www.egive4u.org/CaseDetail.aspx?CaseID=%@",_girdMdel.CaseID];
//        NSString *urlToShare = [NSString stringWithFormat:@"http://www.egive4u.org/CaseList.aspx"];
        MyLog(@"%@",urlToShare);
        //        NSString *string = @"i) Egive – 點擊行善：<專案名稱>，急需您的捐助！- <專案WebSite Link>=\nii) Egive專案 –<專案名稱>\niii) Egive – 點擊行善：<專案名稱>，急需您的捐助！- <專案WebSite Link>\n請瀏覽: http://www.egive4u.org/\n意贈慈善基金\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org"; // TODO
        NSString * string = @"";
        NSString * subject = @"";
        _shareButton.enabled=YES;
        if ([EGUtility getAppLang]==3){
            NSString * str = [NSString stringWithFormat:@"Egive - Egive Projects:\n%@ needs your support! - %@\n\nVisit us at www.egive4u.org\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org",_dataDict[@"Title"],urlToShare];
            string = str;
            
            subject = [NSString stringWithFormat:@"Egive Project – %@",_dataDict[@"Title"]];
            
        }else if ([EGUtility getAppLang]==2){
            
            NSString * str = [NSString stringWithFormat:@"Egive – 点击行善：\n%@,急需您的捐助!- %@\n请浏览: http://www.egive4u.org\n\n意赠慈善基金\nEgive For You Charity Foundation\n电话: (852) 2210 2600\n电邮: info@egive4u.org",_dataDict[@"Title"],urlToShare];
            string = str;
            subject = [NSString stringWithFormat:@"Egive 专案 – %@",_dataDict[@"Title"]];
            MyLog(@"%@",string);
            
        }else{
            
            NSString * str = [NSString stringWithFormat:@"Egive – 點擊行善：\n%@，急需您的捐助！- %@\n\n請瀏覽: http://www.egive4u.org/\n\n意贈慈善基金\nEgive For You Charity Foundation\n電話: (852) 2210 2600\n電郵: info@egive4u.org",_dataDict[@"Title"],urlToShare];
            string = str;
            subject = [NSString stringWithFormat:@"Egive 專案 - %@",_dataDict[@"Title"]];
        }
        
       // NSArray *contentArray = @[string];
        
        [MenuViewController shareToSocialNetworkWithSubject:subject content:string url:nil image:nil];
        
        //        UIImage *imageToShare = [UIImage imageNamed:@"testImage.jpg"];
        
        //        UIActivityViewController *activityViewController =
        //        [[UIActivityViewController alloc] initWithActivityItems:@[string]
        //                                          applicationActivities:nil];
        //        [self.navigationController presentViewController:activityViewController
        //                                                animated:YES
        //                                              completion:^{
        //                                                  // ...
        //                                              }];
        //        activityViewController.excludedActivityTypes = @[UIActivityTypePrint];
        //
        //         [activityViewController setValue:subject forKey:@"subject"];
        
    }];
    
    _imageModelMap = [NSMutableDictionary new];
    
    _headerTitle = @[EGLocalizedString(@"专案摘要", nil),EGLocalizedString(@"专案内容", nil),EGLocalizedString(@"受惠者背景", nil),EGLocalizedString(@"援助需要", nil),EGLocalizedString(@"心声分享", nil)];
    _stateArray = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"1",@"1",@"0",nil];
    
    _font = [UIFont systemFontOfSize:18];
    
    [self createUI];
    [self addMySlider];
    
}



-(UIImage *)imageFromText:(NSArray*)arrContent withFont:(CGFloat)fontSize withTextColor:(UIColor *)textColor withBgImage:(UIImage *)bgImage withBgColor:(UIColor *)bgColor
{
    // set the font type and size
    
    UIFont *font = [UIFont fontWithName:@"Heiti SC" size:fontSize];
    NSMutableArray *arrHeight = [[NSMutableArray alloc] initWithCapacity:arrContent.count];
    
    CGFloat fHeight = 0.0f;
    for (NSString *sContent in arrContent) {
        CGSize stringSize = [sContent sizeWithFont:font constrainedToSize:CGSizeMake(320, 10000) lineBreakMode:NSLineBreakByWordWrapping];
        [arrHeight addObject:[NSNumber numberWithFloat:stringSize.height]];
        
        fHeight += stringSize.height;
    }
    
    CGSize newSize = CGSizeMake(320+20, fHeight+50);
    
    
    // Create a stretchable image for the top of the background and draw it
    UIGraphicsBeginImageContextWithOptions(newSize,NO,0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    //如果设置了背景图片
    if(bgImage)
    {
        UIImage* stretchedTopImage = [bgImage stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        [stretchedTopImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    }else
    {
        if(bgColor)
        {
            //填充背景颜色
            [bgColor set];
            UIRectFill(CGRectMake(0, 0, newSize.width, newSize.height));
        }
    }
    
    CGContextSetCharacterSpacing(ctx, 10);
    CGContextSetTextDrawingMode (ctx, kCGTextFill);
    [textColor set];
    
    
    int nIndex = 0;
    CGFloat fPosY = 20.0f;
    for (NSString *sContent in arrContent) {
        NSNumber *numHeight = [arrHeight objectAtIndex:nIndex];
        CGRect rect = CGRectMake(10, fPosY, 320 , [numHeight floatValue]);
        
        
        [sContent drawInRect:rect withFont:font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        fPosY += [numHeight floatValue];
        nIndex++;
    }
    
    // transfer image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}


- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightAction{
    MyDonationViewController * vc = [[MyDonationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)createUI{
   
    NSDictionary * typeImageDict = @{@"S":@"comment_list_type_education@2x.png",
                                     @"E":@"comment_list_type_elder@2x.png",
                                     @"U":@"comment_list_type_emergency@2x.png",
                                     @"M":@"comment_list_type_medical@2x.png",
                                     @"P":@"comment_list_type_poverty@2x.png",
                                     @"A":@"comment_list_type_case_list@2x.png",
                                     @"O":@"comment_list_type_others@2x.png"};
    
    UIScrollView * scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scroll.bounces = NO;
    scroll.userInteractionEnabled = YES;
    [self.view addSubview:scroll];
    //购物车右侧数量标示label
    NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
    EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
    if (IS_IPHONE_6) {
        
         _cartLabel = [self.navigationController.navigationBar addLabelWithFrame:CGRectMake(ScreenSize.width-83, 18, 18, 18) text:[NSString stringWithFormat:@"%ld",(long)item.NumberOfItems]];
        
    }else if (IS_IPHONE_6P){
    
        _cartLabel = [self.navigationController.navigationBar addLabelWithFrame:CGRectMake(ScreenSize.width-120, 15, 18, 18) text:[NSString stringWithFormat:@"%ld",(long)item.NumberOfItems]];
    
    }else{
        _cartLabel = [self.navigationController.navigationBar addLabelWithFrame:CGRectMake(ScreenSize.width-30, 18, 18, 18) text:[NSString stringWithFormat:@"%ld",(long)item.NumberOfItems]];
    
    }
   
    _cartLabel.layer.cornerRadius = 9;
    _cartLabel.layer.masksToBounds = YES;
    _cartLabel.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    _cartLabel.textAlignment = NSTextAlignmentCenter;
    _cartLabel.font = [UIFont systemFontOfSize:11];
    _cartLabel.textColor = [UIColor whiteColor];
    if (item.NumberOfItems < 1) {
        _cartLabel.hidden = YES;
    }else{
        _cartLabel.hidden = NO;
    }
    _topTabaleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 430)];
    _topTabaleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topTabaleView];
    
    if (ScreenSize.height == 667){
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, ScreenSize.height-170) style:UITableViewStyleGrouped];
    }else if (ScreenSize.height == 736)
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, ScreenSize.height-250) style:UITableViewStyleGrouped];
    else if(ScreenSize.height==480 || [device_.model isEqualToString:@"iPad"]){
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, ScreenSize.height-70) style:UITableViewStyleGrouped];
    }else{
    
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 568-70) style:UITableViewStyleGrouped];
    
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [scroll addSubview:_tableView];
    _tableView.tableHeaderView = _topTabaleView;
    //顶部视图
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 60)];
    topView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    topView.userInteractionEnabled = YES;
    [_topTabaleView addSubview:topView];
    
    _progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progress.frame = CGRectMake(10, 20, 175, 30);
    _progress.layer.cornerRadius = 3;
    _progress.layer.masksToBounds = YES;
    _progress.transform = CGAffineTransformMakeScale(1.0f,3.0f);
    //设置进度条左边的进度颜色
    [_progress setProgressTintColor:[UIColor colorWithRed:255/255.0 green:175/255.0 blue:35/255.0 alpha:1]];
    //设置进度条右边的进度颜色
    [_progress setTrackTintColor:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1]];
    [topView addSubview:_progress];
    //奔跑小人图片
    _proImag =  [topView addImageViewWithFrame:CGRectMake(0, 8,25, 25) image:@"comment_progress_run_1"];
    //创建imageView
    _heartButton = [[UIImageView alloc]initWithFrame:CGRectMake(180, 10, 20, 20)];
    //把图片添加到动态数组
    NSMutableArray * animateArray = [[NSMutableArray alloc]initWithCapacity:2];
    [animateArray addObject:[UIImage imageNamed:@"comment_progress_heart_nor"]];
    [animateArray addObject:[UIImage imageNamed:@"comment_progress_heart_mid"]];
    [animateArray addObject:[UIImage imageNamed:@"comment_progress_heart_complete"]];
    //为图片设置动态
    _heartButton.animationImages = animateArray;
    //为动画设置持续时间
    _heartButton.animationDuration = 0.5;
    //为默认的无限循环
    _heartButton.animationRepeatCount = 0;
    //开始播放动画
    //[_heartButton startAnimating];
    UITapGestureRecognizer * tapHeartImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(heartImageTap)];
    [_heartButton addGestureRecognizer:tapHeartImage];
    
    
    [topView addSubview:_heartButton];
    
    _proLable = [topView addLabelWithFrame:CGRectMake(210, 10, 50, 20) text:nil];
    _proLable.font = [UIFont boldSystemFontOfSize:13];
    
//    UILabel * timeLable = [topView addLabelWithFrame:CGRectMake(10, 35, 70, 20) text:EGLocalizedString(@"GirdView_time_label", nil)];
//    timeLable.textColor = [UIColor grayColor];
//    timeLable.font = [UIFont systemFontOfSize:14];
    
//    _time = [topView addLabelWithFrame:CGRectMake(70, 35, 180, 20) text:nil];
    _time = [topView addLabelWithFrame:CGRectMake(10, 25, 230, 35) text:nil];
    _time.numberOfLines=2;
    //_time.backgroundColor = [UIColor redColor];
    _time.font = [UIFont boldSystemFontOfSize:13];
    
    [topView addImageViewWithFrame:CGRectMake(320-70, 5, 2, 50) image:@"case_separ_line@2x.png"];
    
    //进度报告view
    UIView * buttonView = [[UIView alloc] initWithFrame:CGRectMake(260, 0, 60, 60)];
    buttonView.userInteractionEnabled = YES;
    [topView addSubview:buttonView];
    
    //进度报告view添加点击事件
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(proAction)];
    [buttonView addGestureRecognizer:tap];
    
    [buttonView addImageViewWithFrame:CGRectMake(10, 5, 40, 40) image:@"case_detail_progress@2x.png"];
    
    UILabel * reportLable = [buttonView addLabelWithFrame:CGRectMake(0, 40, 60, 20) text:EGLocalizedString(@"GirdView_report_label", nil)];
    reportLable.textAlignment = NSTextAlignmentCenter;
    reportLable.textColor = [UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1];
    reportLable.font = [UIFont systemFontOfSize:13];
    
    NSArray * imageArray = @[@"case_detail_amount@2x.png",@"case_detail_target@2x.png",@"case_detail_donor@2x.png",@"case_detail_bless@2x.png"];
    NSArray * titleArray = @[EGLocalizedString(@"GirdView_atm_label", nil),EGLocalizedString(@"GirdView_target_label", nil),EGLocalizedString(@"GirdView_donors_label", nil),EGLocalizedString(@"GirdView_blessings_label", nil)];
    
    __weak typeof(self) weakSelf = self;
    for (int i = 0; i < 4; i ++) {
        UIButton * imageButton = [_topTabaleView addImageButtonWithFrame:CGRectMake(i*80+20, 60, 40, 40) title:nil backgroud:imageArray[i] action:^(UIButton *button) {
            
            if (button.tag == 52) {
                DonorsViewController * vc = [[DonorsViewController alloc] init];
                vc.donors = weakSelf.model.Donors;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else if (button.tag == 53){
                BlessingViewController * vc = [[BlessingViewController alloc] init];
                vc.commentsArray = weakSelf.model.Comments;
                vc.model = _model;
                vc.caseID = _caseID;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
            
        }];
        
        UILabel * titleLabel = [_topTabaleView addLabelWithFrame:CGRectMake(i*80, 100, 80, 30) text:titleArray[i]];
        titleLabel.userInteractionEnabled = YES;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:15];
        
        if (i == 2) {
            UITapGestureRecognizer *tapGesture =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(label2Tap)];
            [titleLabel addGestureRecognizer:tapGesture];
        }
        
        if (i == 3){
            UITapGestureRecognizer *tapGesture =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(label3Tap)];
            [titleLabel addGestureRecognizer:tapGesture];
        }
        
        imageButton.titleLabel.font = [UIFont systemFontOfSize:11];
        if (ScreenSize.height > 480) {
            imageButton.titleEdgeInsets = UIEdgeInsetsMake(70, 0, 0, 0);
        }else{
            imageButton.titleEdgeInsets = UIEdgeInsetsMake(55, 0, 0, 0);
        }
        
        imageButton.tag = 50+i;
        if (i < 2) {
            UILabel * imageLabel = [_topTabaleView addLabelWithFrame:CGRectMake(i*80-20, 115, 120, 40) text:nil];
            imageLabel.textAlignment = NSTextAlignmentCenter;
            imageLabel.tag = 55+i;
            imageLabel.font = [UIFont systemFontOfSize:12];
            
        }else{
            UILabel * imageLabel = [_topTabaleView addLabelWithFrame:CGRectMake(i*80+20, 115, 50, 40) text:nil];
            imageLabel.tag = 55+i;
            imageLabel.textAlignment = NSTextAlignmentCenter;
            imageLabel.font = [UIFont systemFontOfSize:12];
            imageLabel.textColor = [UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1];
            titleLabel.textColor = [UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1];
            //            [imageButton setTitleColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1] forState:UIControlStateNormal];
            [_topTabaleView addImageViewWithFrame:CGRectMake(i*80+60, 128, 8, 13) image:@"case_detail_arrow@2x.png"];
        }
    }
    
    _imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 150, 320, 220)];
    _imageScrollView.showsHorizontalScrollIndicator = NO;
    _imageScrollView.pagingEnabled = YES;
    _imageScrollView.delegate = self;
    [_topTabaleView addSubview:_imageScrollView];
    _page = 0;
    
    [_topTabaleView addImageViewWithFrame:CGRectMake(10, 380, 30, 30) image:typeImageDict[_categoryImg]];
    
    _typeTitle = [_topTabaleView addLabelWithFrame:CGRectMake(45, 370, 230, 60) text:nil];
    //_typeTitle.backgroundColor = [UIColor redColor];
    _typeTitle.font = [UIFont systemFontOfSize:13];
    _typeTitle.numberOfLines = 0;
    _typeTitle.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    
    _favouriteButton = [_topTabaleView addImageButtonWithFrame:CGRectMake(320-40, 375, 25, 25) title:nil backgroud:@"case_detail_favourite_nor@2x.png" action:^(UIButton *button) {
        
        if (weakSelf.item != nil) {
            
            if (weakSelf.model.Isfavourite == YES) {
                button.selected = NO;
                [weakSelf DeleteCaseFavourite:weakSelf.model.CaseID];
                [weakSelf.tableView reloadData];
            }else{
                button.selected = YES;
                [weakSelf AddCaseFavourite:weakSelf.model.CaseID];
                [weakSelf.tableView reloadData];
            }
            
        }else{

            MyLog(@"GirdDetailViewController check point 1");
            MyAttentionViewController * vc = [[MyAttentionViewController alloc] init];
            LoginViewController * loginvc = [[LoginViewController alloc] initWithToggleViewController:vc];
            vc.caseId = weakSelf.model.CaseID;
            vc.isFavouritePush = YES;
            [weakSelf.navigationController pushViewController:loginvc animated:YES];
            //LoginViewController * vc = [[LoginViewController alloc] init];
            //[weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
    }];
    
    [_favouriteButton setBackgroundImage:[UIImage imageNamed:@"case_detail_favourite_sel@2x.png"] forState:UIControlStateSelected];

    if (ScreenSize.height>480){
        
        bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 528, 320, 40)];
        bottomView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:0.9];
        [self.view addSubview:bottomView];
    }else{
    
        bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 440, 320, 40)];
        bottomView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:0.9];
        [self.view addSubview:bottomView];

    
    }
   
    
    NSArray * arr = @[EGLocalizedString(@"GirdView_blessings_button", nil),EGLocalizedString(@"GirdView_donate_button", nil)];
    NSArray * arr1 = @[@"footer_bless@2x.png",@"footer_cart@2x.png"];
    //底部button
    for (int i = 0; i < 2; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        //        button.frame = CGRectMake(i*(ScreenSize.width/2)+i, ScreenSize.height-40, ScreenSize.width/2-1, 40);
        //if (ScreenSize.height>480){
            
            button.frame = CGRectMake(i*145+20, 5, 135, 30);
        //}else{
            
            //button.frame = CGRectMake(i*140+i, -10, 125, 30);
        //}
        button.tag = 170+i;
        [button setImage:[UIImage imageNamed:arr1[i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.backgroundColor = [UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1];
        button.layer.cornerRadius = 4;
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [bottomView addSubview:button];
        [button addTarget:self action:@selector(footerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        // UIButton * button = [self.view addImageButtonWithFrame:CGRectMake(i*(ScreenSize.width/2), ScreenSize.height-40, ScreenSize.width/2-5, 40) title:arr[i] backgroud:arr1[i] action:^(UIButton *button) {
        //
        //        }];
        //        button.titleLabel.font = [UIFont systemFontOfSize:12];
        //        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
        //        button.tag = 55+i;
        
    }
}

- (void)label2Tap
{
    __weak typeof(self) weakSelf = self;
    DonorsViewController * vc = [[DonorsViewController alloc] init];
    vc.donors = weakSelf.model.Donors;
    [weakSelf.navigationController pushViewController:vc animated:YES];
}

- (void)label3Tap
{
    __weak typeof(self) weakSelf = self;
    BlessingViewController * vc = [[BlessingViewController alloc] init];
    vc.model = _model;
    vc.caseID = _caseID;
    vc.commentsArray = weakSelf.model.Comments;
    [weakSelf.navigationController pushViewController:vc animated:YES];
}

- (void)heartImageTap
{
    EGEditBlessingController * vc = [[EGEditBlessingController alloc] init];
    vc.model = _model;
    
    if (_item != nil) {
        MyLog(@"_item != nil");
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        MyLog(@"initWithToggleViewController");
        LoginViewController * loginvc = [[LoginViewController alloc] initWithToggleViewController:vc];
        [self.navigationController pushViewController:loginvc animated:YES];
    }
}

#pragma mark - 送上祝福&&立即捐款点击方法
- (void)footerButtonAction:(UIButton *)button{
    if (button.tag == 170) {
        EGEditBlessingController * vc = [[EGEditBlessingController alloc] init];
        vc.model = _model;
        [vc setAction:^(void) {
            BlessingViewController * vc = [[BlessingViewController alloc] init];
            vc.commentsArray = self.model.Comments;
            vc.model = _model;
            vc.caseID = _caseID;
            [self.navigationController pushViewController:vc animated:YES];
        }];
       
        if (_item != nil) {
            MyLog(@"_item != nil");
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            LoginViewController * loginvc = [[LoginViewController alloc] initWithToggleViewController:vc];
            [self.navigationController pushViewController:loginvc animated:YES];
        }
        
    }else{
        
        if ([_girdMdel.RemainingValue intValue] == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"alert_msg_caseFinished", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
        } else if (_girdMdel.IsSuccess) {
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"alert_msg_caseSuccess", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
        } else{
            _isGo = YES;
            [self saveShoppingCartItem:_model.CaseID];
        }
        
    }
    
}

#pragma mark - 请求Cell数据
-(void)requestApiData:(NSString *)caseID andMemberID:(NSString *)memberID{
    [self showLoadingAlert];
    long lang = [EGUtility getAppLang];
    
    MyLog(@"caseID --------------  %@",caseID);
    if (memberID == NULL) {
        memberID = @"";
    }
    _dataArray = [[NSMutableArray alloc] init];
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCaseDtl xmlns=\"egive.appservices\"><Lang>%ld</Lang><CaseID>%@</CaseID><MemberID>%@</MemberID></GetCaseDtl></soap:Body></soap:Envelope>",lang,caseID,memberID];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
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
        
        _dataDict = [NSString parseJSONStringToNSDictionary:dataString];
        MyLog(@"%@",_dataDict);
        _model = [[GirdDetailModel alloc] init];
        [_model setValuesForKeysWithDictionary:_dataDict];
        [_dataArray addObject:_model];
        
        if (_model.Isfavourite) {
            _favouriteButton.selected = YES;
        }
        
        //进度条
        NSNumber * pro = _dataDict[@"Percentage"];
        _progress.progress = [[NSString stringWithFormat:@"%@",pro] floatValue]/100;
        if (pro != NULL) {
        if ([pro floatValue]>= 100) {
            _proLable.text = [NSString stringWithFormat:@"100%%"];
        }else{
            _proLable.text = [NSString stringWithFormat:@"%@%%",pro];
        }
        }else{
          
            _proLable.text=@"";
        
         }
        if (ScreenSize.height == 667) {
            _proImag.frame = CGRectMake([_dataDict[@"Percentage"] floatValue]*(ScreenSize.width/320+0.4), 8,25, 25);
            
        }else if (ScreenSize.height == 736)
            _proImag.frame = CGRectMake([_dataDict[@"Percentage"] floatValue]*(ScreenSize.width/320+0.3), 8,25, 25);
        else{
            _proImag.frame = CGRectMake([_dataDict[@"Percentage"] floatValue]*(ScreenSize.width/320+0.6), 8,25, 25);
        }
        
        CGFloat Percentage = [_dataDict[@"Percentage"] floatValue];
        
        //根据进度改变颜色
        if (Percentage < 50) {
            [_progress setProgressTintColor:[UIColor colorWithRed:255/255.0 green:175/255.0 blue:35/255.0 alpha:1]];
            _heartButton.image = [UIImage imageNamed:@"comment_progress_heart_nor"];
            [_heartButton stopAnimating];
        } else if (Percentage < 100) {
            [_progress setProgressTintColor:[UIColor colorWithRed:219/255.0 green:128/255.0 blue:29/255.0 alpha:1]];
            _heartButton.image = [UIImage imageNamed:@"comment_progress_heart_mid"];
            [_heartButton stopAnimating];
        } else {
            [_progress setProgressTintColor:[UIColor colorWithRed:199/255.0 green:78/255.0 blue:102/255.0 alpha:1]];
            _heartButton.image = [UIImage imageNamed:@"comment_progress_heart_complete"];
            [_heartButton startAnimating];
        }
        
        _proImag.hidden = [_dataDict[@"Percentage"] floatValue] >= 100 ? YES:NO;
        
        NSArray * timeArray = _dataDict[@"RemainingTime"];
        NSMutableArray * remainTime = [[NSMutableArray alloc] init];
        for (NSDictionary * timeDict in timeArray) {
            NSString * time = [NSString stringWithFormat:@"%@ %@",timeDict[@"value"],timeDict[@"unit"]];
            [remainTime addObject:time];
        }
        
        AppLang lang = [EGUtility getAppLang];
        //显示结束时间
        if (timeArray.count == 0) {
            _time.text = EGLocalizedString(@"GirdView_time", nil);
        }else if (timeArray.count == 3){
            if (lang==1) { //hk
                _time.text = [NSString stringWithFormat:@"剩餘時間: %@ %@ %@",remainTime[0],remainTime[1],remainTime[2]];
            }else if (lang==2){//cn
                _time.text = [NSString stringWithFormat:@"剩余时间: %@ %@ %@",remainTime[0],remainTime[1],remainTime[2]];
            }else{
                _time.text = [NSString stringWithFormat:@"%@ %@ %@ To Go",remainTime[0],remainTime[1],remainTime[2]];
            }
        }else if (timeArray.count == 2){
//            _time.text = [NSString stringWithFormat:@"%@ %@ To Go",remainTime[0],remainTime[1]];
            if (lang==1) { //hk
                _time.text = [NSString stringWithFormat:@"剩餘時間: %@ %@ ",remainTime[0],remainTime[1]];
            }else if (lang==2){//cn
                _time.text = [NSString stringWithFormat:@"剩余时间: %@ %@",remainTime[0],remainTime[1]];
            }else{
                _time.text = [NSString stringWithFormat:@"%@ %@  To Go",remainTime[0],remainTime[1]];
            }
        }else{
//            _time.text = [NSString stringWithFormat:@"%@ To Go",remainTime[0]];
            if (lang==1) { //hk
                _time.text = [NSString stringWithFormat:@"剩餘時間: %@ ",remainTime[0]];
            }else if (lang==2){//cn
                _time.text = [NSString stringWithFormat:@"剩余时间: %@",remainTime[0]];
            }else{
                _time.text = [NSString stringWithFormat:@"%@ To Go",remainTime[0]];
            }
        }
        
        //显示捐款目标金额&&已筹金额数据
        if (_dataDict[@"Amt"] != nil) {
            NSArray * labelArray = @[_dataDict[@"Amt"],_dataDict[@"TargetAmt"],_dataDict[@"DonorCount"],_dataDict[@"CommentCount"]];
            for (int i = 0; i < 4; i ++) {
                if (i <2) {
                    UILabel * label = (UILabel *)[_topTabaleView viewWithTag:55+i];
                    label.text = [NSString stringWithFormat:@"$%@",labelArray[i]];
                }else{
                    UILabel * label = (UILabel *)[_topTabaleView viewWithTag:55+i];
                    label.text = [NSString stringWithFormat:@"  %@",labelArray[i]];
                }
            }
        }
        //解析中间图片数据
       galleryArray = [[NSMutableArray alloc] init];
      for (NSDictionary *dict in _model.Media){
            
          NSDictionary * galleryImgDict = [[NSDictionary alloc] initWithObjectsAndKeys:dict[@"MediaURL"],@"MediaURL",nil];
          [galleryArray addObject:galleryImgDict];

          
        }
        _picArray = [[NSMutableArray alloc] init];
        
    for (NSDictionary * dict in _model.GalleryImg){
            NSDictionary * galleryImgDict = [[NSDictionary alloc]
                                             initWithObjectsAndKeys:dict[@"ImgURL"],@"ImgURL",
                                             dict[@"ImgCaption"],@"ImgCaption",
                                             dict[@"IsProfileImg"],@"IsProfileImg",nil];
            [galleryArray addObject:galleryImgDict];
        
            [_picArray addObject:galleryImgDict];
        
        
        }
        //显示中间的scrollView图片
        _imageScrollView.contentSize = CGSizeMake(320*galleryArray.count, 0);
        if (galleryArray.count == 0){
            [_imageScrollView addImageViewWithFrame:CGRectMake(0, 0, 320, 220) image:@"dummy_case_related_default@2x.png"];
            _imageScrollView.contentMode = UIViewContentModeScaleAspectFit;
        }
        
        for (int i = 0; i < galleryArray.count; i ++){
            
            NSDictionary * dict = galleryArray[i];
            NSURL *url = [NSURL URLWithString:SITE_URL];
            
            if ([[dict allKeys] containsObject:@"MediaURL"]){
              url = [url URLByAppendingPathComponent:dict[@"MediaURL"]];
                MyLog(@"url=%@",url);
            // MediogalleryImg = [_imageScrollView addImageViewWithFrame:CGRectMake(320*i, 0, 320, 220) image:nil];
                //NSString *urlString = [NSString stringWithFormat:@"%@",url];
                //UIImage *image = [self getThumbnailImage:urlString];
                //MediogalleryImg.image = image;
                //MediogalleryImg.contentMode = UIViewContentModeScaleAspectFit;
                 // __weak typeof (self) ws = self;
//                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShowDetailePic)];
                //[galleryImg addGestureRecognizer:tap];
                
//        UIButton * playButton = [_imageScrollView addImageButtonWithFrame:CGRectMake(320*i+20, 140, 50, 50) title:nil backgroud:nil action:^(UIButton *button){
//            MPMoviePlayerViewController *mpvc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
//            
//            [ws presentViewController:mpvc animated:YES completion:nil];
//            
//            
//                }];
//                
//            
//        [playButton setBackgroundImage:[UIImage imageNamed:@"comment_play.png"] forState:UIControlStateNormal];
                
            
            }else{
            url = [url URLByAppendingPathComponent:dict[@"ImgURL"]];
            UIImageView * galleryImg = [_imageScrollView addImageViewWithFrame:CGRectMake(320*i, 0, 320, 220) image:nil];
            if (![dict[@"ImgURL"] isEqualToString:@""]){
                [galleryImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
                galleryImg.contentMode = UIViewContentModeScaleAspectFit;
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShowDetailePic)];
                
                [galleryImg addGestureRecognizer:tap];
                
            }else{
                [galleryImg setImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"]];
                galleryImg.contentMode = UIViewContentModeScaleAspectFit;
            }
            
        }
        
        }
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 350, 320, 20)];
        _pageControl.numberOfPages = galleryArray.count;
        _pageControl.currentPage = _page;
        [_topTabaleView addSubview:_pageControl];
        [_pageControl addTarget:self action:@selector(pageControlAction) forControlEvents:UIControlEventValueChanged];
        
        _typeTitle.text = [NSString stringWithFormat:@"%@ (%@)", _dataDict[@"Title"], _dataDict[@"Region"]];
        //        [NSString stringWithFormat:@"%@ (%@)", model.Title, model.Region]
        [_tableView reloadData];
        [_tableView.tableFooterView reloadInputViews];
        
        NSThread *thr = [[NSThread alloc]initWithTarget:self selector:@selector(task) object:nil];
        [thr start];
        
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



-(void)task{
    
       for (int i = 0; i < galleryArray.count; i++){
           
           NSDictionary * dict = galleryArray[i];
           NSURL *url = [NSURL URLWithString:SITE_URL];
           if ([[dict allKeys] containsObject:@"MediaURL"]){
              
               
            url = [url URLByAppendingPathComponent:dict[@"MediaURL"]];
            MediogalleryImg = [_imageScrollView addImageViewWithFrame:CGRectMake(320*i, 0, 320, 220) image:nil];
               NSString *urlString = [NSString stringWithFormat:@"%@",url];
               UIImage *image = [self getThumbnailImage:urlString];
               MediogalleryImg.image = image;
               MediogalleryImg.contentMode = UIViewContentModeScaleAspectFit;
               __weak typeof (self) ws = self;
            UIButton * playButton = [_imageScrollView addImageButtonWithFrame:CGRectMake(320*i+20, 140, 50, 50) title:nil backgroud:nil action:^(UIButton *button){
                   MPMoviePlayerViewController *mpvc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
                   
                   [ws presentViewController:mpvc animated:YES completion:nil];
                   
                   
               }];
               //创建播放按钮
               [playButton setBackgroundImage:[UIImage imageNamed:@"comment_play.png"] forState:UIControlStateNormal];
               
    
           }
    }
    
    
}

-(UIImage *)getThumbnailImage:(NSString *)videoURL{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoURL] options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(10, 50);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    if (error) {
        MyLog(@"截取视频图片失败:%@",error.localizedDescription);
    }
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;
}


-(void)ShowDetailePic{
   GirdShowDetailePicViewController *svc = [[GirdShowDetailePicViewController alloc] initWithNibName:@"GirdShowDetailePicViewController" bundle:nil];
    svc.PicArray  = _picArray;
  [self.navigationController pushViewController:svc animated:YES];
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    _page = point.x/320;
    _pageControl.currentPage = _page;
    
}

-(void)pageControlAction{
    int page = (int)_pageControl.currentPage;
    [_imageScrollView setContentOffset:CGPointMake(320*page, 0) animated:YES];
    
}
//返回组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _stateArray.count;
}
//每组cell的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_stateArray[section] isEqualToString:@"1"]) {
        return 0;
    }else{
        if (section == 4) {
            if ([_model.Share isEqualToString:@""]) {
                return 0;
            }else{
                return 1;
            }
        }else
            return 1;
    }
}
//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _retSize.height+50;
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else
        return 35;
}
//组脚高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 4) {
        NSArray * similarArray = _model.SimilarCaseList[@"ItemList"];
        
        if (similarArray.count == 0) {
            return 0;
        }
        return 300;
    }else
        return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cell";
    GirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil){
        cell = [[GirdTableViewCell alloc] init:self];
        //[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_dataArray.count > 0) {
        //  cell.textLabel.numberOfLines = 0;
        //            cell.textLabel.font = _font;
        [cell setLabelFont:_font];
        if (indexPath.section == 0){
            //                cell.textLabel.text = [_model.ShortDesc stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
            //                _retSize = EG_MULTILINE_TEXTSIZE(cell.textLabel.text, cell.textLabel.font, CGSizeMake(300,CGFLOAT_MAX), NSLineBreakByWordWrapping);
            [cell setLabelText:[_model.ShortDesc stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"]];
            NSString *fontString = [NSString stringWithFormat:@"%f",_font.pointSize];
            CGFloat fontSize = 2.0+[fontString floatValue];
            UIFont *font = [UIFont systemFontOfSize:fontSize];
            
            MyLog(@"%@",font);
            
            _retSize = EG_MULTILINE_TEXTSIZE([_model.ShortDesc stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"], font, CGSizeMake(290,CGFLOAT_MAX), NSLineBreakByWordWrapping);
            
        }else if (indexPath.section == 1){
            
            //                cell.textLabel.text = [_model.Content stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
            //                cell.textLabel.text = [NSString captureData:cell.textLabel.text];
            MyLog(@"_model.Content _model.Content = %@", _model.Content);
            NSString *s = [_model.Content stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
            [cell setLabelText:s];//[NSString captureData:s]];
            NSString *fontString = [NSString stringWithFormat:@"%f",_font.pointSize];
            CGFloat fontSize = 2.0+[fontString floatValue];
            
            MyLog(@"%f",[fontString floatValue]);
            
            UIFont *font = [UIFont systemFontOfSize:fontSize];
            _retSize = EG_MULTILINE_TEXTSIZE(s, font, CGSizeMake(290,CGFLOAT_MAX), NSLineBreakByWordWrapping);
            
        }else if (indexPath.section == 2){
            //                cell.textLabel.text = [_model.BackGround stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
            [cell setLabelText:[_model.BackGround stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"]];
            NSString *fontString = [NSString stringWithFormat:@"%f",_font.pointSize];
            CGFloat fontSize = 2.0+[fontString floatValue];
            UIFont *font = [UIFont systemFontOfSize:fontSize];
            _retSize = EG_MULTILINE_TEXTSIZE([_model.BackGround stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"], font, CGSizeMake(290,CGFLOAT_MAX), NSLineBreakByWordWrapping);
        }else if (indexPath.section == 3){
            //                cell.textLabel.text = [_model.Need stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
            [cell setLabelText:[_model.Need stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"]];
            NSString *fontString = [NSString stringWithFormat:@"%f",_font.pointSize];
            CGFloat fontSize = 2.0+[fontString floatValue];
            UIFont *font = [UIFont systemFontOfSize:fontSize];
            _retSize = EG_MULTILINE_TEXTSIZE([_model.Need stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"], font, CGSizeMake(290,CGFLOAT_MAX), NSLineBreakByWordWrapping);
            
        }else if (indexPath.section == 4){
            //                cell.textLabel.text = [_model.Share stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
            NSString *fontString = [NSString stringWithFormat:@"%f",_font.pointSize];
            CGFloat fontSize = 2.0+[fontString floatValue];
            UIFont *font = [UIFont systemFontOfSize:fontSize];

            [cell setLabelText:[_model.Share stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"]];
            _retSize = EG_MULTILINE_TEXTSIZE([_model.Share stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"], font, CGSizeMake(290,CGFLOAT_MAX), NSLineBreakByWordWrapping);
        }
    }
    
       return cell;
    
}

#pragma mark - 头部视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return nil;
    }
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    _headerView.tag = 70+section;
    _headerView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    if (section != 4) {
        [_headerView addGestureRecognizer:tap];
    }
    
//    NSMutableArray *titleArrry = [[NSMutableArray alloc] init];
//    
//    if (titleDict.count != 0){
//        
//        for(NSString *compKey in titleDict){
//            NSString *title = [titleDict objectForKey:compKey];
//            [titleArrry addObject:title];
//        }
//        
//        MyLog(@"%@",titleArrry);
    
    if (section==1){
       
        UILabel * titleLabel = [_headerView addLabelWithFrame:CGRectMake(10, 7.5, SCREEN_WIDTH-30, 20) text:[titleDict objectForKey:@"lbl_DescTitle"]];
        titleLabel.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
        titleLabel.font =[UIFont systemFontOfSize:15];

        
    }else if(section==2){
    
        UILabel * titleLabel = [_headerView addLabelWithFrame:CGRectMake(10, 7.5, SCREEN_WIDTH-30, 20) text:[[titleDict objectForKey:@"lbl_SituationTitle"]stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"]];
        titleLabel.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
        titleLabel.font =[UIFont systemFontOfSize:15];
    
    }else if (section==3){
    
        UILabel * titleLabel = [_headerView addLabelWithFrame:CGRectMake(10, 7.5, SCREEN_WIDTH-30, 20) text:[titleDict objectForKey:@"lbl_NeedTitle"]];
        titleLabel.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
        titleLabel.font =[UIFont systemFontOfSize:15];
    
    }else if (section==4){
    
        UILabel * titleLabel = [_headerView addLabelWithFrame:CGRectMake(10, 7.5, SCREEN_WIDTH-30, 20) text:[titleDict objectForKey:@"lbl_VoiceTitle"]];
        titleLabel.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
        titleLabel.font =[UIFont systemFontOfSize:15];
    
    }


    NSString * str = [_stateArray objectAtIndex:section];
    if ([str isEqualToString:@"1"]) {
        _stateImage = [_headerView addImageViewWithFrame:CGRectMake(280, 12.5, 15, 8) image:@"case_detail_expand@2x.png"];
    }else{
        if (section != 4) {
            _stateImage = [_headerView addImageViewWithFrame:CGRectMake(280, 12.5, 15, 8) image:@"case_detail_close@2x.png"];
        }
    }
    
    return _headerView;
}
#pragma mark - 尾部视图
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    _itemArray = [[NSMutableArray alloc] init];
    if (section == 4) {
        NSArray * similarArray = _model.SimilarCaseList[@"ItemList"];
        MyLog(@"similarArray");
        MyLog(@"%@",similarArray);
        
        if (similarArray.count == 0) {
            return nil;
        }
        for (NSDictionary * dict in similarArray) {
            GirdModel * model = [[GirdModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [_itemArray addObject:model];
        }
        _bottomTabaleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 250)];
        UILabel * label = [_bottomTabaleView addLabelWithFrame:CGRectMake(10, 5, 200, 25) text:[NSString stringWithFormat:@"%@(%@)",EGLocalizedString(@"IsCase", nil),_model.SimilarCaseList[@"TotalNumberOfItems"]]];
        label.font = [UIFont systemFontOfSize:15];
        
        double width = 320;
        
        UIScrollView * imageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 35, 320, 200)];
        imageScroll.showsHorizontalScrollIndicator = NO;
        imageScroll.pagingEnabled=YES;
        if (_itemArray.count>5) {
            //            imageScroll.contentSize = CGSizeMake(width*5+20, 0);
            imageScroll.contentSize = CGSizeMake(320*5, 0);
        }else{
            //            imageScroll.contentSize = CGSizeMake(width*_itemArray.count+20, 0);
            imageScroll.contentSize = CGSizeMake(320*_itemArray.count, 0);
        }
        [_bottomTabaleView addSubview:imageScroll];
        
        NSMutableArray * arr = [[NSMutableArray alloc] init];
        NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
        EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
        
        for (EGShoppingCart * model in item.ItemList) {
            [arr addObject:model.CaseID];
        }
        for (int i = 0; i < (_itemArray.count >5 ? 5 :_itemArray.count); i ++) {
            GirdModel * model = _itemArray[i];
            for (GirdModel *model in _itemArray) {
                model.isSelect = NO;
                for (EGShoppingCart *obj in item.ItemList) {
                    if ([model.CaseID isEqualToString:obj.CaseID]) {
                        model.isSelect = YES;
                    }
                }
            }
            
            UIImageView * similarImage = [imageScroll addImageViewWithFrame:CGRectMake(i*width, 0,320, 200) image:@"testImage.jpg"];
            similarImage.tag = 555+i;
            NSURL *url = [NSURL URLWithString:SITE_URL];
            url = [url URLByAppendingPathComponent:model.ProfilePicURL];
            if (![model.ProfilePicURL isEqualToString:@""]) {
                [similarImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
                similarImage.contentMode = UIViewContentModeScaleAspectFit;
            }else{
                [similarImage setImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"]];
                similarImage.contentMode = UIViewContentModeScaleAspectFit;
            }
            
            UIButton * similarButton = [imageScroll addImageButtonWithFrame:CGRectMake(i*width+10, 0, 320-10, 200) title:nil backgroud:nil action:^(UIButton *button){
                
                [self openSimilarCase:model];
                
                
            }];
            
            UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 150,320,50)];
            bgView.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:0.8];
            [similarImage addSubview:bgView];
            
            UILabel * title = [bgView addLabelWithFrame:CGRectMake(5,0,bgView.frame.size.width/2, bgView.frame.size.height) text:[NSString stringWithFormat:@"%@ (%@)", model.Title, model.Region]];
            title.font = [UIFont boldSystemFontOfSize:14];
            title.numberOfLines = 2;
            title.textColor = [UIColor whiteColor];
            
            [bgView addImageViewWithFrame:CGRectMake(320/2+20, 5, 1, 40) image:@"case_separ_line@2x.png"];
            
            UILabel * label = [bgView addLabelWithFrame:CGRectMake(320-130, 5, 60, 25) text:EGLocalizedString(@"GirdView_target_label", nil)];
            label.font = [UIFont boldSystemFontOfSize:13];
            label.textColor = [UIColor whiteColor];
            
            UILabel * goalMoney = [bgView addLabelWithFrame:CGRectMake(320-130, 25, 100, 25) text:[NSString stringWithFormat:@"$%@",model.TargetAmt]];
            goalMoney.font = [UIFont boldSystemFontOfSize:14];
            goalMoney.textColor = [UIColor whiteColor];
            UIButton * button = [bgView addImageButtonWithFrame:CGRectMake(320-50, 5, 25, 25) title:nil backgroud:@"" action:^(UIButton *button) {
                if (button.selected) {
                    UIAlertView *alertView = [[UIAlertView alloc] init];
                    alertView.message = EGLocalizedString(@"專案已經加入購物車,請選擇其他專案", nil);
                    [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                    [alertView show];
                    [_tableView reloadData];
                    
                }else{
                    
                    if ([model.RemainingValue intValue] == 0) {
                        UIAlertView *alertView = [[UIAlertView alloc] init];
                        alertView.message = EGLocalizedString(@"專案已結束,請支持其他專案", nil);
                        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                        [alertView show];
                    }else{
                        [self saveShoppingCartItem:model.CaseID];
                        UIAlertView *alertView = [[UIAlertView alloc] init];
                        alertView.message = EGLocalizedString(@"alert_msg_saveShoppingCartItemSuccess", nil);
                        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                        [alertView show];
                        [_tableView reloadData];
                    }
                }
                
            }];
            [button setBackgroundImage:[UIImage imageNamed:@"comment_poster_cart_nor@2x.png"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"comment_poster_cart_sel.png"] forState:UIControlStateSelected];
            if (model.isSelect) {
                button.selected = YES;
            }
        }
        
        return _bottomTabaleView;
        
    }else{
        
        return nil;
    }
}

-(void)openSimilarCase:(GirdModel*) model{
    MyLog(@"openSimilarCase");
    GirdDetailViewController * vc = [[GirdDetailViewController alloc] init];
    vc.girdMdel = model;
    vc.caseID = model.CaseID;
    vc.categoryImg = model.Category;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    int tag = (int)tap.view.tag-70;
    NSString * str = [_stateArray objectAtIndex:tag];
    if ([str isEqualToString:@"1"]) {
        [_stateArray replaceObjectAtIndex:tag withObject:@"0"];
    }else{
        [_stateArray replaceObjectAtIndex:tag withObject:@"1"];
        
    }
    [_tableView reloadData];
    //[_tableView reloadSections:[NSIndexSet indexSetWithIndex:tag] withRowAnimation:UITableViewRowAnimationFade];
}

//请求title
-(void)GetCaseDetailSubtitle{
    //[self showLoadingAlert];
     NSInteger lang = [EGUtility getAppLang];
    NSString * soapMessage =
[NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <GetCaseDetailSubtitle xmlns=\"egive.appservices\"><Lang>%ld</Lang></GetCaseDetailSubtitle></soap:Body></soap:Envelope>",(long)lang];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
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
        NSString *result = [NSString captureData:dataString];
        NSArray *array = [NSString parseJSONStringToNSArray:result];
        MyLog(@"%@",array);
        titleDict = [[NSMutableDictionary alloc] init];
        for (NSDictionary *dict in array) {
            [titleDict setObject:dict[@"LabelDescription"] forKey:dict[@"LabelName"]];
            
        }
        [self.tableView reloadData];
       
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

#pragma mark - 收藏请求
-(void)AddCaseFavourite:(NSString *)caseID{
    [self showLoadingAlert];
    if (_item.MemberID == NULL) {
        _item.MemberID = @"";
    }
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><AddCaseFavourite xmlns=\"egive.appservices\"><CaseID>%@</CaseID><MemberID>%@</MemberID></AddCaseFavourite></soap:Body></soap:Envelope>",caseID,_item.MemberID];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
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
        if ([result isEqual:@"\"\""]) {
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"收藏成功", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            [self requestApiData:_caseID andMemberID:_item.MemberID];
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
-(void)DeleteCaseFavourite:(NSString *)caseID{
    if (_item.MemberID == NULL) {
        _item.MemberID = @"";
    }
    [self showLoadingAlert];
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <DeleteCaseFavourite xmlns=\"egive.appservices\"><CaseID>%@</CaseID><MemberID>%@</MemberID></DeleteCaseFavourite></soap:Body></soap:Envelope>",caseID,_item.MemberID];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
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
            [self requestApiData:_caseID andMemberID:_item.MemberID];
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

- (void)saveShoppingCartItem:(NSString *)caseId{
    
    EGSaveShoppingCartItemRequest *request = [[EGSaveShoppingCartItemRequest alloc] init];
    request.MemberID = _item.MemberID ? _item.MemberID :@"";
    NSString *cookieId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    request.CookieID = cookieId;
    request.CaseID = caseId;
    request.DonateAmt = 0;
    request.IsChecked = 1;
    
    //__weak __typeof(self)weakself = self;
    
    [EGMyDonationRequestAdapter saveShoppingCartItem:request success:^(NSString *result) {
        
        [self GetAndSaveShoppingCart];
        
    } failure:^(NSError *error){
        
        MyLog(@"%@",error);
        
    }];
}

- (void)GetAndSaveShoppingCart{
    
    EGGetAndSaveShoppingCartRequest *request = [[EGGetAndSaveShoppingCartRequest alloc] init];
    request.lang = 1;
    request.LocationCode = @"HK";
    request.DonateWithCharge = YES;
    request.MemberID = _item.MemberID ? _item.MemberID :@"";
    NSString *cookieId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    MyLog(@"cookieId --------------->>>>>>>>%@",cookieId);
    request.CookieID = cookieId;
    request.StartRowNo = 1;
    request.NumberOfRows = 20;
    
    //    __weak __typeof(self)weakSelf = self;
    [EGMyDonationRequestAdapter getGetAndSaveShoppingCart:request success:^(EGGetAndSaveShoppingCartResult *result) {
        
        //        _cartLabel.text = [NSString stringWithFormat:@"%ld",result.NumberOfItems];
        
        NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
        if (result != nil) {
            [shopCartDict setObject:result forKey:@"shopItem"];
        }
        _cartLabel.text = [NSString stringWithFormat:@"%ld",result.NumberOfItems];
        //        EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
        if (result.NumberOfItems < 1) {
            _cartLabel.hidden = YES;
        }else{
            _cartLabel.hidden = NO;
        }
        MyLog(@"NumberOfItems:%ld",result.NumberOfItems);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCount" object: nil];
        
        if (_isGo) {
            MyDonationViewController * vc = [[MyDonationViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } failure:^(NSError *error) {
        MyLog(@"%@",error);
    }];
}

- (void)changeCount {
    
    NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
    EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
    for (GirdModel *model in _dataArray) {
        model.isSelect = NO;
        for (EGShoppingCart *obj in item.ItemList) {
            if ([model.CaseID isEqualToString:obj.CaseID]) {
                model.isSelect = YES;
            }
        }
    }
    _cartLabel.text = [NSString stringWithFormat:@"%ld",item.NumberOfItems];
    if (item.NumberOfItems < 1) {
        _cartLabel.hidden = YES;
    }else{
        _cartLabel.hidden = NO;
    }
    [_tableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated{
    _isGo=NO;
    //判断用户是否登入，如登入获取：MemberID
    NSMutableDictionary * dict = [ShowMenuView getUserInfo];
    _item = dict[@"LoginName"];
    
    [self requestApiData:_caseID andMemberID:_item.MemberID];
    
    NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
    EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
    
    _cartLabel.hidden = NO;
    if (item.NumberOfItems < 1) {
        _cartLabel.hidden = YES;
    }else{
        _cartLabel.hidden = NO;
    }
    
    //
    [self GetAndSaveShoppingCart];
    _navLeftImage.hidden =NO;
    _shareButton.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    _shareButton.hidden = YES;
    _cartLabel.hidden = YES;
    _navLeftImage.hidden = YES;
}

- (void)proAction{
    
    ProReportController * vc = [[ProReportController alloc] init];
    vc.UpdatesDetail = _model.UpdatesDetail;
    vc.caseId = _caseID;
    vc.nameString = self.nameString;
    MyLog(@"%@",vc.nameString);
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)addMySlider{
    
    int height=0;
    if (ScreenSize.height==480 || [device_.model isEqualToString:@"iPad"]) {
        
        height=380;
    }else{
    
        height=568 - 90;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, height, 320 - 20, 47)];
    view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    view.layer.cornerRadius = 3;
    view.layer.masksToBounds = YES;
    [self.view addSubview:view];
    _sliderView = view;
    _sliderView.hidden = YES;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 27, 27)];
    label1.font = [UIFont systemFontOfSize:15];
    label1.text = @"A";
    [view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake( 300 - 30, 10, 27, 27)];
    label2.font = [UIFont systemFontOfSize:20];
    label2.text = @"A";
    [view addSubview:label2];
    
    UISlider *sliderA=[[UISlider alloc]initWithFrame:CGRectMake(25, 20, 300 - 60, 7)];
    sliderA.backgroundColor = [UIColor clearColor];
    sliderA.value=0.5;
    sliderA.minimumValue=0.0;
    sliderA.maximumValue=1.0;
    _slider = sliderA;
    //滑块拖动时的事件
    //    [sliderA addTarget:self action:@selector(sliderValueChanged) forControlEvents:UIControlEventValueChanged];
    //滑动拖动后的事件
    [sliderA addTarget:self action:@selector(sliderDragUp) forControlEvents:UIControlEventTouchUpInside];
    
    [self.sliderView addSubview:sliderA];
    
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.0;
    [self.view addGestureRecognizer:longPressGr];
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDo:)];
    [_tableView addGestureRecognizer:tapGr];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (!_sliderView.hidden) {
        _sliderView.hidden = YES;
    }
}

- (void)tapToDo:(UITapGestureRecognizer *)gr
{
    if (!_sliderView.hidden) {
        _sliderView.hidden = YES;
    }
}

-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        //add your code here
        if (_sliderView.hidden) {
            _sliderView.hidden = NO;
        }
    }
}

-(void)sliderDragUp{
    
    float value = _slider.value;
    float change = 6*(value - 0.5);
    
    for (int i = 0; i< _stateArray.count; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        //    ForeshowDetailCell * cell = (ForeshowDetailCell*)[_tableView cellForRowAtIndexPath:indexPath];
        UITableViewCell * cell = (UITableViewCell*)[_tableView cellForRowAtIndexPath:indexPath];
        CGFloat fontSize = 18 + change;
        cell.textLabel.font = [UIFont systemFontOfSize:fontSize];
        _font =[UIFont systemFontOfSize:fontSize];
    }
    [_tableView reloadData];
}
- (void)showLoadingAlert{
    
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
