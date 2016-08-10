//
//  EGShoppingCart.h
//  Egive
//
//  Created by sinogz on 15/9/11.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGAbstractModel.h"

@interface EGShoppingCart : EGAbstractModel

@property (nonatomic, copy) NSString *CaseID;
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, assign) BOOL IsChecked;
@property (nonatomic, assign) NSInteger PayOption1;
@property (nonatomic, assign) NSInteger PayOption2;
@property (nonatomic, assign) NSInteger PayOption3;
@property (nonatomic, assign) NSInteger SelectedOption;

@property (nonatomic, copy) NSString *ItemMsg;
@property (nonatomic, assign) NSInteger DonateAmt;
@property (nonatomic, assign) NSInteger ReceiveAmt;
@property (nonatomic, assign) NSInteger MinDonateAmt;

@end
