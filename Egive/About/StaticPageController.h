//
//  StaticPageController.h
//  Egive
//
//  Created by sinogz on 15/9/10.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDLabelView.h"
#import "TFHpple.h"
#import "EGStaticPageRequestAdapter.h"

@interface StaticPageController : UIViewController<UIScrollViewDelegate>
{
    CGFloat currentY;
    UIScrollView *mScrollView;
}
@property (nonatomic, assign) UISlider *slider;

- (void)rightAction;

- (void)getStaticPageContentWithFormID:(NSString*)formID;
-(void)parseElements:(NSArray *)elements;

- (void)addSubImageView:(NSURL *)imageURL;
- (void)addTitleText:(NSString *)content font:(UIFont*)font;
- (void)addSubText:(NSString *)content;
-(void)addMySlider;
-(void)sliderDragUp;
@end
