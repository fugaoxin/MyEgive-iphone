//
//  AppDelegate.m
//  Egive
//
//  Created by sino on 15/7/20.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "Constants.h"
#import "AppDelegate.h"
#import "Launching.h"
#import "SideMenuViewController.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "GlobalMacro.h"
#import "EGGeneralRequestAdapter.h"
#import "ConfirmViewController.h"
#import "EGAlertViewController.h"
#import "PopupAdController.h"
#import "EncourageOthersController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "WeiboSDK.h"
#import "testVC.h"
#import "ProReportController.h"
#import "Constants.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "EGUtility.h"
#import "ActivityViewController.h"
#import "MyDonationViewController.h"
#import "GirdDetailViewController.h"
#import "InformationController.h"



@interface AppDelegate ()<UIScrollViewDelegate, WeiboSDKDelegate,UIAlertViewDelegate>{

    UIAlertView *alert;
    NSDictionary * _amtCountdict;

}

@property (strong, nonatomic) HomeViewController * home;
@property (strong, nonatomic) Launching * launch;
@property (strong, nonatomic) LoginViewController * login;
@property (nonatomic) BOOL isOut;
@property (strong, nonatomic) NSString * push;

@property (retain,nonatomic) NSString *latestVersion;
@property (retain,nonatomic) NSString *trackViewUrl;
@property (retain,nonatomic) NSString *trackName;
@property (retain,nonatomic) NSString *currentVersion;
@property (nonatomic) int flag;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@end

@implementation AppDelegate

@synthesize wbtoken;
@synthesize wbCurrentUserID;
@synthesize wbRefreshToken;

-(void)setLoginViewController:(LoginViewController*)vc
{
    _login = vc;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

   // MyLog(@"SITE_URL=%@", SITE_URL);

//    [self test];
    
    [self setVC];
    NSDictionary* remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotification) {
        
//         _launch.push = @"1";
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        [standardUserDefaults setObject:@"1" forKey:@"ispush"];
        [standardUserDefaults synchronize];
    }
    
//    UIAlertView *alertView = [[UIAlertView alloc] init];
//    alertView.delegate = self;
//    alertView.message = [NSString stringWithFormat:@"%@",remoteNotification];
//    [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
//    [alertView show];
    
       _flag = 0;
       return YES;
}

-(void)test{
    testVC * vc = [[testVC alloc] init];
    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nvc;
    [self.window makeKeyAndVisible];
}


- (void)setVC{
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:Weibo_APP_ID];
    
    // security start >>>
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults objectForKey:@"EGIVE_MEMBER_MODEL"]) {
        NSMutableDictionary *m = [[standardUserDefaults objectForKey:@"EGIVE_MEMBER_MODEL"] mutableCopy];
        
        MemberModel * model = [[MemberModel alloc] init];
        [model setValuesForKeysWithDictionary:m];
        [ShowMenuView sharedInstance].member = model;
        NSMutableDictionary * _dict = [ShowMenuView getUserInfo];
        [_dict setObject:model forKey:@"LoginName"];
        
        [self GetMemberInfo:model.MemberID];
       
    }
    // security end <<<
    
    _launch = [[Launching alloc] init];
//    _launch.push = @"1";
    //初始化主页面
//    _home = [[HomeViewController alloc] init];
    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:_launch];
//    _launch.home = _home;
    DDMenuController * rootController = [[DDMenuController alloc]initWithRootViewController:nvc];
    _menuController = rootController;
    [self.window makeKeyAndVisible];
    [self regPushPremission];
    
    //设置抽屉页面
    self.window.rootViewController = rootController;
    
    
    PopupAdController *vc = [[PopupAdController alloc] init];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    [_home presentViewController:vc animated:YES completion:^{
        
    }];
    
    NSString *ipString = [self getIPAddress];
    NSLog(@"%@",ipString);
    
    [self CheckIP:ipString];

    //    return [[FBSDKApplicationDelegate sharedInstance] application:application
    //                                    didFinishLaunchingWithOptions:launchOptions];
}
- (void)GetMemberInfo:(NSString *)memberId {
    
   // MyLog(@"<<<<<<<<<<<<<<<<<<<%@",memberId);
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetMemberInfo xmlns=\"egive.appservices\"><MemberID>%@</MemberID></GetMemberInfo></soap:Body></soap:Envelope>",memberId];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSArray * arr = [NSString parseJSONStringToNSArray:dataString];
     
        for (NSDictionary * dict in arr) {
            
            MemberModel * model = [[MemberModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            
            NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
            [standardUserDefaults setObject:dict forKey:@"EGIVE_MEMBER_MODEL"];
            [standardUserDefaults synchronize];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [operation start];
}

#pragma mark 根据IP地址获取位置代码
- (void)CheckIP:(NSString *)IPAddress{
    
    NSString * soapMsg =[NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                         "<soap:Body>"
                         "<CheckIP xmlns=\"egive.appservices\">"
                         "<IP>%@</IP>"
                         "</CheckIP>"
                         "</soap:Body>"
                         "</soap:Envelope>",IPAddress];
    
    [EGGeneralRequestAdapter postWithSoapMsg1:soapMsg success:^(id responseObj) {
        NSString *jsonString = [[NSString alloc] initWithData:(NSData *)responseObj encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSString parseJSONStringToNSDictionary:jsonString];
        if (dict) {
            
            [EGUtility setLocationCode:dict[@"Code"]];
            
             MyLog(@"%@", dict[@"Code"]);
            
        }
    } failure:^(NSError *error) {
             MyLog(@"%@",error);
    }];
}

//获取ip地址
- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    if ([[[[url absoluteString] componentsSeparatedByString:@"://"] objectAtIndex:0] isEqualToString:@"egive4u"]) {
       // MyLog(@"postNotificationName:@isPaySuccessful");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"isPaySuccessful" object: nil];
    }
    
    if ([[[[url absoluteString] componentsSeparatedByString:@"://"] objectAtIndex:0] isEqualToString:Facebook_URL_SCHEMA]) {
        
       // MyLog(@"%@://authorize = %@", Facebook_URL_SCHEMA, url);
    }
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation
            ]
    ||
    
    [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self ];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter] ;
    [center addObserver:self selector:@selector(handleUIApplicationWillChangeStatusBarFrameNotification:) name:@"ChangeStatusBar" object:nil];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter] ;
    
    [center removeObserver:self name:@"ChangeStatusBar" object:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    [FBSDKAppEvents activateApp];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
       //获取版本号
       [self GetAppVersion];
    
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame{

    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center postNotificationName:@"ChangeStatusBar" object:nil];
}

#define SYS_STATUSBAR_HEIGHT  20
// 热点栏高度
#define HOTSPOT_STATUSBAR_HEIGHT 20
- (void)handleUIApplicationWillChangeStatusBarFrameNotification:(NSNotification*)notification
{
    CGRect newStatusBarFrame = [(NSValue*)[notification.userInfo objectForKey:UIApplicationStatusBarFrameUserInfoKey] CGRectValue];
    // 根据系统状态栏高判断热点栏的变动
    BOOL bPersonalHotspotConnected = (CGRectGetHeight(newStatusBarFrame)==(SYS_STATUSBAR_HEIGHT+HOTSPOT_STATUSBAR_HEIGHT)?YES:NO);
}


-(void) application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
    if (notificationSettings.types){
        
         MyLog(@"%lu",(unsigned long)notificationSettings.types);
         MyLog(@"[didRegisterUserNotificationSettings] -> TRUE");
         MyLog(@"user allowed notifications");
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
         [EGUtility setAllowNotification:YES];

    }else{
         MyLog(@"%lu",(unsigned long)notificationSettings.types);
         MyLog(@"[didRegisterUserNotificationSettings] -> FALSE]");
         MyLog(@"user did not allow notifications");
        [EGUtility setAllowNotification:NO];
         [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLoading"];
        
    }
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{

    MyLog(@"[didRegisterForRemoteNotificationsWithDeviceToken] -> %@", [self deviceTokenAsString:deviceToken]);
    
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"PUSH"
    //                                                    message:[self deviceTokenAsString:deviceToken]
    //                                                   delegate:self
    //                                          cancelButtonTitle:@"OK"
    //                                          otherButtonTitles:nil];
    //    [alert show];
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstPushRegister"]){
        
        
    }else{
        
        
        [self pushTest];
    
    }
    
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error{
    
    MyLog(@"[didFailToRegisterForRemoteNotificationsWithError] -> %@", error);
}

-(void)regPushPremission
{
    UIApplication* app = [UIApplication sharedApplication];
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [app registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil]];
    }
    else
    {
        //work for ios < 8
        [app registerForRemoteNotifications];
    }
}

-(NSString*)deviceTokenAsString:(NSData*)deviceTokenData{
    
    MyLog(@"%@",deviceTokenData);
    
    NSString *rawDeviceTring = [NSString stringWithFormat:@"%@", deviceTokenData];
    NSString *noSpaces = [rawDeviceTring stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *tmp1 = [noSpaces stringByReplacingOccurrencesOfString:@"<" withString:@""];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:[tmp1 stringByReplacingOccurrencesOfString:@">" withString:@""] forKey:@"deviceToken"];
    [standardUserDefaults synchronize];
    
    MyLog(@"^^^^^^^^^^^%@",[tmp1 stringByReplacingOccurrencesOfString:@">" withString:@""]);
   
//                  UIAlertView *alertView = [[UIAlertView alloc] init];
//                  alertView.delegate = self;
//                  alertView.message = [tmp1 stringByReplacingOccurrencesOfString:@">" withString:@""];
//                  [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
//                  [alertView show];
    return [tmp1 stringByReplacingOccurrencesOfString:@">" withString:@""];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    

    
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    if([UIApplication sharedApplication].applicationState ==UIApplicationStateActive){
        
//    UIAlertView *alertView = [[UIAlertView alloc] init];
//     alertView.message = userInfo[@"aps"][@"alert"];
//    [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
//    [alertView show];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:EGLocalizedString(@"Cancel", nil) otherButtonTitles:EGLocalizedString(@"Confirm", nil), nil];
        [alertView show];
      MyLog(@"userInfoActive=%@",userInfo);

     }else{
         
         //跳到意赠活动
         if ([userInfo[@"t"] isEqualToString:@"e"]){
             ActivityViewController *Ac = [[ActivityViewController alloc] init];
             Ac.MsgId = userInfo[@"e"];
             Ac.InboxFlag = 1;
             [navigationController pushViewController:Ac animated:NO];
         }else if ([userInfo[@"t"] isEqualToString:@"a"]){
         //跳到新增个案
             GirdDetailViewController *gc = [[GirdDetailViewController alloc] init];
             gc.caseID = userInfo[@"e"];
             [navigationController pushViewController:gc animated:YES];
         
         }else if ([userInfo[@"t"] isEqualToString:@"pr"]){
         //跳到进度报告
             ProReportController * vc = [[ProReportController alloc] init];
             vc.caseId = userInfo[@"e"];
             [navigationController pushViewController:vc animated:YES];
         }else if ([userInfo[@"t"] isEqualToString:@"d"]){
             //跳到捐款记录
//             MyDonationViewController * vc = [[MyDonationViewController alloc] init];
//             vc.caseId = userInfo[@"c"];
//             vc.MyDonationFlag=1;
//             vc.pushFlag=1;
             
             NSString *caseId = userInfo[@"c"];
             
             if (caseId.length>0) {
                 GirdDetailViewController *gc = [[GirdDetailViewController alloc] init];
                 
                 gc.caseID = userInfo[@"c"];
                 [navigationController pushViewController:gc animated:YES];
             }else{
                 InformationController *imfo = [[InformationController alloc] init];
                 [navigationController pushViewController:imfo animated:YES];
             }
             
             
             
         }else if ([userInfo[@"t"] isEqualToString:@"c"]){
           //跳到成功募捐页面
             GirdDetailViewController *gc = [[GirdDetailViewController alloc] init];
             gc.caseID = userInfo[@"e"];
             [navigationController pushViewController:gc animated:YES];
         }
         
          MyLog(@"userInfo=%@",userInfo);
     
    }
    
//    MyLog(@"didReceiveRemoteNotification");
       application.applicationIconBadgeNumber = 0;
    NSInteger number = [UIApplication sharedApplication].applicationIconBadgeNumber;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:number+1];
    //MyLog(@"[UIApplication sharedApplication].applicationIconBadgeNumber++=%ld",(long)[UIApplication sharedApplication].applicationIconBadgeNumber++);
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:number+1];
    
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    [_login didReceiveWeiboRequest:request];
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
       // NSString *title = NSLocalizedString(@"认证结果", nil);
        //NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        if (response.statusCode == 0) {
            
            [_login didReceiveWeiboResponse:response];
            
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
            //                                                        message:[(WBAuthorizeResponse *)response userID]
            //                                                       delegate:nil
            //                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
            //                                              otherButtonTitles:nil];
            //            [alert show];
        }
        //        self->wbtoken = [(WBAuthorizeResponse *)response accessToken];
        //        self->wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        //        self->wbRefreshToken = [(WBAuthorizeResponse *)response refreshToken];
        
    }
    
}

- (void)pushTest{
    
    [self showLoadingAlert];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 请求的序列化
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    // 回复序列化
    //manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    //    NSString * applicationArn = @"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_ACT";
    //    [dict setObject:applicationArn forKey:@"applicationArn"];
    //[dict setObject:@"arn:aws:sns:us-east-1:819247114127:app/APNS/EGive_APNS_PROD" forKey:@"applicationArn"];
    [dict setObject:Arns forKey:@"applicationArn"];
    
    //device Id for iOS
    NSString *deviceid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    MyLog(@"deviceid--------------------%@",deviceid);
    
    [dict setObject:deviceid forKey:@"deviceid"];
    
    //token
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults objectForKey:@"deviceToken"]) {
        [dict setObject:[standardUserDefaults objectForKey:@"deviceToken"] forKey:@"token"];
        MyLog(@"deviceTokendeviceTokendeviceToken====%@",[standardUserDefaults objectForKey:@"deviceToken"]);
    
    }
    //获取设备语言
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *lang = [languages objectAtIndex:0];
    [dict setObject:lang forKey:@"lang"];
    
    //系统版本
    NSString *systemVersion = [[NSBundle mainBundle]
                               
                               objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    [dict setObject:systemVersion forKey:@"systemVersion"];
    
    //platform
    [dict setObject:@"iOS" forKey:@"platform"];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSString *URLstring = [NSString stringWithFormat:@"http://snsfx.sinodynamic.com:8080/sns/register.api"];
    
    
    MyLog(@"dict=%@",dict);
    
    
    [manager POST:URLstring  parameters:dict
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              [self removeLoadingAlert];
              
              
              [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstPushRegister"];
              NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
              NSLog(@"responseObject===%@",dict);
              
              NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
              [standardUserDefaults setObject:dict[@"endpointArn"] forKey:@"GetendpointArn"];
              [standardUserDefaults synchronize];
              
              //[self sendAllPush];
              [self requestApiData:[EGUtility getAppLang] endpointArn:dict[@"endpointArn"]];
          }
     
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [self removeLoadingAlert];
              
              MyLog(@"%@", operation.request.allHTTPHeaderFields);
              
              // 服务器给我们返回的包得头部信息
              MyLog(@"%@", operation.response);
              
          }];
    
}

//请求详细信息
-(void)requestApiData:(long)AppLang  endpointArn:(NSString*)Apptoken{
    
    [self showLoadingAlert];
   // NSString *Apptoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"GetendpointArn"];
    
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
        
        
        MyLog(@"向服务端注册arn-token完成:%@",dict);
        
        [self removeLoadingAlert];
        
        [self changePushMessagePreference:Apptoken];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        MyLog(@"%@", operation.request.allHTTPHeaderFields);
        // 服务器给我们返回的包得头部信息
        MyLog(@"%@", operation.response);
        // 返回的数据
        MyLog(@"向服务端注册arn-token出错:%@",error);
        [self removeLoadingAlert];
    }];
    
    [operation start];
    
}

-(void)changePushMessagePreference:(NSString *)token{
    
    
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ChangePushMessagePreference xmlns=\"egive.appservices\"><MsgPreference>%@</MsgPreference><AppToken>%@</AppToken></ChangePushMessagePreference></soap:Body></soap:Envelope>",@"EVENT,CASE,CASEUPDATE,SUCCESS,DONATION",token];//EVENT,CASE,CASEUPDATE,SUCCESS,DONATION
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
        //保存开通的push
        NSMutableDictionary *pushDict = [NSMutableDictionary dictionary];
        [pushDict setValue:@"EVENT" forKey:@"kEVENT"];
        [pushDict setValue:@"CASE" forKey:@"kCASE"];
        [pushDict setValue:@"CASEUPDATE" forKey:@"kCASEUPDATE"];
        [pushDict setValue:@"SUCCESS" forKey:@"kSUCCESS"];
        [pushDict setValue:@"DONATION" forKey:@"kDONATION"];

        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        [standardUserDefaults setObject:pushDict forKey:@"kAllPush"];
        [standardUserDefaults synchronize];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"出错:%@",error);
    }];
    
    [operation start];
}

-(void)sendAllPush{
    dispatch_group_t group =  dispatch_group_create();
    [self showLoadingAlert];
    
    [self sendAllPush:@"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_PGR" group:group subscriptionArn:@"subscriptionArn1"];
    
    [self sendAllPush:@"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_ACT" group:group subscriptionArn:@"subscriptionArn2"];
    
    [self sendAllPush:@"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_NEW" group:group subscriptionArn:@"subscriptionArn3"];
    
    [self sendAllPush:@"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_REC" group:group subscriptionArn:@"subscriptionArn4"];
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        //汇总结果
        dispatch_async(dispatch_get_main_queue(), ^{
            
            MyLog(@"removeLoadingAlert");
            [self removeLoadingAlert];
            
        });
    });
}

-(void)sendAllPush:(NSString *)topicArn group:(dispatch_group_t) group subscriptionArn:(NSString*)subscriptionArn{
    
    //[self showLoadingAlert];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 请求的序列化
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    // 回复序列化
    //manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:topicArn forKey:@"topicArn"];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults objectForKey:@"GetendpointArn"]){
        [dict setObject:[standardUserDefaults objectForKey:@"GetendpointArn"] forKey:@"endporintArn"];
        MyLog(@"endpointArn1111111111====%@",[standardUserDefaults objectForKey:@"GetendpointArn"]);
    }
    
    //   [dict setObject:@"arn:aws:sns:us-east-1:819247114127:endpoint/APNS/EGive_APNS_PROD/ceef1022-4447-3723-a857-bf9539b523a9" forKey:@"endporintArn"];
    
    MyLog(@"%@",dict);
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSString *URLstring = [NSString stringWithFormat:@"http://snsfx.sinodynamic.com:8080/sns/subscript.api"];
    
    dispatch_group_enter(group);
    
    [manager POST:URLstring  parameters:dict
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              
              //[self removeLoadingAlert];
              dispatch_group_leave(group);
              
              NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
              MyLog(@"responseObject===%@",dict);
              
              NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
              [standardUserDefaults setObject:dict[@"subscriptionArn"] forKey:subscriptionArn];
              [standardUserDefaults synchronize];
              
              MyLog(@"subscriptionArnNew=%@",[standardUserDefaults objectForKey:subscriptionArn]);
              
              
          }
     
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              //[self removeLoadingAlert];
              dispatch_group_leave(group);
              MyLog(@"%@", operation.request.allHTTPHeaderFields);
              
              // 服务器给我们返回的包得头部信息
              MyLog(@"%@////////////", operation.response);
              
              
          }];

}
//获取版本号
-(void)GetAppVersion{

    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetAppVersion xmlns=\"egive.appservices\" /></soap:Body></soap:Envelope>"
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
         _amtCountdict = [NSString parseJSONStringToNSDictionary:dataString];
        
        MyLog(@"%@",_amtCountdict);
        
        NSString *updateBackgroundVersionString = _amtCountdict[@"VersionNumber"];
        NSString *IOSupdateString = _amtCountdict[@"IOSVersionNumber"];
        
        //同步请求检查版本号
       [self updateVersion:IOSupdateString andupdateBackgroundVersion:updateBackgroundVersionString];
        
        
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

//apple版本更新
//-(void)updateVersionForApple{
//    
//    NSError *error;
//    NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/hk/lookup?id=%@",@"1053021393"];
//
//    //1053021393
//    NSURL *url = [NSURL URLWithString:urlStr];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//    
//    if (error){
//        
//        MyLog(@"error:%@",[error description]);
//        
//        return ;
//    }
//    
//    NSArray *resultsArray = [appInfoDic objectForKey:@"results"];
//    MyLog(@"%@",resultsArray);
//    
//    if (![resultsArray count]) {
//        
//        MyLog(@"error: resultsArray==nil");
//        
//        return ;
//        
//    }
//    
//    NSDictionary *infoDic = [resultsArray objectAtIndex:0];
//    _latestVersion = [infoDic objectForKey:@"version"];
//    _trackViewUrl = [infoDic objectForKey:@"trackViewUrl"];
//    _trackName = [infoDic objectForKey:@"trackName"];
//   //float intUpdateVersion = [updateVersion floatValue];
//}

//服务器版本更新
-(void)updateVersion:(NSString*)updateIOSVersion andupdateBackgroundVersion:(NSString*)BackgroundVersion{
    
    float intCurrentVersion = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] floatValue];
    MyLog(@"intCurrentVersion=%f",intCurrentVersion);
    
    float dateIOSVersion = [updateIOSVersion floatValue];
    //float dateBackgroundVersion = [BackgroundVersion floatValue];
    
   // MyLog(@"dateVersion=%f",dateIOSVersion);
    
    if (([updateIOSVersion intValue] > [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] intValue]) || ([BackgroundVersion intValue] > [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] intValue])){
        
        NSString *messageStr  = EGLocalizedString(@"程式版本已更新", nil);
        alert = [[UIAlertView alloc] initWithTitle:nil message:messageStr delegate:self cancelButtonTitle:nil otherButtonTitles:EGLocalizedString(@"Confirm", nil), nil];
        alert.delegate=self;
        alert.tag=1002;
        [alert show];
        
    }else if (dateIOSVersion > intCurrentVersion){
        NSString *messageStr  = EGLocalizedString(@"程式版本已更新", nil);
        alert = [[UIAlertView alloc] initWithTitle:nil message:messageStr delegate:self cancelButtonTitle:EGLocalizedString(@"Cancel", nil) otherButtonTitles:EGLocalizedString(@"Confirm", nil), nil];
        alert.delegate=self;
        alert.tag=1002;
        [alert show];
    }else{
    
        return;
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag==1002){
        
        if (buttonIndex==1){
            
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/com.egive.mobile/id1053021393?ls=1&mt=8"]];
        }
    }

}
- (void)showLoadingAlert
{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.progressHUD = [MBProgressHUD showHUDAddedTo:app.window animated:NO];
    self.progressHUD.color=[UIColor clearColor];
    self.progressHUD.alpha=0;
    [app.window addSubview:self.progressHUD];
    self.progressHUD.dimBackground = YES;
}

- (void)removeLoadingAlert
{
    
    [self.progressHUD hide:YES];
}

@end
