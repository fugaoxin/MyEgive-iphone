//
//  ProReportController.h
//  Egive
//
//  Created by sino on 15/7/28.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ViewController.h"

@interface ProReportController : ViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) UIImageView * showImage;
@property (strong, nonatomic) UILabel * titleLabel;
@property (strong, nonatomic) NSArray * UpdatesDetail;
@property (strong, nonatomic) NSString * caseId;
@property(retain,nonatomic) NSString *nameString;
@end
