//
//  EGAlertViewController.h
//  Egive
//
//  Created by sinogz on 15/9/15.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EGAlertViewController;

typedef void(^CompletedBlock)(NSInteger buttonIndex);

@interface EGAlertViewController : UIViewController

@property (nonatomic, copy) CompletedBlock completedBlock;

@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles;
- (IBAction)cancelAction:(UIButton *)sender;
- (IBAction)confirmAction:(UIButton *)sender;

@end
