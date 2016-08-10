//
//  FAQPageController.m
//  Egive
//
//  Created by sinogz on 15/9/10.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "FAQPageController.h"
#import "MenuViewController.h"
@interface FAQPageController ()<UIScrollViewDelegate>

@end

@implementation FAQPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = EGLocalizedString(@"AboutGird_label_title6", nil);
//    self.navigationItem.rightBarButtonItem = nil;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 33, 33);
    [rightButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_share@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    mScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    mScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mScrollView];


    [self getStaticPageContentWithFormID:@"Public_HowToJoin"];

    currentY = 64;

    mScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    mScrollView.backgroundColor = [UIColor clearColor];
    mScrollView.delegate = self;
    mScrollView.maximumZoomScale=3.0;
    mScrollView.minimumZoomScale=0.5;
    [self.view addSubview:mScrollView];


//[self parseHTML:nil];
}

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)shareAction{
    
    NSString * string = @"";
    NSString * subject = @"";
    if ([EGUtility getAppLang]==1) {
        NSString *str = @"Egive - 常見問題  http://www.egive4u.org/FAQ.aspx\n\n請瀏覽: http://www.egive4u.org/\n\n意贈慈善基金\nEgive For You Charity Foundation\n電話: (852) 2210 2600\n電郵: info@egive4u.org";
        string = str;
        subject = @"Egive - 常見問題";
        
        
    }else if ([EGUtility getAppLang]==2){
        NSString *str = @"Egive - 常见问题  http://www.egive4u.org/FAQ.aspx\n\n请浏览: http://www.egive4u.org/\n\n意赠慈善基金\nEgive For You Charity Foundation\n电话: (852) 2210 2600\n电邮: info@egive4u.org";
        string = str;
        subject = @"Egive - 常见问题";
    }else{
        
        NSString * str = [NSString stringWithFormat:@"Egive - FAQ www.egive4u.org/FAQ.aspx\n\nVisit us at www.egive4u.org\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org"];
        string = str;
        subject = @"Egive - FAQ";
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
//    
//    [activityViewController setValue:subject forKey:@"subject"];
    
}


- (void)parseHTML:(NSString*)htmlString
{
//    NSString *html = @"<ul id=\"ctl00_cnt_PageContent_ContentList\" class=\"ContentList2 OrganizationStructureList\" style=\"padding-top:58px;\"><li><img src=\"Images\\HowToSupport_TC.jpg\" class=\"\" alt=\"\" usemap=\"#ImgMap_HowToSupport_TC\" />";
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    
    NSData *dataTitle=[htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
    
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//img"];
    
    [self parseElements:elements];
}

- (void)addSubImageView:(NSURL *)imageURL {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    __weak __typeof(self)weakSelf = self;
    [imageView sd_setImageWithURL:imageURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        CGFloat height = (weakSelf.view.frame.size.width-30)/image.size.width * image.size.height;
        
        CGRect rect = CGRectMake(15, currentY, weakSelf.view.frame.size.width-30, height);
        
        currentY += height + 10;
        
        imageView.frame = rect;
        imageView.tag = 100;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
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
