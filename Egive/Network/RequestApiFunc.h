//
//  RequestApiFunc.h
//  Egive
//
//  Created by sino on 15/8/31.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface RequestApiFunc : NSObject
@property (copy, nonatomic) NSString * dataString;

- (NSString *)requestApiData:(NSString *)soapMessage;
@end
