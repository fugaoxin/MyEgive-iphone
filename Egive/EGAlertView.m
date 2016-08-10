//
//  EGAlertView.m
//  Egive
//
//  Created by sinogz on 15/9/14.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGAlertView.h"
#import "EGUtility.h"
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

@interface EGAlertView ()

@property (nonatomic, strong)UIView *alertView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIView *blurredBackgroundView;
@property (nonatomic, strong) EGAlertWindowOverlay *overlay;

@end

#define kAlertViewDefaultSize CGSizeMake(280, 200)
#define kURBAlertPadding 8.0
#define kURBAlertMessageDefaultHeight 50.0
#define kURBAlertMessagePadding 20.0
#define kURBAlertButtonHeight 50
#define screenSize [UIScreen mainScreen].bounds.size
@implementation EGAlertView
{
@private
    struct {
        CGRect titleRect;
        CGRect messageRect;
        CGRect buttonRect;
        CGRect buttonRegionRect;
        CGRect textFieldsRect;
    } layout;
}

#pragma mark - init

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[self defaultFrame]];
    if (self) {
        
    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.title = title;
        self.message = message;
        [self initialize];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [self initWithTitle:title message:message];
    if (self) {
        if (cancelButtonTitle) {
            NSUInteger cancelButtonIndex = [self addButtonWithTitle:cancelButtonTitle];
            UIButton *cancelButton = [self buttonAtIndex:cancelButtonIndex];
            self.cancelButton = cancelButton;
        }
        if (otherButtonTitles) {
            va_list otherTitles;
            va_start(otherTitles, otherButtonTitles);
            for (NSString *otherTitle = otherButtonTitles; otherTitle; otherTitle = (va_arg(otherTitles, NSString *))) {
                [self addButtonWithTitle:otherTitle];
            }
            va_end(otherTitles);
        }
    }
    return self;
}

- (void)initialize {
    
    _cornerRadius = 6.0;
    self.buttons = [NSMutableArray array];
    self.animationType = EGAlertAnimationDefault;
    
    _titleFont = [UIFont boldSystemFontOfSize:18.0];
    _titleColor = [UIColor whiteColor];
    _messageFont = [UIFont systemFontOfSize:14.0];
    _messageColor = [UIColor whiteColor];
    
    self.backgroundColor = [UIColor redColor];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    
    self.opaque = NO;
    self.alpha = 1.0;
    self.darkenBackground = YES;
    self.blurBackground = NO;
    
    _buttonBackgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    
    //
    _titleLabel = [self addLabelWithFrame:CGRectZero text:self.title];
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    [self addSubview:_titleLabel];
    
    _messageLabel = [self addLabelWithFrame:CGRectZero text:self.message];
    _messageLabel.font = [UIFont systemFontOfSize:14];
    _messageLabel.numberOfLines = 0;
    _messageLabel.backgroundColor = [UIColor whiteColor];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setContentView:(UIView *)contentView
{
    
}

#pragma mark - Buttons and Text Fields

- (NSInteger)addButtonWithTitle:(NSString *)title
{
    // convert button over to internal button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.contentMode = UIViewContentModeCenter;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    
    if (self.buttonBackgroundColor) {
        button.backgroundColor = self.buttonBackgroundColor;
    }
    
    [self.buttons addObject:button];
    
    return [self.buttons indexOfObject:button];
}

- (UIButton *)buttonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex >= 0 && buttonIndex < [self.buttons count]) {
        return [self.buttons objectAtIndex:buttonIndex];
    }
    return nil;
}

#pragma mark - Animations

- (void)show {
    [self animateWithType:self.animationType show:YES completionBlock:nil];
}

- (void)showWithCompletionBlock:(void (^)())completion {
    [self animateWithType:self.animationType show:YES completionBlock:completion];
}

- (void)hide {
    [self animateWithType:self.animationType show:NO completionBlock:nil];
}

- (void)hideWithCompletionBlock:(void (^)())completion {
    [self animateWithType:self.animationType show:NO completionBlock:completion];
}

- (void)animateWithType:(EGAlertAnimation)animation show:(BOOL)show completionBlock:(void (^)())completion
{
    CGAffineTransform transform = self.transform;
    
    // default "pop" animation like UIAlertView
        if (show) {
            [self showOverlay:YES];
            
            self.alpha = 0.0f;
            self.transform = CGAffineTransformScale(transform, 0.7, 0.7);
            
            [UIView animateWithDuration:0.18 animations:^{
                self.transform = CGAffineTransformScale(transform, 1.1, 1.1);
                self.alpha = 1.0f;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.13 animations:^{
                    self.transform = CGAffineTransformScale(transform, 0.9, 0.9);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 animations:^{
                        self.transform = transform;
                    } completion:^(BOOL finished) {
                        if (completion)
                            completion();
                    }];
                }];
            }];
        }
        else {
            
            [self showOverlay:NO];

            [UIView animateWithDuration:0.13 animations:^{
                self.transform = CGAffineTransformScale(transform, 1.1, 1.1);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.18 animations:^{
                    self.transform = CGAffineTransformScale(transform, 0.7, 0.7);
                    self.alpha = 0.0f;
                } completion:^(BOOL finished) {
                    [self cleanup];
                    if (completion)
                        completion();
                }];
            }];
        }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutComponents];
}

- (void)layoutComponents
{
    CGRect defaultFrame = [self defaultFrame];
    CGRect layoutFrame = CGRectInset(CGRectMake(0, 0, CGRectGetWidth(defaultFrame), CGRectGetHeight(defaultFrame)), 0, 0);
    CGRect textFrame = CGRectInset(layoutFrame, 6.0, 0.0);
    CGFloat layoutWidth = CGRectGetWidth(layoutFrame);
    
    // title frame
    CGFloat titleHeight = 0;
    CGFloat minY = CGRectGetMinY(layoutFrame);
    if (self.title.length > 0) {
        titleHeight = 40;
    }
    layout.titleRect = CGRectMake(CGRectGetMinX(layoutFrame), minY, CGRectGetWidth(textFrame), titleHeight);
    
    // message frame
    CGFloat messageHeight = 0;
    minY = CGRectGetMaxY(layout.titleRect);
    if (self.message.length > 0) {
        CGRect messageBounds = [self.message boundingRectWithSize:CGSizeMake(CGRectGetWidth(textFrame), MAXFLOAT)
                                                          options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                       attributes:@{NSFontAttributeName:self.messageFont}
                                                          context:nil];
        messageHeight = messageBounds.size.height;
        messageHeight = ceilf(messageHeight) + kURBAlertMessagePadding*2;
    }
    
    messageHeight = MAX(messageHeight, kURBAlertMessageDefaultHeight);
    
    layout.messageRect = CGRectMake(CGRectGetMinX(layoutFrame), minY, CGRectGetWidth(textFrame), messageHeight);
    
    // buttons frame
    NSUInteger totalButtons = [self.buttons count];
    CGFloat buttonsHeight = 0;

    minY = CGRectGetMaxY(layout.messageRect);
    if (totalButtons > 0) {
        buttonsHeight = kURBAlertButtonHeight;
    }

    layout.buttonRect = CGRectMake(CGRectGetMinX(layoutFrame), minY, layoutWidth, buttonsHeight);
    // adjust layout frame
    layoutFrame.size.height = CGRectGetMaxY(layout.buttonRect);
    
    //
    self.titleLabel.frame = layout.titleRect;
    self.messageLabel.frame = layout.messageRect;
    
    // layout buttons
    // if we have more than two buttons, we lay out buttons vertically, otherwise two buttons are placed next to each other horizontally
    NSUInteger count = self.buttons.count;
    if (count > 0) {
        
        // if we are laying buttons out vertically (more than two buttons) and we have a cancel button, shift array so cancel button will always be
        // inserted at the bottom of the button column
        if (count > 2 && self.cancelButton != nil) {
            if ([self buttonAtIndex:0] == self.cancelButton) {
                [self.buttons removeObject:self.cancelButton];
                [self.buttons addObject:self.cancelButton];
            }
        }
        
        CGFloat buttonWidth = (totalButtons > 2) ? CGRectGetWidth(layout.buttonRect) : (CGRectGetWidth(layout.buttonRect) - kURBAlertPadding * ((CGFloat)count - 1.0)) / (CGFloat)count;
        for (int i = 0; i < count; i++) {
            CGFloat xOffset = CGRectGetMinX(layout.buttonRect);
            CGFloat yOffset = CGRectGetMinY(layout.buttonRect);
            
            if (totalButtons == 1) {
                xOffset = CGRectGetMinX(layout.buttonRect) + (CGRectGetWidth(layout.buttonRect) - buttonWidth)*0.5;
            }else if (totalButtons > 2) {
                yOffset = CGRectGetMinY(layout.buttonRect) + (kURBAlertButtonHeight + kURBAlertPadding) * (CGFloat)i;
            }
            else {
                CGFloat padding = (CGRectGetWidth(layout.buttonRect) - buttonWidth*2) / (CGFloat)2;
                
                xOffset = CGRectGetMinX(layout.buttonRect) + ((buttonWidth+padding)*(CGFloat)i);
            }
            
            CGRect frame = CGRectIntegral(CGRectMake(xOffset, yOffset, buttonWidth, CGRectGetHeight(layout.buttonRect)));
            
            UIButton *button = (UIButton *)[self.buttons objectAtIndex:i];
            button.frame = frame;
            //button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            
            [self addSubview:button];
        }
    }
    
    // reset main frame based on title and message heights and set background frame and image
    CGFloat width = CGRectGetWidth(defaultFrame);
    CGFloat height = CGRectGetMaxY(layout.buttonRect);
    CGFloat posX = (screenSize.width - width) / 2.0;
    CGFloat posY = (screenSize.height - height) / 2.0;
    
    self.frame = CGRectIntegral(CGRectMake(posX, posY, width, height+10));
}

- (CGRect)defaultFrame {
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    // keep alert view in center of app frame
    CGRect insetFrame = CGRectIntegral(CGRectInset(appFrame, 10, (appFrame.size.height - kAlertViewDefaultSize.height) / 2));
    
    return insetFrame;
}

- (void)buttonTapped:(id)button {
    NSUInteger buttonIndex = [self.buttons indexOfObject:(UIButton *)button];
    if (self.block) {
        self.block(self, buttonIndex);
    }
    else if ([self.buttons count] == 1) {
        // if only a single button and no handler block, then it's probably just an "OK" button so automatically hide
        [self hide];
    }
}

- (UIView *)blurredBackground {
    UIView *backgroundView = [[UIApplication sharedApplication] keyWindow];
    UIImageView *blurredView = [[UIImageView alloc] initWithFrame:backgroundView.bounds];
    blurredView.image = [[backgroundView screenshot] boxblurImageWithBlur:0.08];
    
    return blurredView;
}

- (void)showOverlay:(BOOL)show {
    if (show) {
        // create a new window to add our overlay and dialogs to
        UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window = window;
        window.windowLevel = UIWindowLevelStatusBar + 1;
        window.opaque = NO;
        
        // darkened background
        if (self.darkenBackground) {
            self.overlay = [EGAlertWindowOverlay new];
            EGAlertWindowOverlay *overlay = self.overlay;
            overlay.opaque = NO;
            overlay.alertView = self;
            overlay.frame = self.window.bounds;
            overlay.alpha = 0.0;
        }
        
        // blurred background
        if (self.blurBackground) {
            self.blurredBackgroundView = [self blurredBackground];
            self.blurredBackgroundView.alpha = 0.0f;
            [self.window addSubview:self.blurredBackgroundView];
        }
        
        [self.window addSubview:self.overlay];
        self.backgroundColor = [UIColor redColor];
        [self.window addSubview:self];
        
        // window has to be un-hidden on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.window makeKeyAndVisible];
            
            // fade in overlay
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                self.blurredBackgroundView.alpha = 1.0f;
                self.overlay.alpha = 1.0f;
            } completion:^(BOOL finished) {
                // stub
            }];
        });
    }
    else {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.overlay.alpha = 0.0f;
            self.blurredBackground.alpha = 0.0f;
        } completion:^(BOOL finished) {
            self.blurredBackgroundView = nil;
        }];
    }
}

- (void)cleanup {

    self.alpha = 1.0f;
    self.window = nil;
    // rekey main AppDelegate window
    [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
}

@end

#pragma mark - EGAlertWindowOverlay

@implementation EGAlertWindowOverlay

- (void)drawRect:(CGRect)rect {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /// colors
    UIColor *gradientOuter = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.4];
    UIColor *gradientInner = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.4];
    
    NSArray *radialGradientColors = @[(id)gradientInner.CGColor, (id)gradientOuter.CGColor];
    CGFloat radialGradientLocations[] = {0, 0.5, 1};
    CGGradientRef radialGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)radialGradientColors, radialGradientLocations);
    
    // main shape
    UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextDrawRadialGradient(context, radialGradient,
                                CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2), rect.size.width / 4,
                                CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2), rect.size.width,
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);
    
    CGGradientRelease(radialGradient);
    CGColorSpaceRelease(colorSpace);
}

@end


#pragma mark - UIView + Screenshot

@implementation UIView (Screenshot)

- (UIImage*)screenshot {
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // hack, helps w/ our colors when blurring
    NSData *imageData = UIImageJPEGRepresentation(image, 1); // convert to jpeg
    image = [UIImage imageWithData:imageData];
    
    return image;
}

@end

#pragma mark - UIImage + Blur

@implementation UIImage (Blur)

-(UIImage *)boxblurImageWithBlur:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 50);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    
    //create vImage_Buffer with data from CGImageRef
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //create vImage_Buffer for output
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if (pixelBuffer == NULL)
        MyLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    //perform convolution
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    
    if (error) {
        MyLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

@end
