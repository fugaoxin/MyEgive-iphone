//
//  ForeshowCell.m
//  Egive
//
//  Created by sino on 15/8/19.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "Constants.h"
#import "ForeshowCell.h"
#import "UIView+ZJQuickControl.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@implementation ForeshowCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellID = @"foreshowCell";
    ForeshowCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ForeshowCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    return cell;
}


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
    _titleLabel.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.numberOfLines = 2;
    
    
    _conten = [self.contentView addLabelWithFrame:CGRectMake(_titleLabel.frame.origin.x, 40, ScreenSize.width-135, 30) text:nil];
    _conten.font = [UIFont systemFontOfSize:13];
    _conten.numberOfLines = 2;
    
    _dateLabel = [self.contentView addLabelWithFrame:CGRectMake(_titleLabel.frame.origin.x, 70, ScreenSize.width-135, 25) text:nil];
    _dateLabel.font = [UIFont systemFontOfSize:13];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //上分割线， CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"ffffff"].CGColor); CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor); CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width , 0.5));
    
}

- (void)setEventDtl:(EGEventDtl *)eventDtl
{
    _eventDtl = eventDtl;
    
    if (_eventDtl.Img.count) {
        NSString *ImgURL = eventDtl.Img[0][@"ImgURL"];
        NSURL *url = [NSURL URLWithString:SITE_URL];
        url = [url URLByAppendingPathComponent:ImgURL];
        [self.leftImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
//        self.leftImage.contentMode = UIViewContentModeScaleAspectFit;
    } else {
        //img is nil
        self.leftImage.image = [UIImage imageNamed:@"dummy_case_related_default@2x.png"];
        self.leftImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    self.titleLabel.text = eventDtl.Title;
    self.conten.text = eventDtl.Desp;
    
    \
    
    
    if (self.eventDtl.EventStartDate.length != 0) {
       
        
         _str1 = [self.eventDtl.EventStartDate substringToIndex:[self.eventDtl.EventStartDate length]/2+1];
    }
    
   

    
    if (self.eventDtl.EventEndDate.length != 0) {
    _str2 = [self.eventDtl.EventEndDate substringToIndex:[self.eventDtl.EventEndDate length]/2+1];
    //NSLog(@"%@",str1);
        
        
    }
    
    if ([_str1 isEqualToString:_str2] ||self.eventDtl.EventStartDate.length== 0 || self.eventDtl.EventEndDate.length == 0){
        
        self.dateLabel.text = [NSString stringWithDataString:self.eventDtl.EventStartDate];
        
    }else{
        
        self.dateLabel.text = [NSString stringWithFormat:@"%@ - %@",[NSString stringWithDataString:self.eventDtl.EventStartDate],[NSString stringWithDataString:self.eventDtl.EventEndDate]];
    }

    
   //    self.dateLabel.text = [NSString stringWithDataString:eventDtl.EventStartDate];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
