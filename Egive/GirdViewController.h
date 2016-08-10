//
//  GirdViewController.h
//  Egive
//
//  Created by sino on 15/7/27.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"
#import "ShowMenuView.h"
#import "EGDropDownMenu.h"
#import "UIImageView+WebCache.h"
#import "EGGeneralRequestAdapter.h"
#import "MyAttentionViewController.h"
#import "EGMyDonationRequestAdapter.h"

@interface GirdViewController : MenuViewController<EGDropDownMenuDelegate>
@property (strong, nonatomic) UIButton * navbutton;
@property (assign, nonatomic) NSInteger index;
- (id)initWithTag:(int) tag;
@property (nonatomic) BOOL isAddJump;
@property (nonatomic) BOOL isSucPush;
@end
