//
//  AboutGridViewController.m
//  Egive
//
//  Created by sino on 15/7/30.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "AboutGridViewController.h"
#import "MyDonationViewController.h"
#import "UIView+ZJQuickControl.h"
#import "AboutDetailViewController.h"
#import "AboutUsPageController.h"
#import "ChairmanPageController.h"
#import "OrganisationStructurePageController.h"
#import "SponsorPageController.h"
#import "donationMethodPageController.h"
#import "FAQPageController.h"
#import "EGUtility.h"
#import "ZJScreenAdaptation.h"
#import "ZJScreenAdaptationMacro.h"
#import "EGStaticPageRequestAdapter.h"

#define ScreenSize [UIScreen mainScreen].bounds.size
@interface AboutGridViewController ()
{
    NSArray * _dataArray;
    NSArray * _imageArray;
    UIImageView * _navImage;
}
@property (strong, nonatomic) UILabel * cartLabel;
@end

@implementation AboutGridViewController

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
       // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    self.title = EGLocalizedString(@"MenuView_aboutButton_title", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    leftButton.transform = CGAffineTransformScale(leftButton.transform, 0.85, 0.85);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 33, 33);
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_cart@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    //购物车右侧数量标示label
    NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
    EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
    
    _cartLabel = [self.navigationController.navigationBar addLabelWithFrame:CGRectMake(ScreenSize.width-30, 18, 18, 18) text:[NSString stringWithFormat:@"%ld",item.NumberOfItems]];
    _cartLabel.layer.cornerRadius = 9;
    _cartLabel.layer.masksToBounds = YES;
    _cartLabel.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    _cartLabel.textAlignment = NSTextAlignmentCenter;
    _cartLabel.font = [UIFont systemFontOfSize:11];
    _cartLabel.textColor = [UIColor whiteColor];
    if (item.NumberOfItems < 1) {
        _cartLabel.hidden = YES;
    }else{
        _cartLabel.hidden = NO;
    }
    
    _dataArray = @[EGLocalizedString(@"AboutGird_label_title1", nil),EGLocalizedString(@"AboutGird_label_title2", nil),EGLocalizedString(@"AboutGird_label_title3", nil),EGLocalizedString(@"AboutGird_label_title4", nil),EGLocalizedString(@"AboutGird_label_title5", nil),EGLocalizedString(@"AboutGird_label_title6", nil)];
    _imageArray = @[@"about_us_idea_btn@2x.png",
                    @"about_us_speech_btn@2x.png",
                    @"about_us_structure_btn@2x.png",
                    @"about_us_sponsor_btn@2x.png",
                    @"about_us_method_btn@2x.png",
                    @"about_us_q_a_btn@2x.png"];
    
    [self createUI];
    [self createFooterButton];
    [self createMenuUI];
}
- (void)rightAction{
    
    MyDonationViewController * vc = [[MyDonationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)createUI {
    
    for (int i = 0; i < _dataArray.count; i ++){
        
        if (ScreenSize.height==480) {
            UIImageView * imageView = [self.view addImageViewWithFrame:CGRectMake(i%2*170+35,i/2*120+84 , 80,80) image:_imageArray[i]];
            imageView.userInteractionEnabled = YES;
            imageView.tag = 210+i;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageAction:)];
            [imageView addGestureRecognizer:tap];
            
            UILabel * label = [self.view addLabelWithFrame:CGRectMake(i%2*(150+20),i/2*120+170 , 150, 40) text:_dataArray[i]];
            //label.backgroundColor = [UIColor redColor];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            if (i == 2 || i== 4) {
                //            label.frame = CGRectMake(i%2*150+35,i/2*150+190 , 100, 40);
                label.numberOfLines = 2;
            }
        }else{
        UIImageView * imageView = [self.view addImageViewWithFrame:CGRectMake(i%2*150+35,i/2*150+84 , 100,100) image:_imageArray[i]];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 210+i;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageAction:)];
        [imageView addGestureRecognizer:tap];
        
        UILabel * label = [self.view addLabelWithFrame:CGRectMake(i%2*150+10,i/2*150+190 , 150, 40) text:_dataArray[i]];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        if (i == 2 || i== 4) {
//            label.frame = CGRectMake(i%2*150+35,i/2*150+190 , 100, 40);
            label.numberOfLines = 2;
        }
    }
        
    }
    
}

- (void)tapImageAction:(UITapGestureRecognizer *)tap {
    
    int tag = (int)tap.view.tag;
    switch (tag) {
        case 210:
        {
            AboutUsPageController * vc = [[AboutUsPageController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 211:
        {
            ChairmanPageController * vc = [[ChairmanPageController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 212:
        {
            OrganisationStructurePageController * vc = [[OrganisationStructurePageController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 213:
        {
            SponsorPageController * vc = [[SponsorPageController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 214:
        {
            donationMethodPageController * vc = [[donationMethodPageController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 215:
        {
            FAQPageController * vc = [[FAQPageController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    _cartLabel.hidden = NO;
    //购物车右侧数量标示label
    NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
    EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
    if (item.NumberOfItems < 1) {
        _cartLabel.hidden = YES;
    }else{
        _cartLabel.hidden = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    
    _cartLabel.hidden = YES;
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
