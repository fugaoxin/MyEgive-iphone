//
//  EGAlertViewController.m
//  Egive
//
//  Created by sinogz on 15/9/15.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGAlertViewController.h"
#import "EGUtility.h"

@interface EGAlertViewController ()

@property (nonatomic, copy)NSString *titleText;
@property (nonatomic, copy)NSString *messageText;
@property (nonatomic, copy)NSString *cancelText;
@property (nonatomic, copy)NSString *confirmText;

@end

@implementation EGAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.75];
    
    self.alertView.layer.cornerRadius = 8;
    self.alertView.layer.masksToBounds = YES;
    self.alertView.layer.borderWidth = 0.5;
    self.alertView.layer.borderColor = [kPurpleColor CGColor];
    
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.font = [UIFont boldSystemFontOfSize:15];
    
    
    self.titleLabel.text = _titleText;
    self.messageLabel.text = _messageText;
    [self.cancelBtn setTitle:_cancelText forState:UIControlStateNormal];
    [self.confirmBtn setTitle:_confirmText forState:UIControlStateNormal];

    
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles
{
    if (self = [super initWithNibName:@"EGAlertViewController" bundle:nil]) {
        self.titleText = title;
        self.messageText = message;
        self.cancelText = cancelButtonTitle;
        self.confirmText = otherButtonTitles;
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelAction:(UIButton *)sender {
    __weak typeof(self)weakSelf = self;
    
    [self dismissViewControllerAnimated:NO completion:^{
        if (weakSelf.completedBlock) {
            weakSelf.completedBlock(0);
        }
    }];
}

- (IBAction)confirmAction:(UIButton *)sender {
    
    __weak typeof(self)weakSelf = self;
    [self dismissViewControllerAnimated:NO completion:^{
        if (weakSelf.completedBlock) {
            weakSelf.completedBlock(1);
        }
    }];
}

@end
