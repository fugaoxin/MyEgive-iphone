//
//  EGDIRequestAdapter.h
//  Egive
//
//  Created by sinogz on 15/9/4.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGGeneralRequestAdapter.h"
#import "EGGetEventDtlListResult.h"
#import "EGGetAnnouncementCentreListResult.h"

@interface EGDIRequestAdapter : EGGeneralRequestAdapter

+ (void)getEventDtlListWithSoapMsg:(NSString *)soapMsg success:(void (^)(EGGetEventDtlListResult *result))success failure:(void (^)(NSError *error))failure;
+ (void)getAnnouncementCentreListWithLang:(AppLang)lang success:(void (^)(EGGetAnnouncementCentreListResult *))success failure:(void (^)(NSError *))failure;
@end
