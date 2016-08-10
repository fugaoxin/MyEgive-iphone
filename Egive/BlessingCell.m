//
//  BlessingCell.m
//  Egive
//
//  Created by sino on 15/9/2.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "BlessingCell.h"
#import "UIView+ZJQuickControl.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@implementation BlessingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        
    }
    return self;
}

- (void)createUI {
    
    _commentWv = [[UIWebView alloc] init];
    _commentWv.frame = CGRectMake(11, 40, ScreenSize.width-22, 110);
    _commentWv.contentMode = UIViewContentModeScaleAspectFit;
    _commentWv.scrollView.scrollEnabled = NO;
    _commentWv.scrollView.bounces = NO;
    _commentWv.userInteractionEnabled = NO;
    //    _commentWv.opaque = NO;
    _commentWv.backgroundColor = [UIColor whiteColor];
    _commentWv.layer.cornerRadius = 5;
    [self.contentView addSubview:_commentWv];
    
    _commentDate = [self.contentView addLabelWithFrame:CGRectMake(ScreenSize.width/2, 5, ScreenSize.width/2-10, 25) text:nil];
    _commentDate.textColor = [UIColor grayColor];
    _commentDate.textAlignment = NSTextAlignmentRight;
    _commentDate.font = [UIFont systemFontOfSize:13];
    
    _view = [[UIView alloc] initWithFrame:CGRectMake(10, 30, ScreenSize.width-20, 120)];
    _view.layer.cornerRadius = 5;
    _view.layer.borderWidth = 1;
    _view.layer.borderColor = [[UIColor grayColor] CGColor];
    _view.layer.masksToBounds = YES;
    [self.contentView addSubview:_view];
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-20, 40)];
    bgView.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    [_view addSubview:bgView];
    
    _userIcon = [self.contentView addImageViewWithFrame:CGRectMake(20, 10, 76, 76) image:nil];
    _userIcon.layer.cornerRadius = 38;
    _userIcon.layer.masksToBounds = YES;
    _userIcon.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    
    
    _deleteComment = [[MyBtn alloc] init];
    _deleteComment.frame = CGRectMake(ScreenSize.width-55, 7, 25, 25);
    [_deleteComment setBackgroundImage:[UIImage imageNamed:@"bless_delete@2x.png"] forState:UIControlStateNormal];
    [bgView addSubview:_deleteComment];
    
    //    _comment = [view addLabelWithFrame:CGRectMake(10, 55, ScreenSize.width-35, 40) text:nil];
    //    _comment.font = [UIFont systemFontOfSize:14];
    //    _comment.numberOfLines = 3;
    
    
    _memberName = [bgView addLabelWithFrame:CGRectMake(100, 5, 200, 30) text:nil];
    _memberName.font = [UIFont systemFontOfSize:14];
    _memberName.textColor = [UIColor whiteColor];
    
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
