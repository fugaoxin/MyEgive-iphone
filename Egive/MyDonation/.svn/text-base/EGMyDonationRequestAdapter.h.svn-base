//
//  EGMyDonationRequestAdapter.h
//  Egive
//
//  Created by sinogz on 15/9/11.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGGeneralRequestAdapter.h"
#import "EGGetDonationRecordResult.h"
#import "EGGetAndSaveShoppingCartResult.h"
#import "EGMyDonationRequest.h"


@interface EGMyDonationRequestAdapter : EGGeneralRequestAdapter

// 7.
+ (void)getDonationRecordWithMemberID:(NSString *)memberID DonationID:(NSString*)DonationID success:(void (^)(EGGetDonationRecordResult *result))success failure:(void (^)(NSError *))failure;
// 4.
+ (void)getShoppingCartDisclaimerWithLocationCode:(NSString *)LocationCode memberID:(NSString *)memberID success:(void (^)(NSString *result))success failure:(void (^)(NSError *error))failure;
// 3.
+ (void)getGetAndSaveShoppingCart:(EGGetAndSaveShoppingCartRequest *)request success:(void (^)(EGGetAndSaveShoppingCartResult *result))success failure:(void (^)(NSError *error))failure;
// 5.
+ (void)saveShoppingCartItem:(EGSaveShoppingCartItemRequest *)request success:(void (^)(NSString *result))success failure:(void (^)(NSError *error))failure;
// 6.
+ (void)checkOutShoppingCart:(EGCheckOutShoppingCartRequest *)request success:(void (^)(NSString *result))success failure:(void (^)(NSError *error))failure;
@end
