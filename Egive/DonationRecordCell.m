//
//  DonationRecordCell.m
//  Egive
//
//  Created by sino on 15/8/21.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "DonationRecordCell.h"
#import "UIView+ZJQuickControl.h"

#define ScreenSize [UIScreen mainScreen].bounds.size
@implementation DonationRecordCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    _title = [self.contentView addLabelWithFrame:CGRectMake(10, 5, ScreenSize.width - 90, 30) text:nil];
    _title.font = [UIFont boldSystemFontOfSize:14];
    
    _date = [self.contentView addLabelWithFrame:CGRectMake(10,30, 100, 25) text:nil];
    _date.textColor = [UIColor grayColor];
    _date.font = [UIFont systemFontOfSize:12];
    
    _money = [self.contentView addLabelWithFrame:CGRectMake(100, 20, ScreenSize.width-110, 25) text:nil];
    _money.font = [UIFont systemFontOfSize:14];
    _money.textAlignment = NSTextAlignmentRight;
    _money.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
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
