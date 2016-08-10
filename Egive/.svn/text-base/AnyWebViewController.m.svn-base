//
//  AddCaseViewController.m
//  Egive
//
//  Created by sino on 15/9/24.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "Constants.h"
#import "AnyWebViewController.h"

@interface AnyWebViewController ()<UIWebViewDelegate>
@property (retain, nonatomic) UIWebView * webView;
@property (retain, nonatomic) NSString * url;
@end

@implementation AnyWebViewController

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
    
   // MyLog(@"URL = %@", (_aURL != nil ? _aURL : [NSString stringWithFormat:@"%@/%@",SITE_URL,_sURL]));
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    _webView.scalesPageToFit = YES;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: (_aURL != nil ? _aURL : [NSString stringWithFormat:@"%@/%@",SITE_URL,_sURL])]]];
}

-(void)setAbsoluteURL:(NSString *)theURL{
    _aURL = theURL;
}

-(void)setURL:(NSString *)theURL{
    _sURL = theURL;
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
