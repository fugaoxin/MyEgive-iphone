//
//  EGSegmentedControl.m
//  Egive
//
//  Created by sinogz on 15/9/13.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGSegmentedControl.h"

@implementation EGSegmentedControl

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    if (self = [super initWithFrame:frame]) {
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
        segmentedControl.frame = frame;
        segmentedControl.selectedSegmentIndex = 0;
        segmentedControl.tintColor = [UIColor colorWithRed:110/255.0 green:184/255.0 blue:43/255.0 alpha:1];;
        [segmentedControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
        [self addSubview:segmentedControl];
        self.segmentedControl = segmentedControl;
    }
    return self;
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [self.segmentedControl addTarget:target action:action forControlEvents:controlEvents];
}

- (void)setContentView:(UIView *)contentView
{
    [_contentView removeFromSuperview];
    _contentView = contentView;
    [self addSubview:_contentView];
}

#pragma mark actions
-(void)segmentAction:(UISegmentedControl *)Seg
{
    NSInteger Index = Seg.selectedSegmentIndex;
    switch (Index) {
        case 0:
            
            break;
            
        default:
            break;
    }
}

@end
