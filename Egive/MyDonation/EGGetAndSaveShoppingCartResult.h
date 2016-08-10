//
//  EGGetAndSaveShoppingCartResult.h
//  Egive
//
//  Created by sinogz on 15/9/11.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGShoppingCart.h"

@interface EGGetAndSaveShoppingCartResult : NSObject

@property (nonatomic, copy) NSString *MemberID;
@property (nonatomic, copy) NSString *CookieID;
@property (nonatomic, assign) NSInteger NumberOfItems;
@property (nonatomic, assign) BOOL DonateWithCharge;
@property (nonatomic, copy) NSString *Location;
@property (nonatomic, strong) NSMutableArray *ItemList;

@property (nonatomic, assign) NSInteger TotalDonateAmt;
@property (nonatomic, assign) NSInteger TotalReceiveAmt;

@end
