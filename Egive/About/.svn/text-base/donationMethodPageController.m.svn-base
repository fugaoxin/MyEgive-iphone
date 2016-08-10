//
//  donationMethodPageController.m
//  Egive
//
//  Created by sinogz on 15/9/10.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "donationMethodPageController.h"

@interface donationMethodPageController ()<UIScrollViewDelegate>

@end

@implementation donationMethodPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = EGLocalizedString(@"AboutGird_label_title5", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;

    self.navigationItem.rightBarButtonItem = nil;
    currentY = 64;
    mScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    mScrollView.delegate = self;
    mScrollView.maximumZoomScale=3.0;
    mScrollView.minimumZoomScale=0.5;
   
    mScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mScrollView];
    
//    [self parseHTML:nil];
    [self getStaticPageContentWithFormID:@"Public_DonationFlow"];
}

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)parseHTML:(NSString*)htmlString
{
//    NSString *html = @"<ul id=\"ctl00_cnt_PageContent_ContentList\" class=\"ContentList2 OrganizationStructureList\" style=\"padding-top:58px;\"><li><img src=\"Images/DonationFlow.png\" alt="" class=\"OrganizationStructure\"</li></ul>";

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
        imageView.tag = 110;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
       
        [mScrollView setContentSize:CGSizeMake(weakSelf.view.frame.size.width, currentY)];
    }];
    [mScrollView addSubview:imageView];
    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    UIImageView * image = (UIImageView *)[scrollView viewWithTag:110];
    return image;
}
@end
