//
//  LoginViewController.m
//  Egive
//
//  Created by sino on 15/7/21.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "Constants.h"
#import "Constants.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "DDMenuController.h"
#import "PopupAdController.h"
#import "ShowMenuView.h"
#import "AFNetworking.h"
#import "ModelTool.h"
#import "MemberModel.h"
#import "ForgetPswViewController.h"
#import "RegisterViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "WeiboSDK.h"
#import "MyAttentionViewController.h"
#import "MBProgressHUD.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface LoginViewController () {
    NSString *wbtoken;
    NSString *wbCurrentUserID;
    NSString *wbRefreshToken;
}
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *PswTextField;
@property (strong, nonatomic) IBOutlet UIButton *faceBook;
- (IBAction)forgetPswButton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) IBOutlet UIButton *facebookButton;
@property (strong, nonatomic) IBOutlet UIImageView *faceImage;
@property (strong, nonatomic) IBOutlet UIButton *weiboButton;
@property (strong, nonatomic) IBOutlet UIImageView *weiboImage;

@property (strong, nonatomic) MemberModel * item;
@property (copy, nonatomic) NSMutableDictionary * shareDict;
@property (copy, nonatomic) RegisterViewController * vc;
@property (strong, nonatomic) HomeViewController * home;
@property (strong, nonatomic) DDMenuController * menuController;
@property (strong, nonatomic) AlertViewController * alertVc;
- (IBAction)Register:(UIButton *)sender;
- (IBAction)Login:(UIButton *)sender;
- (IBAction)FacebookLogin:(id)sender;
- (IBAction)wbLogin:(UIButton *)sender;

@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (assign) int isfb;

@end

@implementation LoginViewController

- (id)initWithToggleViewController:(UIViewController*)targetController {
    self = [super init];
    if (self) {
        _theTargetController = targetController;
        MyLog(@"_theTargetController = targetController;");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    _loginTextField.layer.borderColor=[[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1]CGColor];
    _loginTextField.layer.borderWidth= 1.0f;
    [_loginTextField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [_loginTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    
    _PswTextField.layer.borderColor=[[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1]CGColor];
    _PswTextField.layer.borderWidth= 1.0f;
    [_PswTextField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_faceBook setTitleColor:[UIColor colorWithRed:55/255.0 green:90/255.0 blue:150/255.0 alpha:1] forState:UIControlStateNormal];

    
    _dataArray = [[NSMutableArray alloc] init];

    __weak typeof(self) weakSelf = self;
    _vc = [[RegisterViewController alloc] init];
    [_vc setAction:^(NSString * name) {
        
         MyLog(@"%@",name);
        weakSelf.loginTextField.text = name;
    }];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
    
    _isfb = 0;
    _alertVc = [[AlertViewController alloc] initWithNibName:@"AlertViewController" bundle:nil];;
    [_alertVc setAction:^(AlertViewController *vc) {
       
        if (_isfb == 1) {
            [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
                FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
            
                [login
                 logInWithReadPermissions: @[@"public_profile", @"email"]
                 handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                     if (error) {
                         MyLog(@"Process error");
                     } else if (result.isCancelled) {
                         MyLog(@"Cancelled");
                     } else {
                         MyLog(@"Logged in");
                         if ([FBSDKAccessToken currentAccessToken]) {
                             [[NSUserDefaults standardUserDefaults] setObject:[[FBSDKAccessToken currentAccessToken] tokenString  ]forKey:@"FBSDKAccessToken"];
                             [[NSUserDefaults standardUserDefaults] synchronize];
                             MyLog(@"Access Token Activated");
            
                             NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                             [parameters setValue:@"id,name,email,gender,picture,first_name,last_name" forKey:@"fields"];
                             __weak typeof(self) weakSelf = self;
                             [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
                              startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                                  if (!error) {
                                      
                                      MyLog(@"fetched user:%@", result);
                                      
                                      NSDictionary *result2 = result;
            
                                      // testing purpose
                                      //                          NSMutableDictionary *result3 = [result2 mutableCopy];
                                      //                          NSNumber *ts = [NSNumber numberWithDouble: [[NSDate date] timeIntervalSince1970]]; // testing purpose
                                      //                          NSString *fbID = [result3 objectForKey:@"id"];
                                      //                          NSString *email = [result3 objectForKey:@"email"];
                                      //
                                      //                          fbID = [NSString stringWithFormat:@"%@%@", fbID, ts];
                                      //                          email = [NSString stringWithFormat:@"%@%@", ts, email];
                                      //
                                      //                          [result3 setObject:fbID forKey:@"id"];
                                      //                          [result3 setObject:email forKey:@"email"];
                                      //
                                      //                          NSUserDefaults *def2 = [NSUserDefaults standardUserDefaults];
                                      //                          [def2 setObject:@"1" forKey:@"FACEBOOK_REG_REQ"];
                                      //                          [def2 setObject:result3 forKey:@"FACEBOOK_DETAIL"];
                                      //                          [def2 synchronize];
                                      //
                                      //                          MyLog(@"result3 = %@", result3);
                                      //                          [self requestLoginApiData:@"facebook"];
                                      //                          _vc.model = _model;
                                      //                          [_vc thirdPartyLogin: weakSelf];
                                      //
                                      //                          return;
                                      // testing purpose
            
                    // NSString *url = [[[result2 objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"];
                                      
                                      NSString *url = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [result2 objectForKey:@"id"]];
                                      
                                      MyLog(@"%@",url);
                                     

                                      NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
                                      
                                      NSString *base64 = [UIImagePNGRepresentation([self imageWithImage:[UIImage imageWithData: imageData] convertToSize:CGSizeMake(128, 128)]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                                     
                                      
                                      NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
                                      [def setObject:@"1" forKey:@"FACEBOOK_REG_REQ"];
                                      [def setObject:result2 forKey:@"FACEBOOK_DETAIL"];
                                      [def setObject:base64 forKey:@"FACEBOOK_PICTURE"];
                                      [def synchronize];
            
                                      [self requestLoginApiData:@"facebook"];
                                      _vc.model = _model;
                                      [_vc thirdPartyLogin: weakSelf];
            
                                      //                          if ([def objectForKey:[NSString stringWithFormat:@"fb%@", [result2 objectForKey:@"id"]]] != nil) {
                                      //                              [self requestLoginApiData:@"facebook"];
                                      //                          } else {
                                      //                              _vc.model = _model;
                                      //                              [_vc thirdPartyLogin: weakSelf];
                                      //                              [self.navigationController pushViewController:_vc animated:YES];
                                      //                          }
                                    
                                      //                           RegisterViewController* vc = [[RegisterViewController alloc] init];
                                      //                          [self.navigationController pushViewController:vc animated:YES];
                                  }
                                  else {
                                      
                                      MyLog(@"error=%@", error);
                                  }
                              }];
                             
                         }
                     }
                 }];
        }
        else if (_isfb == 2){
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"removeView" object: nil];
           

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                AppDelegate *dele = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [dele setLoginViewController:self];
                
                WBAuthorizeRequest *request = [WBAuthorizeRequest request];
                request.redirectURI = Weibo_redirectURI;
                request.scope = @"all";
                request.userInfo = @{@"SSO_From": @"LoginViewController",
                                     @"Other_Info_1": [NSNumber numberWithInt:123],
                                     @"Other_Info_2": @[@"obj1", @"obj2"],
                                     @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
                
                [WeiboSDK sendRequest:request];
                
            });
        }
    
    }];


#if 0
    if (_item != nil) {
        _loginTextField.text = _item.LoginName;
        _PswTextField.text = @"";
    }else{
        _loginTextField.text = @"xsl";
        _PswTextField.text = @"111111";
        
    }
#endif
    
    //生产环境隐藏facebook 和 weibo 开发环境打开
    if([faceBookAndWeiboLogin isEqualToString:@"1"]){
    
        _faceBook.hidden=YES;
        _weiboButton.hidden=YES;
        _faceImage.hidden=YES;
        _weiboImage.hidden=YES;
    
    }else{
    
        _faceBook.hidden=NO;
        _weiboButton.hidden=NO;
        _faceImage.hidden=NO;
        _weiboImage.hidden=NO;
    
      }

    [self requestMemberFormData];
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    self.loginTextField.placeholder = EGLocalizedString(@"Login_userName_textFile", nil);
    self.PswTextField.placeholder = EGLocalizedString(@"Login_passWord_textFile", nil);
    [self.loginButton setTitle:EGLocalizedString(@"Login_loginButton_title", nil) forState:UIControlStateNormal];
    [self.registerButton setTitle:EGLocalizedString(@"Login_registerButton_title", nil) forState:UIControlStateNormal];
    [self.faceBook setTitle:EGLocalizedString(@"Login_faceBookButton_title", nil) forState:UIControlStateNormal];
    [self.weiboButton setTitle:EGLocalizedString(@"Login_wbButton_title", nil) forState:UIControlStateNormal];
    [self.termsOfUse setTitle:EGLocalizedString(@"Login_label_title1", nil) forState:UIControlStateNormal];
    [self.privacy setTitle:EGLocalizedString(@"Login_label_title2", nil) forState:UIControlStateNormal];
    [self.copyright setTitle:EGLocalizedString(@"Login_label_title3", nil) forState:UIControlStateNormal];
    
    
    MyLog(@"viewWillAppear viewWillAppear");
    
}

- (void)tapAction{
    [self.loginTextField resignFirstResponder];
    [self.PswTextField resignFirstResponder];

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


#pragma mark - 请求API,下载解析数据
-(void)requestLoginApiData:(NSString *)loginType{
    
    [self showLoadingAlert];
    NSString *theID = @"";
    NSString *login = @"";
    NSString *password = @"";
    
    if ([loginType isEqualToString:@"facebook"]){
        
        NSUserDefaults *standardUserDefaults  = [NSUserDefaults standardUserDefaults];
        NSDictionary *acc = [standardUserDefaults objectForKey:@"FACEBOOK_DETAIL"];
        theID = [acc objectForKey:@"id"];
        
    } else if ([loginType isEqualToString:@"weibo"]){
        
        NSUserDefaults *standardUserDefaults  = [NSUserDefaults standardUserDefaults];
        NSDictionary *acc = [standardUserDefaults objectForKey:@"WEIBO_DETAIL"];
        theID = [acc objectForKey:@"usid"];
        
    } else {
        login = _loginTextField.text;
        password = _PswTextField.text;
    }
    
     NSString *Apptoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"GetendpointArn"];
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <Login xmlns=\"egive.appservices\"><LoginType>%@</LoginType><LoginName>%@</LoginName><PWD>%@</PWD><ID>%@</ID><AppToken>%@</AppToken><CookieID></CookieID></Login></soap:Body></soap:Envelope>",loginType,login,password, theID,Apptoken];
    //<FaceBookID></FaceBookID> <WeiboID></WeiboID>
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    MyLog(@"soapMessage = %@", soapMessage);
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        //        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        //        MyLog(@"%@", operation.request.allHTTPHeaderFields);
        //        // 服务器给我们返回的包得头部信息
//                MyLog(@"%@", operation.response);
        //        返回的数据
        //        MyLog(@"success = %@",responseObject);
        
        [self removeLoadingAlert];
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        MyLog(@"requestLoginApiData JSON:%@", dataString);
        NSDictionary * dict = [NSString parseJSONStringToNSDictionary:dataString];
    
        MyLog(@"%@",dict);
    
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSString *FACEBOOK_REG_REQ = [standardUserDefaults objectForKey:@"FACEBOOK_REG_REQ"];
        NSString *WEIBO_REG_REQ = [standardUserDefaults objectForKey:@"WEIBO_REG_REQ"];
        
        if (([[self jSONStringToNSDictionary:dataString] isEqualToString:@"\"Member not registered!\""]||[[self jSONStringToNSDictionary:dataString] isEqualToString:@"\"Error(5007)\""]) &&
            ([FACEBOOK_REG_REQ isEqualToString:@"1"] || [WEIBO_REG_REQ isEqualToString:@"1"])
            ) {
            
            
            [self.navigationController pushViewController:_vc animated:YES];
            
            
        } else if (dict != nil){
            
            _memberId = dict[@"MemberID"];
            [self GetMemberInfo:_memberId];
            
            if(self.action)
            {
                _action(self);
            }
            
            if (_theTargetController != nil) {
                
                MyLog(@"_theTargetController != nil _theTargetController != nil");
                [self.navigationController popViewControllerAnimated:YES];
                [self.navigationController pushViewController:_theTargetController animated:YES];
                return ;
              
            } else{
                
                 NSUserDefaults *facebookorweiboDefaults = [[NSUserDefaults alloc] init];
                if([loginType isEqualToString:@"facebook"] || [loginType isEqualToString:@"weibo"]){
                    
                    [facebookorweiboDefaults setObject:@"1" forKey:@"faceBookOrWeibo"];
                    
                    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
                    HomeViewController * vc = [[HomeViewController alloc] init];
                    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
                    [menuController setRootController:navController animated:YES];
                
                
                }else{
                
                [facebookorweiboDefaults setObject:@"0" forKey:@"faceBookOrWeibo"];
                DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
                              HomeViewController * vc = [[HomeViewController alloc] init];
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
                [menuController setRootController:navController animated:YES];
            }
                
                
            }
        
        }else{
            
            if ([[self jSONStringToNSDictionary:dataString] isEqualToString:@"\"Wrong password!\""] ||[[self jSONStringToNSDictionary:dataString] isEqualToString:@"\"Error(5008)\""]||[[self jSONStringToNSDictionary:dataString] isEqualToString:@"\"Error(5006)\""]) {
                
                UIAlertView *alertView = [[UIAlertView alloc] init];
                alertView.message = EGLocalizedString(@"密码错误", nil);
                [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                [alertView show];
                
            }else if ([[self jSONStringToNSDictionary:dataString] isEqualToString:@"\"Member not registered!\""]||[[self jSONStringToNSDictionary:dataString] isEqualToString:@"\"Error(5007)\""]){
                
                UIAlertView *alertView = [[UIAlertView alloc] init];
                alertView.message = EGLocalizedString(@"未注册的用户", nil);
                [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                [alertView show];
            }
            
            MyLog(@"%@",[self jSONStringToNSDictionary:dataString]);

        }
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

- (void)GetMemberInfo:(NSString *)memberId{
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
        //        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        //        MyLog(@"%@", operation.request.allHTTPHeaderFields);
        //        // 服务器给我们返回的包得头部信息
        //                MyLog(@"%@", operation.response);
        //        返回的数据
        //        MyLog(@"success = %@",responseObject);
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];

        NSArray * arr = [self parseJSONStringToNSDictionary:dataString];
        
        MyLog(@"GetMemberInfo JSON = %@", arr);
        
         MyLog(@"%ld",arr.count);
        
        NSMutableDictionary * _dict = [ShowMenuView getUserInfo];
        for (NSDictionary * dict in arr) {
            
            MemberModel * model = [[MemberModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
            [standardUserDefaults setObject:dict forKey:@"EGIVE_MEMBER_MODEL"];
            [standardUserDefaults synchronize];
            [_dict setObject:model forKey:@"LoginName"];
            [ShowMenuView sharedInstance].member = model;
            
        }
        
        if(self.action)
        {
            _action(self);
        }
        
        if (_theTargetController != nil) {
//            MyLog(@"_theTargetController != nil _theTargetController != nil");
//            [self.navigationController pushViewController:_theTargetController animated:YES];
//            [self dismissViewControllerAnimated:YES completion:nil];
            return ;
            
        } else {
            DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
            
            HomeViewController * vc = [[HomeViewController alloc] init];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
                [menuController setRootController:navController animated:YES];
            // [self.navigationController popViewControllerAnimated:YES];
        }
        
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

- (NSString *)jSONStringToNSDictionary:(NSString *)JSONString {
    NSRange r;
    while ((r = [JSONString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound){
        JSONString = [JSONString stringByReplacingCharactersInRange:r withString:@""];
        
    }
    return JSONString;
}

- (NSArray *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSRange r;
    while ((r = [JSONString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound){
        JSONString = [JSONString stringByReplacingCharactersInRange:r withString:@""];
        
    }
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray * arr = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    
    return arr;
}


#pragma mark - 请求表格数据
-(void)requestMemberFormData{
    
   long lang = [EGUtility getAppLang];
    
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <GetMemberForm xmlns=\"egive.appservices\"><Lang>%ld</Lang></GetMemberForm></soap:Body></soap:Envelope>",lang];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //                // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        //                MyLog(@"%@", operation.request.allHTTPHeaderFields);
        //                // 服务器给我们返回的包得头部信息
        //                        MyLog(@"%@", operation.response);
        //               // 返回的数据
        //                MyLog(@"success = %@",responseObject);
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary * dict = [NSString parseJSONStringToNSDictionary:dataString];
//        MyLog(@"%@",dataString);
        _model = [[MemberFormModel alloc] init];
        [_model setValuesForKeysWithDictionary:dict];
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        [standardUserDefaults setObject:dict forKey:@"MemberForm"];
        [standardUserDefaults synchronize];

        
        
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


- (IBAction)forgetPswButton:(UIButton *)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.message = EGLocalizedString(@"是否通过Email找回密码？", nil);
    alertView.delegate = self;
    [alertView addButtonWithTitle:EGLocalizedString(@"取消", nil)];
    [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
    [alertView show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    MyLog(@"buttonIndex = %ld",buttonIndex);
    if (buttonIndex == 1) {
        ForgetPswViewController * vc = [[ForgetPswViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
#pragma mark 会员注册
- (IBAction)Register:(UIButton *)sender {
    
   
    _vc.model = _model;
    [self.navigationController pushViewController:_vc animated:YES];
    
}

- (IBAction)Login:(UIButton *)sender {
    
    NSString * logintype = @"normal";
    if (![NSString isEmpty:_loginTextField.text andNote:EGLocalizedString(@"Login_note_title", nil)] && ![NSString isEmpty: _PswTextField.text andNote:EGLocalizedString(@"Login_note_title", nil)]) {
        [self requestLoginApiData:logintype];
    }

//    HomeViewController * vc = [[HomeViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void) preformUpdateLoginFields:(NSString*)login andPassword:(NSString*)password
{
    _loginTextField.text = login;
    _PswTextField.text = password;
}

- (IBAction)FacebookLogin:(id)sender {
    
//        AlertViewController * vc = [[AlertViewController alloc] initWithNibName:@"AlertViewController" bundle:nil];
//        vc.model = _model;
//        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//        [self.view.window.rootViewController presentViewController:vc animated:YES completion:nil];
    _isfb = 1;
    
    self.alertVc.model = _model;
    self.alertVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.view.window.rootViewController presentViewController:self.alertVc animated:YES completion:nil];
    
//    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
//    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
//    
//    [login
//     logInWithReadPermissions: @[@"public_profile", @"email"]
//     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//         if (error) {
//             MyLog(@"Process error");
//         } else if (result.isCancelled) {
//             MyLog(@"Cancelled");
//         } else {
//             MyLog(@"Logged in");
//             if ([FBSDKAccessToken currentAccessToken]) {
//                 [[NSUserDefaults standardUserDefaults] setObject:[[FBSDKAccessToken currentAccessToken] tokenString  ]forKey:@"FBSDKAccessToken"];
//                 [[NSUserDefaults standardUserDefaults] synchronize];
//                 MyLog(@"Access Token Activated");
//                 
//                 NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
//                 [parameters setValue:@"id,name,email" forKey:@"fields"];
//                 __weak typeof(self) weakSelf = self;
//                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
//                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//                      if (!error) {
//                          MyLog(@"fetched user:%@", result);
//                          NSDictionary *result2 = result;
//                          
//                          // testing purpose
//                          //                          NSMutableDictionary *result3 = [result2 mutableCopy];
//                          //                          NSNumber *ts = [NSNumber numberWithDouble: [[NSDate date] timeIntervalSince1970]]; // testing purpose
//                          //                          NSString *fbID = [result3 objectForKey:@"id"];
//                          //                          NSString *email = [result3 objectForKey:@"email"];
//                          //
//                          //                          fbID = [NSString stringWithFormat:@"%@%@", fbID, ts];
//                          //                          email = [NSString stringWithFormat:@"%@%@", ts, email];
//                          //
//                          //                          [result3 setObject:fbID forKey:@"id"];
//                          //                          [result3 setObject:email forKey:@"email"];
//                          //
//                          //                          NSUserDefaults *def2 = [NSUserDefaults standardUserDefaults];
//                          //                          [def2 setObject:@"1" forKey:@"FACEBOOK_REG_REQ"];
//                          //                          [def2 setObject:result3 forKey:@"FACEBOOK_DETAIL"];
//                          //                          [def2 synchronize];
//                          //
//                          //                          MyLog(@"result3 = %@", result3);
//                          //                          [self requestLoginApiData:@"facebook"];
//                          //                          _vc.model = _model;
//                          //                          [_vc thirdPartyLogin: weakSelf];
//                          //
//                          //                          return;
//                          // testing purpose
//                          
//                          
//                          
//                          NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//                          [def setObject:@"1" forKey:@"FACEBOOK_REG_REQ"];
//                          [def setObject:result2 forKey:@"FACEBOOK_DETAIL"];
//                          [def synchronize];
//                          
//                          [self requestLoginApiData:@"facebook"];
//                          _vc.model = _model;
//                          [_vc thirdPartyLogin: weakSelf];
//                          
//                          //                          if ([def objectForKey:[NSString stringWithFormat:@"fb%@", [result2 objectForKey:@"id"]]] != nil) {
//                          //                              [self requestLoginApiData:@"facebook"];
//                          //                          } else {
//                          //                              _vc.model = _model;
//                          //                              [_vc thirdPartyLogin: weakSelf];
//                          //                              [self.navigationController pushViewController:_vc animated:YES];
//                          //                          }
//                          
//                          
//                          
//                          //                           RegisterViewController* vc = [[RegisterViewController alloc] init];
//                          //                          [self.navigationController pushViewController:vc animated:YES];
//                      }
//                  }];
//                 
//             }
//         }
//     }];
    
}

- (IBAction)wbLogin:(UIButton *)sender {
    
    _isfb = 2;
    self.alertVc.model = _model;
    self.alertVc.isWBLogin = YES;
    self.alertVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.view.window.rootViewController presentViewController:self.alertVc animated:YES completion:nil];
    
//    AppDelegate *dele = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    [dele setLoginViewController:self];
//    
//    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
//    request.redirectURI = @"http://www.sina.com";
//    request.scope = @"all";
//    request.userInfo = @{@"SSO_From": @"LoginViewController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
//    [WeiboSDK sendRequest:request];
    
}

- (IBAction)termsOfUseAction:(UIButton *)sender {
    
    TermsOfUseView * vc = [[TermsOfUseView alloc] initWithNibName:@"BaseNotesController" bundle:nil];;
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:vc animated:NO completion:nil];
}

- (IBAction)privacyAction:(UIButton *)sender {
    PrivacyView * vc = [[PrivacyView alloc] initWithNibName:@"BaseNotesController" bundle:nil];;
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:vc animated:NO completion:nil];
}

- (IBAction)copyrightAction:(UIButton *)sender {
    CopyrightController * vc = [[CopyrightController alloc] initWithNibName:@"BaseNotesController" bundle:nil];;
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:vc animated:NO completion:nil];
}

// WEIBO SDK

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    MyLog(@"didReceiveWeiboRequest");
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = NSLocalizedString(@"认证结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        MyLog(@"WEIBO INFO->%@",message);
        if (response.statusCode == 0) {
            
            self->wbtoken = [(WBAuthorizeResponse *)response accessToken];
            self->wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
            self->wbRefreshToken = [(WBAuthorizeResponse *)response refreshToken];
            
            
            NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?source=%@&access_token=%@&uid=%@", Weibo_APP_ID, self->wbtoken, self->wbCurrentUserID]]];
            NSURLResponse * response = nil;
            NSError * error = nil;
            NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
            
            NSMutableDictionary * innerJson = [NSJSONSerialization
                                               JSONObjectWithData:data
                                               options:kNilOptions
                                               error:&error];
            
            NSString *url = [innerJson objectForKey:@"avatar_large"];
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
            NSString *base64 = [UIImagePNGRepresentation([self imageWithImage:[UIImage imageWithData: imageData] convertToSize:CGSizeMake(128, 128)]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//            MyLog(@"base64 = %@", base64);
            
//            MyLog(@"innerJson = %@", innerJson);
            
            NSMutableDictionary *acc = [NSMutableDictionary dictionary];
//            NSString* userName =  [innerJson ]
            [acc setObject:[innerJson objectForKey:@"name"] forKey:@"userName"];
            [acc setObject:self->wbCurrentUserID forKey:@"usid"];
            [acc setObject:@"" forKey:@"email"];
            
            //TODO WEIBO EMAIL
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            [def setObject:@"1" forKey:@"WEIBO_REG_REQ"];
            [def setObject:acc forKey:@"WEIBO_DETAIL"];
            [def setObject:base64 forKey:@"WEIBO_PICTURE"];
            [def synchronize];
            [self requestLoginApiData:@"weibo"];
            _vc.model = _model;
            [_vc thirdPartyLogin: self];
            
        }
        
        
    }
    
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

@end
