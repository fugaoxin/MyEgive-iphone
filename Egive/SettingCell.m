//
//  SettingCell.m
//  Egive
//
//  Created by sino on 15/7/30.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "SettingCell.h"
#import "UIView+ZJQuickControl.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@implementation SettingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    _titleLabel = [self.contentView addLabelWithFrame:CGRectMake(20, 20, 250, 30) text:nil];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    _swith = [[UISwitch alloc] initWithFrame:CGRectMake(ScreenSize.width-80, 20, 0, 0)];
    [self.contentView addSubview:_swith];
    
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
