//
//  IndividualUserController.h
//  Egive
//
//  Created by sino on 15/7/30.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"
#import "RankListViewController.h"
#import "MyDonationViewController.h"
#import "EGGeneralRequestAdapter.h"
#import "MemberFormModel.h"
#import "NSString+RegexKitLite.h"
@interface IndividualUserController : MenuViewController
@property (strong, nonatomic) MemberFormModel * model;
@property (strong, nonatomic) UIImageView * userImage;
@property (strong, nonatomic) UILabel * money;
@property (copy, nonatomic) NSString * ageGroup;
@property (strong, nonatomic) UITextField * loginName;
@property (strong, nonatomic) UITextField * pws;
@property (strong, nonatomic) UITextField * name;
@property (strong, nonatomic) UITextField * chName;
@property (strong, nonatomic) UITextField * chLastName;
@property (strong, nonatomic) UITextField * chfirstName;
@property (strong, nonatomic) UITextField * enName;
@property (strong, nonatomic) UITextField * enLastName;
@property (strong, nonatomic) UITextField * enfirstName;
@property (strong, nonatomic) UITextField * email;
@property (strong, nonatomic) UITextField * organization;
@property (strong, nonatomic) UITextField * sex;
@property (strong, nonatomic) UILabel * address;
@property (strong, nonatomic) UITextField * age;
@property (strong, nonatomic) UITextField * phoneNum;
@property (copy, nonatomic) NSString * memberTotalDonationAmount;

//新添地址
//室楼座
@property (strong, nonatomic) IBOutlet UITextField *addressDistrict;
//大楼/楼宇名称
@property (strong, nonatomic) IBOutlet UITextField *addressBldg;
//屋苑
@property (strong, nonatomic) IBOutlet UITextField *addressEstate;
//街道
@property (strong, nonatomic) IBOutlet UITextField *addressStreet;
//地区
@property (strong, nonatomic) IBOutlet UITextField *region;
@property (strong, nonatomic) IBOutlet UILabel *RegionLabel;
@property (strong, nonatomic) IBOutlet UITextField *RegionTitleTextfield;
@property (strong, nonatomic) IBOutlet UILabel *addressTitleLabel;

@end
