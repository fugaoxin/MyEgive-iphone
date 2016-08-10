//
//  EGShoppingCartCell.h
//  Egive
//
//  Created by sinogz on 15/9/11.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGUtility.h"
#import "EGShoppingCart.h"

@class EGShoppingCartCell;
typedef void(^CheckedBlock)(EGShoppingCartCell *cell, BOOL isChecked);
typedef void(^SaveShoppingCartItemBlock)(EGShoppingCartCell *cell, NSInteger tag);

@protocol EGShoppingCartCellDataSource<NSObject>

- (BOOL)donateWithCharge;
- (NSString *)Location;
- (NSInteger)numberOfCheckedItems;

@end

@interface EGShoppingCartCell : UIView <UITextFieldDelegate>
@property (nonatomic, assign)UILabel * tipLabel2;
@property (nonatomic, strong) EGShoppingCart *item;
@property (nonatomic, assign) NSInteger donateAmt;
@property (nonatomic, assign) NSInteger receiveAmt;
@property (nonatomic, strong) UITextField * textField;

@property (nonatomic, assign) BOOL IsChecked;
@property (nonatomic, assign) NSInteger numberOfCheckedItems;
@property (nonatomic, assign) CGFloat rate;
@property (nonatomic, assign) BOOL donateWithCharge;

@property (nonatomic, strong) UIButton *checkBox;
@property (nonatomic, copy) CheckedBlock checkedBlock;
@property (nonatomic, copy) SaveShoppingCartItemBlock saveShoppingCartItemBlock;
@property (nonatomic, assign) id<EGShoppingCartCellDataSource> dataSource;

- (id)initWithFrame:(CGRect)frame item:(EGShoppingCart *)item;
- (id)initWithFrame:(CGRect)frame item:(EGShoppingCart *)item block:(SaveShoppingCartItemBlock)block;
- (void)updateDonateAmt;
- (void)reloadData;
@end
