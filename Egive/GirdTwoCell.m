//
//  GirdTwoCell.m
//  Egive
//
//  Created by sino on 15/8/13.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "GirdTwoCell.h"
#import "UIView+ZJQuickControl.h"
#import "EGUtility.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@implementation GirdTwoCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

#pragma  mark - Bar1
- (void)createUI{
    
    _showImage = [self.contentView addImageViewWithFrame:CGRectMake(0, 0, ScreenSize.width/2-50, 100) image:@"dummy_case_related_default@2x.png"];
    _showImage.contentMode = UIViewContentModeScaleAspectFit;
    
    _succeedImage = [self.contentView addImageViewWithFrame:CGRectMake(0, 0, 40, 40) image:@"comment_poster_complete@2x.png"];
    _succeedImage.hidden = YES;
    
    UILabel * succeedLabel = [_succeedImage addLabelWithFrame:CGRectMake(-4, 8, 40, 15) text:EGLocalizedString(@"筹募", nil)];
    succeedLabel.textAlignment = NSTextAlignmentCenter;
    succeedLabel.font = [UIFont systemFontOfSize:7];
    succeedLabel.textColor = [UIColor whiteColor];
    succeedLabel.transform = CGAffineTransformMakeRotation(-M_PI/4);
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(ScreenSize.width/2-50, 0,ScreenSize.width-(ScreenSize.width/2-40),75)];
    _bgView.hidden = YES;
    [self.contentView addSubview:_bgView];

    [self styleBar2];
    
    
    _titleLabel = [_bgView addLabelWithFrame:CGRectMake(10, 0, 150, 25) text:nil];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    
    _typeImage = [_bgView addImageViewWithFrame:CGRectMake(_bgView.frame.size.width -25, 0, 25, 25) image:@"comment_poster_type_poverty.png"];
    
    UILabel * label = [_bgView addLabelWithFrame:CGRectMake(10, 25, 60, 25) text:EGLocalizedString(@"GirdView_atm_label", nil)];
    label.font = [UIFont boldSystemFontOfSize:13];
    label.textColor = [UIColor grayColor];
    
    _moneyLabel = [_bgView addLabelWithFrame:CGRectMake(65, 25, 120, 25) text:nil];
    _moneyLabel.font = [UIFont boldSystemFontOfSize:14];
    _moneyLabel.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:0.8];
    
    
    _progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progress.frame = CGRectMake(10, 60,_bgView.frame.size.width-50, 0);
    _progress.layer.cornerRadius = 3;
    _progress.layer.masksToBounds = YES;
    _progress.transform = CGAffineTransformMakeScale(1.0f,3.0f);
    //设置进度条左边的进度颜色
//    [_progress setProgressTintColor:[UIColor colorWithRed:255/255.0 green:175/255.0 blue:35/255.0 alpha:1]];
    [_progress setProgressTintColor:[UIColor colorWithRed:199/255.0 green:78/255.0 blue:102/255.0 alpha:1]];
    //设置进度条右边的进度颜色
    [_progress setTrackTintColor:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1]];
//    [_progress setTrackTintColor:[UIColor blackColor]];
    [_bgView addSubview:_progress];

    _progressImg = [_bgView addImageViewWithFrame:CGRectMake(0, 48,25, 25) image:@"comment_progress_run_1@2x.png"];
    
//    [_bgView addImageViewWithFrame:CGRectMake(_bgView.frame.size.width-50, 52, 15, 15) image:@"comment_progress_heart_nor@2x.png"];
    
//    _heartImg = [_bgView addImageViewWithFrame:CGRectMake(_bgView.frame.size.width-50, 52, 15, 15) image:@"comment_progress_heart_complete@3x.png"];
    _heartImg = [[UIImageView alloc]initWithFrame:CGRectMake(_bgView.frame.size.width-50, 52, 15, 15)];
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
    [_bgView addSubview:_heartImg];

    
    _proLabel = [_bgView addLabelWithFrame:CGRectMake(_bgView.frame.size.width-30, 44, 50, 30) text:nil];
    _proLabel.font = [UIFont systemFontOfSize:13];

    
    _attentionButton = [[MyBtn alloc] init];
    _attentionButton.frame = CGRectMake(ScreenSize.width/2-50, 75, (ScreenSize.width-(ScreenSize.width/2-50))/2-1, 25);
    [_attentionButton setImage:[UIImage imageNamed:@"comment_list_favourite@2x.png"] forState:UIControlStateNormal];
    [_attentionButton setTitle:EGLocalizedString(@"GirdView_attention1_label", nil) forState:UIControlStateNormal];
    [_attentionButton setTitle:EGLocalizedString(@"GirdView_attention2_label", nil) forState:UIControlStateSelected];
    _attentionButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _attentionButton.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:0.8];
    [self.contentView addSubview:_attentionButton];
    
    
    _donationButton = [[MyBtn alloc] init];
    _donationButton.frame = CGRectMake((ScreenSize.width-(ScreenSize.width/2-50))/2+(ScreenSize.width/2-50), 75, (ScreenSize.width-120)/2-1, 25);
    [_donationButton setImage:[UIImage imageNamed:@"comment_list_cart_nor@2x.png"] forState:UIControlStateNormal];
    [_donationButton setTitle:EGLocalizedString(@"GirdView_donate_button", nil) forState:UIControlStateNormal];
    _donationButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _donationButton.backgroundColor = [UIColor colorWithRed:105/255.0 green:48/255.0 blue:142/255.0 alpha:0.8];
    [self.contentView addSubview:_donationButton];
    
}

#pragma mark - bar2
- (void)styleBar2{
    
    _bgView1 = [[UIView alloc] initWithFrame:CGRectMake(ScreenSize.width/2-50, 0,ScreenSize.width-(ScreenSize.width/2-40),75)];
    [self.contentView addSubview:_bgView1];
    
    _titleLabel1 = [_bgView1 addLabelWithFrame:CGRectMake(10, 0, 150, 25) text:nil];
    _titleLabel1.font = [UIFont systemFontOfSize:13];
    
    _typeImage1 = [_bgView1 addImageViewWithFrame:CGRectMake(_bgView1.frame.size.width -35, 0, 25, 25) image:@"comment_poster_type_education.png"];
    
    UILabel * label = [_bgView1 addLabelWithFrame:CGRectMake(10, 25, 60, 25) text:EGLocalizedString(@"GirdView_target_label", nil)];
    label.font = [UIFont boldSystemFontOfSize:13];
    label.textColor = [UIColor grayColor];
    
    _goalMoney = [_bgView1 addLabelWithFrame:CGRectMake(65, 25, 120, 25) text:nil];
    _goalMoney.font = [UIFont boldSystemFontOfSize:14];
    _goalMoney.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:0.8];
    
    
//    _timeLabel = [_bgView1 addLabelWithFrame:CGRectMake(10, 50, 75, 25) text:EGLocalizedString(@"GirdView_time_label", nil)];
//    _timeLabel.font = [UIFont systemFontOfSize:13];
//    _timeLabel.textColor = [UIColor grayColor];
    
//    _time = [_bgView1 addLabelWithFrame:CGRectMake(80, 50, 60, 25) text:nil];
    _time = [_bgView1 addLabelWithFrame:CGRectMake(10, 50, 120, 25) text:nil];
    _time.font = [UIFont systemFontOfSize:14];
    
    _sponsorCount = [_bgView1 addLabelWithFrame:CGRectMake(_bgView1.frame.size.width-85, 50, 60, 25) text:EGLocalizedString(@"GirdView_count_label", nil)];
    _sponsorCount.font = [UIFont systemFontOfSize:13];
    _sponsorCount.textColor = [UIColor grayColor];
    
    _count = [_bgView1 addLabelWithFrame:CGRectMake(_bgView1.frame.size.width-25, 50, 40, 25) text:nil];
    _count.font = [UIFont systemFontOfSize:14];

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
