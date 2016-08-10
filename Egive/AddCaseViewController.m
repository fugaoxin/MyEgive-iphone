//
//  AddCaseViewController.m
//  Egive
//
//  Created by sino on 15/9/24.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "Constants.h"
#import "AddCaseViewController.h"
#import "EGUtility.h"
@interface AddCaseViewController ()<UIWebViewDelegate>
@property (retain, nonatomic) UIWebView * webView;
@property (retain, nonatomic) NSString * url;
@end

@implementation AddCaseViewController

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    _webView.scalesPageToFit = YES;
   // MyLog(@"%@",_MemberID);
//    if (_isLogin) {
//        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:
//            [NSString stringWithFormat:@"%@/AppLogin.aspx?MemberID=%@&AppToken=",SITE_URL1,_MemberID]]]];
//        
//        MyLog(@"%@",[NSString stringWithFormat:@"%@/AppLogin.aspx?MemberID=%@&AppToken=",SITE_URL1,_MemberID]);
//    }else{
//        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/Login.aspx?start=CaseApplication", SITE_URL1]]]];
//    }
    
    if ([EGUtility getAppLang]==1) {
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:

                                                        [NSString stringWithFormat:@"%@/CaseApplicationTerms.aspx?type=S&lang=1&MemberID=%@&AppToken=",SITE_URL,_MemberID]]]];

                                

    
    }else if ([EGUtility getAppLang]==2){
    
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:
                                                            [NSString stringWithFormat:@"%@/CaseApplicationTerms.aspx?type=S&lang=2&MemberID=%@&AppToken=",SITE_URL,_MemberID]]]];
    }else{
    
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:
                                                            [NSString stringWithFormat:@"%@/CaseApplicationTerms.aspx?type=S&lang=3&MemberID=%@&AppToken=",SITE_URL,_MemberID]]]];
    
    
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
