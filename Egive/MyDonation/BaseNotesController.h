//
//  BaseNotesController.h
//  Egive
//
//  Created by sinogz on 15/9/24.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFHpple.h"
#import "FDLabelView.h"
#import "EGUtility.h"
#import "ShowMenuView.h"
#import "EGMyDonationRequestAdapter.h"

@interface BaseNotesController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIScrollView *noteView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
- (IBAction)cancelAction:(UIButton *)sender;

- (void)parseHTML:(NSString*)htmlString;
- (void)parseHTML2:(NSString*)htmlString;
- (void)getStaticPageContentWithFormID:(NSString*)formID;
@end
