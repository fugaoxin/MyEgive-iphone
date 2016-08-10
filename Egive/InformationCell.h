//
//  InformationCell.h
//  Egive
//
//  Created by sino on 15/7/28.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationModel.h"
#import "MDHTMLLabel.h"

@interface InformationCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *LogoImage;
@property (strong, nonatomic) IBOutlet UIImageView *NewImage;

@property (strong, nonatomic) IBOutlet UILabel *Title;

@property (strong, nonatomic) IBOutlet UILabel *SubTitle;

@property (strong, nonatomic) IBOutlet UILabel *Dtate;


/**
 * 获取数据
 * dataDic: 数据字典
 * array: 已读信息数组
 */
-(void)setData:(InformationModel *)model andIDArray:(NSArray *)array;

@end
