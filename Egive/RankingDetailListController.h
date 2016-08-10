//
//  RankingDetailListController.h
//  Egive
//
//  Created by sino on 15/7/29.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "NSString+RegexKitLite.h"
#import "RankingModel.h"
#import "MemberModel.h"
#import "ShowMenuView.h"
#import "MenuViewController.h"



typedef NS_ENUM(NSInteger, RankListStyle) {
    PersonRankStyle,                  // 默认
    CompanyRankStyle                 // 企业
};


@interface RankingDetailListController : MenuViewController
@property (copy, nonatomic) NSString * navTitle;
@property (copy, nonatomic) NSString * typeTitle; //排名类型名
@property (copy, nonatomic) NSString * category;  //排名类型post参数
@property (copy, nonatomic) NSString * ranking;
@property (nonatomic) BOOL isShowMoney;


@property (nonatomic) RankListStyle rankStyle;
@property(retain,nonatomic)NSString *nameString;
@end
