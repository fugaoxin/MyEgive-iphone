//
//  EGMyDonationRequest.h
//  Egive
//
//  Created by sinogz on 15/9/11.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EGUtility.h"

@interface EGMyDonationRequest : NSObject

@property (nonatomic, assign) NSInteger StartRowNo;
@property (nonatomic, assign) NSInteger NumberOfRows;

@end

/**
 * 3.GetAndSaveShoppingCart
 * Must provide either MemberID or CookieID.
 * If both MemberID and CookieID are provided, system will refer to MemberID
 */
@interface EGGetAndSaveShoppingCartRequest : EGMyDonationRequest

@property (nonatomic, assign) AppLang lang;
@property (nonatomic, copy) NSString *LocationCode;
@property (nonatomic, assign) BOOL DonateWithCharge;
@property (nonatomic, copy) NSString *MemberID;
@property (nonatomic, copy) NSString *CookieID;
@end

/**
 * 5.SaveShoppingCartItem
 * Must provide either MemberID or CookieID. 
 * If both MemberID and CookieID are provided, system will refer to MemberID
 */
@interface EGSaveShoppingCartItemRequest : NSObject
@property (nonatomic, copy) NSString *MemberID;
@property (nonatomic, copy) NSString *CookieID;
@property (nonatomic, copy) NSString *CaseID;

@property (nonatomic, assign) NSInteger DonateAmt;
@property (nonatomic, assign) BOOL IsChecked;

@end

/**
 * 6.CheckOutShoppingCart
 * Save donation and receipt information before proceeding to paypal.
 */
@interface EGCheckOutShoppingCartRequest : NSObject
@property (nonatomic, copy) NSString *MemberID;
@property (nonatomic, copy) NSString *CookieID;
@property (nonatomic, copy) NSString *DisplayName;
@property (nonatomic, copy) NSString *NameOnReceipt;
@property (nonatomic, copy) NSString *Email;
@property (nonatomic, copy) NSString *AppToken;

@end
