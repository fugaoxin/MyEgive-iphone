//
//  ShareViewCell.m
//  Egive
//
//  Created by sino on 15/8/17.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ShareViewCell.h"
#import "UIView+ZJQuickControl.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@implementation ShareViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _shareImage = [self.contentView addImageViewWithFrame:CGRectMake(0, 0, ScreenSize.width, 200) image:@"testImage.jpg"];
        _shareLabel = [self.contentView addLabelWithFrame:CGRectMake(10, 200, ScreenSize.width-20, 40) text:@"史蒂夫哈阿隆索大量收到啦收到卡拉合适的卡拉卡斯的婚看见好多家咖啡馆的身份空间"];
        _shareLabel.numberOfLines = 0;
        _shareLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
