//
//  GirdViewCell.m
//  Egive
//
//  Created by sino on 15/8/5.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "GirdViewCell.h"
#import "UIView+ZJQuickControl.h"
#import "EGUtility.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@implementation GirdViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
 
    }
    return self;
}

#pragma  mark - Bar1
- (void)createUI{
    _showImage = [self.contentView addImageViewWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.width/4*3) image:@"dummy_case_related_default@2x.png"];
//    _showImage.contentMode = UIViewContentModeScaleAspectFit;
    _succeedImage = [self.contentView addImageViewWithFrame:CGRectMake(0, 0, 75, 75) image:@"comment_poster_complete@2x.png"];
    _succeedImage.hidden = YES;
    
    UILabel * succeedLabel = [_succeedImage addLabelWithFrame:CGRectMake(-5, 20, 70, 20) text:EGLocalizedString(@"筹募", nil)];
    succeedLabel.textAlignment = NSTextAlignmentCenter;
    succeedLabel.font = [UIFont systemFontOfSize:12];
    succeedLabel.textColor = [UIColor whiteColor];
    succeedLabel.transform = CGAffineTransformMakeRotation(-M_PI/4);

    _favouriteButton = [[MyBtn alloc] init];
    _favouriteButton.frame = CGRectMake(0, 0, 45, 45);
    [_favouriteButton setBackgroundImage:[UIImage imageNamed:@"comment_poster_favourite_nor.png"] forState:UIControlStateNormal];
    [_favouriteButton setBackgroundImage:[UIImage imageNamed:@"comment_poster_favourite_sel.png"] forState:UIControlStateSelected];
    [self.contentView addSubview:_favouriteButton];
    
    
    
   _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 155,ScreenSize.width,55)];
    _bgView.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:0.8];
    [self.contentView addSubview:_bgView];
    
    [self styleView];
    
    _typeImage = [_bgView addImageViewWithFrame:CGRectMake(2, 14, 30, 30) image:nil];
    
    _titleLabel = [_bgView addLabelWithFrame:CGRectMake(40,5, ScreenSize.width/2, 25) text:nil];
    //    _titleLabel = [bgView addLabelWithFrame:CGRectMake(40, 0, 150, 40) text:@"Elderly Community Care & Suport"];
    _titleLabel.font = [UIFont boldSystemFontOfSize:13];
    _titleLabel.numberOfLines = 2;
    _titleLabel.textColor = [UIColor whiteColor];
    
    _progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progress.frame = CGRectMake(40, 42,ScreenSize.width/2-45, 0);
    _progress.layer.cornerRadius = 3;
    _progress.layer.masksToBounds = YES;
    _progress.transform = CGAffineTransformMakeScale(1.0f,3.0f);
    //设置进度条左边的进度颜色
    [_progress setProgressTintColor:[UIColor colorWithRed:255/255.0 green:175/255.0 blue:35/255.0 alpha:1]];
    //设置进度条右边的进度颜色
    [_progress setTrackTintColor:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1]];
    [_bgView addSubview:_progress];
    
    _progressImg = [_bgView addImageViewWithFrame:CGRectMake(25, 30,25, 25) image:@"comment_progress_run_1@2x.png"];
    

    //_heartImg = [_bgView addImageViewWithFrame:CGRectMake(ScreenSize.width/2-10, 34, 15, 15) image:@"comment_progress_heart_complete@3x.png"];
    
    //创建imageView
    _heartImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenSize.width/2-10, 34, 15, 15)];
    //把图片添加到动态数组
    NSMutableArray * animateArray = [[NSMutableArray alloc]initWithCapacity:2];
    [animateArray addObject:[UIImage imageNamed:@"comment_progress_heart_nor"]];
    [animateArray addObject:[UIImage imageNamed:@"comment_progress_heart_mid"]];
    [animateArray addObject:[UIImage imageNamed:@"comment_progress_heart_complete"]];
    //为图片设置动态
    _heartImg.animationImages = animateArray;
    //为动画设置持续时间
    _heartImg.animationDuration = 0.5;
    //为默认的无限循环
    _heartImg.animationRepeatCount = 0;
    //开始播放动画
    //[_heartImg startAnimating];

    [_bgView addSubview:_heartImg];

    
    _proLabel = [_bgView addLabelWithFrame:CGRectMake(ScreenSize.width/2+10, 27, 50, 30) text:nil];
    _proLabel.font = [UIFont boldSystemFontOfSize:12];
    _proLabel.textColor = [UIColor whiteColor];
    
    [_bgView addImageViewWithFrame:CGRectMake(ScreenSize.width/2+50, 5, 1, 45) image:@"case_separ_line@2x.png"];
    
    UILabel * label = [_bgView addLabelWithFrame:CGRectMake(ScreenSize.width/2+55, 5, 60, 25) text:EGLocalizedString(@"GirdView_atm_label", nil)];
    label.font = [UIFont boldSystemFontOfSize:13];
    label.textColor = [UIColor whiteColor];
    
    _moneyLabel = [_bgView addLabelWithFrame:CGRectMake(ScreenSize.width/2+55, 30, 80, 25) text:nil];
    _moneyLabel.font = [UIFont boldSystemFontOfSize:14];
    _moneyLabel.textColor = [UIColor whiteColor];
    
    //    _iconButton = [bgView addImageButtonWithFrame:CGRectMake(ScreenSize.width-40, 18, 25, 25) title:nil backgroud:@"comment_poster_cart_nor@2x.png" action:^(UIButton *button) {
    //
    //        if (button.selected) {
    //            button.selected = NO;
    //        }else{
    //            button.selected = YES;
    //        }
    //
    //    }];
    
    _button = [[MyBtn alloc] init];
    _button.frame = CGRectMake(ScreenSize.width-40, 170, 30, 30);
    [_button setBackgroundImage:[UIImage imageNamed:@"comment_poster_cart_nor@2x.png"] forState:UIControlStateNormal];
    [_button setBackgroundImage:[UIImage imageNamed:@"comment_poster_cart_sel@2x.png"] forState:UIControlStateSelected];
    [self.contentView addSubview:_button];
}

#pragma mark - Bar2
- (void)styleView{
    
    _bgView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 155,ScreenSize.width,55)];\
    _bgView1.hidden = YES;
    _bgView1.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:0.8];
    [self.contentView addSubview:_bgView1];
    
    _typeImage1 = [_bgView1 addImageViewWithFrame:CGRectMake(2, 14, 30, 30) image:nil];
    _titleLabel1 = [_bgView1 addLabelWithFrame:CGRectMake(40,5, ScreenSize.width/2, 25) text:nil];
    //    _titleLabel = [bgView addLabelWithFrame:CGRectMake(40, 0, 150, 40) text:@"Elderly Community Care & Suport"];
    _titleLabel1.font = [UIFont boldSystemFontOfSize:13];
    _titleLabel1.numberOfLines = 2;
    _titleLabel1.textColor = [UIColor whiteColor];
    
    [_bgView1 addImageViewWithFrame:CGRectMake(ScreenSize.width/2+50, 5, 1, 45) image:@"case_separ_line@2x.png"];
    
    UILabel * label = [_bgView1 addLabelWithFrame:CGRectMake(ScreenSize.width/2+60, 5, 60, 25) text:EGLocalizedString(@"GirdView_target_label", nil)];
    label.font = [UIFont boldSystemFontOfSize:13];
    label.textColor = [UIColor whiteColor];
    
//    _timeLabel = [_bgView1 addLabelWithFrame:CGRectMake(40,30, 65, 25) text:EGLocalizedString(@"GirdView_time_label", nil)];
//    //    _titleLabel = [bgView addLabelWithFrame:CGRectMake(40, 0, 150, 40) text:@"Elderly Community Care & Suport"];
//    _timeLabel.font = [UIFont boldSystemFontOfSize:12];
//    _timeLabel.textColor = [UIColor whiteColor];
    
//    _time = [_bgView1 addLabelWithFrame:CGRectMake(92,30, 60, 25) text:nil];
    _time = [_bgView1 addLabelWithFrame:CGRectMake(40,30, 120, 25) text:nil];
    _time.font = [UIFont boldSystemFontOfSize:12];
    _time.textColor = [UIColor whiteColor];
    
    _sponsorCount = [_bgView1 addLabelWithFrame:CGRectMake(ScreenSize.width/2-30,30, 60, 25) text:EGLocalizedString(@"GirdView_count_label", nil)];
    _sponsorCount.font = [UIFont boldSystemFontOfSize:12];
    _sponsorCount.textAlignment = NSTextAlignmentRight;
    _sponsorCount.textColor = [UIColor whiteColor];
    
    _count = [_bgView1 addLabelWithFrame:CGRectMake(ScreenSize.width/2+30,30, 60, 25) text:nil];
    _count.font = [UIFont boldSystemFontOfSize:12];
    _count.textColor = [UIColor whiteColor];
    
    _goalMoney = [_bgView1 addLabelWithFrame:CGRectMake(ScreenSize.width/2+60, 30, 100, 25) text:nil];
    _goalMoney.font = [UIFont boldSystemFontOfSize:13];
    _goalMoney.textColor = [UIColor whiteColor];
    

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _showImage.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _bgView.frame = CGRectMake(0, self.frame.size.height - 55, self.frame.size.width, 55);
    _bgView1.frame = CGRectMake(0, self.frame.size.height - 55, self.frame.size.width, 55);
    _button.frame = CGRectMake(ScreenSize.width-40, self.frame.size.height - 50, 30, 30);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
