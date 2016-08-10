//
//  RankingDetailListCell.m
//  Egive
//
//  Created by sino on 15/7/29.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "RankingDetailListCell.h"
#import "UIView+ZJQuickControl.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@implementation RankingDetailListCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI{

    _userImage = [self.contentView addImageViewWithFrame:CGRectMake(15, 5, 60, 60) image:nil];
    _userImage.layer.cornerRadius = 30;
    _userImage.layer.masksToBounds = YES;
    _title = [self.contentView addLabelWithFrame:CGRectMake(90, 5, ScreenSize.width-150, 50) text:nil];
    _title.numberOfLines=2;
    //_title.backgroundColor=[UIColor redColor];
    _title.font = [UIFont boldSystemFontOfSize:15];
    
    _amount = [self.contentView addLabelWithFrame:CGRectMake(90, 45, 200, 25) text:@"HKD$ 1,090,211"];
    _amount.font = [UIFont systemFontOfSize:15];
    
   UIImageView * rankImage = [self.contentView addImageViewWithFrame:CGRectMake(ScreenSize.width-70, -25, 65, 90) image:@"ranking_others@2x.png"];
    
    _ranking = [rankImage addLabelWithFrame:CGRectMake(20, 40, 25, 20) text:nil];
    _ranking.font = [UIFont boldSystemFontOfSize:15];
    _ranking.textAlignment = NSTextAlignmentCenter;
    _ranking.textColor = [UIColor whiteColor];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //上分割线， CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"ffffff"].CGColor); CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor); CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width , 0.5));
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
