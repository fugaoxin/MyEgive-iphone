//
//  ReleaseCenterCell.m
//  Egive
//
//  Created by sino on 15/8/19.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ReleaseCenterCell.h"
#import "UIView+ZJQuickControl.h"
#import "EGUtility.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@implementation ReleaseCenterCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {

    UILabel * dateLabel = [self.contentView addLabelWithFrame:CGRectMake(6, 0, 100, 25) text:EGLocalizedString(@"活动日期", nil)];
    dateLabel.font = [UIFont systemFontOfSize:14];
    dateLabel.textColor = [UIColor grayColor];

    _date = [self.contentView addLabelWithFrame:CGRectMake(100,0, 100, 25) text:nil];
    _date.font = [UIFont systemFontOfSize:14];
    
    _title = [self.contentView addLabelWithFrame:CGRectMake(5, 25, ScreenSize.width-10, 50) text:nil];
    _title.numberOfLines=2;
    _title.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    _title.font = [UIFont boldSystemFontOfSize:15];

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
