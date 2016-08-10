//
//  RankListViewController.m
//  Egive
//
//  Created by sino on 15/7/29.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "RankListViewController.h"
#import "RankListCell.h"
#import "AOIViewController.h"
#import "UIView+ZJQuickControl.h"
#import "MyDonationViewController.h"
#import "EGUtility.h"
#import "Constants.h"
#define ScreenSize [UIScreen mainScreen].bounds.size

@interface RankListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UILabel * _rankLabel;
    NSArray * _dataArray;
    NSArray * _imageArray;
    
}
@property (strong, nonatomic)UITableView * tableView;
@property (strong, nonatomic) UILabel * cartLabel;
@property (strong, nonatomic) UIImageView * dateimage;
@end

@implementation RankListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = EGLocalizedString(@"MenuView_rankingButton_title", nil);
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

    
    _dataArray = @[EGLocalizedString(@"累积最高捐款企业", nil),EGLocalizedString(@"最热心参与企业", nil),EGLocalizedString(@"每月最高个人捐款", nil),EGLocalizedString(@"累积最高个人捐款", nil)];
    _imageArray = @[@"ranking_donate_business_icon@2x.png",
                    @"ranking_participate_business_icon@2x.png",
                    @"ranking_monthly_personal_icon@2x.png",
                    @"ranking_donate_personal_icon@2x.png"];
    [self requestRankingInfoData];
    [self createTopView];
    [self createUI];
    
    [self createFooterButton];
    [self createMenuUI];
}
-(void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightAction{
    MyDonationViewController * vc = [[MyDonationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 创建顶部视图
- (void)createTopView{

    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, ScreenSize.width, 57)];
    topView.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:180.0/255.0 blue:4.0/255.0 alpha:1];
    [self.view addSubview:topView];
    
    [topView addImageViewWithFrame:CGRectMake(5, 8, 35, 35) image:@"common_top_bar_personal_ranking@2x.png"];
    
//    UILabel * accumulateLabel = [topView addLabelWithFrame:CGRectMake(45, 5, 100, 20) text:EGLocalizedString(@"Ranking_accumulateLabel", nil)];
    
    
    //获取个人累积捐款
    NSMutableDictionary * dict = [ShowMenuView getUserInfo];
    MemberModel * item = dict[@"LoginName"];

    if ([item.MemberType isEqualToString:@"P" ]) {
        
        UILabel * accumulateLabel = [topView addLabelWithFrame:CGRectMake(45, 0, 100, 40) text:EGLocalizedString(@"个人捐款排名", nil)];
        accumulateLabel.numberOfLines = 2;
        accumulateLabel.font = [UIFont systemFontOfSize:14];
        accumulateLabel.textColor = [UIColor whiteColor];
        
        UILabel * personalLabel = [topView addLabelWithFrame:CGRectMake(ScreenSize.width/2-5, 0, ScreenSize.width/2-40, 40) text:EGLocalizedString(@"个人累积捐款", nil)];
        personalLabel.font = [UIFont systemFontOfSize:14];
        personalLabel.numberOfLines = 2;
        personalLabel.textColor = [UIColor whiteColor];
        
    }else{
    
        UILabel * accumulateLabel = [topView addLabelWithFrame:CGRectMake(45, 0, 100, 40) text:EGLocalizedString(@"企业捐款排名", nil)];
        accumulateLabel.numberOfLines = 2;
        accumulateLabel.font = [UIFont systemFontOfSize:14];
        accumulateLabel.textColor = [UIColor whiteColor];
        
        UILabel * personalLabel = [topView addLabelWithFrame:CGRectMake(ScreenSize.width/2-5, 0, ScreenSize.width/2-40, 40) text:EGLocalizedString(@"企业累积捐款", nil)];
        personalLabel.font = [UIFont systemFontOfSize:14];
        personalLabel.numberOfLines = 2;
        personalLabel.textColor = [UIColor whiteColor];

    
    }

    NSMutableDictionary * donationDict = [ShowMenuView getDonationAmount];
    UILabel * moneyLabel = [topView addLabelWithFrame:CGRectMake(ScreenSize.width/2, 35, 150,20) text:nil];
    if (donationDict[@"shopItem"] != nil) {
        moneyLabel.text = [NSString stringWithFormat:@"HK$%@",donationDict[@"shopItem"]];
    }
    moneyLabel.font = [UIFont boldSystemFontOfSize:15];
    moneyLabel.textColor = [UIColor whiteColor];

    //获取个人捐款排名
    _rankLabel = [topView addLabelWithFrame:CGRectMake(45, 35, 100, 20) text:nil];
    _rankLabel.font = [UIFont boldSystemFontOfSize:15];
    _rankLabel.textColor = [UIColor whiteColor];
    
    
    //updated by vincent
    
    if (item) {
        //排名截至按钮
        __weak typeof(self) weakSelf = self;
        [topView addImageButtonWithFrame:CGRectMake(105, 38, 10, 14) title:nil backgroud:@"ranking_rank_arrow@2x.png" action:^(UIButton *button) {
            
            //        if (button.selected) {
            //            weakSelf.dateimage.hidden  = YES;
            //            button.selected = NO;
            //        }else{
            //            weakSelf.dateimage.hidden = NO;
            //            button.selected = YES;
            //        }
        }];
        UIView * rankTapView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 120, 57)];
        rankTapView.userInteractionEnabled = YES;
        [topView addSubview:rankTapView];
        
        UITapGestureRecognizer * rankTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rankTapAciton)];
        [rankTapView addGestureRecognizer:rankTap];
    }
    
    
    
    
    

    [topView addImageViewWithFrame:CGRectMake(ScreenSize.width-60, 10, 0.5, 40) image:@"case_separ_line@2x.png"];
    
    
    [topView addImageButtonWithFrame:CGRectMake(ScreenSize.width-55, 5, 50, 50) title:nil backgroud:@"common_top_bar_share@2x.png" action:^(UIButton *button) {
  
        NSString * string = @"";
        NSString * subject = @"";
        if (item != nil) {
            
            
            if ([item.MemberType isEqualToString:@"P" ]) {
                if ([EGUtility getAppLang]==1) {
                    NSString *str = [NSString stringWithFormat:@"Egive - 排名榜\n%@支持了Egive的慈善工作, 於%@名列第%@位，你也來支持！\n%@/Ranking.aspx?Tp=AC\n\n意贈慈善基金\nEgive For You Charity Foundation\n電話: (852) 2210 2600\n電郵:info@egive4u.org",item.LoginName,EGLocalizedString(@"个人累积捐款", nil),_rankLabel.text,SITE_URL];
                    string = str;
                    subject = @"Egive - 排名榜";
                }else if ([EGUtility getAppLang]==2){
                    
                    NSString *str = [NSString stringWithFormat:@"Egive - 排名榜\n%@支持了Egive的慈善工作, 于%@名列第%@位，你也来支持！\n%@/Ranking.aspx?Tp=AC\n\n意赠慈善基金\nEgive For You Charity Foundation\n电話: (852) 2210 2600\n电邮: info@egive4u.org",item.LoginName,EGLocalizedString(@"个人累积捐款", nil),_rankLabel.text,SITE_URL];
                    string = str;
                    subject = @"Egive - 排名榜";
                }else{
                    
                    NSString * str = [NSString stringWithFormat:@"Egive - Top Individual Fundraiser Awards\n%@ just donated to support Egive and ranked %@ at Top Individual Fundraiser Awards, let's support Egive Now!\n%@/Ranking.aspx?Tp=AC\n\nVisit us at www.egive4u.org\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org",item.LoginName,_rankLabel.text,SITE_URL];
                    string = str;
                    
                    subject = @"Egive - Top Individual Fundraiser Awards";
                }
            }else{
                if ([EGUtility getAppLang]==1) {
                    NSString *str = [NSString stringWithFormat:@"Egive - 排名榜\n%@支持了Egive的慈善工作, 於%@名列第%@位，你也來支持！\n%@/Ranking.aspx?Tp=AC\n\n意贈慈善基金\nEgive For You Charity Foundation\n電話: (852) 2210 2600\n電郵:info@egive4u.org",item.LoginName,EGLocalizedString(@"企业累积捐款", nil),_rankLabel.text,SITE_URL];
                    string = str;
                    subject = @"Egive - 排名榜";
                }else if ([EGUtility getAppLang]==2){
                    
                    NSString *str = [NSString stringWithFormat:@"Egive - 排名榜\n%@支持了Egive的慈善工作, 于%@名列第%@位，你也来支持！\n%@/Ranking.aspx?Tp=AC\n\n意赠慈善基金\nEgive For You Charity Foundation\n电話: (852) 2210 2600\n电邮: info@egive4u.org",item.LoginName,EGLocalizedString(@"企业累积捐款", nil),_rankLabel.text,SITE_URL];
                    string = str;
                    subject = @"Egive - 排名榜";
                }else{
                    
                    NSString * str = [NSString stringWithFormat:@"Egive - Top Corporate Fundraiser Awards\n%@ just donated to support Egive and ranked %@ at Top Corporate Fundraiser Awards, let's support Egive Now!\n%@/Ranking.aspx?Tp=AC\n\nVisit us at www.egive4u.org\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org",item.LoginName,_rankLabel.text,SITE_URL];
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
                NSString *str = [NSString stringWithFormat:@"Egive - 排名榜\n%@/Ranking.aspx?Tp=AC\n\n意赠慈善基金\nEgive For You Charity Foundation\n电話: (852) 2210 2600\n电邮: info@egive4u.org",SITE_URL];
                string = str;
                subject = @"Egive - 排名榜";
            }else{
                
                NSString * str = [NSString stringWithFormat:@"Egive - Awards \n%@/Ranking.aspx?Tp=AC\n\nVisit us at www.egive4u.org\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org",SITE_URL];
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
//      [activityViewController setValue:subject forKey:@"subject"];

    }];
}
int rankFlag = 1;
-(void)rankTapAciton{
    rankFlag *= -1;
    if (rankFlag == 1) {
        self.dateimage.hidden  = YES;
  
    }else{
        self.dateimage.hidden = NO;
    }
}

- (void)createUI{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 67+55, ScreenSize.width, ScreenSize.height-55-95) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    _dateimage = [self.view addImageViewWithFrame:CGRectMake(50, 60+55, 140, 45) image:@"ranking_date@2x.png"];
    _dateimage.hidden = YES;
    
    UILabel * dateLabel = [_dateimage addLabelWithFrame:CGRectMake(5,15,_dateimage.frame.size.width-10 , 25) text:EGLocalizedString(@"截至", nil)];
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
//    UILabel * date = [_dateimage addLabelWithFrame:CGRectMake(45, 15, 90, 25) text:locationString];
//    date.font = [UIFont systemFontOfSize:13];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cell";
    RankListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[RankListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    cell.title.text = _dataArray[indexPath.row];
    cell.image.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AOIViewController * vc = [[AOIViewController alloc] init];
    vc.ranking = _rankLabel.text;
    if (indexPath.row == 0) {
        vc.typeTitle = _dataArray[indexPath.row];
        vc.dataArray = @[EGLocalizedString(@"综合－累积最高捐款企业", nil),EGLocalizedString(@"助学－累积最高捐款企业", nil),EGLocalizedString(@"安老－累积最高捐款企业", nil),EGLocalizedString(@"助医－累积最高捐款企业", nil),EGLocalizedString(@"扶贫－累积最高捐款企业", nil),EGLocalizedString(@"紧急援助－累积最高捐款企业", nil),EGLocalizedString(@"意赠行动－累积最高捐款企业", nil),EGLocalizedString(@"其他－累积最高捐款企业", nil)];
        vc.nameString = EGLocalizedString(@"累积最高捐款企业", nil);
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 1){
     
        RankingDetailListController * vc = [[RankingDetailListController alloc] init];
        vc.typeTitle = EGLocalizedString(@"最热心参与企业", nil);
        vc.ranking = _rankLabel.text;
        vc.category = @"MC";
        vc.rankStyle = CompanyRankStyle;
        vc.nameString = EGLocalizedString(@"最热心参与企业", nil);
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 2){
        
        vc.typeTitle = _dataArray[indexPath.row];
        
        vc.dataArray = @[EGLocalizedString(@"综合－每月最高个人捐款", nil),EGLocalizedString(@"助学－每月最高个人捐款", nil),EGLocalizedString(@"安老－每月最高个人捐款", nil),EGLocalizedString(@"助医－每月最高个人捐款", nil),EGLocalizedString(@"扶贫－每月最高个人捐款", nil),EGLocalizedString(@"紧急援助－每月最高个人捐款", nil),EGLocalizedString(@"意赠行动－每月最高个人捐款", nil),EGLocalizedString(@"其他－每月最高个人捐款", nil)];
        vc.nameString = EGLocalizedString(@"每月最高个人捐款", nil);
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 3){
        vc.typeTitle = _dataArray[indexPath.row];
        vc.dataArray = @[EGLocalizedString(@"综合－累积最高个人捐款", nil),EGLocalizedString(@"助学－累积最高个人捐款", nil),EGLocalizedString(@"安老－累积最高个人捐款", nil),EGLocalizedString(@"助医－累积最高个人捐款", nil),EGLocalizedString(@"扶贫－累积最高个人捐款", nil),EGLocalizedString(@"紧急援助－累积最高个人捐款", nil),EGLocalizedString(@"意赠行动－累积最高个人捐款", nil),EGLocalizedString(@"其他－累积最高个人捐款", nil)];
        vc.nameString = EGLocalizedString(@"累积最高个人捐款", nil);
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - 请求排名数据
- (void)requestRankingInfoData{
    
    NSMutableDictionary * dict = [ShowMenuView getUserInfo];
    MemberModel * item = dict[@"LoginName"];
    if (item != nil) {
        NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetGlobalRanking xmlns=\"egive.appservices\"><MemberID>%@</MemberID></GetGlobalRanking></soap:Body></soap:Envelope>",item.MemberID];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl" ,SITE_URL]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
        [request addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        //    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            //        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
            //        MyLog(@"%@", operation.request.allHTTPHeaderFields);
            //
            //        // 服务器给我们返回的包得头部信息
            //        MyLog(@"%@", operation.response);
            
            NSString * dataSting = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            MyLog(@"requestRankingInfoData JSON = %@", dataSting);
            
            NSDictionary * dict = [NSString parseJSONStringToNSDictionary:dataSting];
            MyLog(@"dict=%@",dict);
            _rankLabel.text = [NSString stringWithFormat:@"%@",dict[@"Rank"]];
            if ([[_rankLabel.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"/"]) {
                _rankLabel.text = [NSString stringWithFormat:@"0%@", _rankLabel.text];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
            MyLog(@"%@", operation.request.allHTTPHeaderFields);
            // 服务器给我们返回的包得头部信息
            MyLog(@"%@", operation.response);
            // 返回的数据
            MyLog(@"success = %@", error);
        }];
        
        [operation start];
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
