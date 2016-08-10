//
//  MyBtn.m
//  Leying
//
//  Created by qianfeng on 15-6-9.
//  Copyright (c) 2015年 ZXJ. All rights reserved.
//

#import "MyBtn.h"

@implementation MyBtn


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    [self addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}
//- (void)layoutSubviews
//{
//    [self addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//}
- (void)btnClick
{
    if (self.action) {
        self.action(self);
    }
}
@end
