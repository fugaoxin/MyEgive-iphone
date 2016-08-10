//
//  ContactListController.h
//  Egive
//
//  Created by sinogz on 15/9/15.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "baseController.h"
#import "ContactCell.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

typedef void(^DismissBlock)(NSMutableArray *contactList);

@interface ContactListController : baseController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) DismissBlock dismissBlock;

@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkBox;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkAllBtn;
@property (strong, nonatomic) IBOutlet UILabel *CheckObjectLabel;
@property (strong, nonatomic) IBOutlet UILabel *allLabel;
- (IBAction)cancelAction:(UIButton *)sender;
- (IBAction)confirmAction:(UIButton *)sender;
- (IBAction)checkAllAction:(UIButton *)sender;
@end
