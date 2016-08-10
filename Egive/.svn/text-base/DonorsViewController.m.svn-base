//
//  DonorsViewController.m
//  Egive
//
//  Created by sino on 15/7/28.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "Constants.h"
#import "DonorsViewController.h"
#import "UIView+ZJQuickControl.h"

//#import "ZJScreenAdaptation.h"
//#import "ZJScreenAdaptationMacro.h"

#import "EGUtility.h"

#define ScreenSize [UIScreen mainScreen].bounds.size

@interface DonorsViewController (){
    NSMutableArray * _dataArray;
}

@end

@implementation DonorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [NSString stringWithFormat:@"%@(%ld)", EGLocalizedString(@"捐款者", nil), _donors.count];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;

    _dataArray = [[NSMutableArray alloc] init];
    
    [self createUI];
    
}

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createUI{
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height)];

    [self.view addSubview:scrollView];
    
    for (NSDictionary * donorsDict in _donors) {
        NSDictionary * dict = [[NSDictionary alloc]initWithObjectsAndKeys:donorsDict[@"DonorName"],@"DonorName",donorsDict[@"ImgURL"],@"ImgURL", nil];
        [_dataArray addObject:dict];
    }
    
   // scrollView.contentSize = CGSizeMake(0, _donors.count/3*120);
    
    for (int i = 0; i < _donors.count; i ++) {
        
        NSDictionary * dict = _dataArray[i];
        float ImageVW=(ScreenSize.width-3*76)/4;
//        UIImageView * donorsImage = [scrollView addImageViewWithFrame:CGRectMake(i%3*105+15, i/3*120+20, 76, 76) image:nil];
        UIImageView * donorsImage = [scrollView addImageViewWithFrame:CGRectMake(ImageVW+i%3*(76+ImageVW), i/3*120+20, 76, 76) image:nil];
        donorsImage.backgroundColor = [UIColor grayColor];
        donorsImage.layer.cornerRadius = 76/2;
        donorsImage.layer.masksToBounds = YES;
        NSURL *url = [NSURL URLWithString:SITE_URL];
        url = [url URLByAppendingPathComponent:dict[@"ImgURL"]];
        [donorsImage setImageWithURL:url];

        float IVW=(ScreenSize.width-3*93)/4;
//        UILabel * donorsName = [scrollView addLabelWithFrame:CGRectMake(i%3*103+10, i/3*120+96, 93, 40) text:dict[@"DonorName"]];
         UILabel * donorsName = [scrollView addLabelWithFrame:CGRectMake(IVW+i%3*(93+IVW), i/3*120+96, 93, 40) text:dict[@"DonorName"]];
       // donorsName.backgroundColor=[UIColor redColor];
        donorsName.textAlignment = NSTextAlignmentCenter;
        donorsName.font = [UIFont systemFontOfSize:13];
        donorsName.numberOfLines = 3;
        donorsName.textColor = [UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1];
        donorsName.textAlignment = NSTextAlignmentCenter;
    }
    int lines = (int)_donors.count/3;
    if (_donors.count %3 > 0) lines++;
    
    MyLog(@"lines = %d", lines);
    
    scrollView.contentSize = CGSizeMake(ScreenSize.width,lines * 120+20);
    //[scrollView sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
