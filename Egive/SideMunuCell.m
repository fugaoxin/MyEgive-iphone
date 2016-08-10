//
//  SideMunuCell.m
//  Egive
//
//  Created by sino on 15/7/20.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "SideMunuCell.h"
#import "UIView+ZJQuickControl.h"
@implementation SideMunuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createrUI];
    }
    return self;
}

- (void)createrUI{
    
    _iconImage = [self.contentView addImageViewWithFrame:CGRectMake(10, 5, 35, 35) image:nil];
    
    _titelLabel = [self.contentView addLabelWithFrame:CGRectMake(55, 5, 150, 35) text:nil];
    _titelLabel.font = [UIFont systemFontOfSize:15];

    
}

//自定义分割线
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //上分割线， CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"ffffff"].CGColor); CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
    //下分割线
       CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor); CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width , 0.5));

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
