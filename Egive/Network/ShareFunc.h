//
//  ShareFunc.h
//  HKGTA
//
//  Created by lufei on 15/8/3.
//  Copyright (c) 2015年 香港. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface ShareFunc : NSObject

@property (nonatomic, strong)AFHTTPSessionManager *HTTPSessionManager;
@property (nonatomic, strong)NSDictionary *agentDataDict;
@property (copy, nonatomic) NSString * dataString;

- (NSString *)requestApiData:(NSString *)inputField;
+ (ShareFunc *)shared;
+ (void)checkNetWorkStatus;

@end
