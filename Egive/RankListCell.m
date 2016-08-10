//
//  RankListCell.m
//  Egive
//
//  Created by sino on 15/7/29.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "RankListCell.h"
#import "UIView+ZJQuickControl.h"
@implementation RankListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    _image = [self.contentView addImageViewWithFrame:CGRectMake(20, 10, 60, 86) image:nil];
    _title = [self.contentView addLabelWithFrame:CGRectMake(115, 35, 200, 40) text:nil];
    _title.numberOfLines =2;
    _title.font = [UIFont boldSystemFontOfSize:15];
    _title.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];

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
