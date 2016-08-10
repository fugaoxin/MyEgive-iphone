//
//  ForeshowCell.h
//  Egive
//
//  Created by sino on 15/8/19.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGEventDtl.h"

@interface ForeshowCell : UITableViewCell
@property (strong, nonatomic) UIImageView * leftImage;
@property (strong, nonatomic) UILabel * titleLabel;
@property (strong, nonatomic) UILabel * dateLabel;
@property (strong, nonatomic) UILabel * conten;
@property (nonatomic, strong) EGEventDtl *eventDtl;
@property(retain,nonatomic)NSString * str1;
@property(retain,nonatomic)NSString * str2;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
