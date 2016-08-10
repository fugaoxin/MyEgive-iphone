//
//  AboutDetailViewController.m
//  Egive
//
//  Created by sino on 15/7/30.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "AboutDetailViewController.h"
#import "UIView+ZJQuickControl.h"
#import "AFNetworking.h"
#import "NSString+RegexKitLite.h"
#import "ShareFunc.h"
#import "EGUtility.h"
#import "Constants.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface AboutDetailViewController ()

@end

@implementation AboutDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = EGLocalizedString(@"成立理念", nil);
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
    //    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_share@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;


    
    
    [self createUI];

}



- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createUI{
    
    UIScrollView * scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height)];
    [self.view addSubview:scroll];
    [scroll addImageViewWithFrame:CGRectMake(0, 0, ScreenSize.width, 200) image:@"testImage.jpg"];
    
    UIPageControl  * pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 180, ScreenSize.width, 20)];
    pageControl.numberOfPages = 4;
    pageControl.backgroundColor = [UIColor grayColor];
    [scroll addSubview:pageControl];
    
    UILabel * titleLabel = [scroll addLabelWithFrame:CGRectMake(10, 210, ScreenSize.width, 30) text:@"「意贈慈善基金」理念"];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    
    _contenLabel =[scroll addLabelWithFrame:CGRectMake(10, 250, ScreenSize.width-20, 400) text:@"「意贈慈善基金」旨在團結個人力量,以生命影響生命的方法,通過互聯網募捐平台,將有需要人士、捐款者及公眾緊密地連繫起來,共建關懷互助的社群。"];
    _contenLabel.font = [UIFont boldSystemFontOfSize:12];
    _contenLabel.numberOfLines = 0;
    
    
    [self test];
}
-(void)test{
    
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetStaticPageContent xmlns=\"egive.appservices\"><Lang>2</Lang><FormID>Chairman</FormID></GetStaticPageContent></soap:Body></soap:Envelope>"
     ];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl" ,SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml" forHTTPHeaderField:@"Content-Type"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 请求的序列化
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // 回复序列化
    //    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    //    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        //        MyLog(@"%@", operation.request.allHTTPHeaderFields);
        //
        //        // 服务器给我们返回的包得头部信息
        //        MyLog(@"%@", operation.response);
        
        NSString *data2String = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];

        NSDictionary * dict = [NSString parseJSONStringToNSDictionary:data2String];
        _contenLabel.text = dict[@"ContentText"];

        
        // 返回的数据
        //        MyLog(@"success = %@",responseObject);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
       // MyLog(@"%@", operation.request.allHTTPHeaderFields);
        
        // 服务器给我们返回的包得头部信息
       // MyLog(@"%@", operation.response);
        
        // 返回的数据
        //MyLog(@"success = %@", error);
        //
        //        if([self.delegate respondsToSelector:@selector(myAppHTTPClientDelegate:self:didFailWithError:)]){
        //            [self.delegate myAppHTTPClientDelegate:self didFailWithError:error];
        //        }
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
