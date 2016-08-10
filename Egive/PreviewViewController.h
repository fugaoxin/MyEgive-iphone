//
//  PreviewViewController.h
//  Egive
//
//  Created by sino on 15/9/13.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGUtility.h"
#import "GirdDetailModel.h"
#import "EGGeneralRequestAdapter.h"
#import "AppDelegate.h"
@interface PreviewViewController : UIViewController
@property (copy, nonatomic) NSString * caseId;
@property (copy, nonatomic) NSString * comments;
@property (copy, nonatomic) NSString * memberId;
@property (copy,nonatomic)void(^action)(void);
@end
