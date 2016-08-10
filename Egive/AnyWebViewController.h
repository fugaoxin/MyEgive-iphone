//
//  AddCaseViewController.h
//  Egive
//
//  Created by sino on 15/9/24.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnyWebViewController : UIViewController
@property (strong, nonatomic) NSString * sURL;
@property (strong, nonatomic) NSString * aURL;
-(void)setAbsoluteURL:(NSString *)theURL;
-(void)setURL:(NSString *)theURL;
@end
