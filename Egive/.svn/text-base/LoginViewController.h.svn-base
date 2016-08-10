//
//  LoginViewController.h
//  Egive
//
//  Created by sino on 15/7/21.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ViewController.h"
#import "baseController.h"
#import "MemberFormModel.h"
#import "AlertViewController.h"
#import "TermsOfUseView.h"
#import "PrivacyView.h"
#import "CopyrightController.h"
#import "WeiboSDK.h"

@interface LoginViewController : baseController<UIGestureRecognizerDelegate, WeiboSDKDelegate>
@property (strong, nonatomic) MemberFormModel * model;
@property (copy, nonatomic) NSString * userName;
@property (copy, nonatomic) NSString * iconUrl;
@property (copy,nonatomic)void(^action)(LoginViewController *vc);
@property (copy, nonatomic) NSMutableArray * dataArray;
@property (copy, nonatomic) NSString * memberId;
- (IBAction)termsOfUse:(UITapGestureRecognizer *)sender;
- (IBAction)privacy:(UITapGestureRecognizer *)sender;
- (IBAction)copyright:(UITapGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIButton *termsOfUse;
@property (weak, nonatomic) IBOutlet UIButton *privacy;
@property (weak, nonatomic) IBOutlet UIButton *copyright;
@property (retain, nonatomic) UIViewController * theTargetController;
- (IBAction)termsOfUseAction:(UIButton *)sender;
- (IBAction)privacyAction:(UIButton *)sender;
- (IBAction)copyrightAction:(UIButton *)sender;
- (id)initWithToggleViewController:(UIViewController*)targetController ;
-(void) preformUpdateLoginFields:(NSString*)login andPassword:(NSString*)password;
-(void)requestLoginApiData:(NSString *)loginType;
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request;
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response;
@property (nonatomic) BOOL isFavouritePush; //是否点击收藏跳到登录页面

//确认资料页面跳转过来
@property(nonatomic)int MakeSureFlag;

@end
