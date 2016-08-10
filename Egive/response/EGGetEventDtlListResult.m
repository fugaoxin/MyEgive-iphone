//
//  EGGetEventDtlListResult.m
//  Egive
//
//  Created by sinogz on 15/9/4.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGGetEventDtlListResult.h"

@implementation EGGetEventDtlListResult

MJLogAllIvars;

+(NSDictionary *)objectClassInArray
{
    return @{@"ItemList":[EGEventDtl class]};
}

@end
