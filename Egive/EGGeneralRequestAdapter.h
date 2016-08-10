//
//  EGGeneralRequestAdapter.h
//  Egive
//
//  Created by sinogz on 15/9/4.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EGUtility.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "NSString+RegexKitLite.h"

@interface EGGeneralRequestAdapter : NSObject

+ (void)postWithSoapMsg:(NSString *)soapMsg success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+ (void)postWithSoapMsg1:(NSString *)soapMsg success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)postWithHttpsConnection:(BOOL)safe soapMsg:(NSString *)soapMsg success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end
