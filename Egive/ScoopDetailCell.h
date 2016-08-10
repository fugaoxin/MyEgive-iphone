//
//  ScoopDetailCell.h
//  Egive
//
//  Created by sinogz on 15/9/7.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGEventDtl.h"
#import "MJPhotoBrowser/MJPhotoBrowser.h"

#define cellMargin 2
#define columnMax  2

@interface ScoopDetailCell : UITableViewCell

@property (nonatomic, strong) EGEventDtl *eventDtl;

@property (nonatomic, strong) NSDictionary *currentDict;

@property (nonatomic, strong)  MJPhotoBrowser *browser;

+(instancetype)cellWithTableView:(UITableView *)tableView eventDtl:(EGEventDtl *)eventDtl;

@end

@interface ScoopDetailCellFrame : NSObject

@property (nonatomic, readonly) CGRect      *avatarFrame;
@property (nonatomic, readonly) CGRect      titleFrame;
@property (nonatomic, readonly) CGRect      descLabel;
@property (nonatomic, readonly) CGRect      dateLabel;

@property (nonatomic, strong)   EGEventDtl  *eventDtl;             // 数据模型
@property(nonatomic,assign)CGFloat cellHeight;                 //cell的高度



@end