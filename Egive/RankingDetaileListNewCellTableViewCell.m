//
//  RankingDetaileListNewCellTableViewCell.m
//  Egive
//
//  Created by zxj on 15/12/7.
//  Copyright © 2015年 sino. All rights reserved.
//

#import "RankingDetaileListNewCellTableViewCell.h"

@implementation RankingDetaileListNewCellTableViewCell

- (void)awakeFromNib {
    
    _userImage.layer.cornerRadius = 30;
    _userImage.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
