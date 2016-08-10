//
//  EncourageOthersCell.m
//  Egive
//
//  Created by sinogz on 15/9/15.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EncourageOthersCell.h"
#import "EGUtility.h"
#import "NSString+RegexKitLite.h"
@interface EncourageOthersCell ()
{
    BOOL markDeleted;
}
@property (nonatomic, weak)UIButton *deleteBtn;

@end

@implementation EncourageOthersCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //初始化
        CGFloat width = kScreenW - 16;
        CGFloat posX = 10.0;
        CGFloat posY = 10;
        CGFloat padding = 8.0;
        CGFloat buttonW = 35;
        
        UITextField *email = [[UITextField alloc] initWithFrame:CGRectMake(posX, posY, width - buttonW - padding*2, buttonW)];
        email.delegate = self;
        email.placeholder = EGLocalizedString(@"valid_email_address", nil);// Input valid email address  //Add Donors
        email.font = [UIFont systemFontOfSize:14];
        email.borderStyle = UITextBorderStyleRoundedRect;
        email.keyboardType = UIKeyboardTypeEmailAddress;
        [self addSubview:email];
        _email = email;
        
        UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        posX = CGRectGetMaxX(email.frame) + padding;
        delBtn.frame = CGRectMake(posX, posY, buttonW, buttonW);
        
        [delBtn setImage:[UIImage imageNamed:@"ad_close@2x.png"] forState:UIControlStateNormal];
        [delBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:delBtn];
        _deleteBtn = delBtn;
        
        _cellHeight = CGRectGetMaxY(email.frame);
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"EncourageOthersCell";
    EncourageOthersCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }    
    return cell;
}

- (void)deleteAction:(UIButton *)button
{
    
    if (self.delObjectBlock && !markDeleted) {
        self.delObjectBlock(self);
        markDeleted = true;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_email resignFirstResponder];
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([NSString isEmail:textField.text]) {
        
        if (self.update) {
            self.update(self, textField.text);
        }
    }
}


@end
