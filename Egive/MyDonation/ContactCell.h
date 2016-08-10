//
//  ContactCell.h
//  Egive
//
//  Created by sinogz on 15/9/15.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGUtility.h"
#import "ContactModel.h"

@class ContactCell;


@interface ContactCell : UITableViewCell

typedef void(^ContactCellCheckedBlock)(ContactCell *cell, BOOL isChecked);

@property (nonatomic, assign)CGFloat cellHeight;
@property (nonatomic, strong)ContactModel *model;
@property (nonatomic, copy) ContactCellCheckedBlock checkedBlock;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
