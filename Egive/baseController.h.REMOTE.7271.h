//
//  baseController.h
//  Egive
//
//  Created by sino on 15/7/24.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ViewController.h"

@interface baseController : ViewController<UITextFieldDelegate, UIAlertViewDelegate>

- (void)setAlertView:(NSString *)message;
- (void)tapAction;

@end
