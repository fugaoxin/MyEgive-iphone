//
//  EGAlertView.h
//  Egive
//
//  Created by sinogz on 15/9/14.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    EGAlertAnimationDefault = 0,
    EGAlertAnimationFade,
    EGAlertAnimationFlipHorizontal,
    EGAlertAnimationFlipVertical,
    EGAlertAnimationTumble,
    EGAlertAnimationSlideLeft,
    EGAlertAnimationSlideRight
};
typedef NSInteger EGAlertAnimation;


@interface EGAlertView : UIView

typedef void (^EGAlertViewBlock)(EGAlertView *alertView, NSInteger buttonIndex);

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) UIView *contentView;

///-----------------
/// @name Appearance
///-----------------

@property (nonatomic, strong) UIColor *backgroundColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat backgroundGradation UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *strokeColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat strokeWidth UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIFont *titleFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *titleColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *titleShadowColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGSize titleShadowOffset UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIFont *messageFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *messageColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *messageShadowColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGSize messageShadowOffset UI_APPEARANCE_SELECTOR;

//------------------------
// @name Button Appearance
//------------------------

@property (nonatomic, strong) UIColor *buttonBackgroundColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *buttonStrokeColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat buttonStrokeWidth UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *cancelButtonBackgroundColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) BOOL darkenBackground;
@property (nonatomic, assign) BOOL blurBackground;

@property (nonatomic, assign) EGAlertAnimation animationType;
@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) EGAlertViewBlock block;


- (id)initWithTitle:(NSString *)title message:(NSString *)message;
- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void)show;
- (void)showWithCompletionBlock:(void (^)())completion;
- (void)hide;
- (void)hideWithCompletionBlock:(void (^)())completion;

@end

@interface EGAlertWindowOverlay : UIView
@property (nonatomic, strong) EGAlertView *alertView;
@end

@interface UIView (Screenshot)
- (UIImage*)screenshot;
@end

@interface UIImage (Blur)
-(UIImage *)boxblurImageWithBlur:(CGFloat)blur;
@end
