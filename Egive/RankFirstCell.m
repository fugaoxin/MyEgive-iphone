//
//  RankFirstCell.m
//  Egive
//
//  Created by sino on 15/8/18.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "RankFirstCell.h"
#import "UIView+ZJQuickControl.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@implementation RankFirstCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createFirstUI];
    }
    return self;
}

- (void)createFirstUI{
    [self.contentView addImageViewWithFrame:CGRectMake(5, 15, 70, 70) image:@"ranking_photo_first@2x.png"];
    _userImage = [self.contentView addImageViewWithFrame:CGRectMake(10, 20, 60, 60) image:nil];
    _userImage.layer.cornerRadius = 30;
    _userImage.layer.masksToBounds = YES;
    
    _title = [self.contentView addLabelWithFrame:CGRectMake(80, 20, ScreenSize.width-150, 50) text:nil];
    _title.numberOfLines=2;
    //_title.backgroundColor = [UIColor redColor];
    _title.font = [UIFont boldSystemFontOfSize:15];
    _title.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    
    _amount = [self.contentView addLabelWithFrame:CGRectMake(80, 60, 200, 30) text:nil];
    _amount.font = [UIFont boldSystemFontOfSize:15];
    _amount.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    
    [self.contentView addImageViewWithFrame:CGRectMake(ScreenSize.width-75, 0, 65, 86) image:@"ranking_first@2x.png"];
    
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
