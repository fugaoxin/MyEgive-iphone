//
//  ShowDetaileTableViewCell.m
//  Egive
//
//  Created by zxj on 15/10/30.
//  Copyright © 2015年 sino. All rights reserved.
//

#import "ShowDetaileTableViewCell.h"
#import "EGUtility.h"
@implementation ShowDetaileTableViewCell

- (void)awakeFromNib {
    
   self.DateTitleLabel.text= EGLocalizedString(@"DonationInfo_foreshow_date", nil);
    self.ContentTitleLabel.text = EGLocalizedString(@"ContentTitLe", nil);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
