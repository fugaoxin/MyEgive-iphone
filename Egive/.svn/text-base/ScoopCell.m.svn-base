//
//  ScoopCell.m
//  Egive
//
//  Created by sino on 15/8/19.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ScoopCell.h"
#import "UIView+ZJQuickControl.h"
#import "EGUtility.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@implementation ScoopCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UIImage *temp = [UIImage imageNamed:@"dummy_case_related_default@2x.png"];
    CGSize tempsize = temp.size;
    CGFloat scale = tempsize.width / tempsize.height;
    
    _leftImage = [self.contentView addImageViewWithFrame:CGRectMake(0, 0, 100*scale, 100) image:@"dummy_case_related_default@2x.png"];
    _titleLabel = [self.contentView addLabelWithFrame:CGRectMake(_leftImage.frame.size.width+10, 0, ScreenSize.width-135, 40) text:nil];
    
    
    //_leftImage = [self.contentView addImageViewWithFrame:CGRectMake(0, 0, 100, 95) image:nil];
    
    //_titleLabel = [self.contentView addLabelWithFrame:CGRectMake(105, 0, 210, 40) text:nil];
    _titleLabel.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.numberOfLines = 2;
    
    
//    _describe = [self.contentView addLabelWithFrame:CGRectMake(105, 35, 210, 40) text:nil];
    _describe = [self.contentView addLabelWithFrame:CGRectMake(_titleLabel.frame.origin.x, 35, ScreenSize.width-135, 40) text:nil];
    _describe.font = [UIFont systemFontOfSize:11];
    _describe.numberOfLines = 2;
    
//    UILabel * dateLabel = [self.contentView addLabelWithFrame:CGRectMake(105, 70, 70, 25) text:EGLocalizedString(@"活动日期", nil)];
//    UILabel * dateLabel = [self.contentView addLabelWithFrame:CGRectMake(_titleLabel.frame.origin.x, 70, 70, 25) text:EGLocalizedString(@"活动日期", nil)];
//    dateLabel.font = [UIFont systemFontOfSize:11];
//    dateLabel.textColor = [UIColor grayColor];
    
    
    _date = [self.contentView addLabelWithFrame:CGRectMake(_titleLabel.frame.origin.x, 68, 100, 30) text:nil];
    _date.font = [UIFont systemFontOfSize:11];
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
