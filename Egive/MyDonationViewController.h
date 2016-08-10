//
//  MyDonationViewController.h
//  Egive
//
//  Created by sino on 15/7/30.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"
#import "ConfirmViewController.h"
#import "EGMyDonationRequestAdapter.h"
#import "EGShoppingCartCell.h"
#import "ShowMenuView.h"
#import "FDLabelView.h"
#import "TFHpple.h"
#import "EGDropDownMenu.h"

@interface MyDonationViewController : MenuViewController<UITableViewDataSource,UITableViewDelegate, EGDropDownMenuDelegate, EGShoppingCartCellDataSource>
@property (retain, nonatomic) UIButton * menuButton;
@property (retain, nonatomic) UIScrollView * scrollView;
@property (retain, nonatomic) UIButton * hkButton;
@property (retain, nonatomic) UIButton * nhkButton;
@property (retain, nonatomic) UIButton * suportButton;

@property (strong, nonatomic) UIView * recordView;
@property (strong, nonatomic) UITableView * tableView;

@property (strong, nonatomic) UIScrollView * noteView;
@property (nonatomic, assign) CGFloat rate;

@property (nonatomic, assign) BOOL donateWithCharge;
@property (nonatomic, copy) NSString *Location;

@property (nonatomic, strong)EGGetAndSaveShoppingCartResult *shoppingCart;

@property (nonatomic) BOOL isByPush;

@property(nonatomic) int MyDonationFlag;
@property(retain,nonatomic) NSString *caseId;
@property(nonatomic) int pushFlag;
@end
