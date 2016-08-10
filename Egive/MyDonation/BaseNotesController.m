//
//  BaseNotesController.m
//  Egive
//
//  Created by sinogz on 15/9/24.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "BaseNotesController.h"
#import "MDHTMLLabel.h"
#import "EGStaticPageRequestAdapter.h"

@interface BaseNotesController ()<MDHTMLLabelDelegate>

@property (nonatomic, assign)CGFloat currentY;
@end

@implementation BaseNotesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _currentY = 10;
    
    self.contentView.layer.cornerRadius = 8;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.borderWidth = 0.5;
    self.contentView.layer.borderColor = [kPurpleColor CGColor];
    
    [self.cancelButton setTitle:EGLocalizedString(@"Common_button_close", nil) forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark HTML数据解析
- (void)parseHTML:(NSString*)htmlString
{
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br /><br />" withString:@"</p><p>"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"</span>" withString:@"</span></p><p>"];
    
    NSData *dataTitle=[htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
    
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//p"];
    
    [self parseElements:elements];
}

-(void)parseElements:(NSArray *)elements
{
    for (TFHppleElement *element in elements) {
        NSArray *childs=[element children];
        if (childs.count) {
            [self parseElements:childs];
        } else {
            //没有子节点
            if ([element.tagName isEqualToString:@"span"]) {
                //MyLog(@"tagName:%@, content:%@", element.tagName, element.content);
                [self addTitleText:element.content font:kTitleFontH2];
            } else if ([element.tagName isEqualToString:@"p"]) {
                //MyLog(@"tagName:%@, content:%@", element.tagName, element.content);
                [self addSubText:element.content];
            }
        }
    }
}
//添加文章标题
- (void)addTitleText:(NSString *)content font:(UIFont*)font {
    
    FDLabelView *titleView = [[FDLabelView alloc] initWithFrame:CGRectMake(10, _currentY, _noteView.frame.size.width-20, 0)];
    //titleView.backgroundColor = [UIColor redColor];
    titleView.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    //titleView.backgroundColor = [UIColor redColor];
    titleView.font = kTitleFontH2;
    titleView.minimumScaleFactor = 0.50;
    titleView.numberOfLines = 0;
    titleView.text = content;
    titleView.lineHeightScale = 0.90;
    titleView.fixedLineHeight = 25;
    titleView.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
    titleView.fdTextAlignment = FDTextAlignmentLeft;
    titleView.fdAutoFitMode = FDAutoFitModeAutoHeight;
    titleView.fdLabelFitAlignment = FDLabelFitAlignmentCenter;
    titleView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    [_noteView addSubview:titleView];
    _currentY += titleView.visualTextHeight;
    [_noteView setContentSize:CGSizeMake(0, _currentY)];
}

//添加文章段落
- (void)addSubText:(NSString *)content {
    
    
    FDLabelView *titleView = [[FDLabelView alloc] initWithFrame:CGRectMake(10, _currentY, _noteView.frame.size.width-20, 0)];
    titleView.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.00];
    titleView.textColor = [UIColor blackColor];
    //titleView.backgroundColor = [UIColor redColor];
    titleView.font = [UIFont systemFontOfSize:14];
    titleView.minimumScaleFactor = 0.50;
    titleView.numberOfLines = 0;
    titleView.text = content;
    titleView.lineHeightScale = 0.80;
    titleView.fixedLineHeight = 20;
    titleView.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
    titleView.fdTextAlignment = FDTextAlignmentLeft;
    titleView.fdAutoFitMode = FDAutoFitModeAutoHeight;
    titleView.fdLabelFitAlignment = FDLabelFitAlignmentCenter;
    titleView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    [_noteView addSubview:titleView];
    
    _currentY += titleView.visualTextHeight;
    
    [_noteView setContentSize:CGSizeMake(0, _currentY)];
    
    titleView.debug = NO;
}

#pragma mark htmlPares
- (void)getStaticPageContentWithFormID:(NSString*)formID
{
    [EGStaticPageRequestAdapter GetStaticPageContentWithFormID:formID success:^(EGGetStaticPageContentResult *result) {
        if (result.ContentText) {
            [self parseHTML2:result.ContentText];
        }
    } failure:^(NSError *error) {
       // MyLog(@"error:%@",error);
    }];
}

- (void)parseHTML2:(NSString *)htmlString
{
    MDHTMLLabel *htmlLabel = [[MDHTMLLabel alloc] init];
    htmlLabel.delegate = self;
    htmlLabel.numberOfLines = 0;
    htmlLabel.font = [UIFont systemFontOfSize:15];
    //htmlLabel.shadowColor = [UIColor whiteColor];
    //htmlLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    //htmlLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    htmlLabel.linkAttributes = @{
                                 NSForegroundColorAttributeName: [UIColor blackColor],
                                 //NSFontAttributeName: [UIFont systemFontOfSize:15],
                                 NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    
    htmlLabel.activeLinkAttributes = @{
                                       NSForegroundColorAttributeName: [UIColor blackColor],
                                       //NSFontAttributeName: [UIFont systemFontOfSize:15],
                                       NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    
    htmlLabel.htmlText = htmlString;
    
    [self.noteView addSubview:htmlLabel];
    
    CGRect rect = self.noteView.frame;
    
    CGSize maxSize = CGSizeMake(rect.size.width - 20, CGFLOAT_MAX);
    
    CGSize size = [htmlLabel sizeThatFits:maxSize];
    
    htmlLabel.frame = CGRectMake(10, 10, size.width, size.height);
    self.noteView.contentSize = CGSizeMake(0, size.height + 20);
}

- (IBAction)cancelAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
