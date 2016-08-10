//
//  MyRegisterButton.m
//  Egive
//
//  Created by zxj on 15/11/19.
//  Copyright © 2015年 sino. All rights reserved.
//

#import "MyRegisterButton.h"

@implementation MyRegisterButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews
{
    [self addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)btnClick
{
    if (self.action){
        
        self.action(self);
        
    }
}

@end
