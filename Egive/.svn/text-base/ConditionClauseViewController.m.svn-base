//
//  ConditionClauseViewController.m
//  Egive
//
//  Created by sino on 15/9/12.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ConditionClauseViewController.h"
#import "EGUtility.h"

@interface ConditionClauseViewController ()
@property (nonatomic, strong)MDHTMLLabel *htmlLabel;
@property (nonatomic, copy)NSString *htmlString;
@end

@implementation ConditionClauseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = EGLocalizedString(@"条款及细则", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.rightBarButtonItem = nil;
    [self getStaticPageContentWithFormID:@"TermsOfUse"];
    
    currentY = 200;
    
    mScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    mScrollView.backgroundColor = [UIColor clearColor];
    mScrollView.delegate = self;
    [self.view addSubview:mScrollView];
    [self addMySlider];
    
}

- (void)parseHTML:(NSString*)htmlString
{
    MDHTMLLabel *htmlLabel = [[MDHTMLLabel alloc] init];
    htmlLabel.delegate = self;
    htmlLabel.numberOfLines = 0;
    htmlLabel.font = [UIFont systemFontOfSize:15];
    //htmlLabel.shadowColor = [UIColor whiteColor];
    //htmlLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    //htmlLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _htmlLabel = htmlLabel;
    
    htmlLabel.linkAttributes = @{
                                 NSForegroundColorAttributeName: [UIColor blackColor],
                                 NSFontAttributeName: [UIFont systemFontOfSize:15],
                                 NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    
    htmlLabel.activeLinkAttributes = @{
                                       NSForegroundColorAttributeName: [UIColor blackColor],
                                       NSFontAttributeName: [UIFont systemFontOfSize:15],
                                       NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    _htmlString = htmlString;
    
    htmlLabel.htmlText = htmlString;
    
    [mScrollView addSubview:htmlLabel];
    
    CGRect rect = [UIScreen mainScreen].bounds;
    
    CGSize maxSize = CGSizeMake(rect.size.width - 20, CGFLOAT_MAX);
    
    CGSize size = [htmlLabel sizeThatFits:maxSize];
    
    htmlLabel.frame = CGRectMake(10, 10, size.width, size.height);
    mScrollView.contentSize = CGSizeMake(0, size.height + 20);
    
}

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sliderDragUp{
    
    float value = self.slider.value;
    float change = 6*(value - 0.5);
    CGFloat fontSize = 15 + change;
    
    _htmlLabel.numberOfLines = 0;
    _htmlLabel.font = [UIFont systemFontOfSize:fontSize];
    _htmlLabel.htmlText = @"";
    _htmlLabel.htmlText = _htmlString;
    
    CGFloat height = [MDHTMLLabel sizeThatFitsHTMLString:_htmlLabel.htmlText withFont:[UIFont systemFontOfSize:fontSize] constraints:CGSizeMake(self.view.bounds.size.width - 20, CGFLOAT_MAX) limitedToNumberOfLines:0 autoDetectUrls:YES];
    //    CGRect rect = [UIScreen mainScreen].bounds;
    //    CGSize maxSize = CGSizeMake(rect.size.width - 20, CGFLOAT_MAX);
    //    CGSize size = [_htmlLabel sizeThatFits:maxSize];
    
    _htmlLabel.frame = CGRectMake(10, 10, self.view.bounds.size.width - 20, height);
    
    mScrollView.contentSize = CGSizeMake(0, height + 20);
}

@end
