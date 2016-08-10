//
//  EGSwitch.m
//  Egive
//
//  Created by sinogz on 15/9/13.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGSwitch.h"

@implementation EGSwitch

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame onTitle:(NSString *)onTitle offTitle:(NSString *)offTitle
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:onTitle forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"comment_segment_left_nor.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"comment_segment_left_sel.png"] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.selected = YES;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor colorWithRed:70.0/255.0 green:180.0/255.0 blue:4.0/255.0 alpha:1] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:button];
    return self;
}

- (void)btnClicked:(UIButton *)button
{
    
    
}


- (void)setOn:(BOOL)on animated:(BOOL)animated
{
    
}

@end
