//
//  ConfirmViewController.h
//  Egive
//
//  Created by sino on 15/8/26.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ViewController.h"
#import "baseController.h"
#import "EGMyDonationRequestAdapter.h"
#import "ShowMenuView.h"
#import "MenuViewController.h"
#import "MDHTMLLabel.h"
#import "NotesForDonations.h"

@interface ConfirmViewController : baseController<MDHTMLLabelDelegate>
@property (strong, nonatomic) UILabel * donSumMoney;
@property (retain, nonatomic) UIButton * needButton;
@property (retain, nonatomic) UIButton * noButton;
@property (retain, nonatomic) UIButton * thkButton;
@property (retain, nonatomic) UIButton * nThkButton;
@property (strong, nonatomic) UITextField * receiptName;
@property (strong, nonatomic) UITextField * thankName;
@property (strong, nonatomic) UITextField * emailTextField;
@property (strong, nonatomic) UIButton * confirmInfoButton;
@property (strong, nonatomic) UIButton * agreeButton;
@property (nonatomic) BOOL isPaySuccessful;
- (id)initWithDataModel:(EGGetAndSaveShoppingCartResult *)model;
@end
