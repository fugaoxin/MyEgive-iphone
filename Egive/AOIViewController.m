//
//  AOIViewController.m
//  Egive
//
//  Created by sino on 15/7/29.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "AOIViewController.h"
#import "UIView+ZJQuickControl.h"
#import "AOIViewCell.h"
#import "RankingDetailListController.h"
#import "EGUtility.h"
#import "Constants.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface AOIViewController ()<UITableViewDataSource,UITableViewDelegate>
{
  
    NSArray * _imageArray;
}
@property (strong, nonatomic)UITableView * tableView;
@property (strong, nonatomic) UIImageView * dateimage;
@end

@implementation AOIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = EGLocalizedString(@"善心排名", nil);

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;

    _imageArray = @[@"ranking_personal_integrate_icon@2x.png",
                    @"ranking_personal_education_icon@2x.png",
                    @"ranking_personal_elderly_icon@2x.png",
                    @"ranking_personal_medical_icon@2x.png",
                    @"ranking_personal_poverty_icon@2x.png",
                    @"ranking_personal_emergency_icon@2x.png",
                    @"ranking_personal_case_list_icon@2x.png",
                    @"ranking_personal_others_icon@2x.png"];
    
    [self createTopView];
    [self createTableView];
}

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 创建顶部视图
- (void)createTopView{
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, ScreenSize.width, 50)];
    topView.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:180.0/255.0 blue:4.0/255.0 alpha:1];
    [self.view addSubview:topView];
    
    UILabel * typeLabel = [self.view addLabelWithFrame:CGRectMake(0, 65+50, ScreenSize.width, 30) text:_typeTitle];
    typeLabel.font = [UIFont boldSystemFontOfSize:15];
    typeLabel.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    typeLabel.textAlignment = NSTextAlignmentCenter;
    
    [topView addImageViewWithFrame:CGRectMake(5, 5, 35, 35) image:@"common_top_bar_personal_ranking@2x.png"];
    NSMutableDictionary * dict = [ShowMenuView getUserInfo];
    MemberModel * item = dict[@"LoginName"];
    
    if ([item.MemberType isEqualToString:@"P" ]) {
        
        UILabel * accumulateLabel = [topView addLabelWithFrame:CGRectMake(45, 0, 100, 40) text:EGLocalizedString(@"个人捐款排名", nil)];
        accumulateLabel.numberOfLines = 2;
        accumulateLabel.font = [UIFont systemFontOfSize:14];
        accumulateLabel.textColor = [UIColor whiteColor];
        
        
        UILabel * personalLabel = [topView addLabelWithFrame:CGRectMake(ScreenSize.width/2, 0, ScreenSize.width/2-40, 40) text:EGLocalizedString(@"个人累积捐款", nil)];
        personalLabel.font = [UIFont systemFontOfSize:14];
        personalLabel.numberOfLines = 2;
        personalLabel.textColor = [UIColor whiteColor];
        
    }else{
        
        UILabel * accumulateLabel = [topView addLabelWithFrame:CGRectMake(45, 0, 100, 40) text:EGLocalizedString(@"企业捐款排名", nil)];
        accumulateLabel.numberOfLines = 2;
        accumulateLabel.font = [UIFont systemFontOfSize:14];
        accumulateLabel.textColor = [UIColor whiteColor];
        
        
        UILabel * personalLabel = [topView addLabelWithFrame:CGRectMake(ScreenSize.width/2, 0, ScreenSize.width/2-40, 40) text:EGLocalizedString(@"企业累积捐款", nil)];
        personalLabel.font = [UIFont systemFontOfSize:14];
        personalLabel.numberOfLines = 2;
        personalLabel.textColor = [UIColor whiteColor];
        
        
    }

    NSMutableDictionary * donationDict = [ShowMenuView getDonationAmount];
    UILabel * moneyLabel = [topView addLabelWithFrame:CGRectMake(ScreenSize.width/2, 30, 150,20) text:nil];
    if (donationDict[@"shopItem"] != nil) {
        moneyLabel.text = [NSString stringWithFormat:@"HK$%@",donationDict[@"shopItem"]];
    }
    moneyLabel.font = [UIFont boldSystemFontOfSize:13];
    moneyLabel.textColor = [UIColor whiteColor];
    
    UILabel * rankLabel = [topView addLabelWithFrame:CGRectMake(45, 30, ScreenSize.width, 20) text:_ranking];
    rankLabel.font = [UIFont boldSystemFontOfSize:13];
    rankLabel.textColor = [UIColor whiteColor];
    
    
    
    //updated by vincent
    if (item) {
        //排名截至按钮
        __weak typeof(self) weakSelf = self;
        [topView addImageButtonWithFrame:CGRectMake(105, 35, 10, 12) title:nil backgroud:@"ranking_rank_arrow@2x.png" action:^(UIButton *button) {
            
            if (button.selected) {
                weakSelf.dateimage.hidden  = YES;
                button.selected = NO;
            }else{
                weakSelf.dateimage.hidden = NO;
                button.selected = YES;
            }
        }];
        
        UIView * rankTapView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 120, 40)];
        rankTapView.userInteractionEnabled = YES;
        [topView addSubview:rankTapView];
        
        UITapGestureRecognizer * rankTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rankTapAciton)];
        [rankTapView addGestureRecognizer:rankTap];
    }
    
   
    
    
    [topView addImageViewWithFrame:CGRectMake(ScreenSize.width-60, 3, 0.5, 40) image:@"case_separ_line@2x.png"];

    [topView addImageButtonWithFrame:CGRectMake(ScreenSize.width-50, 5, 45, 45) title:nil backgroud:@"common_top_bar_share@2x.png" action:^(UIButton *button){
        NSString * string = @"";
        NSString * subject= @"";
        if (item != nil) {
            
            if ([item.MemberType isEqualToString:@"P" ]) {
                
                if ([EGUtility getAppLang]==1) {
                    NSString *str = [NSString stringWithFormat:@"Egive - 排名榜\n%@支持了Egive的慈善工作, 於%@名列第%@位，你也來支持！\n%@/Ranking.aspx?Tp=AC\n\n意贈慈善基金\nEgive For You Charity Foundation\n電話: (852) 2210 2600\n電郵:info@egive4u.org",item.LoginName,EGLocalizedString(@"个人累积捐款", nil),rankLabel.text,SITE_URL];
                    string = str;
                    subject = @"Egive - 排名榜";
                }else if ([EGUtility getAppLang]==2){
                    
                    NSString *str = [NSString stringWithFormat:@"Egive - 排名榜\n%@支持了Egive的慈善工作, 于%@名列第%@位，你也来支持！\n%@/Ranking.aspx?Tp=AC\n\n意赠慈善基金\nEgive For You Charity Foundation\n电話: (852) 2210 2600\n电邮: info@egive4u.org",item.LoginName,EGLocalizedString(@"个人累积捐款", nil),rankLabel.text,SITE_URL];
                    string = str;
                    subject = @"Egive - 排名榜";
                }else{
                    
                    NSString * str = [NSString stringWithFormat:@"Egive - Top Individual Fundraiser Awards\n%@ just donated to support Egive and ranked %@ at Top Individual Fundraiser Awards, let's support Egive Now!\n%@/Ranking.aspx?Tp=AC\n\nVisit us at www.egive4u.org\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org",item.LoginName,rankLabel.text,SITE_URL];
                    string = str;
                    
                    subject = @"Egive - Top Individual Fundraiser Awards";
                }
            }else{
                
                if ([EGUtility getAppLang]==1) {
                    NSString *str = [NSString stringWithFormat:@"Egive - 排名榜\n%@支持了Egive的慈善工作, 於%@名列第%@位，你也來支持！\n%@/Ranking.aspx?Tp=AC\n\n意贈慈善基金\nEgive For You Charity Foundation\n電話: (852) 2210 2600\n電郵:info@egive4u.org",item.LoginName,EGLocalizedString(@"企业累积捐款", nil),rankLabel.text,SITE_URL];
                    string = str;
                    subject = @"Egive - 排名榜";
                }else if ([EGUtility getAppLang]==2){
                    
                    NSString *str = [NSString stringWithFormat:@"Egive - 排名榜\n%@支持了Egive的慈善工作, 于%@名列第%@位，你也来支持！\n%@/Ranking.aspx?Tp=AC\n\n意赠慈善基金\nEgive For You Charity Foundation\n电話: (852) 2210 2600\n电邮: info@egive4u.org",item.LoginName,EGLocalizedString(@"企业累积捐款", nil),rankLabel.text,SITE_URL];
                    string = str;
                    subject = @"Egive - 排名榜";
                }else{
                    
                    NSString * str = [NSString stringWithFormat:@"Egive - Top Corporate Fundraiser Awards\n%@ just donated to support Egive and ranked %@ at Top Corporate Fundraiser Awards, let's support Egive Now!\n%@/Ranking.aspx?Tp=AC\n\nVisit us at www.egive4u.org\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org",item.LoginName,rankLabel.text,SITE_URL];
                    string = str;
                    
                    subject = @"Egive - Top Corporate Fundraiser Awards";
                }
            }
           
            
        }else{
            
            if ([EGUtility getAppLang]==1) {
                NSString *str = [NSString stringWithFormat:@"Egive - 排名榜\n%@/Ranking.aspx?Tp=AC\n\n意贈慈善基金\nEgive For You Charity Foundation\n電話: (852) 2210 2600\n電郵: info@egive4u.org",SITE_URL];
                string = str;
                subject = @"Egive - 排名榜";
            }else if ([EGUtility getAppLang]==2){
                NSString *str = [NSString stringWithFormat:@"Egive - 排名榜\n%@/Ranking.aspx?Tp=AC\n\n意赠慈善基金\nEgive For You Charity Foundation\n电話: (852) 2210 2600\n电邮: info@egive4u.org" ,SITE_URL];
                string = str;
                subject = @"Egive - 排名榜";
            }else{
                
                NSString * str = [NSString stringWithFormat:@"Egive - Awards\n%@/Ranking.aspx?Tp=AC\n\nVisit us at www.egive4u.org\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org",SITE_URL];
                string = str;
                
                subject = @"Egive - Awards";
            }
            
        }
        
        [MenuViewController shareToSocialNetworkWithSubject:subject content:string url:nil image:nil];
        
//        UIActivityViewController *activityViewController =
//        [[UIActivityViewController alloc] initWithActivityItems:@[string]
//                                          applicationActivities:nil];
//        [self.navigationController presentViewController:activityViewController
//                                                animated:YES
//                                              completion:^{
//                                                  // ...
//                                              }];
//        activityViewController.excludedActivityTypes = @[UIActivityTypePrint];
//        [activityViewController setValue:subject forKey:@"subject"];
    }];
}
int rankFlag1 = 1;
-(void)rankTapAciton{
    rankFlag1 *= -1;
    if (rankFlag1 == 1) {
        self.dateimage.hidden  = YES;
        
    }else{
        self.dateimage.hidden = NO;
    }
}
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+76, ScreenSize.width, ScreenSize.height-135) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    _dateimage = [self.view addImageViewWithFrame:CGRectMake(50, 60+45, 140, 45) image:@"ranking_date@2x.png"];
    _dateimage.hidden = YES;
    
    UILabel * dateLabel = [_dateimage addLabelWithFrame:CGRectMake(5,15, _dateimage.frame.size.width-10, 25) text:EGLocalizedString(@"截至", nil)];
    dateLabel.textAlignment=NSTextAlignmentCenter;
    dateLabel.font = [UIFont systemFontOfSize:13];
    dateLabel.textColor = [UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1];
    //获取当前日期
//    NSDate *  senddate=[NSDate date];
//    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:senddate];//前一天
//    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"YYYY-MM-dd"];
//    NSString *  locationString=[dateformatter stringFromDate:lastDay];
//    
//    
//    UILabel * date = [_dateimage addLabelWithFrame:CGRectMake(45, 15, 90, 25) text:locationString];
//    date.font = [UIFont systemFontOfSize:13];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cell";
    AOIViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[AOIViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    cell.iconImage.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    cell.title.text = _dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    RankingDetailListController * vc = [[RankingDetailListController alloc] init];
    vc.ranking = _ranking;
    if ([_typeTitle isEqualToString:EGLocalizedString(@"累积最高捐款企业", nil)]) {
        NSArray * categoryArray = @[@"AC",@"S_C",@"E_C",@"M_C",@"P_C",@"U_C",@"A_C",@"O_C"]; //post数据参数
        vc.typeTitle = _dataArray[indexPath.row];
        vc.category = categoryArray[indexPath.row];
        
        if ([vc.category isEqualToString:@"AC"]) {
            vc.isShowMoney = YES;
        }
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([_typeTitle isEqualToString:EGLocalizedString(@"每月最高个人捐款", nil)]){
        NSArray * categoryArray = @[@"MP",@"S_M",@"E_M",@"M_M",@"P_M",@"U_M",@"A_M",@"O_M"];
        vc.typeTitle = _dataArray[indexPath.row];
        vc.category = categoryArray[indexPath.row];
        if ([vc.category isEqualToString:@"MP"]) {
            vc.isShowMoney = YES;
        }
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        NSArray * categoryArray = @[@"AP",@"S",@"E",@"M",@"P",@"U",@"A",@"O"];
        vc.typeTitle = _dataArray[indexPath.row];
        vc.category = categoryArray[indexPath.row];
        if ([vc.category isEqualToString:@"AP"]) {
            vc.isShowMoney = YES;
        }
        [self.navigationController pushViewController:vc animated:YES];
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
