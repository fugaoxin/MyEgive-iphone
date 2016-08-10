//
//  ReleaseDtlViewController.m
//  Egive
//
//  Created by sino on 15/9/22.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ReleaseDtlViewController.h"
#import "baseController.h"
#import "NSString+EGIVE.h"
#import "UIView+ZJQuickControl.h"
#import "EGUtility.h"
#import "MenuViewController.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface ReleaseDtlViewController ()

@end

@implementation ReleaseDtlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = EGLocalizedString(@"發布中心", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_share@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self createUI];
}

- (void)createUI{
    
    UILabel * titleLabel = [self.view addLabelWithFrame:CGRectMake(20, 68, ScreenSize.width-40, 50) text:_TitleLabel];
    //titleLabel.backgroundColor=[UIColor redColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.numberOfLines=0;
    titleLabel.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    
     [self.view addImageViewWithFrame:CGRectMake(10, 120, ScreenSize.width-20, 2) image:@"Line@2x.png"];
    
    UILabel * dateLabel = [self.view addLabelWithFrame:CGRectMake(20, 125, 60, 25) text:EGLocalizedString(@"DonationInfo_foreshow_date", nil)];
    dateLabel.textColor = [UIColor grayColor];
    dateLabel.font = [UIFont systemFontOfSize:14];
    
    UILabel * date = [self.view addLabelWithFrame:CGRectMake(70, 125, 150, 25) text:[NSString stringWithDataString:_PublishDate format:@"yyyy/MM/dd"]];
    date.textColor = [UIColor grayColor];
    date.font = [UIFont systemFontOfSize:14];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 155, ScreenSize.width, ScreenSize.height - 155)];
    
    NSURL *targetURL = self.URL;
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [webView loadRequest:request];
    webView.scalesPageToFit = YES;
    
    [self.view addSubview:webView];
}

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightAction{
    
    NSString * string = @"";
    NSString * subject = @"";
    if ([EGUtility getAppLang]==1) {
        NSString *str = [NSString stringWithFormat:@"Egive -  發佈中心\n%@已上載，請瀏覽:http://www.egive4u.org/DownloadForm.aspx?type=A\n\n意贈慈善基金\nEgive For You Charity Foundation\n電話: (852) 2210 2600\n電郵: info@egive4u.org",_TitleLabel];
        string = str;
        subject = [NSString stringWithFormat:@"Egive 發佈中心 - %@",_TitleLabel];
        
    }else if ([EGUtility getAppLang]==2){
        
        NSString *str = [NSString stringWithFormat:@"Egive -  发布中心\n%@已上载，请浏览:http://www.egive4u.org/DownloadForm.aspx?type=A\n\n意赠慈善基金\nEgive For You Charity Foundation\n电話: (852) 2210 2600\n电邮: info@egive4u.org",_TitleLabel];
        string = str;
        subject = [NSString stringWithFormat:@"Egive 发布中心 - %@",_TitleLabel];
        
    }else{
        
        NSString * str = [NSString stringWithFormat:@"Egive - Publication\n%@ has been released, pelase visit www.egive4u.org/DownloadForm.aspx?type=A for details.\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org",_TitleLabel];
        string = str;
        subject = [NSString stringWithFormat:@"Egive - Publication - %@",_TitleLabel];

    }

    [MenuViewController shareToSocialNetworkWithSubject:subject content:string url:nil image:nil];
    
//    UIActivityViewController *activityViewController =
//    [[UIActivityViewController alloc] initWithActivityItems:@[string]
//                                      applicationActivities:nil];
//    [self.navigationController presentViewController:activityViewController
//                                            animated:YES
//                                          completion:^{
//                                              // ...
//                                          }];
//    activityViewController.excludedActivityTypes = @[UIActivityTypePrint];
//    [activityViewController setValue:subject forKey:@"subject"];
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
