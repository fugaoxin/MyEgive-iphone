//
//  PopupAdController.m
//  Egive
//
//  Created by sinogz on 15/9/30.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "PopupAdController.h"
#import "EGUtility.h"
#import "AppDelegate.h"
#import "HomeModel.h"
#import "Constants.h"
@interface PopupAdController (){

    UIImageView *imageView;
}

@end

@implementation PopupAdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self GetAppInitImage];
    UIView *popupView = [[UIView alloc] initWithFrame:self.view.bounds];
    popupView.userInteractionEnabled=YES;
    popupView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    [self.view addSubview:popupView];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    //imageView.image = [UIImage imageNamed:@"Lanch.png"];
    [popupView addSubview:imageView];

    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (IS_IPHONE_6){
        
        closeBtn.frame = CGRectMake(kScreenW - 30, 40, 30, 30);
        
    }
    
    if (IS_IPHONE_5){
        
        closeBtn.frame = CGRectMake(kScreenW - 30, 30, 30, 30);
    }
    
    if (IS_IPHONE_6P){
        
         closeBtn.frame = CGRectMake(kScreenW - 30, 40, 30, 30);
    }
    if (IS_IPHONE_4_OR_LESS){
        
        closeBtn.frame = CGRectMake(kScreenW - 33,10, 30, 30);
        
    }
    if (IS_IPAD){
        
         closeBtn.frame = CGRectMake(kScreenW - 33,0, 30, 30);
        
    }
    [closeBtn setImage:[UIImage imageNamed:@"ad_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [popupView addSubview:closeBtn];
    
}

-(void)GetAppInitImage{
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetAppInitImage xmlns=\"egive.appservices\" /></soap:Body></soap:Envelope>"
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
        
        MyLog(@"%@",arr);
        
        for (NSDictionary *dict in arr) {
            
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[SITE_URL stringByAppendingPathComponent:[[dict objectForKey:@"FilePath"] stringByReplacingOccurrencesOfString:@"\\" withString:@"/"]]]] placeholderImage:nil];
            
            MyLog(@"%@",[NSString stringWithFormat:@"%@",[SITE_URL stringByAppendingPathComponent:[[dict objectForKey:@"FilePath"] stringByReplacingOccurrencesOfString:@"\\" withString:@"/"]]]);
            
        }
        
        
        //MyLog(@"%@",arr);[UIImage imageNamed:@"Lanch.png" ]
        
        
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

- (void)closeAction:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
