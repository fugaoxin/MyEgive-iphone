//
//  CALayer+EGIVE.m
//  Egive
//
//  Created by sinogz on 15/9/8.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "CALayer+EGIVE.h"

@implementation CALayer (EGIVE)

- (void)addAnimation:(CAAnimation *)anim andValue:(NSValue *)value forKeyPath:(NSString *)keyPath
{
    [self addAnimation:anim forKey:keyPath];
    [self setValue:value forKeyPath:keyPath];
}

@end
