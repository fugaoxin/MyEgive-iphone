//
//  MyBtn.h
//  Leying
//
//  Created by qianfeng on 15-6-9.
//  Copyright (c) 2015年 ZXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBtn : UIButton

@property(copy,nonatomic)void(^action)(MyBtn *btn);

@property(assign,nonatomic)BOOL myflag;


@end
