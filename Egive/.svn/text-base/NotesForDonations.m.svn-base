//
//  NotesForDonations.m
//  Egive
//
//  Created by sinogz on 15/9/23.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "NotesForDonations.h"

@interface NotesForDonations ()

@end

@implementation NotesForDonations

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = EGLocalizedString(@"MyDonation_designationButton", nil);
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self getShoppingCartDisclaimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getShoppingCartDisclaimer
{
    MemberModel *member = [ShowMenuView sharedInstance].member;
    NSString *LocationCode = [ShowMenuView sharedInstance].LocationCode;
    
    NSString *memberID = member ? member.MemberID : @"";
    NSString *locCode = LocationCode ?  LocationCode:@"HK";
    __weak __typeof(self)weakself = self;
    [EGMyDonationRequestAdapter getShoppingCartDisclaimerWithLocationCode:locCode memberID:memberID success:^(NSString *result) {
        MyLog(@"%@",result);
        [weakself parseHTML:result];
    } failure:^(NSError *error) {
        MyLog(@"%@",error);
    }];
    
}

//#pragma mark HTML数据解析
//- (void)parseHTML:(NSString*)htmlString
//{
//    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br /><br />" withString:@"</p><p>"];
//    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
//    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"</span>" withString:@"</span></p><p>"];
//    
//    NSData *dataTitle=[htmlString dataUsingEncoding:NSUTF8StringEncoding];
//    
//    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
//    
//    NSArray *elements=[xpathParser searchWithXPathQuery:@"//p"];
//    
//    [self parseElements:elements];
//}

@end
