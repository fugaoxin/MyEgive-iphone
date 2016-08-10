//
//  EGDropDownMenu.h
//  Egive
//
//  Created by sinogz on 15/9/8.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CALayer+EGIVE.h"

@class EGDropDownMenu;

@protocol EGDropDownMenuDelegate <NSObject>

- (void)dropDownMenu:(EGDropDownMenu *)dropDownMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath;;

@end

@interface EGDropDownMenu : UIView <UITableViewDelegate, UITableViewDataSource>

/**
 * Cover the HUD background view with a radial gradient.
 */
@property (assign) BOOL dimBackground;

@property (nonatomic, assign)CGFloat rowHeight;
@property (nonatomic, assign)NSInteger selectedRow;

@property (nonatomic) id<EGDropDownMenuDelegate> delegate;

- (id)initWithFrame:(CGRect)frame Array:(NSArray *)array;
- (id)initWithFrame:(CGRect)frame Array:(NSArray *)array selectedColor:(UIColor *)color;
- (NSString*)getTitleByIndex:(NSInteger)index;
- (void)setItemName:(NSString *)name AtIndex:(NSIndexPath*)indexPath;
@end
