//
//  BlessingCell.h
//  Egive
//
//  Created by sino on 15/9/2.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBtn.h"
@interface BlessingCell : UITableViewCell

@property (strong, nonatomic) UIImageView * userIcon;
@property (strong, nonatomic) UILabel * memberName;
@property (strong, nonatomic) UILabel * commentDate;
@property (strong, nonatomic) UILabel * comment;
@property (strong, nonatomic) UIWebView * commentWv;
@property (strong, nonatomic) MyBtn * deleteComment;
@property (strong, nonatomic) UIView * view;
@end
