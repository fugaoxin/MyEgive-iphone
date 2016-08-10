//
//  LangViewController.m
//  Egive
//
//  Created by sino on 15/10/7.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "LangViewController.h"
#import "EGUtility.h"
#import "DDMenuController.h"
#import "HomeViewController.h"
#import "PopupAdController.h"
#import "Constants.h"
@interface LangViewController ()
@property (nonatomic, strong) UIView * launchView;
@property (nonatomic) BOOL isFirstLuch;
@end

@implementation LangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createLaunchView];
}
- (void)createLaunchView{
    
    _launchView = [[UIView alloc] initWithFrame:self.view.bounds];
//    _launchView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    _launchView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_launchView];
    
    [_launchView addImageViewWithFrame:CGRectMake(0, kScreenH/2-180, kScreenW, 300) image:@"dummy_case_related_default@2x.png"];
    
    
    UIView * langBgView = [[UIView alloc] initWithFrame:CGRectMake(40, kScreenH-150, kScreenW-80, 50)];
    langBgView.backgroundColor = [UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1];
    langBgView.layer.cornerRadius = 4;
    langBgView.layer.masksToBounds = YES;
    [_launchView addSubview:langBgView];
    
    [langBgView addImageViewWithFrame:CGRectMake(langBgView.frame.size.width/3, 5, 0.5, 40) image:@"case_separ_line@2x.png"];
    
    [langBgView addImageViewWithFrame:CGRectMake(langBgView.frame.size.width/3*2, 5, 0.5, 40) image:@"case_separ_line@2x.png"];
    
    NSArray * langTitleArr = @[@"English",@"繁",@"简"];
    for (int i = 0; i < 3; i ++) {
        UILabel * label = [langBgView addLabelWithFrame:CGRectMake(langBgView.frame.size.width/3*i, 5, langBgView.frame.size.width/3-0.5, 40) text:langTitleArr[i]];
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor whiteColor];
        label.userInteractionEnabled = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 600+i;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(langAction:)];
        [label addGestureRecognizer:tap];
        
    }
    
}

- (void)langAction:(UITapGestureRecognizer *)tap{
    
    if (tap.view.tag == 600) {
        [self switchLang:EN];
        _launchView.hidden = YES;
 
        [self pushToHomePage];
       [self requestApiData:3];
        
        
    }else if (tap.view.tag == 601){
        [self switchLang:HK];
        _launchView.hidden = YES;
        
        [self pushToHomePage];
        [self requestApiData:1];
        
    }else{
        [self switchLang:CN];
        _launchView.hidden = YES;
        [self pushToHomePage];
        [self requestApiData:2];
    }
    
}
- (void)switchLang:(AppLang)lang
{
    [EGUtility setAppLang:lang];
    
    
}

-(void)pushToHomePage{
    
    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    HomeViewController * vc = [[HomeViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    [menuController setRootController:navController animated:YES];
    
    
    PopupAdController *pvc = [[PopupAdController alloc] init];
    pvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    pvc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [vc presentViewController:pvc animated:YES completion:^{
        
    }];

    
}
//请求详细信息
#pragma mark - 请求Cell数据
-(void)requestApiData:(long)AppLang{
    
    [self showLoadingAlert];
    NSString *Apptoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"GetendpointArn"];
    
    MyLog(@"%@",Apptoken);
    
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><RegisterMobileUser xmlns=\"egive.appservices\"><AppLang>%ld</AppLang><AppToken>%@</AppToken></RegisterMobileUser></soap:Body></soap:Envelope>",AppLang,Apptoken];
    
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
