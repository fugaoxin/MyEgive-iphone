//
//  ForeshowDetailCell.m
//  Egive
//
//  Created by sino on 15/8/19.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ForeshowDetailCell.h"
#import "UIView+ZJQuickControl.h"
#import "EGUtility.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@implementation ForeshowDetailCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    
    UILabel * dateLabel = [self.contentView addLabelWithFrame:CGRectMake(5, 5, 60, 25) text:EGLocalizedString(@"DonationInfo_foreshow_date", nil)];
    dateLabel.textColor = [UIColor grayColor];
    dateLabel.font = [UIFont systemFontOfSize:12];
    
    _date = [self.contentView addLabelWithFrame:CGRectMake(60, 5, 150, 25) text:nil];
    _date.font = [UIFont systemFontOfSize:12];
    
//    UILabel * addressLabel = [self.contentView addLabelWithFrame:CGRectMake(5, 30, 60, 25) text:EGLocalizedString(@"DonationInfo_foreshow_address", nil)];
//    addressLabel.textColor = [UIColor grayColor];
//    addressLabel.font = [UIFont systemFontOfSize:12];
 
//    _address = [self.contentView addLabelWithFrame:CGRectMake(60, 30, 260, 25) text:nil];
//    _address.font = [UIFont systemFontOfSize:12];
//    self.ContentLabelTitle = [self.contentView addLabelWithFrame:CGRectMake(10, 55,30 ,150) text:@"内容:"];
//    self.ContentLabelTitle.font = [UIFont systemFontOfSize:12];
//    self.ContentLabelTitle.textColor = [UIColor lightGrayColor];
    
    _conten = [self.contentView addLabelWithFrame:CGRectMake(10, 55,ScreenSize.width-20 ,150) text:nil];
    _conten.font = [UIFont systemFontOfSize:12];
    _conten.numberOfLines = 0;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
