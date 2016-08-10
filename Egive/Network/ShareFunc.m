//
//  ShareFunc.m
//  HKGTA
//
//  Created by lufei on 15/8/3.
//  Copyright (c) 2015年 香港. All rights reserved.
//

#import "ShareFunc.h"
#import "AppDelegate.h"
#import "EGUtility.h"

#define API_ENDPOINT @"http://ec2-52-74-159-250.ap-southeast-1.compute.amazonaws.com:8080/coreService/rest/"
static ShareFunc *sharedShareFunc;

@implementation ShareFunc

- (id)init{
    self = [super init];
    if (self) {
        
        self.HTTPSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:API_ENDPOINT]];
        
        self.HTTPSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.HTTPSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        self.HTTPSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"application/binary", @"image/png", @"image/jpeg", nil];
        [self.HTTPSessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        //语言
        //[self.HTTPSessionManager.requestSerializer setValue:[OPUtility getLangHeader] forHTTPHeaderField:@"Accept-Language"];
    }
    return self;
}

+ (ShareFunc *)shared{
    if (sharedShareFunc == nil) {
        sharedShareFunc = [[ShareFunc alloc] init];
        
    }
    return sharedShareFunc;
}


+ (BOOL)showServerErrorMessage:(NSDictionary *)dict{
    
    if([[dict objectForKey:@"returnCode"] isEqualToString:@"9010102"]||
       [[dict objectForKey:@"returnCode"] isEqualToString:@"9010103"]||
       [[dict objectForKey:@"returnCode"] isEqualToString:@"9010104"]||
       [[dict objectForKey:@"returnCode"] isEqualToString:@"9010105"]||
       [[dict objectForKey:@"returnCode"] isEqualToString:@"9010106"]
       ){
        
        //[[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TOKEN_INVAILD object:nil];
        
    }
    
    if(![[dict objectForKey:@"returnCode"] isEqualToString:@"0"]){
        
       // NSLog(@"%@",[dict objectForKey:@"errorMessage"]);
        
        
        return YES;
        
    }
    
    return NO;
    
}



+ (void)checkNetWorkStatus{
    
    
    /**
     *  AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     *  AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     *  AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G
     *  AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络Wifi
     */
    // 如果要检测网络状态的变化, 必须要用检测管理器的单例startMoitoring
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        
        if(status == AFNetworkReachabilityStatusNotReachable){
            
           // NSLog(@"未连接网络，请检查您的网络！");
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:EGLocalizedString(@"未连接网络，请检查您的网络", nil) delegate:nil cancelButtonTitle:EGLocalizedString(@"Common_button_confirm", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
    }];
    
}

@end
