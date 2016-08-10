//
//  MenuViewController.h
//  Egive
//
//  Created by sino on 15/8/4.
//  Copyright (c) 2015年 sino. All rights reserved.
//
//已使用的tag值范围：[1-30],[100-110],[200-225][50]
#import "ViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "MemberModel.h"
#import "EGGetAndSaveShoppingCartResult.h"
#import <Social/Social.h>
#import "MBProgressHUD.h"
@interface MenuViewController : ViewController <UIActionSheetDelegate>
@property (assign, nonatomic) NSInteger  appLang;
@property (strong, nonatomic) UIView * logOutView;
@property (strong, nonatomic) UIView * logintView;
@property (strong, nonatomic) UIImageView * iconImage;
@property (strong, nonatomic) UILabel * userName;
@property (strong, nonatomic) UILabel * donMoney;
@property (strong, nonatomic) UILabel * donationsLable;
@property (strong, nonatomic) UILabel * topTitle;
@property (copy, nonatomic) NSString * dataString;
@property (strong, nonatomic) UIView * topTitleView;
@property (strong, nonatomic) UILabel * donationsLabel;
@property(retain,nonatomic)UILabel * messageLabel;
@property (assign, nonatomic) int isHidden;
@property (strong, nonatomic) UIView * donationsView;
- (void)createFooterButton;
- (void)createMenuUI;
- (void)menuAction;
- (void)updateLangString;
- (void)shareSystem;
- (void)showUserInfo;
- (void)updateIcon;
- (void)showLoadingAlert;
- (void)removeLoadingAlert;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
+ (void)shareToSocialNetworkWithSubject:(NSString*)subject content:(NSString*)content url:(NSString*)url image:(UIImage*)image;
@end
