//
//  RecordDtlViewController.m
//  Egive
//
//  Created by sino on 15/9/23.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "RecordDtlViewController.h"
#import "UIView+ZJQuickControl.h"
#import "baseController.h"
#import "EGUtility.h"
#import "MenuViewController.h"

#define ScreenSize [UIScreen mainScreen].bounds.size
@interface RecordDtlViewController ()

@end

@implementation RecordDtlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber--;
    
    // Do any additional setup after loading the view.
    self.title = EGLocalizedString(@"MyDonation_recordButton", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 33, 33);
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_share@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self createUI];
}

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightAction{
    
    NSString * string = @"";
    NSString * subject = @"";
    if ([EGUtility getAppLang]==1) {
        NSString *str = [NSString stringWithFormat:@"我剛剛贊助了Eigve - %@，您也來支持！\n\n請瀏覽: http://www.egive4u.org/\n\n意贈慈善基金\nEgive For You Charity Foundation\n電話: (852) 2210 2600\n電郵: info@egive4u.org",_record.CaseTitle];
        string = str;
         subject = [NSString stringWithFormat:@"請支持Egive專案 – %@",_record.CaseTitle];
    }else if ([EGUtility getAppLang]==2){
        NSString *str = [NSString stringWithFormat:@"我刚刚赞助了Eigve - %@，您也来支持！\n\n请浏览: http://www.egive4u.org/\n\n意赠慈善基金\nEgive For You Charity Foundation\n电話: (852) 2210 2600\n电邮: info@egive4u.org",_record.CaseTitle];
        string = str;
        subject = [NSString stringWithFormat:@"请支持Egive项目 –%@",_record.CaseTitle];
    }else{
        
        NSString *str = [NSString stringWithFormat:@"I just made an donation to support Egive - %@, let's join me and support Egive!\n\nVisit us at www.egive4u.org\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org",_record.CaseTitle];
        string = str;
       
        subject = [NSString stringWithFormat:@"Let's support Egive Projects - %@",_record.CaseTitle];
        
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

- (void)createUI{
    
    UILabel * projectTitleLabel = [self.view addLabelWithFrame:CGRectMake(20, 80, ScreenSize.width/2-20, 25) text:EGLocalizedString(@"捐款项目", nil)];
    projectTitleLabel.textColor = [UIColor grayColor];
    projectTitleLabel.font = [UIFont systemFontOfSize:15];
    
    UILabel * projectTitle = [self.view addLabelWithFrame:CGRectMake(20, 105, ScreenSize.width/2, 40) text:_record.CaseTitle];
    projectTitle.numberOfLines = 2;
    projectTitle.font = [UIFont systemFontOfSize:15];
    
    UILabel * moneyLabel = [self.view addLabelWithFrame:CGRectMake(ScreenSize.width/2+20, 80, ScreenSize.width/2-20, 25) text:EGLocalizedString(@"捐款金额", nil)];
    moneyLabel.textColor = [UIColor grayColor];
    moneyLabel.font = [UIFont systemFontOfSize:15];
    
    UILabel * money = [self.view addLabelWithFrame:CGRectMake(ScreenSize.width/2+20, 112, 100, 25) text:[NSString stringWithFormat:@"HK$ %@", _record.Amt]];
    money.textColor = [UIColor grayColor];
    money.font = [UIFont systemFontOfSize:15];
    
    //线
    [self.view addImageViewWithFrame:CGRectMake(10, 140, ScreenSize.width-20, 2) image:@"Line@2x.png"];
    AppLang lang = [EGUtility getAppLang];
    
    
    UILabel * dateLabel = [self.view addLabelWithFrame:CGRectMake(20, 145, ScreenSize.width/2-20, 25) text:EGLocalizedString(@"捐款日期", nil)];
    dateLabel.textColor = [UIColor grayColor];
    dateLabel.font = [UIFont systemFontOfSize:15];
    
    UILabel * date;
    if (lang==3) {
        date = [self.view addLabelWithFrame:CGRectMake(20, 170+10, ScreenSize.width/2, 25) text:[NSString stringWithDataString:_record.DonateDate format:@"yyyy/MM/dd"]];
    }else{
        date = [self.view addLabelWithFrame:CGRectMake(20, 170, ScreenSize.width/2, 25) text:[NSString stringWithDataString:_record.DonateDate format:@"yyyy/MM/dd"]];
    }
    date.font = [UIFont systemFontOfSize:15];
    
    
    UILabel * receivedLabel;
    if (lang==3) {
        receivedLabel = [self.view addLabelWithFrame:CGRectMake(ScreenSize.width/2+20, 145, ScreenSize.width/2-20, 40) text:EGLocalizedString(@"受助者收到金额", nil)];
    }else{
        receivedLabel = [self.view addLabelWithFrame:CGRectMake(ScreenSize.width/2+20, 145, ScreenSize.width/2-20, 25) text:EGLocalizedString(@"受助者收到金额", nil)];
    }
    receivedLabel.textColor = [UIColor grayColor];
    receivedLabel.numberOfLines = 0;
    receivedLabel.font = [UIFont systemFontOfSize:15];
    
    UILabel * receivedMoney;
    if (lang==3) {
        receivedMoney = [self.view addLabelWithFrame:CGRectMake(ScreenSize.width/2+20, 170+10, ScreenSize.width/2-20, 25) text:[NSString stringWithFormat:@"HK$ %@",_record.ReceivedAmt]];
    }else{
        receivedMoney = [self.view addLabelWithFrame:CGRectMake(ScreenSize.width/2+20, 170, ScreenSize.width/2-20, 25) text:[NSString stringWithFormat:@"HK$ %@",_record.ReceivedAmt]];
    }
    receivedMoney.textColor = [UIColor grayColor];
    receivedMoney.font = [UIFont systemFontOfSize:14];
    
    
    UILabel * sourceLabel = [self.view addLabelWithFrame:CGRectMake(20, 200, ScreenSize.width/2-20, 25) text:EGLocalizedString(@"捐款來源", nil)];
    sourceLabel.textColor = [UIColor grayColor];
    sourceLabel.font = [UIFont systemFontOfSize:15];
    
    UILabel * source = [self.view addLabelWithFrame:CGRectMake(20, 230, ScreenSize.width/2, 25) text:_record.Location];
    source.font = [UIFont systemFontOfSize:15];
    
    
    UILabel * wayLabel = [self.view addLabelWithFrame:CGRectMake(20, 260, ScreenSize.width/2-20, 25) text:EGLocalizedString(@"捐款形式", nil)];
    wayLabel.textColor = [UIColor grayColor];
    wayLabel.font = [UIFont systemFontOfSize:15];
    
    UILabel * way = [self.view addLabelWithFrame:CGRectMake(20, 285, ScreenSize.width-20, 25) text:nil];
    way.font = [UIFont systemFontOfSize:15];
    way.textAlignment = NSTextAlignmentLeft;
    if ([_record.ChargeIncluded integerValue]==1) {
        way.text = EGLocalizedString(@"包括手续费", nil);
        
    }else{
        way.text = EGLocalizedString(@"不包括手续费", nil);

    }
    
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
