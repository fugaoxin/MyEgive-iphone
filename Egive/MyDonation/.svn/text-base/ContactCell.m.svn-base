//
//  ContactCell.m
//  Egive
//
//  Created by sinogz on 15/9/15.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ContactCell.h"

@interface ContactCell ()

@property (nonatomic, weak)UILabel *nameLabel;
@property (nonatomic, weak)UILabel *emailLabel;

@property (nonatomic, weak)UIButton *checkBox;

@end

@implementation ContactCell

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
        CGFloat width = kScreenW - 20;
        CGFloat padding = 8.0;
        CGFloat margin = 10.0;
        
        CGFloat posX = margin;
        CGFloat posY = 10;
        
        CGFloat buttonW = 25;
        CGFloat labelW = width - margin*2 - buttonW - padding;
        CGFloat labelH = 30;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(posX, 0, labelW, labelH)];
        [self addSubview:nameLabel];
        nameLabel.font = [UIFont boldSystemFontOfSize:14];
        nameLabel.text = @"蔡业文";
        nameLabel.textColor = [UIColor blackColor];
        _nameLabel = nameLabel;
        
        posY = CGRectGetMaxY(nameLabel.frame);
        UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(posX, posY, labelW, labelH - padding)];
        [self addSubview:emailLabel];
        emailLabel.text = @"cyw026@163.com";
        emailLabel.textColor = [UIColor blackColor];
        emailLabel.font = [UIFont systemFontOfSize:12];
        _emailLabel = emailLabel;
        
        _cellHeight = CGRectGetMaxY(_emailLabel.frame) + padding;
        
        UIButton *checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
        posX = width - 15 - buttonW;
        posY = (_cellHeight - buttonW)/2;
        checkBox.frame = CGRectMake(posX, posY, buttonW, buttonW);
        
        [checkBox setImage:[UIImage imageNamed:@"cart_checkbox_nor.png"] forState:UIControlStateNormal];
        [checkBox setImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
        [checkBox addTarget:self action:@selector(checkedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:checkBox];
        _checkBox = checkBox;
        
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ContactCell";
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void)setModel:(ContactModel *)model
{
    _model = model;
    
    _nameLabel.text = model.name;
    _emailLabel.text = model.email;
    _checkBox.selected = model.isChecked;
}

- (void)checkedAction:(UIButton *)button
{
    button.selected = !button.selected;
    if (self.checkedBlock) {
        self.checkedBlock(self, button.selected);
    }
}

@end
