//
//  EGShoppingCartCell.m
//  Egive
//
//  Created by sinogz on 15/9/11.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGShoppingCartCell.h"

#import "ZJScreenAdaptation.h"
#import "ZJScreenAdaptationMacro.h"

@interface EGShoppingCartCell ()



@property (nonatomic, strong) UILabel *PayOption1Label;
@property (nonatomic, strong) UILabel *PayOption2Label;
@property (nonatomic, strong) UILabel *PayOption3Label;

@property (nonatomic, strong)UILabel  * tipLabel;

@property (nonatomic, strong) UILabel *donateAmtLabel;
@property (nonatomic, strong) UILabel *receiveAmtLabel;

@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation EGShoppingCartCell

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame item:(EGShoppingCart *)item
{
    if (self = [super initWithFrame:frame]) {
        _item = item;
        [self setupSubView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame item:(EGShoppingCart *)item block:(SaveShoppingCartItemBlock)block
{
    self.saveShoppingCartItemBlock = block;
    
    return [self initWithFrame:frame item:item];
}


- (void)setupSubView
{
    __weak __typeof(self)weakSelf = self;
    
    _checkBox = [self addImageButtonWithFrame:CGRectMake(20, 10, 20, 20) title:nil backgroud:@"cart_checkbox_nor@2x.png" action:^(UIButton *button) {
        BOOL selected = !button.selected;
        weakSelf.IsChecked = selected;
    }];
    [_checkBox setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel@2x.png"] forState:UIControlStateSelected];
    _IsChecked = _item.IsChecked;
    _checkBox.selected = _IsChecked;
    
    UILabel * suportLabel = [self addLabelWithFrame:CGRectMake(50, 0, 320-50, 40) text:_item.Title];
    suportLabel.font = [UIFont systemFontOfSize:14];
    suportLabel.numberOfLines = 2;
    suportLabel.textColor = [UIColor colorWithRed:70.0/255.0 green:180.0/255.0 blue:4.0/255.0 alpha:1];
    //_item.ItemMsg = @"专案已结束，请支持其他专案。";
    if ([_item.ItemMsg isEqualToString:@""]){
        
        NSArray * money = @[[NSString stringWithFormat:@"HK$  %ld",_item.PayOption1],
                            [NSString stringWithFormat:@"HK$  %ld",_item.PayOption2],
                            [NSString stringWithFormat:@"HK$  %ld",_item.PayOption3],
                            [NSString stringWithFormat:@" %@",EGLocalizedString(@"Register_org_otherButton", nil)]];
        __weak __typeof(self)weakSelf = self;
        
        for (int i = 0; i < 4; i ++) {
            UIButton *button = [self addImageButtonWithFrame:CGRectMake(i%2*145+20, i/2*55+40, 135, 40) title:money[i] backgroud:nil action:^(UIButton *button) {
                
                if (!button.selected) {
                    weakSelf.selectedIndex = button.tag;
                }
            }];
            button.tag = i;
            button.layer.borderWidth = 1;
            button.layer.cornerRadius = 4;
            if (i != 3) {
                [button setImage:[UIImage imageNamed:@"cart_amount_sel"] forState:UIControlStateSelected];
                button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25);
            }
            
            
            [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            button.backgroundColor = [UIColor whiteColor];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            button.layer.borderColor = [[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1] CGColor];
            
            if (i == 3) {
                button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                _textField = [[UITextField alloc]initWithFrame:CGRectMake(210, 102.5, 80, 25)];
                _textField.placeholder = @"HK$";
                _textField.delegate = self;
                _textField.adjustsFontSizeToFitWidth = YES;
                _textField.borderStyle = UITextBorderStyleRoundedRect;
                _textField.keyboardType = UIKeyboardTypeNumberPad;
                _textField.returnKeyType = UIReturnKeyDone;
                
                [self addSubview:_textField];
            }
            
            if (_item.PayOption1 == 0 && _item.PayOption2 == 0  && _item.PayOption3 == 0) {
                button.hidden = YES;
                _textField.hidden = YES;
                _checkBox.hidden = YES;
                
               
                UILabel * label = [self addLabelWithFrame:CGRectMake(20,70, 300, 40) text:EGLocalizedString(@"专案目标已经达到,请支持其他意赠项目", nil)];
                label.numberOfLines = 2;
                label.font = [UIFont systemFontOfSize:14];
            }
            
            
            [self.buttons addObject:button];
        }
    }
    self.donateAmt = _item.DonateAmt;
    // 根据金额得到选中项
    self.receiveAmt = _item.ReceiveAmt;
    _selectedIndex = [self selectedOptionByAmt:_item.SelectedOption];
    
    if (_selectedIndex == 3) {
        
        _textField.text = [NSString stringWithFormat:@"%ld", _item.SelectedOption];
    }
    
    [self selectButtonAtIndex:_selectedIndex];
    
    _tipLabel2 = [self addLabelWithFrame:CGRectMake(16, 133, 250, 25) text:EGLocalizedString(@"目标余额", nil)];
    _tipLabel2.font = [UIFont systemFontOfSize:10];
    _tipLabel2.textColor = [UIColor grayColor];
    
    
    UILabel * tipLabel = [self addLabelWithFrame:CGRectMake(16, 150, 250, 25) text:EGLocalizedString(@"捐款金额", nil)];
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textColor = [UIColor grayColor];
    _tipLabel = tipLabel;
    
    if (_item.IsChecked) {
        if (_item.DonateAmt > _item.MinDonateAmt) {
            
            tipLabel.textColor = [UIColor grayColor];
            tipLabel.text = EGLocalizedString(@"捐款金额", nil);
            tipLabel.frame = CGRectMake(16, 150, 250, 25);
            _tipLabel.numberOfLines = 1;
            
        } else {
            
            _tipLabel.text = [NSString stringWithFormat:EGLocalizedString(@"每個捐款專案最低捐款金額為港幣20元", nil), (long)_item.MinDonateAmt];
            _tipLabel.textColor = [UIColor redColor];
            _tipLabel.numberOfLines = 2;
            _tipLabel.frame = CGRectMake(16, 150, 250, 25);
        }
    }
    
    
    NSString *text = _item.IsChecked ? [NSString stringWithFormat:@"HK$ %ld",_item.DonateAmt] : @"HK$ 0";
    _donateAmtLabel = [self addLabelWithFrame:CGRectMake(160, 150, 140, 25) text:text];
    _donateAmtLabel.textAlignment = NSTextAlignmentRight;
    _donateAmtLabel.font = [UIFont systemFontOfSize:14];
    _donateAmtLabel.textColor = _item.DonateAmt > _item.MinDonateAmt ? [UIColor grayColor]:[UIColor redColor];
    [self addImageViewWithFrame:CGRectMake(20, 185, 280, 2) image:@"Line@2x.png"];
    
    UILabel *receiveLabel = [self addLabelWithFrame:CGRectMake(20, 190, 200, 25) text:EGLocalizedString(@"受助者收到金额", nil)];
    receiveLabel.font = [UIFont boldSystemFontOfSize:14];
    
    text = _item.IsChecked ? [NSString stringWithFormat:@"HK$ %ld",_item.ReceiveAmt] : @"HK$ 0";
    _receiveAmtLabel = [self addLabelWithFrame:CGRectMake(160, 190, 140, 25) text:text];
    _receiveAmtLabel.textAlignment = NSTextAlignmentRight;
    _receiveAmtLabel.font = [UIFont boldSystemFontOfSize:14];
    _receiveAmtLabel.textColor = _item.DonateAmt > _item.MinDonateAmt ? [UIColor blackColor]:[UIColor redColor];
    
    if (_item.IsChecked) {
        _donateAmtLabel.textColor = _item.DonateAmt > _item.MinDonateAmt ? [UIColor grayColor]:[UIColor redColor];
        _receiveAmtLabel.textColor = _item.DonateAmt > _item.MinDonateAmt ? [UIColor blackColor]:[UIColor redColor];
    } else {
        _donateAmtLabel.textColor = [UIColor grayColor];
        _receiveAmtLabel.textColor = [UIColor blackColor];
    }
    
    if (_item.PayOption1 == 0 && _item.PayOption2 == 0  && _item.PayOption3 == 0 && _item.IsChecked) {
        self.IsChecked = NO;
    }
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"donateWithCharge"]) {
        
    }
}


- (void)updateDonateAmt
{
    if (_checkBox.selected) {
        
        NSString *text = [NSString stringWithFormat:@"HK$ %ld",self.donateAmt];
        self.donateAmtLabel.text = text;
        text = [NSString stringWithFormat:@"HK$ %ld",self.receiveAmt];
        
        
        self.receiveAmtLabel.text = text;
        if (self.donateAmt < _item.MinDonateAmt) {
            self.donateAmtLabel.textColor = [UIColor redColor];
            self.receiveAmtLabel.textColor = [UIColor redColor];
            _tipLabel.text = [NSString stringWithFormat:EGLocalizedString(@"每個捐款專案最低捐款金額為港幣20元", nil), (long)_item.MinDonateAmt];
            _tipLabel.textColor = [UIColor redColor];
            //            _tipLabel.frame = CGRectMake(_tipLabel.frame.origin.x, _tipLabel.frame.origin.y - 20, 280, _tipLabel.frame.size.height);
            _tipLabel.frame = CGRectMake(20, 150, 250, 25);
        } else {
            self.donateAmtLabel.textColor = [UIColor grayColor];
            self.receiveAmtLabel.textColor = [UIColor blackColor];
            _tipLabel.text = EGLocalizedString(@"捐款金额", nil);
            _tipLabel.frame = CGRectMake(20, 150, 250, 25);
            _tipLabel.textColor = [UIColor grayColor];
        }
        
        
    } else {
        self.donateAmtLabel.text = @"HK$ 0";
        self.receiveAmtLabel.text = @"HK$ 0";
        _donateAmtLabel.textColor = [UIColor grayColor];
        _receiveAmtLabel.textColor = [UIColor blackColor];
        
        _tipLabel.text = EGLocalizedString(@"捐款金额", nil);
        _tipLabel.textColor = [UIColor grayColor];
    }
}

- (void)reloadData
{
    NSString *location = [self.dataSource Location];
    self.donateWithCharge = self.dataSource ? [self.dataSource donateWithCharge]:YES;
    self.numberOfCheckedItems = [self.dataSource numberOfCheckedItems];
    if ([location isEqualToString:@"HK"]){
        
        self.rate = 3.9;
        
    } else {
        
        self.rate = 4.4;
    }
    
    MyLog(@"%f",self.rate);
    
    NSInteger amt = [self getAmtBySelectedIndex:_selectedIndex];
    if (amt >= 0) {
        if (_donateWithCharge) {
            // 包括手續費
            self.receiveAmt = amt;
            
            MyLog(@"%ld",(long)self.receiveAmt);
            
            self.donateAmt = [self receiveAmtToDonateAmt:self.receiveAmt];
            MyLog(@"%ld",(long)self.donateAmt);
            
        } else {
            self.donateAmt = amt;
            self.receiveAmt = [self donateAmtToReceiveAmt:self.donateAmt];
        }
    }
    
    [self updateDonateAmt];
}

- (void)setIsChecked:(BOOL)IsChecked
{
    _IsChecked = IsChecked;
    _checkBox.selected = IsChecked;
    self.numberOfCheckedItems = [[self dataSource] numberOfCheckedItems];
    self.donateWithCharge = self.dataSource ? [self.dataSource donateWithCharge]:YES;
    NSString *location = [self.dataSource Location];
    if ([location isEqualToString:@"HK"]) {
        self.rate = 3.9;
    } else {
        self.rate = 4.4;
    }
    
    IsChecked ? self.numberOfCheckedItems++ :self.numberOfCheckedItems--;
    
    if (_selectedIndex == 3) {
        // 根据当前收到金额更新选项
        BOOL donateWithCharge = self.dataSource ? [self.dataSource donateWithCharge]:YES;
        if (donateWithCharge) {
            // 包括手續費
            _selectedIndex = [self selectedOptionByAmt:self.receiveAmt];
        } else {
            _selectedIndex = [self selectedOptionByAmt:self.donateAmt];
        }
        [self selectButtonAtIndex:_selectedIndex];
    }
    
    
    NSInteger amt = [self getAmtBySelectedIndex:_selectedIndex];
    if (amt >= 0) {
        if (_donateWithCharge) {
            // 包括手續費
            self.receiveAmt = amt;
            self.donateAmt = [self receiveAmtToDonateAmt:self.receiveAmt];
        } else {
            self.donateAmt = amt;
            self.receiveAmt = [self donateAmtToReceiveAmt:self.donateAmt];
        }
    }
    
    [self updateDonateAmt];
    if (self.saveShoppingCartItemBlock) {
        self.saveShoppingCartItemBlock(self, 1);
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    [self reloadData];
    
    [self selectButtonAtIndex:_selectedIndex];
    
    if (selectedIndex != 3) {
        _textField.text = @"";
        [_textField resignFirstResponder];
    }
    if (self.saveShoppingCartItemBlock) {
        if (selectedIndex == 3 && !_textField.text.length) {
            return;
        }
        self.saveShoppingCartItemBlock(self, 0);
    }
}

- (void)setRate:(CGFloat)rate
{
    _rate = rate;
}

/**
 *  根据收到金额获取获取索引
 *
 *  @param amt 金额
 *
 *  @return selectedIndex
 */
- (NSInteger)selectedOptionByAmt:(NSInteger)amt
{
    NSInteger ret;
    if (amt == _item.PayOption1) {
        ret = 0;
    }else if (amt == _item.PayOption2) {
        ret = 1;
    }else if (amt == _item.PayOption3) {
        ret = 2;
    } else {
        ret = 3;
    }
    return ret;
}

/**
 *  根据索引获取获取收到金额
 *
 *  @param amt 金额
 *
 *  @return selectedIndex
 */
- (NSInteger)getAmtBySelectedIndex:(NSUInteger)index
{
    NSInteger amount = -1;
    if (index == 0) {
        amount = _item.PayOption1;
    } else if (index == 1) {
        amount = _item.PayOption2;
    } else if (index == 2) {
        amount = _item.PayOption3;
    } else if (_textField.text.length) {
        amount = [_textField.text integerValue];
    }
    
    return amount;
}

/**
 *  根据收到金额计算包括手续费在内的捐款金额
 *
 *  @param recv 收到金额
 *
 *  @return 捐款金额
 */
-(NSInteger)receiveAmtToDonateAmt:(NSInteger)recv
{
    if (self.numberOfCheckedItems && recv) {
        float fee = 2.35/self.numberOfCheckedItems;
        MyLog(@"%f",fee);
        float amt = (recv + fee)/(1 - self.rate*0.01);
        return roundf(amt + 0.5);
    }
    return 0;
}
/**
 *  根据捐款金额计算受助人收到金額
 *
 *  @param donateAmt 捐款金额
 *
 *  @return 收到金額
 */
-(NSInteger)donateAmtToReceiveAmt:(NSInteger)donateAmt
{
    if (self.numberOfCheckedItems && donateAmt){
        
        float charge = 2.35/self.numberOfCheckedItems;
        return donateAmt - roundf(donateAmt*self.rate/100 + charge + 0.5);
    }
    return 0;
}


/**
 *  根据索引选中按钮
 *
 *  @param index 索引
 */
- (void)selectButtonAtIndex:(NSUInteger)index
{
    if (index >= self.buttons.count) {
        MyLog(@"Array Index Out Of Bounds Exception");
        return;
    }
    for (UIButton *btn in self.buttons) {
        if (index == btn.tag) {
            btn.selected = YES;
            btn.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
        } else {
            btn.selected = NO;
            btn.backgroundColor = [UIColor whiteColor];
        }
    }
}


#pragma mark UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _selectedIndex = 3;
    [self selectButtonAtIndex:3];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length) {
        self.selectedIndex = 3;
    }
    [textField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length + string.length > 7) {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        self.selectedIndex = 3;
    }
    return YES;
}
@end
