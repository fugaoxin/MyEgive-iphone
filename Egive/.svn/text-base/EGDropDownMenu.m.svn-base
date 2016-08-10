//
//  EGDropDownMenu.m
//  Egive
//
//  Created by sinogz on 15/9/8.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGDropDownMenu.h"
#import "AppDelegate.h"
@implementation EGDropDownMenu{
    UIColor *_menuColor;
    UIView *_backGroundView;
    UITableView *_tableView;
    NSMutableArray *_titles;
    NSMutableArray *_indicators;

    NSInteger _currentSelectedMenudIndex;
    bool _show;
    NSInteger _numOfMenu;
    NSMutableArray *_array;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame Array:(NSArray *)array
{
    UIColor *color = [UIColor colorWithRed:164.0/255.0 green:166.0/255.0 blue:169.0/255.0 alpha:1.0];
    return [self initWithFrame:frame Array:array selectedColor:color];
}

- (id)initWithFrame:(CGRect)frame Array:(NSArray *)array selectedColor:(UIColor*)color{
    
    self = [super initWithFrame:frame];
    
    if (self){
        
        self.layer.cornerRadius = 3;
        _rowHeight = frame.size.height;
        _selectedRow = 0;
//        self.layer.borderColor = [[UIColor grayColor] CGColor];
//        self.layer.borderWidth = 1;
        
        _array = [NSMutableArray array];
        
        _menuColor = [UIColor colorWithRed:164.0/255.0 green:166.0/255.0 blue:169.0/255.0 alpha:1.0];
        
        [_array addObjectsFromArray:array];
        
        _numOfMenu = _array.count;
        
        CGFloat interval = self.frame.size.width / _numOfMenu;
        
        _titles = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        _indicators = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        
        for (int i = 0; i < _numOfMenu; i++) {
            
            CGPoint position = CGPointMake( i * interval , 0);
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(position.x + 12, position.y, self.frame.size.width, self.frame.size.height)];
            title.text = _array[i][0];
            if (IS_IPAD || IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
                 title.font = [UIFont systemFontOfSize:12];
                
            }else{
                title.font = [UIFont systemFontOfSize:15];
            
            }
            title.textColor = color;
            [self addSubview:title];
            [_titles addObject:title];
            CAShapeLayer *indicator = [self creatIndicatorWithColor:_menuColor andPosition:CGPointMake(position.x + interval - 12, self.frame.size.height / 2)];
            [self.layer addSublayer:indicator];
            [_indicators addObject:indicator];
            if (i != _numOfMenu - 1) {
                CGPoint separatorPosition = CGPointMake((i + 1) * interval, self.frame.size.height / 2);
                CAShapeLayer *separator = [self creatSeparatorLineWithColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:243.0/255.0 alpha:1.0] andPosition:separatorPosition];
                [self.layer addSublayer:separator];
            }
            
        }
        _tableView = [self creatTableViewAtPosition:CGPointMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height)];
        _tableView.tintColor = color;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        // 设置menu, 并添加手势
        self.backgroundColor = [UIColor whiteColor];
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMenu:)];
        [self addGestureRecognizer:tapGesture];
        // 创建背景
        _backGroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        _backGroundView.opaque = NO;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround:)];
        [_backGroundView addGestureRecognizer:gesture];

        _currentSelectedMenudIndex = -1;
        _show = NO;
    }
    return self;
}

#pragma mark - tapEvent
// 处理菜单点击事件.
- (void)tapMenu:(UITapGestureRecognizer *)paramSender
{

    CGPoint touchPoint = [paramSender locationInView:self];
    
    // 得到tapIndex
    NSInteger tapIndex = touchPoint.x / (self.frame.size.width / _numOfMenu);
    
    for (int i = 0; i < _numOfMenu; i++) {
        if (i != tapIndex){
            [self animateIndicator:_indicators[i] Forward:NO complete:^{
                
            }];
        }
    }
    if (tapIndex == _currentSelectedMenudIndex && _show) {
        
        [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
            _currentSelectedMenudIndex = tapIndex;
            _show = NO;
            
        }];
        
    } else {
        
        _currentSelectedMenudIndex = tapIndex;
        [_tableView reloadData];
        [self animateIdicator:_indicators[tapIndex] background:_backGroundView tableView:_tableView title:_titles[tapIndex] forward:YES complecte:^{
            _show = YES;
        }];
    }
}

- (void)tapBackGround:(UITapGestureRecognizer *)paramSender
{
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
    }];
    
}


#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self confiMenuWithSelectRow:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(dropDownMenu:didSelectRowAtIndexPath:)]) {
        [self.delegate dropDownMenu:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_array[_currentSelectedMenudIndex] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        if (IS_IPAD || IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
           cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        
        }else{

            cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        }
       
    }

    [cell.textLabel setTextColor:[UIColor blackColor]];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    cell.textLabel.text = _array[_currentSelectedMenudIndex][indexPath.row];
    
//    if (cell.textLabel.text == [(CATextLayer *)[_titles objectAtIndex:_currentSelectedMenudIndex] string]) {
//        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
//        [cell.textLabel setTextColor:[tableView tintColor]];
//    }
    
     return cell;
}





#pragma mark - animation

- (void)animateIndicator:(CAShapeLayer *)indicator Forward:(BOOL)forward complete:(void(^)())complete
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = forward ? @[ @0, @(M_PI) ] : @[ @(M_PI), @0 ];
    
    if (!anim.removedOnCompletion) {
        [indicator addAnimation:anim forKey:anim.keyPath];
    } else {
        [indicator addAnimation:anim andValue:anim.values.lastObject forKeyPath:anim.keyPath];
    }
    
    [CATransaction commit];
    
    indicator.fillColor = forward ? _tableView.tintColor.CGColor : _menuColor.CGColor;
    
    complete();
}





- (void)animateBackGroundView:(UIView *)view show:(BOOL)show complete:(void(^)())complete
{
    
    if (show) {
        
        [self.superview addSubview:view];
        [view.superview addSubview:self];
        
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        }];
        
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
        
    }
    complete();
    
}

- (void)animateTableView:(UITableView *)tableView show:(BOOL)show complete:(void(^)())complete
{
    if (show){
        
        tableView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
        [self.superview addSubview:tableView];
        
        
        CGFloat tableViewHeight = ([tableView numberOfRowsInSection:0] > 6) ? (6 * tableView.rowHeight) : ([tableView numberOfRowsInSection:0] * tableView.rowHeight);
        
        [UIView animateWithDuration:0.2 animations:^{
            _tableView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, tableViewHeight);
        }];
        
    } else {
        
        [UIView animateWithDuration:0.2 animations:^{
            _tableView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
        } completion:^(BOOL finished) {
            [tableView removeFromSuperview];
        }];
        
        
    }
    complete();
    
}

- (void)animateIdicator:(CAShapeLayer *)indicator background:(UIView *)background tableView:(UITableView *)tableView title:(UILabel *)title forward:(BOOL)forward complecte:(void(^)())complete{
    
    [self animateIndicator:indicator Forward:forward complete:^{
        [self animateBackGroundView:background show:forward complete:^{
            [self animateTableView:tableView show:forward complete:^{
            }];
        }];
    }];
    
    complete();
}


#pragma mark - drawing
- (CAShapeLayer *)creatIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point
{
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(12, 0)];
    [path addLineToPoint:CGPointMake(6, 8)];
    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.fillColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    layer.position = point;
    
    return layer;
}

- (CAShapeLayer *)creatSeparatorLineWithColor:(UIColor *)color andPosition:(CGPoint)point
{
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(160,0)];
    [path addLineToPoint:CGPointMake(160, 20)];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.strokeColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    layer.position = point;
    
    return layer;
}


- (UITableView *)creatTableViewAtPosition:(CGPoint)point
{
    UITableView *tableView = [UITableView new];
    tableView.frame = CGRectMake(point.x, point.y, self.frame.size.width, 0);
    tableView.rowHeight = _rowHeight;
    tableView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    tableView.layer.borderWidth = 1;
    
    return tableView;
}

#pragma mark - otherMethods
- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    CGFloat fontSize = 13.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}

- (void)confiMenuWithSelectRow:(NSInteger)row{
    _selectedRow = row;
    UILabel *title = (UILabel *)_titles[_currentSelectedMenudIndex];
    title.text = [[_array objectAtIndex:_currentSelectedMenudIndex] objectAtIndex:row];
   [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
        
    }];
}

- (NSString*)getTitleByIndex:(NSInteger)index
{
    NSString *title = @"";
    if (_array[0] && index < [_array[0] count]) {
        title = [[_array objectAtIndex:0] objectAtIndex:index];
    }
    return title;
}

- (void)setSelectedRow:(NSInteger)selectedRow
{
    if (selectedRow >= [_array[0] count]) {
        return;
    }
    _selectedRow = selectedRow;
    
    UILabel *title = (UILabel *)_titles[0];
    title.text = [[_array objectAtIndex:0] objectAtIndex:_selectedRow];
}

- (void)setItemName:(NSString *)name AtIndex:(NSIndexPath*)indexPath
{
    NSInteger index = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section < _array.count && indexPath.row < [_array[section] count]) {
        
        NSMutableArray *arrar = [NSMutableArray arrayWithArray:_array[section]];
        arrar[index] = name;
        _array[section] = arrar;
        
        
        UILabel *title = (UILabel *)_titles[section];
        title.text = [[_array objectAtIndex:section] objectAtIndex:_selectedRow];
        
        //[_tableView reloadData];
    }
}

@end
