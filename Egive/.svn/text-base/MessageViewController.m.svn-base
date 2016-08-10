//
//  MessageViewController.m
//  Egive
//
//  Created by sino on 15/10/16.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "MessageViewController.h"
#import "EGUtility.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
@interface MessageViewController ()
{
    
    NSArray * _dataArray;
    NSMutableDictionary *_pushDict;
}

@property (strong, nonatomic) IBOutlet UISwitch *allSwitch;
- (IBAction)allAction:(id)sender;
@property (strong, nonatomic) IBOutlet UISwitch *proSwitch;
- (IBAction)proAction:(id)sender;
@property (strong, nonatomic) IBOutlet UISwitch *actSwitch;
- (IBAction)actAction:(id)sender;
@property (strong, nonatomic) IBOutlet UISwitch *addSwitch;
- (IBAction)addAction:(id)sender;
@property (strong, nonatomic) IBOutlet UISwitch *DonationSwitch;

@property (strong, nonatomic) IBOutlet UISwitch *sucSwtich;
- (IBAction)sucAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *allLabel;
@property (strong, nonatomic) IBOutlet UILabel *proLabel;
@property (strong, nonatomic) IBOutlet UILabel *actLabel;
@property (strong, nonatomic) IBOutlet UILabel *addLabel;
@property (strong, nonatomic) IBOutlet UILabel *sucLabel;
@property (strong, nonatomic) IBOutlet UILabel *DonationLabel;

@property (strong, nonatomic) NSMutableArray * statusArray;
@property (strong, nonatomic) NSString * testString;
@property (strong, nonatomic) NSString * tokey;

@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic) int flag;
@property (nonatomic) int closeflag;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = EGLocalizedString(@"讯息提示", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.rightBarButtonItem = nil;
    _dataArray = @[EGLocalizedString(@"所有提示", nil),EGLocalizedString(@"进度报告提示", nil),EGLocalizedString(@"意赠活动提示", nil),EGLocalizedString(@"新增个案提示", nil),EGLocalizedString(@"成功筹募提示", nil)];
    
    _allLabel.text =EGLocalizedString(@"所有提示", nil);
    _proLabel.text =EGLocalizedString(@"进度报告提示", nil);
    _actLabel.text =EGLocalizedString(@"意赠活动提示", nil);
    _addLabel.text =EGLocalizedString(@"新增个案提示", nil);
    _sucLabel.text =EGLocalizedString(@"成功筹募提示", nil);
    _DonationLabel.text=EGLocalizedString(@"捐款记录提示", nil);
//    _recodeLabel.text = EGLocalizedString(@"捐款记录", nil);
    
    _flag = 0;
    _closeflag=0;
    
//    //判断是否已经发送推送注册
//    NSUserDefaults *isAllSendUserDefaults = [NSUserDefaults standardUserDefaults];
//    if (![[isAllSendUserDefaults objectForKey:@"isAllSend"] isEqualToString:@"YES"]){
//        
//        [self pushTest];//发送推送注册
//    }
    
    [self.DonationSwitch addTarget:self action:@selector(DonationAtion:) forControlEvents:UIControlEventValueChanged];

    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
     if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLoading"]){
      
         
         [self showSwitchOnorOff];
        
    }else{
    
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLoading"];
        
        //判断注册成功后开关是打开还是关闭
        [_allSwitch setOn:[EGUtility getIsAllowNotification]];
        [_proSwitch setOn:[EGUtility getIsAllowNotification]];
        [_actSwitch setOn:[EGUtility getIsAllowNotification]];
        [_addSwitch setOn:[EGUtility getIsAllowNotification]];
        [_sucSwtich setOn:[EGUtility getIsAllowNotification]];
        [self.DonationSwitch setOn:[EGUtility getIsAllowNotification]];
        
        if ([EGUtility getIsAllowNotification]==YES) {
            
            [standardUserDefaults setObject:@"1" forKey:@"Switch0"];
            [standardUserDefaults setObject:@"1" forKey:@"Switch1"];
            [standardUserDefaults setObject:@"1" forKey:@"Switch2"];
            [standardUserDefaults setObject:@"1" forKey:@"Switch3"];
            [standardUserDefaults setObject:@"1" forKey:@"Switch4"];
            [standardUserDefaults setObject:@"1" forKey:@"Switch5"];
            
        }else{
            
            [standardUserDefaults setObject:@"0" forKey:@"Switch0"];
            [standardUserDefaults setObject:@"0" forKey:@"Switch1"];
            [standardUserDefaults setObject:@"0" forKey:@"Switch2"];
            [standardUserDefaults setObject:@"0" forKey:@"Switch3"];
            [standardUserDefaults setObject:@"0" forKey:@"Switch4"];
            [standardUserDefaults setObject:@"0" forKey:@"Switch5"];
        }
    
    }
}

-(void)showSwitchOnorOff{

   NSUserDefaults *standardUserDefaults1 = [NSUserDefaults standardUserDefaults];
    
    
    MyLog(@"Switch0=%@",[standardUserDefaults1 objectForKey:@"Switch0"]);
    
    
    if ([[standardUserDefaults1 objectForKey:@"Switch0"] isEqualToString:@"0"]){
        
        if([[standardUserDefaults1 objectForKey:@"Switch1"] isEqualToString:@"0"]&&[[standardUserDefaults1 objectForKey:@"Switch2"] isEqualToString:@"0"]&&[[standardUserDefaults1 objectForKey:@"Switch3"] isEqualToString:@"0"]&&[[standardUserDefaults1 objectForKey:@"Switch4"] isEqualToString:@"0"]&&[[standardUserDefaults1 objectForKey:@"Switch5"] isEqualToString:@"0"]){
        
        [_allSwitch setOn:NO];
        [_proSwitch setOn:NO];
        [_actSwitch setOn:NO];
        [_addSwitch setOn:NO];
        [_sucSwtich setOn:NO];
        [self.DonationSwitch setOn:NO];
            
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch0"];
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch1"];
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch2"];
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch3"];
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch4"];
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch5"];
            
        }else{
        
              [_allSwitch setOn:NO];
             [standardUserDefaults1 setObject:@"0" forKey:@"Switch0"];
            
            if ([[standardUserDefaults1 objectForKey:@"Switch1"] isEqualToString:@"0"]){
                
                 [_proSwitch setOn:NO];
                
               [standardUserDefaults1 setObject:@"0" forKey:@"Switch1"];
                
            }else{
            
                 [_proSwitch setOn:YES];
             [standardUserDefaults1 setObject:@"1" forKey:@"Switch1"];
            }
        
            if ([[standardUserDefaults1 objectForKey:@"Switch2"] isEqualToString:@"0"]) {
                [_actSwitch setOn:NO];
                [standardUserDefaults1 setObject:@"0" forKey:@"Switch2"];
                
            }else{
                
                [_actSwitch setOn:YES];
              [standardUserDefaults1 setObject:@"1" forKey:@"Switch2"];
            }
            if ([[standardUserDefaults1 objectForKey:@"Switch3"] isEqualToString:@"0"]) {
                [_addSwitch setOn:NO];
                [standardUserDefaults1 setObject:@"0" forKey:@"Switch3"];
                
            }else{
                
                [_addSwitch setOn:YES];
                [standardUserDefaults1 setObject:@"1" forKey:@"Switch3"];
                
            }
            if ([[standardUserDefaults1 objectForKey:@"Switch4"] isEqualToString:@"0"]) {
                [_sucSwtich setOn:NO];
                [standardUserDefaults1 setObject:@"0" forKey:@"Switch4"];
                
            }else{
                
                [_sucSwtich setOn:YES];
                [standardUserDefaults1 setObject:@"1" forKey:@"Switch4"];
                
            }
            if ([[standardUserDefaults1 objectForKey:@"Switch5"] isEqualToString:@"0"]) {
                [self.DonationSwitch setOn:NO];
                [standardUserDefaults1 setObject:@"0" forKey:@"Switch5"];
                
            }else{
                
                [self.DonationSwitch setOn:YES];
                [standardUserDefaults1 setObject:@"1" forKey:@"Switch5"];
                
            }
        }
        
    }else if ([[standardUserDefaults1 objectForKey:@"Switch0"] isEqualToString:@"1"]){
    
        [_allSwitch setOn:YES];
        [_proSwitch setOn:YES];
        [_actSwitch setOn:YES];
        [_addSwitch setOn:YES];
        [_sucSwtich setOn:YES];
        [self.DonationSwitch setOn:YES];
        
        [standardUserDefaults1 setObject:@"1" forKey:@"Switch0"];
        [standardUserDefaults1 setObject:@"1" forKey:@"Switch1"];
        [standardUserDefaults1 setObject:@"1" forKey:@"Switch2"];
        [standardUserDefaults1 setObject:@"1" forKey:@"Switch3"];
        [standardUserDefaults1 setObject:@"1" forKey:@"Switch4"];
        [standardUserDefaults1 setObject:@"1" forKey:@"Switch5"];
    }
}

-(void)showAllAPNSSwitchOnorOff{

  NSUserDefaults *standardUserDefaults1 = [NSUserDefaults standardUserDefaults];
    if([[standardUserDefaults1 objectForKey:@"Switch1"] isEqualToString:@"1"]&&[[standardUserDefaults1 objectForKey:@"Switch2"] isEqualToString:@"1"]&&[[standardUserDefaults1 objectForKey:@"Switch3"] isEqualToString:@"1"]&&[[standardUserDefaults1 objectForKey:@"Switch4"] isEqualToString:@"1"]&&[[standardUserDefaults1 objectForKey:@"Switch5"] isEqualToString:@"1"]){
    
        [_allSwitch setOn:YES];
        [standardUserDefaults1 setObject:@"1" forKey:@"Switch0"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
    }else{
    
        [_allSwitch setOn:NO];
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch0"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
    }
}
-(void)getDevieInfo{
    UIDevice *currentDevice = [UIDevice currentDevice];
    
    NSString *model = [currentDevice model];
    
    NSString *systemVersion = [currentDevice systemVersion];
    NSArray *languageArray = [NSLocale preferredLanguages];
    
    NSString *language = [languageArray objectAtIndex:0];
    
    NSLocale *locale = [NSLocale currentLocale];
    
    NSString *country = [locale localeIdentifier];
    
    NSString *appVersion = [[NSBundle mainBundle]
                            
                            objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    NSString *deviceSpecs =
    [NSString stringWithFormat:@"%@ - %@ - %@ - %@ - %@",
     model, systemVersion, language, country, appVersion];
    
    MyLog(@"Device Specs --> %@",deviceSpecs);
    
}

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
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
    [dict setObject:@"arn:aws:sns:us-east-1:819247114127:app/APNS/EGive_APNS_PROD" forKey:@"applicationArn"];
    
    //device Id for iOS
    NSString *deviceid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    MyLog(@"deviceid--------------------%@",deviceid);
    
   [dict setObject:deviceid forKey:@"deviceid"];
    
    //token
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults objectForKey:@"deviceToken"]) {
        [dict setObject:[standardUserDefaults objectForKey:@"deviceToken"] forKey:@"token"];
        MyLog(@"deviceTokendeviceTokendeviceToken====%@",[standardUserDefaults objectForKey:@"deviceToken"]);
        
//        UIAlertView *alertView = [[UIAlertView alloc] init];
//        alertView.delegate = self;
//        alertView.message = [standardUserDefaults objectForKey:@"deviceToken"];
//        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
//        [alertView show];
    }
//    [dict setObject:@"c4f17a2d760e475d82453433aa9c8329b11572b6c6bbbe9d1350171a60973880" forKey:@"token"];
//    [dict setObject:_tokey forKey:@"token"];
    
    
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
              
              NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              MyLog(@"responseObject===%@",dict);

              NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
              [standardUserDefaults setObject:dict[@"endpointArn"] forKey:@"GetendpointArn"];
              [standardUserDefaults synchronize];

//              _flag =1;
//              [self sendPush:@"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_PGR"];//进度报告提示
          
//              UIAlertView *alertView = [[UIAlertView alloc] init];
//              alertView.delegate = self;
//              alertView.message = @"注册成功!";
//              [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
//              [alertView show];
              
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
        
        [self changePushMessagePreferenceMsgP:@"EVENT,CASE,CASEUPDATE,SUCCESS,DONATION"];
        
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

-(void)changePushMessagePreferenceMsgP:(NSString *)MsgP{
    
    NSString *Apptoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"GetendpointArn"];
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ChangePushMessagePreference xmlns=\"egive.appservices\"><MsgPreference>%@</MsgPreference><AppToken>%@</AppToken></ChangePushMessagePreference></soap:Body></soap:Envelope>",MsgP,Apptoken];//EVENT,CASE,CASEUPDATE,SUCCESS,DONATION
    
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
            
            //UI操作
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
    //    NSString * applicationArn = @"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_ACT";
    
    //    [dict setObject:@"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_ACT" forKey:@"topicArn"];
    [dict setObject:topicArn forKey:@"topicArn"];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults objectForKey:@"GetendpointArn"]) {
        
        [dict setObject:[standardUserDefaults objectForKey:@"GetendpointArn"] forKey:@"endporintArn"];
        //        _testString = [standardUserDefaults objectForKey:@"endpointArn"];
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
              //MyLog(@"responseObject===%@",dict);
              
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

//- (void)sendPush:(NSString *)topicArn{
//    
//    [self showLoadingAlert];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    // 请求的序列化
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
//    // 回复序列化
//    //manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    //    NSString * applicationArn = @"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_ACT";
//    
////    [dict setObject:@"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_ACT" forKey:@"topicArn"];
//    [dict setObject:topicArn forKey:@"topicArn"];
//    
//    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//    if ([standardUserDefaults objectForKey:@"GetendpointArn"]) {
//        
//        [dict setObject:[standardUserDefaults objectForKey:@"GetendpointArn"] forKey:@"endporintArn"];
////        _testString = [standardUserDefaults objectForKey:@"endpointArn"];
//        MyLog(@"endpointArn1111111111====%@",[standardUserDefaults objectForKey:@"GetendpointArn"]);
//    }
//
//
////   [dict setObject:@"arn:aws:sns:us-east-1:819247114127:endpoint/APNS/EGive_APNS_PROD/ceef1022-4447-3723-a857-bf9539b523a9" forKey:@"endporintArn"];
//
//    MyLog(@"%@",dict);
//    
//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//    NSString *URLstring = [NSString stringWithFormat:@"http://snsfx.sinodynamic.com:8080/sns/subscript.api"];
//    
//    [manager POST:URLstring  parameters:dict
//          success:^(AFHTTPRequestOperation *operation, id responseObject){
//              
//              [self removeLoadingAlert];
//
//              NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//              MyLog(@"responseObject===%@",dict);
//              
//
//              NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//              [standardUserDefaults setObject:dict[@"subscriptionArn"] forKey:@"subscriptionArn"];
//              [standardUserDefaults synchronize];
//              
//              MyLog(@"subscriptionArn=%@",[standardUserDefaults objectForKey:@"subscriptionArn"]);
//              
//              
////              NSUserDefaults *standardUserDefaults1 = [NSUserDefaults standardUserDefaults];
////              if (![[standardUserDefaults1 objectForKey:@"isAllSend"] isEqualToString:@"YES"]){
//      
//                  //if (_flag!= 5) {
//                      if (_flag == 1){
//                          
//                          NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//                          [standardUserDefaults setObject:dict[@"subscriptionArn"] forKey:@"subscriptionArn1"];
//                          [standardUserDefaults synchronize];
//                          
//                          MyLog(@"subscriptionArn1=%@",[standardUserDefaults objectForKey:@"subscriptionArn1"]);
//                          
//                          [self sendPush:@"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_ACT"];//意赠活动提示
//                          _flag ++;
//                      }else if (_flag ==2){
//                          
//                          NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//                          [standardUserDefaults setObject:dict[@"subscriptionArn"] forKey:@"subscriptionArn2"];
//                          [standardUserDefaults synchronize];
//                           MyLog(@"subscriptionArn2=%@",[standardUserDefaults objectForKey:@"subscriptionArn2"]);
//                          [self sendPush:@"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_NEW"];//新增活动提示
//                          _flag ++;
//                          
//                          
//                      }else if (_flag ==3){
//                          
//                          NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//                          [standardUserDefaults setObject:dict[@"subscriptionArn"] forKey:@"subscriptionArn3"];
//                          [standardUserDefaults synchronize];
//                          
//                           MyLog(@"subscriptionArn3=%@",[standardUserDefaults objectForKey:@"subscriptionArn3"]);
//                          [self sendPush:@"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_REC"];//成功专案提示
//                          _flag ++;
//                          
//                          
//                      }else if (_flag ==4){
//                          NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//                          [standardUserDefaults setObject:dict[@"subscriptionArn"] forKey:@"subscriptionArn4"];
//                          [standardUserDefaults synchronize];
//                          
//                           MyLog(@"subscriptionArn4=%@",[standardUserDefaults objectForKey:@"subscriptionArn4"]);
//                          
////                          NSUserDefaults *standardUserDefaults1 = [NSUserDefaults standardUserDefaults];
////                          [standardUserDefaults1 setObject:@"YES" forKey:@"isAllSend"];
////                          [standardUserDefaults1 synchronize];
//                          
//                          [self sendPush:@"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_SUC"];
//                          _flag ++;
//                          
//                      }
//                 // }
//              
//              
//             // }
//              
//              
////              UIAlertView *alertView = [[UIAlertView alloc] init];
////              alertView.delegate = self;
////              alertView.message = @"开启成功!";
////              [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
////              [alertView show];
//          }
//     
//          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//              
//              [self removeLoadingAlert];
//              MyLog(@"%@", operation.request.allHTTPHeaderFields);
//              
//              // 服务器给我们返回的包得头部信息
//              MyLog(@"%@////////////", operation.response);
//              
////              UIAlertView *alertView = [[UIAlertView alloc] init];
////              alertView.delegate = self;
////              alertView.message = @"失败!";
////              [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
////              [alertView show];
//          }];
//}


- (void)colosePush:(NSString *)subscriptionArn group:(dispatch_group_t) group{
    //[self showLoadingAlert];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 请求的序列化
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    // 回复序列化
    //manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:subscriptionArn forKey:@"subscriptionArn"];
//    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//    if ([standardUserDefaults objectForKey:@"subscriptionArn"]) {
//        [dict setObject:[standardUserDefaults objectForKey:@"subscriptionArn"] forKey:@"subscriptionArn"];
//        //        _testString = [standardUserDefaults objectForKey:@"endpointArn"];
//        MyLog(@"subscriptionArn====%@",[standardUserDefaults objectForKey:@"subscriptionArn"]);
//    }
    
//        [dict setObject:@"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_ACT" forKey:@"topicArn"];
//    [dict setObject:@"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_PGR:717fa952-80ae-4e7b-a04f-0134a8fca0ea" forKey:@"subscriptionArn"];

    MyLog(@"%@",dict);
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSString *URLstring = [NSString stringWithFormat:@"http://snsfx.sinodynamic.com:8080/sns/unsubscript.api"];
    
    dispatch_group_enter(group);
    [manager POST:URLstring  parameters:dict
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              
            //[self removeLoadingAlert];
              
              NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
              MyLog(@"responseObject===%@",dict);
              
              dispatch_group_leave(group);
              
//              UIAlertView *alertView = [[UIAlertView alloc] init];
//              alertView.delegate = self;
//              alertView.message = @"关闭成功!";
//              [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
//              [alertView show];
          }
     
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              //[self removeLoadingAlert];
              MyLog(@"%@", operation.request.allHTTPHeaderFields);
              dispatch_group_leave(group);
              
              // 服务器给我们返回的包得头部信息
              MyLog(@"%@", operation.response);
              
          //              UIAlertView *alertView = [[UIAlertView alloc] init];
          //              alertView.delegate = self;
          //              alertView.message = @"失败!";
          //              [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
          //              [alertView show];
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
-(void)regPushPremission
{
    UIApplication* app = [UIApplication sharedApplication];
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [app registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationActivationModeBackground|UIUserNotificationActivationModeForeground| UIUserNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIUserNotificationTypeSound categories:nil]];
    }else{
        //work for ios < 8
        [app registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeNewsstandContentAvailability | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
}
- (IBAction)allAction:(UISwitch*)sender {
    MyLog(@"%d",sender.isOn);
    NSUserDefaults *standardUserDefaults1 = [NSUserDefaults standardUserDefaults];
    if (!sender.isOn){
        [_proSwitch setOn:NO];
        [_actSwitch setOn:NO];
        [_addSwitch setOn:NO];
        [_sucSwtich setOn:NO];
        [self.DonationSwitch setOn:NO];
        //[self closeAllAPNS];
        [self changePushMessagePreferenceMsgP:@""];
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch0"];
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch1"];
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch2"];
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch3"];
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch4"];
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch5"];
        [_pushDict removeAllObjects];
        [standardUserDefaults1 setObject:_pushDict forKey:@"kAllPush"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        [self regPushPremission];
        [self pushTest];
        [_proSwitch setOn:YES];
        [_actSwitch setOn:YES];
        [_addSwitch setOn:YES];
        [_sucSwtich setOn:YES];
        [self.DonationSwitch setOn:YES];
        [standardUserDefaults1 setObject:@"1" forKey:@"Switch0"];
        [standardUserDefaults1 setObject:@"1" forKey:@"Switch1"];
        [standardUserDefaults1 setObject:@"1" forKey:@"Switch2"];
        [standardUserDefaults1 setObject:@"1" forKey:@"Switch3"];
        [standardUserDefaults1 setObject:@"1" forKey:@"Switch4"];
        [standardUserDefaults1 setObject:@"1" forKey:@"Switch5"];
        //保存开通的push
        NSMutableDictionary *pushDict = [NSMutableDictionary dictionary];
        [pushDict setValue:@"EVENT" forKey:@"kEVENT"];
        [pushDict setValue:@"CASE" forKey:@"kCASE"];
        [pushDict setValue:@"CASEUPDATE" forKey:@"kCASEUPDATE"];
        [pushDict setValue:@"SUCCESS" forKey:@"kSUCCESS"];
        [pushDict setValue:@"DONATION" forKey:@"kDONATION"];
        _pushDict = [pushDict mutableCopy];
        [standardUserDefaults1 setObject:pushDict forKey:@"kAllPush"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}
-(void)closeAllAPNS{
    
    NSUserDefaults *standardUserDefaults1 = [NSUserDefaults standardUserDefaults];
    dispatch_group_t group =  dispatch_group_create();
    [self showLoadingAlert];
    
    if ([standardUserDefaults1 objectForKey:@"subscriptionArn1"]){
        [self colosePush:[standardUserDefaults1 objectForKey:@"subscriptionArn1"] group:group];
        MyLog(@"subscriptionArn1");
    };
    
    if ([standardUserDefaults1 objectForKey:@"subscriptionArn2"]){
        [self colosePush:[standardUserDefaults1 objectForKey:@"subscriptionArn2"] group:group];
        MyLog(@"subscriptionArn2");
    };
    
    if ([standardUserDefaults1 objectForKey:@"subscriptionArn3"]){
        [self colosePush:[standardUserDefaults1 objectForKey:@"subscriptionArn3"] group:group];
        MyLog(@"subscriptionArn3");
    };
    if ([standardUserDefaults1 objectForKey:@"subscriptionArn4"]){
        [self colosePush:[standardUserDefaults1 objectForKey:@"subscriptionArn4"] group:group];
        MyLog(@"subscriptionArn4");
    };
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        //汇总结果
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //UI操作
            MyLog(@"removeLoadingAlert");
            [self removeLoadingAlert];
            
        });
    });

}

-(NSString *)savePushConfig{
    
    NSArray *values = [_pushDict allValues];
    NSMutableString *param = [[NSMutableString alloc] init];
    for (NSString *s in values) {
        [param appendFormat:@"%@,",s];
    }
    
    NSRange range = [param rangeOfString:@"," options:NSBackwardsSearch];
    NSString *s = @"";
    if (param.length>0) {
        s = [param substringWithRange:NSMakeRange(0, range.location)];
    }
    return s;
}

//进度报告switch
- (IBAction)proAction:(UISwitch*)sender{
    
   NSUserDefaults *standardUserDefaults1 = [NSUserDefaults standardUserDefaults];
     dispatch_group_t group =  dispatch_group_create();
    [self showLoadingAlert];
    
    if (!sender.isOn){
        [_pushDict removeObjectForKey:@"kCASEUPDATE"];
        //[self colosePush:[standardUserDefaults1 objectForKey:@"subscriptionArn1"]group:group];
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch1"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch0"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [_allSwitch setOn:NO];
    }else{
        [_pushDict setValue:@"CASEUPDATE" forKey:@"kCASEUPDATE"];
        //[self sendAllPush:@"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_PGR" group:group subscriptionArn:@"subscriptionArn1"];
        [standardUserDefaults1 setObject:@"1" forKey:@"Switch1"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self showAllAPNSSwitchOnorOff];
    }
    
    [self changePushMessagePreferenceMsgP:[self savePushConfig]];
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        //汇总结果
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //UI操作
            MyLog(@"removeLoadingAlert");
            [self removeLoadingAlert];
            
        });
    });
}
//意赠活动switch
- (IBAction)actAction:(UISwitch*)sender {
    
    NSUserDefaults *standardUserDefaults1 = [NSUserDefaults standardUserDefaults];
    dispatch_group_t group =  dispatch_group_create();
    [self showLoadingAlert];
    
    if (!sender.isOn){
        [_pushDict removeObjectForKey:@"kEVENT"];
        
         [standardUserDefaults1 setObject:@"0" forKey:@"Switch2"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch0"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [_allSwitch setOn:NO];
    }else{
       //[self sendAllPush:@"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_ACT" group:group subscriptionArn:@"subscriptionArn2"];
        [_pushDict setValue:@"EVENT" forKey:@"kEVENT"];
        [standardUserDefaults1 setObject:@"1" forKey:@"Switch2"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self showAllAPNSSwitchOnorOff];

    }

    [self changePushMessagePreferenceMsgP:[self savePushConfig]];
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        //汇总结果
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //UI操作
            MyLog(@"removeLoadingAlert");
            [self removeLoadingAlert];
            
        });
    });
}
//新增个案switch
- (IBAction)addAction:(UISwitch*)sender {
    NSUserDefaults *standardUserDefaults1 = [NSUserDefaults standardUserDefaults];
    dispatch_group_t group =  dispatch_group_create();
    [self showLoadingAlert];
    if (!sender.isOn){
        [_pushDict removeObjectForKey:@"kCASE"];
        
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch3"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch0"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [_allSwitch setOn:NO];
    }else{
        [_pushDict setValue:@"CASE" forKey:@"kCASE"];
        //[self sendAllPush:@"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_NEW" group:group subscriptionArn:@"subscriptionArn3"];
         [standardUserDefaults1 setObject:@"1" forKey:@"Switch3"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self showAllAPNSSwitchOnorOff];

    }
    
    [self changePushMessagePreferenceMsgP:[self savePushConfig]];
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        //汇总结果
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //UI操作
            MyLog(@"removeLoadingAlert");
            [self removeLoadingAlert];
            
        });
    });
}

//成功筹募switch
- (IBAction)sucAction:(UISwitch*)sender{
    NSUserDefaults *standardUserDefaults1 = [NSUserDefaults standardUserDefaults];
    dispatch_group_t group =  dispatch_group_create();
    [self showLoadingAlert];
    if (!sender.isOn){
        [_pushDict removeObjectForKey:@"kSUCCESS"];
         [standardUserDefaults1 setObject:@"0" forKey:@"Switch4"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch0"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [_allSwitch setOn:NO];
    }else{
        [_pushDict setValue:@"SUCCESS" forKey:@"kSUCCESS"];
       //[self sendAllPush:@"arn:aws:sns:us-east-1:819247114127:EGive_APNS_PROD_REC" group:group subscriptionArn:@"subscriptionArn4"];
        [standardUserDefaults1 setObject:@"1" forKey:@"Switch4"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self showAllAPNSSwitchOnorOff];

    }
    
    [self changePushMessagePreferenceMsgP:[self savePushConfig]];
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        //汇总结果
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //UI操作
            MyLog(@"removeLoadingAlert");
            [self removeLoadingAlert];
            
        });
    });
}

//捐款記錄switch
- (void)DonationAtion:(UISwitch*)sender{
    NSUserDefaults *standardUserDefaults1 = [NSUserDefaults standardUserDefaults];
    dispatch_group_t group =  dispatch_group_create();
    [self showLoadingAlert];
    if (!sender.isOn){
        [_pushDict removeObjectForKey:@"kDONATION"];
        
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch5"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [standardUserDefaults1 setObject:@"0" forKey:@"Switch0"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [_allSwitch setOn:NO];
    }
    else{
        [_pushDict setValue:@"DONATION" forKey:@"kDONATION"];
        [standardUserDefaults1 setObject:@"1" forKey:@"Switch5"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self showAllAPNSSwitchOnorOff];
    }
    
    [self changePushMessagePreferenceMsgP:[self savePushConfig]];
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        //汇总结果
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //UI操作
            MyLog(@"removeLoadingAlert");
            [self removeLoadingAlert];
            
        });
    });
}


- (void)showLoadingAlert
{
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.progressHUD = [MBProgressHUD showHUDAddedTo:app.window animated:NO];
    [app.window addSubview:self.progressHUD];
    self.progressHUD.dimBackground = YES;
}

- (void)removeLoadingAlert
{
    
    [self.progressHUD hide:YES];
}

- (IBAction)DonationAction:(id)sender {
}
@end
