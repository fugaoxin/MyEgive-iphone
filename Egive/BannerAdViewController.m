//
//  BannerAdViewController.m
//  Egive
//
//  Created by sino on 15/9/8.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "BannerAdViewController.h"
#import "Constants.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "objc/runtime.h"
#import "UIView+WebCacheOperation.h"
#import "Constants.h"
#import "EGUtility.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface BannerAdViewController (){

    UIImageView *imageview;
}

@end

@implementation BannerAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    long langnum = [EGUtility getAppLang];
    
    
    if (![_url isEqualToString:@""] &&  _url != NULL){
        
        MyLog(@"%@",_url);
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_webView];
        //[_webView setScalesPageToFit:YES];
       // MyLog(@"%@",_url);
      if ([_url containsString:@"egive4u"]){
          
        NSString *strUrl = [ NSString stringWithFormat:@"%@&&lang=%ld",_url,langnum];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]]];
            
        }else{
            
       // MyLog(@"%@",_url);
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
        
    }
        
    }else{
    
        _imageurl = [SITE_URL stringByAppendingPathComponent:[_imageurl stringByReplacingOccurrencesOfString:@"\\" withString:@"/"]];
       
        NSThread *thr = [[NSThread alloc]initWithTarget:self selector:@selector(task) object:nil];
        [thr start];
        
        
        
     }
    
}

-(void)task{

    imageview = [[UIImageView alloc] initWithFrame:CGRectMake(5, 40, ScreenSize.width-10, ScreenSize.height-44*2)];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    [imageview sd_setImageWithURL:[NSURL URLWithString:_imageurl] placeholderImage:nil];
    [self.view addSubview:imageview];

}
- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
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
