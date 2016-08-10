//
//  EGGetEventDtlListResult.h
//  Egive
//
//  Created by sinogz on 15/9/4.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EGEventDtl.h"

@interface EGGetEventDtlListResult : NSObject
@property (nonatomic, assign) NSInteger TotalNumberOfItems;
@property (nonatomic, strong) NSArray *ItemList;
@end
