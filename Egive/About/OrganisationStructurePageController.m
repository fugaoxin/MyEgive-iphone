//
//  OrganisationStructurePageController.m
//  Egive
//
//  Created by sinogz on 15/9/10.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "OrganisationStructurePageController.h"

@interface OrganisationStructurePageController ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIImageView *imageView;
@end

@implementation OrganisationStructurePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = EGLocalizedString(@"AboutGird_label_title3", nil);
    
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

    self.navigationItem.rightBarButtonItem = nil;
    currentY = 64;
    
    mScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    mScrollView.backgroundColor = [UIColor clearColor];
    mScrollView.delegate = self;
    [self.view addSubview:mScrollView];
    
//    [mScrollView addImageViewWithFrame:CGRectMake(0, 0, kScreenW, 200) image:@"testImage.jpg"];
//    
//    UIPageControl  * pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 180, kScreenW, 20)];
//    pageControl.numberOfPages = 4;
//    pageControl.backgroundColor = [UIColor grayColor];
//    [mScrollView addSubview:pageControl];
    
    
    [self getStaticPageContentWithFormID:@"Public_OrganizationStructure"];
//    [self parseHTML:nil];
}

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)parseHTML:(NSString*)htmlString
{
//    NSString *html = @"<ul id=\"ctl00_cnt_PageContent_ContentList\" class=\"ContentList2 OrganizationStructureList\" style=\"padding-top:58px;\"><li><img src=\"Images/OChart.jpg\" alt="" class=\"OrganizationStructure\"</li></ul>";
    
//     NSString *html = @"<ul id='ContentList' class='ContentList2 OrganizationStructureList'><li><img src=\"Images/OChart_EN.jpg\" alt="" class=\"OrganizationStructure\"</li></ul>";
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    
    NSData *dataTitle=[htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
    
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//ul"];
    
    [self parseElements:elements];
}

- (void)addSubImageView:(NSURL *)imageURL {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView = imageView;
    
    __weak __typeof(self)weakSelf = self;
    [imageView sd_setImageWithURL:imageURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        // 基本尺寸参数
        CGSize boundsSize = mScrollView.bounds.size;
        CGFloat boundsWidth = boundsSize.width;
        CGSize imageSize = image.size;
        CGFloat imageWidth = imageSize.width;
        CGFloat imageHeight = imageSize.height;
        
        // 设置伸缩比例
        CGFloat minScale = boundsWidth / imageWidth;
        if (minScale > 1) {
            minScale = 1.0;
        }
        CGFloat maxScale = minScale*2;

        mScrollView.maximumZoomScale = maxScale;
        mScrollView.minimumZoomScale = minScale;
        mScrollView.zoomScale = minScale;
        
        CGRect imageFrame = CGRectMake(0, 0, boundsWidth, imageHeight * boundsWidth / imageWidth);
        // 内容尺寸
        mScrollView.contentSize = CGSizeMake(0, imageFrame.size.height);
        imageView.frame = imageFrame;
    }];
    [mScrollView addSubview:imageView];
}

@end
