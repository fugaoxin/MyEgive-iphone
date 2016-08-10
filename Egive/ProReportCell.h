//
//  ProReportCell.h
//  Egive
//
//  Created by sino on 15/8/17.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProReportCell : UITableViewCell<UIWebViewDelegate>
@property (strong, nonatomic) UILabel * date;
@property (strong, nonatomic) UILabel * conten;
@property (strong, nonatomic) UILabel * proReport;


//
@property (strong, nonatomic) UIWebView *webview;
@end
