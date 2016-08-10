//
//  InformationController.m
//  Egive
//
//  Created by sino on 15/7/28.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "InformationController.h"
#import "InformationCell.h"
#import "UIView+ZJQuickControl.h"
#import "ShowMenuView.h"
#import "MyDonationViewController.h"
#import "ProReportController.h"
#import "EGUtility.h"
#import "Constants.h"
#import "InformationModel.h"
#import "SDImageCache.h"
#import "ActivityViewController.h"
#import "GirdDetailViewController.h"
#import "MyDonationViewController.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface InformationController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * _selectArray;
    NSArray * _selectDataArray;
    NSMutableArray * _dataArray;
    BOOL _isShow;
}
@property (strong, nonatomic) UILabel * cartLabel;
@property (strong, nonatomic)UITableView * tableView;
@property (strong, nonatomic)UITableView * downtableView;
@property(nonatomic)int selectedIndex;
@property (nonatomic,strong) NSMutableArray * HaveReadIDArray;//已读ID数组

@end

@implementation InformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.HaveReadIDArray=[[NSMutableArray alloc] init];
    self.title = EGLocalizedString(@"訊息中心", nil);
    _selectedIndex=0;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    //_dataArray = [[NSMutableArray alloc] initWithObjects:nil];
    // @"1",@"2",@"3",@"4",@"5",@"6",nil];
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 33, 33);
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_cart@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;

    //购物车右侧数量标示label
    NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
    EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
    
    _cartLabel = [self.navigationController.navigationBar addLabelWithFrame:CGRectMake(ScreenSize.width-30, 18, 18, 18) text:[NSString stringWithFormat:@"%ld",(long)item.NumberOfItems]];
    _cartLabel.layer.cornerRadius = 9;
    _cartLabel.layer.masksToBounds = YES;
    _cartLabel.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    _cartLabel.textAlignment = NSTextAlignmentCenter;
    _cartLabel.font = [UIFont systemFontOfSize:11];
    _cartLabel.textColor = [UIColor whiteColor];
    //EVENT – 意贈活動
    //CASE – 新增個案
    //CASEUPDATE – 進度報告
    //SUCCESS – 成功籌募
    //DONATION – 捐款記錄
    _selectArray = @[@[EGLocalizedString(@"全部信息", nil),EGLocalizedString(@"意赠活动", nil),EGLocalizedString(@"新增个案", nil),EGLocalizedString(@"进度报告", nil),EGLocalizedString(@"成功筹募", nil),EGLocalizedString(@"捐款记录", nil)]];
    _selectDataArray = @[@"",@"EVENT",@"CASE",@"CASEUPDATE",@"SUCCESS",@"DONATION"];

     [self createUI];
    [self requestApiData:@""];
}

-(void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction{
    
    MyDonationViewController * vc = [[MyDonationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    _cartLabel.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    _cartLabel.hidden = YES;
}
- (void)createUI{
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, ScreenSize.width, 40)];
    topView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [self.view addSubview:topView];
    
    EGDropDownMenu *menu = [[EGDropDownMenu alloc] initWithFrame:CGRectMake(10, 72, ScreenSize.width-20, 25) Array:_selectArray selectedColor:[UIColor grayColor]];
    menu.delegate = self;
    [self.view addSubview:menu];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,105, ScreenSize.width, ScreenSize.height-105-40) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:@"InformationCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    [self createFooterButton];
    [self createMenuUI];
   
}


#pragma mark filter
- (void)dropDownMenu:(EGDropDownMenu *)dropDownMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedIndex = indexPath.row;
    
    NSLog(@"ww==%ld",_selectedIndex);
    
    NSString *CategeryString = _selectDataArray[_selectedIndex];
    
    [self requestApiData:CategeryString];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 90;

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        InformationModel *model = [_dataArray objectAtIndex:indexPath.row];
        /////////fgx//////////
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        if ([user objectForKey:@"HaveReadID"]) {
            if (self.HaveReadIDArray) {
                [self.HaveReadIDArray removeAllObjects];
            }
            for(NSString * ID in [user objectForKey:@"HaveReadID"]){
                [self.HaveReadIDArray addObject:ID];
            }
            
            for(int i=0; i<self.HaveReadIDArray.count; i++)
            {
                if ([model.MsgID isEqualToString:self.HaveReadIDArray[i]]) {
                    [self.HaveReadIDArray removeObjectAtIndex:i];
                    [user setObject:self.HaveReadIDArray forKey:@"HaveReadID"];
                    break;
                }
                else
                {
                    if (self.HaveReadIDArray.count-1==i) {
                        if (((int)(_dataArray.count)-(int)(self.HaveReadIDArray.count))>0) {
                            [[NSUserDefaults standardUserDefaults] setInteger:_dataArray.count-self.HaveReadIDArray.count forKey:@"MsgInboxCount"];
                        }
                        else{
                            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"MsgInboxCount"];
                        }
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeInboxCount" object: nil];
                        break;
                    }
                }
            }
        }
        /////////////////////
        
         NSString *CategeryString = _selectDataArray[_selectedIndex];

        [self DeleteMessage:model.MsgID Categery:CategeryString];
       
    }

    
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
       return YES;
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return YES;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    long lang = [EGUtility getAppLang];
    if (lang == 1)
        return @"删除";
    else if (lang == 2)
        return @"删除";
    else
        return @"Delete";
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"cell";
    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InformationCell" owner:self options:nil] lastObject];
    }
    
    InformationModel *model = [_dataArray objectAtIndex:indexPath.row];
    
    //[UIImage imageNamed:@"dummy_case_related_default.png"]
    
    [cell.LogoImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",SITE_URL,@"/./",[model.ImageFilePath stringByReplacingOccurrencesOfString:@"\\" withString:@"//"]]] placeholderImage:[UIImage imageNamed:@"dummy_case_related_default.png"]];
    
//    [cell.LogoImage sd_setImageWithURL:[NSURL URLWithString:@"https://img20.360buyimg.com/da/jfs/t2743/230/911797008/102609/bed7aff6/572aa6ddN9f685064.jpg"] placeholderImage:[UIImage imageNamed:@"dummy_case_related_default.png"]];
    
    MyLog(@"%@",[NSString stringWithFormat:@"%@%@",SITE_URL,model.ImageFilePath]);
    
    //cell.Title.text=model.Title;
    //cell.SubTitle.text=model.Msg;
    //cell.Dtate.text=model.CreatedDate;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [cell setData:_dataArray[indexPath.row] andIDArray:[user objectForKey:@"HaveReadID"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InformationModel *model = [_dataArray objectAtIndex:indexPath.row];
    if([model.Title rangeOfString:@"支持意赠"].location==NSNotFound&&[model.Title rangeOfString:@"支持意贈"].location==NSNotFound&&[model.Title rangeOfString:@"Donate Egive"].location==NSNotFound)
    {
        if([model.MsgTp isEqualToString:@"EVENT"]){
            //意赠活动
            ActivityViewController *Ac = [[ActivityViewController alloc] init];
            Ac.MsgId = model.RefID;
            Ac.InboxFlag = 1;
            [self.navigationController pushViewController:Ac animated:NO];
            
        }else if ([model.MsgTp isEqualToString:@"CASEUPDATE"]){
            
            //进度报告
            ProReportController * vc = [[ProReportController alloc] init];
            vc.caseId = model.RefID;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if ([model.MsgTp isEqualToString:@"CASE"]){
            //新增个案
            
            GirdDetailViewController *gc = [[GirdDetailViewController alloc] init];
            gc.caseID = model.RefID;
            [self.navigationController pushViewController:gc animated:YES];
            
            
            
        }else if ([model.MsgTp isEqualToString:@"SUCCESS"]){
            //成功募捐
            
            GirdDetailViewController *gc = [[GirdDetailViewController alloc] init];
            gc.caseID = model.RefID;
            [self.navigationController pushViewController:gc animated:YES];
            
        }else if ([model.MsgTp isEqualToString:@"DONATION"]){
            //募捐记录
//            MyDonationViewController * vc = [[MyDonationViewController alloc] init];
//            vc.caseId = model.RefID;
//            vc.MyDonationFlag=1;
//            vc.pushFlag=1;
//            [self.navigationController pushViewController:vc animated:NO];
            GirdDetailViewController *gc = [[GirdDetailViewController alloc] init];
            gc.caseID = model.RefID;
            [self.navigationController pushViewController:gc animated:YES];
        }
    }
    
    ///////fgx//////
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:@"HaveReadID"]) {
        if (self.HaveReadIDArray) {
            [self.HaveReadIDArray removeAllObjects];
        }
        for(NSString * ID in [user objectForKey:@"HaveReadID"]){
            [self.HaveReadIDArray addObject:ID];
        }
    }
    
    if (self.HaveReadIDArray.count==0) {
        [self.HaveReadIDArray addObject:model.MsgID];
    }
    else
    {
        for(int i=0; i<self.HaveReadIDArray.count; i++)
        {
            if (![model.MsgID isEqualToString:self.HaveReadIDArray[i]]) {
                if (self.HaveReadIDArray.count-1==i) {
                    [self.HaveReadIDArray addObject:model.MsgID];
                }
            }
            else
            {
                if (self.HaveReadIDArray.count-1==i) {
                    if (((int)(_dataArray.count)-(int)(self.HaveReadIDArray.count))>0) {
                        [[NSUserDefaults standardUserDefaults] setInteger:_dataArray.count-self.HaveReadIDArray.count forKey:@"MsgInboxCount"];
                    }
                    else{
                        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"MsgInboxCount"];
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeInboxCount" object: nil];
                    break;
                }
            }
        }
    }
    [user setObject:self.HaveReadIDArray forKey:@"HaveReadID"];
    [_tableView reloadData];
    ////////////////
}

//删除信息
-(void)DeleteMessage:(NSString*)MsgId Categery:(NSString *)CategeryString{
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><DeleteMailBoxMsg xmlns=\"egive.appservices\"><MsgID>%@</MsgID></DeleteMailBoxMsg></soap:Body></soap:Envelope>",MsgId
     ];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml" forHTTPHeaderField:@"Content-Type"];
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
        
        [self removeLoadingAlert];
        
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        MyLog(@"dataString = %@", dataString);
        
        NSDictionary * dict = [NSString parseJSONStringToNSDictionary:dataString];
        MyLog(@"%@",dict);
        
      UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:nil message:EGLocalizedString(@"DeleteSuccess", nil) delegate:self cancelButtonTitle:nil otherButtonTitles:EGLocalizedString(@"Confirm", nil), nil];
        alert.delegate=self;
        [alert show];
      
        [self requestApiData:CategeryString];
        
       // [[NSNotificationCenter defaultCenter] postNotificationName:@"changeInboxCount" object: nil];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        MyLog(@"%@", operation.request.allHTTPHeaderFields);
        // 服务器给我们返回的包得头部信息
        MyLog(@"%@", operation.response);
        // 返回的数据
        MyLog(@"success = %@", error);
        [self removeLoadingAlert];
    }];
    
    [operation start];
}
//请求详细信息
#pragma mark - 请求Cell数据
-(void)requestApiData:(NSString *)CategeryString{
    
    [self showLoadingAlert];
    //long lang = [EGUtility getAppLang];
    NSString *Apptoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"GetendpointArn"];
    
    MyLog(@"%@",Apptoken);
    long lang = [EGUtility getAppLang];
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetMailBoxMsg xmlns=\"egive.appservices\"><Lang>%ld</Lang><MsgTp>%@</MsgTp><maxOccurs>30</maxOccurs><minOccurs>0</minOccurs><AppToken>%@</AppToken></GetMailBoxMsg></soap:Body></soap:Envelope>",lang,CategeryString,Apptoken
     ];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml" forHTTPHeaderField:@"Content-Type"];
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
        
        [self removeLoadingAlert];
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        MyLog(@"dataString = %@", dataString);
        
        NSDictionary * dict = [NSString parseJSONStringToNSDictionary:dataString];
        
        MyLog(@"%@",dict);
        
        _dataArray = [[NSMutableArray alloc] init];
        
        MyLog(@"%@",dict[@"MsgList"]);
                     
        if (![dict[@"MsgList"] isEqual:[NSNull null]]){
            
            NSArray * listArray = dict[@"MsgList"];
            if (listArray.count>0) {
                self.title = [NSString stringWithFormat:@"%@(%lu)",EGLocalizedString(@"訊息中心", nil),listArray.count];
            }
            else{
                self.title = [NSString stringWithFormat:@"%@",EGLocalizedString(@"訊息中心", nil)];
            }
          
            for (NSDictionary * listDict in listArray){
                
                InformationModel *  model = [[InformationModel alloc] init];
                [model setValuesForKeysWithDictionary:listDict];
                [_dataArray addObject:model];
            }
            
            
        }
        
        [_tableView reloadData];
        MyLog(@"%ld",_dataArray.count);
        
        
        if ([CategeryString isEqualToString:@""]) {
            NSArray * arr=[[NSUserDefaults standardUserDefaults] objectForKey:@"HaveReadID"];
            if (arr.count>0) {
                if (self.HaveReadIDArray) {
                    [self.HaveReadIDArray removeAllObjects];
                }
                for (InformationModel *  model in _dataArray) {
                    for (NSString * str in arr) {
                        if ([model.MsgID isEqualToString:str]) {
                            [self.HaveReadIDArray addObject:str];
                        }
                    }
                }
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:self.HaveReadIDArray forKey:@"HaveReadID"];
            if (((int)(_dataArray.count)-(int)(self.HaveReadIDArray.count))>0) {
                [[NSUserDefaults standardUserDefaults] setInteger:_dataArray.count-self.HaveReadIDArray.count forKey:@"MsgInboxCount"];
            }
            else{
                [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"MsgInboxCount"];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeInboxCount" object: nil];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        MyLog(@"%@", operation.request.allHTTPHeaderFields);
        // 服务器给我们返回的包得头部信息
        MyLog(@"%@", operation.response);
        // 返回的数据
        MyLog(@"success = %@", error);
        [self removeLoadingAlert];
    }];
    
    [operation start];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeInboxCount" object:nil];
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
