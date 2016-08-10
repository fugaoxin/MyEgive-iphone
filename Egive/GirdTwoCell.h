//
//  GirdTwoCell.h
//  Egive
//
//  Created by sino on 15/8/13.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBtn.h"
@interface GirdTwoCell : UITableViewCell
@property (strong, nonatomic) UIView * bgView;
@property (strong, nonatomic) UIView * bgView1;
@property (strong, nonatomic) UIImageView * showImage;
@property (strong, nonatomic) UIImageView * typeImage;
@property (strong, nonatomic) UILabel * titleLabel;
@property (strong, nonatomic) UILabel * moneyLabel;
@property (strong, nonatomic) UIProgressView * progress;
@property (strong, nonatomic) UILabel * proLabel;
@property (strong, nonatomic) UIImageView * heartImg;
@property (strong, nonatomic) UIImageView * progressImg;
@property (strong, nonatomic) MyBtn * attentionButton;
@property (strong, nonatomic) MyBtn * donationButton;
@property (strong, nonatomic) UIImageView * succeedImage;

@property (strong, nonatomic) UILabel * titleLabel1;
@property (strong, nonatomic) UIImageView * typeImage1;
@property (strong, nonatomic) UILabel * goalLabel;
@property (strong, nonatomic) UILabel * timeLabel;
@property (strong, nonatomic) UILabel * time;
@property (strong, nonatomic) UILabel * sponsorCount;
@property (strong, nonatomic) UILabel * count;
@property (strong, nonatomic) UILabel * goalMoney;
@end
