//
//  RankingDetailListController.m
//  Egive
//
//  Created by sino on 15/7/29.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "Constants.h"
#import "RankingDetailListController.h"
#import "UIView+ZJQuickControl.h"
#import "RankingDetailListCell.h"
#import "RankFirstCell.h"
#import "EGUtility.h"
#import "MenuViewController.h"
#import "RankingDetaileListNewCellTableViewCell.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface RankingDetailListController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _dataArray;
    
    
    
    
    UILabel *_rankLabel1;
    UILabel *_rankLabel2;
}
@property (strong, nonatomic)UITableView * tableView;
@property (strong, nonatomic) UIImageView * dateimage;
@end

@implementation RankingDetailListController

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
    
    _dataArray = [[NSMutableArray alloc] init];
    

    
    [self requestApiData];
    [self createTopView];
    [self createUI];
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
    typeLabel.font = [UIFont boldSystemFontOfSize:14];
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
    }

    UIView * rankTapView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 120, 40)];
    rankTapView.userInteractionEnabled = YES;
    [topView addSubview:rankTapView];
    
    UITapGestureRecognizer * rankTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rankTapAciton)];
    [rankTapView addGestureRecognizer:rankTap];
    
    [topView addImageViewWithFrame:CGRectMake(ScreenSize.width-60, 3, 0.5, 40) image:@"case_separ_line@2x.png"];
    
    [topView addImageButtonWithFrame:CGRectMake(ScreenSize.width-50, 5, 45, 45) title:nil backgroud:@"common_top_bar_share@2x.png" action:^(UIButton *button) {
        
        NSString * string = @"";
        NSString * subject = @"";
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
                NSString *str = [NSString stringWithFormat:@"Egive - 排名榜\n%@/Ranking.aspx?Tp=AC\n\n意赠慈善基金\nEgive For You Charity Foundation\n电話: (852) 2210 2600\n电邮: info@egive4u.org",SITE_URL];
                string = str;
                subject = @"Egive - 排名榜";
            }else{
                
                NSString * str = [NSString stringWithFormat:@"Egive - Awards\n%@/Ranking.aspx?Tp=AC\n\nVisit us at www.egive4u.org\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org",SITE_URL];
                string = str;
                subject = @"Egive - Top Corporate Fundraiser Awards";
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
//        if (item != nil) {
//            
//        }else{
//            UIAlertView *alertView = [[UIAlertView alloc] init];
//            alertView.message = EGLocalizedString(@"請登入後再進行分享!", nil);
//            alertView.delegate = self;
//            [alertView addButtonWithTitle:EGLocalizedString(@"取消", nil)];
//            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
//            [alertView show];
//        }

    }];
}
int rankFlag2 = 1;
-(void)rankTapAciton{
    rankFlag2 *= -1;
    if (rankFlag2 == 1) {
        self.dateimage.hidden  = YES;
        
    }else{
        self.dateimage.hidden = NO;
    }
}
#pragma mark - 请求Cell数据
-(void)requestApiData{
    
    NSInteger lang = [EGUtility getAppLang];
    
    MyLog(@"_category=%@",_category);
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <GetRankingList xmlns=\"egive.appservices\"><Lang>%ld</Lang><Category>%@</Category><StartRowNo>1</StartRowNo><NumberOfRows>10</NumberOfRows></GetRankingList></soap:Body></soap:Envelope>",(long)lang,_category
     ];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        //        MyLog(@"%@", operation.request.allHTTPHeaderFields);
        //        // 服务器给我们返回的包得头部信息
        //                MyLog(@"%@", operation.response);
        //        返回的数据
        //        MyLog(@"success = %@",responseObject);
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSArray * arr = [NSString parseJSONStringToNSArray:dataString];
        
        MyLog(@"%@",arr);
        for (NSDictionary * rankDict in arr) {
            RankingModel * model = [[RankingModel alloc] init];
            [model setValuesForKeysWithDictionary:rankDict];
            [_dataArray addObject:model];
        }
        
//        if (_dataArray.count > 1) {
//            
//            for (int i = 0; i < _dataArray.count - 1; i ++) {
//                for (int j = 0; j < _dataArray.count - i - 1; j ++) {
//                    RankingModel * item = [_dataArray objectAtIndex:j];
//                    RankingModel * item1 = [_dataArray objectAtIndex:j+1];
//                    int num1 = [item.Amt intValue];
//                    int num2 = [item1.Amt intValue];
//                    if (num1 < num2) {
//                        [_dataArray exchangeObjectAtIndex:j+1 withObjectAtIndex:j];
//                    }
//                }
//            }
//        }
        
        [_tableView reloadData];
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

- (void)createUI{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+76, ScreenSize.width, ScreenSize.height-140) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
//    UILabel * date = [_dateimage addLabelWithFrame:CGRectMake(45, 15, 90, 25) text:locationString];
//    date.font = [UIFont systemFontOfSize:13];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 90;
    }else{
        
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        static NSString *cellID = @"firstCell";
        RankFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil)
        {
            cell = [[RankFirstCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }

        RankingModel * model = [_dataArray objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:SITE_URL];
        url = [url URLByAppendingPathComponent:model.ProfilePicFilePath];
        [cell.userImage sd_setImageWithURL:url placeholderImage:nil];
        cell.userImage.contentMode = UIViewContentModeScaleAspectFit;
        cell.title.text = model.MemberName;
       
        if (_isShowMoney) {
            cell.amount.hidden = NO;
        }else{
            cell.amount.hidden = YES;
        }
        MyLog(@"_typeTitle=%@",_typeTitle);
        if ([_typeTitle isEqualToString: EGLocalizedString(@"最热心参与企业", nil)]){
            cell.amount.hidden = NO;
            cell.amount.text = [NSString stringWithFormat:@"%@ %@",EGLocalizedString(@"joinPeople", nil),[NSString strmethodComma:[NSString stringWithFormat:@"%@",model.Amt]]];
        }else{
            
            cell.amount.hidden = NO;
            cell.amount.text = [NSString stringWithFormat:@"HKD$ %@",[NSString strmethodComma:[NSString stringWithFormat:@"%@",model.Amt]]];
            
            
            if([_category isEqualToString:@"AC"] || [_category isEqualToString:@"MP"] || [_category isEqualToString:@"AP"]){
                
                cell.amount.hidden = NO;
                
            }else{
                
                cell.amount.hidden = YES;
                
            }
        }
      
        return cell;

    }else{
        
        static NSString *cellID = @"RankingDetaileListNewCellTableViewCell";
        //RankingDetailListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    RankingDetaileListNewCellTableViewCell  *cell = (RankingDetaileListNewCellTableViewCell *)[_tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil)
        {
//            cell = [[RankingDetailListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            
        cell = (RankingDetaileListNewCellTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row == 0) {
            cell.userImage.frame = CGRectMake(10, 15, 70, 70);
        }
        RankingModel * model = [_dataArray objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:SITE_URL];
        url = [url URLByAppendingPathComponent:model.ProfilePicFilePath];
        [cell.userImage sd_setImageWithURL:url];
        cell.title.font = [UIFont boldSystemFontOfSize:15];
        cell.title.text = model.MemberName;
        cell.title.numberOfLines=0;
       CGSize requiredSize = [cell.title.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(ScreenSize.width-135, 10000) lineBreakMode:NSLineBreakByWordWrapping];
        //重新设置自定义Label的frame，很关键
        cell.title.frame = CGRectMake(0, 0, ScreenSize.width-135, requiredSize.height);
        CGRect rect = cell.frame;
        rect.size.height = requiredSize.height+70;
        //设置cell的高度
        cell.frame = rect;
        
        if (_isShowMoney) {
            cell.amount.hidden = NO;
        }else{
            cell.amount.hidden = YES;
        }
        if ([_typeTitle isEqualToString: EGLocalizedString(@"最热心参与企业", nil)]) {
            cell.amount.hidden = NO;
            cell.amount.text = [NSString stringWithFormat:@"%@ %@",EGLocalizedString(@"joinPeople", nil),[NSString strmethodComma:[NSString stringWithFormat:@"%@",model.Amt]]];
        }else{

             cell.amount.hidden = NO;
            cell.amount.text = [NSString stringWithFormat:@"HKD$ %@",[NSString strmethodComma:[NSString stringWithFormat:@"%@",model.Amt]]];
            
            
            if([_category isEqualToString:@"AC"] || [_category isEqualToString:@"MP"] || [_category isEqualToString:@"AP"]){
                
                cell.amount.hidden = NO;
                
            }else{
                
                cell.amount.hidden = YES;
                
            }
        }
    
         cell.ranking.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
         return cell;
    }
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - setter

-(void)setRankStyle:(RankListStyle)rankStyle{
    _rankStyle = rankStyle;
    if (_rankStyle==CompanyRankStyle) {
        _rankLabel1.text = EGLocalizedString(@"企业捐款排名", nil);
        _rankLabel2.text = EGLocalizedString(@"企业累积捐款", nil);
    }
}


@end
