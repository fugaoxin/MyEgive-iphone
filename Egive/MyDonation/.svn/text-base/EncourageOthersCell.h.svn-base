//
//  EncourageOthersCell.h
//  Egive
//
//  Created by sinogz on 15/9/15.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EncourageOthersCell;
typedef void(^DeleteContactBlock)(EncourageOthersCell *cell);


@interface EncourageOthersCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, weak)UITextField *email;
@property (nonatomic, assign)CGFloat cellHeight;
@property (nonatomic, copy) DeleteContactBlock delObjectBlock;
@property (nonatomic, copy) void(^update)(EncourageOthersCell *cell, NSString *);
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
