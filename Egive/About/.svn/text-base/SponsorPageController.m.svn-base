//
//  SponsorPageController.m
//  Egive
//
//  Created by sinogz on 15/9/10.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "SponsorPageController.h"
#import "MenuViewController.h"
@interface SponsorPageController ()<UIScrollViewDelegate>

@end

@implementation SponsorPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = EGLocalizedString(@"AboutGird_label_title4", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    mScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    mScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mScrollView];

    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 33, 33);
    [rightButton addTarget:self action:@selector(chairmanButton) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_share@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    currentY = 64;
    
    mScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    mScrollView.backgroundColor = [UIColor clearColor];
    mScrollView.delegate = self;
    mScrollView.maximumZoomScale=3.0;
    mScrollView.minimumZoomScale=0.5;
    [self.view addSubview:mScrollView];
    
//    [self parseHTML:nil];
    [self getStaticPageContentWithFormID:@"Public_Egiver"];
}

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)chairmanButton{
    
    [self shareSystem:self];
}
-(void)shareSystem:(UIViewController *)viewController{
    
    NSString * string = @"";
    NSString * subject = @"";
    if ([EGUtility getAppLang]==1) {
        NSString *str = @"Egive 意贈慈善基金由一群熱心公益的社會賢達創辦，旨在團結個人力量，以生命影響生命的方法，透過互聯網募捐平台不分地域、文化、族裔和語言，將受惠者、捐款者及公眾緊密連繫起來，宣揚關懷互愛的訊息，共建關懷互助的社群，以達致「網絡相連．善心相傳」之效\n\n請瀏覽: http://www.egive4u.org/";
        string = str;
        subject = @"Egive 意贈慈善基金";
        
    }else if ([EGUtility getAppLang]==2){
        NSString *str = @"Egive 意赠慈善基金由一群热心公益的社会贤达创办，旨在团结个人力量，以生命影响生命的方法，透过互联网募捐平台不分地域、文化、族裔和语言，将受惠者、捐款者及公众紧密连系起来，宣扬关怀互爱的讯息，共建关怀互助的社群，以达致「网络相连．善心相传」之效。\n\n请浏览: http://www.egive4u.org/";
        string = str;
        subject = @"Egive 意赠慈善基金";
    }else{
        
        NSString * str = [NSString stringWithFormat:@"\"Egive\" was founded by a group of public-spirited community leaders who aim to gather everyone to touch the lives of each other. \n\n For more details, please visit us at www.egive4u.org\n\n"];
        string = str;
        
        subject = @"Egive For You Charity Foundation";
    }
    
  [MenuViewController shareToSocialNetworkWithSubject:subject content:string url:nil image:nil];
    
//    UIActivityViewController *activityViewController =
//    [[UIActivityViewController alloc] initWithActivityItems:@[string]
//                                      applicationActivities:nil];
//    [self.navigationController presentViewController:activityViewController
//                                            animated:YES
//                                          completion:^{
//                                              // ...
//                                          }];
//    activityViewController.excludedActivityTypes = @[UIActivityTypePrint];
//    [activityViewController setValue:subject forKey:@"subject"];
    
}
- (void)parseHTML:(NSString*)htmlString
{
//    NSString *html = @"<ul id=\"ctl00_cnt_PageContent_ContentList\" class=\"ContentList2 OrganizationStructureList\" style=\"padding-top:58px;\"><li><img src=\"Images/Egiver_TC.jpg\" alt="" />";
    
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    
    NSData *dataTitle=[htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
    
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//img"];
    
//    TFHppleElement *element = [elements firstObject];
//    MyLog(@"%@",element.content);
    
    [self parseElements:elements];
}

- (void)addSubImageView:(NSURL *)imageURL {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    __weak __typeof(self)weakSelf = self;
    [imageView sd_setImageWithURL:imageURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        CGFloat height = (weakSelf.view.frame.size.width-30)/image.size.width * image.size.height;
        
        CGRect rect = CGRectMake(15, currentY, weakSelf.view.frame.size.width-30, height);
        
        currentY += height + 10;
        
        imageView.frame = rect;
        imageView.tag = 100;
        [mScrollView setContentSize:CGSizeMake(weakSelf.view.frame.size.width, currentY)];
    }];
    [mScrollView addSubview:imageView];
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    UIImageView * image = (UIImageView *)[scrollView viewWithTag:100];
    return image;
}
@end
