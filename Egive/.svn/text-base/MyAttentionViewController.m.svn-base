//
//  MyAttentionViewController.m
//  Egive
//
//  Created by sino on 15/9/11.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "Constants.h"
#import "MyAttentionViewController.h"
#import "UIView+ZJQuickControl.h"
#import "GirdTwoCell.h"
#import "GirdDetailViewController.h"
#import "MyDonationViewController.h"
#import "GirdModel.h"
#import "NSString+RegexKitLite.h"
#import "UIKit+AFNetworking.h"
#import "AFNetworking.h"
#import "EGUtility.h"

#define ScreenSize [UIScreen mainScreen].bounds.size
@interface MyAttentionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSTimer * _timer;
    NSMutableArray * _dataArray;
    BOOL _isSwap;
    NSDictionary * _categoryDict;
    NSDictionary * _typeImageDict1;
    NSMutableArray * CateImageSortarray;
    NSMutableDictionary *CateImageSortdict;
    NSArray *KeyCateArray;
}
@property (strong, nonatomic) UILabel * cartLabel;
@property (strong, nonatomic) MemberModel * item;
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic) BOOL isList;
@property (strong, nonatomic)UITableView * tableView;


@end

@implementation MyAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = EGLocalizedString(@"我的关注", nil);
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];


    _typeImageDict1 = @{
                        @"O":@"comment_list_type_others.png",//其他
                        @"S":@"comment_list_type_education@2x.png",//助学
                        @"E":@"comment_list_type_elder@2x.png",//助老
                        @"M":@"comment_list_type_medical@2x.png",//助医
                        @"P":@"comment_list_type_poverty@2x.png",//扶贫
                        @"U":@"comment_list_type_emergency@2x.png",//紧急援助
                        @"A":@"comment_list_type_case_list@2x.png"//意赠行动
                        };
    
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
    if (item.NumberOfItems < 1) {
        _cartLabel.hidden = YES;
    }else{
        _cartLabel.hidden = NO;
    }
//    _selectedIndex = 0;
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenSize.width, 35)];
    topView.userInteractionEnabled = YES;
    topView.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    [self.view addSubview:topView];
    
    _categoryDict   = @{@"0":@"", @"1":@"S",@"2":@"E",@"3":@"M",@"4":@"P",@"5":@"U",@"6":@"A",@"7":@"O",};
    NSArray * arr = @[@[EGLocalizedString(@"GirdView_selectButton_title", nil),EGLocalizedString(@"助学", nil),EGLocalizedString(@"安老", nil),EGLocalizedString(@"助医", nil),EGLocalizedString(@"扶贫", nil),EGLocalizedString(@"紧急援助", nil),EGLocalizedString(@"意赠行动", nil),EGLocalizedString(@"其他", nil)]];
    EGDropDownMenu *menu = [[EGDropDownMenu alloc] initWithFrame:CGRectMake(10, 70, ScreenSize.width-20, 25) Array:arr selectedColor:[UIColor grayColor]];
    menu.delegate = self;
    [self.view addSubview:menu];

    //定时切换cell中紫色view的数据
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    _isSwap = YES;
    //获取：MemberID
    NSMutableDictionary * dict = [ShowMenuView getUserInfo];
    _item = dict[@"LoginName"];
    [self requestApiData:@"CareList" andMemberID:_item.MemberID];
    [self createTable];
    [self createFooterButton];
    [self createMenuUI];
    
    CateImageSortarray = [[NSMutableArray alloc] initWithObjects:@"O",@"S",@"E",@"M",@"P",@"U",@"A",nil];
    CateImageSortdict = [[NSMutableDictionary alloc] init];
    [CateImageSortdict setObject:@"O" forKey:@"key1"];
    [CateImageSortdict setObject:@"S" forKey:@"key2"];
    [CateImageSortdict setObject:@"E" forKey:@"key3"];
    [CateImageSortdict setObject:@"M" forKey:@"key4"];
    [CateImageSortdict setObject:@"P" forKey:@"key5"];
    [CateImageSortdict setObject:@"U" forKey:@"key6"];
    [CateImageSortdict setObject:@"A" forKey:@"key7"];
    

}
- (void)dropDownMenu:(EGDropDownMenu *)dropDownMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger num = indexPath.row;
    
    MyLog(@"%@",_categoryDict[[NSString stringWithFormat:@"%ld",num]]);
                              
    [self requestApiData:_categoryDict[[NSString stringWithFormat:@"%ld",num]] andMemberID:_item.MemberID];
}
- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction{
    MyDonationViewController * vc = [[MyDonationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 请求Cell数据
-(void)requestApiData:(NSString *)category andMemberID:(NSString *)memberID{

    if (memberID == NULL) {
        memberID = @"";
    }
    if (category == NULL) {
        category = @"";
    }
    
    
    long lang = [EGUtility getAppLang];
    
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCaseList xmlns=\"egive.appservices\"><Lang>%ld</Lang><Category>%@</Category><CaseTitle></CaseTitle><MemberID>%@</MemberID><StartRowNo>1</StartRowNo><NumberOfRows>999</NumberOfRows></GetCaseList></soap:Body></soap:Envelope>",lang,category,memberID];
    
    MyLog(@"%@",soapMessage);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [self showLoadingAlert];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        //        MyLog(@"%@", operation.request.allHTTPHeaderFields);
        //        // 服务器给我们返回的包得头部信息
        //                MyLog(@"%@", operation.response);
        //        返回的数据
        //        MyLog(@"success = %@",responseObject);
        [self removeLoadingAlert];
         _dataArray = [[NSMutableArray alloc] init];
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary * dict = [[NSDictionary alloc] init];
        dict = [NSString parseJSONStringToNSDictionary:dataString];
        
        MyLog(@"%@",dict);
        
        
        if (![dict[@"ItemList"] isEqual:[NSNull null]]){
        NSArray * listArray = [[NSArray alloc] initWithArray:dict[@"ItemList"]];
            for (NSDictionary * listDict in listArray) {
                GirdModel *  model = [[GirdModel alloc] init];
                [model setValuesForKeysWithDictionary:listDict];
                if (model.Isfavourite) {
                    [_dataArray addObject:model];
                }
            }
        }
        
        
        NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
        EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
        
        for (GirdModel *model in _dataArray){
            model.isSelect = NO;
            for (EGShoppingCart *obj in item.ItemList) {
                if ([model.CaseID isEqualToString:obj.CaseID]) {
                    model.isSelect = YES;
                }
            }
        }
     
        MyLog(@"%ld",_dataArray.count);
        
        if (_dataArray.count != 0) {
            
            
             [_tableView reloadData];
            
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


- (void)createTable{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,100, ScreenSize.width, ScreenSize.height-164) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        static NSString *cellID = @"twoCell";
        GirdTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil)
        {
            cell = [[GirdTwoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (_isSwap) {
            cell.bgView.hidden = NO;
            cell.bgView1.hidden = YES;
        }else{
            cell.bgView.hidden = YES;
            cell.bgView1.hidden = NO;
        }
        
        GirdModel * model = _dataArray[indexPath.row];
        NSURL *url = [NSURL URLWithString:SITE_URL];
        url = [url URLByAppendingPathComponent:model.ProfilePicURL];
        if (![model.ProfilePicURL isEqualToString:@""] && model.ProfilePicURL) {
            [cell.showImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
            cell.showImage.contentMode = UIViewContentModeScaleAspectFit;
        }else{
            [cell.showImage setImage: [UIImage imageNamed:@"dummy_case_related_default@2x.png"]];
            cell.showImage.contentMode = UIViewContentModeScaleAspectFit;
        }
        
        cell.titleLabel.text = model.Title;
        cell.titleLabel1.text = model.Title;
        cell.progress.progress = model.Percentage/100;
        if (model.Percentage >= 100) {
            cell.proLabel.text = [NSString stringWithFormat:@"100%%"];
            cell.progressImg.hidden=YES;
        }else{
            cell.progressImg.hidden=NO;
            cell.proLabel.text = [NSString stringWithFormat:@"%2.f%%",model.Percentage];
        }

        if (ScreenSize.height == 667) {
            if (model.Percentage >= 100) {
                cell.progressImg.frame = CGRectMake(25+100*(ScreenSize.width/320+0.15), 48,25, 25);
            }else
            cell.progressImg.frame = CGRectMake(model.Percentage*(ScreenSize.width/320+0.4), 48,25, 25);
        }else if (ScreenSize.height == 736)
            if (model.Percentage >= 100) {
                cell.progressImg.frame = CGRectMake(25+100*(ScreenSize.width/320+0.15), 48,25, 25);
            }else
            cell.progressImg.frame = CGRectMake(model.Percentage*(ScreenSize.width/320+0.45), 48,25, 25);
        else{
            if (model.Percentage >= 100) {
                cell.progressImg.frame = CGRectMake(25+100*(ScreenSize.width/320+0.15), 48,25, 25);
            }else
            cell.progressImg.frame = CGRectMake(model.Percentage*(ScreenSize.width/320+0.3), 48,25, 25);
        }
    
       AppLang lang = [EGUtility getAppLang];

    NSMutableArray *CateArray  =[[NSMutableArray alloc] init];
    KeyCateArray  =[[NSMutableArray alloc] init];
    MyLog(@"%@",model.Category);
    if ([model.Category length]>1){
        
      NSArray *CaArray = [model.Category componentsSeparatedByString:@","];
        
        for (int j=0; j<CaArray.count; j++){
        KeyCateArray = [CateImageSortdict allKeysForObject:CaArray[j]];
            
            [CateArray addObject:[KeyCateArray objectAtIndex:0]];
        }
        
     NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];//yes升序排列，no,降序排列
     NSArray *myary = [CateArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
     model.Category = [CateImageSortdict objectForKey:[myary objectAtIndex:0]];
     cell.typeImage.image = [UIImage imageNamed:_typeImageDict1[model.Category]];
      cell.typeImage1.image = [UIImage imageNamed:_typeImageDict1[model.Category]];
        
        
    }else{
        cell.typeImage.image = [UIImage imageNamed:_typeImageDict1[model.Category]];
        cell.typeImage1.image = [UIImage imageNamed:_typeImageDict1[model.Category]];
    }
     //        cell.time.text = [NSString stringWithFormat:@"%@ %@ To Go",model.RemainingValue,model.RemainingUnit];
    
    
        if (lang==1) { //hk
            cell.time.text = [NSString stringWithFormat:@"剩餘時間:%@ %@",model.RemainingValue,model.RemainingUnit];
        }else if (lang==2){//cn
            cell.time.text = [NSString stringWithFormat:@"剩余时间:%@ %@",model.RemainingValue,model.RemainingUnit];
        }else{
            cell.time.text = [NSString stringWithFormat:@"%@ %@ To Go",model.RemainingValue,model.RemainingUnit];
        }
        cell.count.text = [NSString stringWithFormat:@"%@",model.DonorCount];
        cell.moneyLabel.text = [NSString stringWithFormat:@"$%@",model.Amt];
        cell.goalMoney.text = [NSString stringWithFormat:@"$%@",model.TargetAmt];
        cell.attentionButton.selected = YES;
        if (model.IsSuccess) {
            
        cell.heartImg.image = [UIImage imageNamed:@"comment_progress_heart_complete"];
            [cell.heartImg startAnimating];
        }else
        {
            
            cell.heartImg.image = [UIImage imageNamed:@"comment_progress_heart_nor@2x.png"];
            
        }
        __weak typeof(self)weakSelf = self;
        [cell.attentionButton setAction:^(MyBtn * button) {
            
            [weakSelf DeleteCaseFavourite:model.CaseID];
            
    }];
    
    if (model.Isfavourite == YES) {
        cell.attentionButton.selected = YES;
        cell.attentionButton.backgroundColor = [UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1];
    }else{
        cell.attentionButton.selected = NO;
        cell.attentionButton.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:0.8];
        
    }
    
    [cell.donationButton setAction:^(MyBtn * button) {
        
        if (button.selected) {
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"專案已經加入購物車,請選擇其他專案", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            [_tableView reloadData];
            
        }else{
            
            if ([model.RemainingValue intValue] == 0) {
                UIAlertView *alertView = [[UIAlertView alloc] init];
                alertView.message = EGLocalizedString(@"專案已結束,請支持其他專案", nil);
                [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                [alertView show];
            }else{
                
                [weakSelf saveShoppingCartItem:model.CaseID];
                [_tableView reloadData];
            }
        }
    }];
    
    if (model.isSelect) {
        cell.donationButton.selected = YES;
        cell.donationButton.backgroundColor = [UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1];
    }else{
        cell.donationButton.selected = NO;
        cell.donationButton.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:0.8];
    }
    

        return cell;

}

- (void)timerAction{
    if (_isSwap) {
        _isSwap = NO;
        
    }else{
        _isSwap = YES;
    }
//    NSArray *indexPaths = [_tableView indexPathsForVisibleRows];
//    [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [_tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GirdModel * model = _dataArray[indexPath.row];
    GirdDetailViewController * vc = [[GirdDetailViewController alloc] init];
    vc.caseID = model.CaseID;
    vc.girdMdel = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 收藏请求
-(void)AddCaseFavourite:(NSString *)caseID{
    
    if (_item.MemberID == NULL) {
        _item.MemberID = @"";
    }
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><AddCaseFavourite xmlns=\"egive.appservices\"><CaseID>%@</CaseID><MemberID>%@</MemberID></AddCaseFavourite></soap:Body></soap:Envelope>",caseID,_item.MemberID];
    
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
        
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSString *result = [NSString captureData:dataString];
        if ([result isEqual:@"\"\""]) {
            
            [self requestApiData:@"CareList" andMemberID:_item.MemberID];
            
        }else{
            
        if ([result isEqualToString:@"\"Error(9001)\""]||[result isEqualToString:@"Error(9001)"]) {
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"此专案已被收藏在我的关注页面", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];

            
            }else{
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = result;
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                [alertView show];
            
            }
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

#pragma mark - 取消收藏请求
-(void)DeleteCaseFavourite:(NSString *)caseID{
    if (_item.MemberID == NULL) {
        _item.MemberID = @"";
    }
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <DeleteCaseFavourite xmlns=\"egive.appservices\"><CaseID>%@</CaseID><MemberID>%@</MemberID></DeleteCaseFavourite></soap:Body></soap:Envelope>",caseID,_item.MemberID];
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
        NSString *result = [NSString captureData:dataString];
        if ([[NSString captureData:dataString] isEqualToString:@"\"\""]) {
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"取消成功!", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            [self requestApiData:@"CareList" andMemberID:_item.MemberID];
        }else{
            
            if ([result isEqualToString:@"\"Error(9002)\""]||[result isEqualToString:@"Error(9002)"]) {
                
                UIAlertView *alertView = [[UIAlertView alloc] init];
                alertView.message = EGLocalizedString(@"此专案未在我的关注页面", nil);
                [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                [alertView show];
                
            }else{
            
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = result;
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            }
            
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
- (void)saveShoppingCartItem:(NSString *)caseId
{
    EGSaveShoppingCartItemRequest *request = [[EGSaveShoppingCartItemRequest alloc] init];
    request.MemberID = _item.MemberID ? _item.MemberID :@"";
    NSString *cookieId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    request.CookieID = cookieId;
    request.CaseID = caseId;
    request.DonateAmt = 0;
    request.IsChecked = 1;
    
    //    __weak __typeof(self)weakself = self;
    
    [EGMyDonationRequestAdapter saveShoppingCartItem:request success:^(NSString *result) {
        
        [self GetAndSaveShoppingCart];
        
        
    } failure:^(NSError *error) {
        MyLog(@"%@",error);
    }];
}

- (void)GetAndSaveShoppingCart{
    
    EGGetAndSaveShoppingCartRequest *request = [[EGGetAndSaveShoppingCartRequest alloc] init];
    request.lang = 1;
    request.LocationCode = @"HK";
    request.DonateWithCharge = YES;
    request.MemberID = _item.MemberID ? _item.MemberID :@"";
    NSString *cookieId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    MyLog(@"cookieId --------------->>>>>>>>%@",cookieId);
    request.CookieID = cookieId;
    request.StartRowNo = 1;
    request.NumberOfRows = 20;
    
    //    __weak __typeof(self)weakSelf = self;
    [EGMyDonationRequestAdapter getGetAndSaveShoppingCart:request success:^(EGGetAndSaveShoppingCartResult *result) {
        
        //        _cartLabel.text = [NSString stringWithFormat:@"%ld",result.NumberOfItems];
        
        NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
        if (result != nil) {
            [shopCartDict setObject:result forKey:@"shopItem"];
        }
        _cartLabel.text = [NSString stringWithFormat:@"%ld",result.NumberOfItems];
        if (result.NumberOfItems < 1) {
            _cartLabel.hidden = YES;
        }else{
            _cartLabel.hidden = NO;
        }
        //        EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCount" object: nil];
        
    } failure:^(NSError *error) {
        MyLog(@"%@",error);
    }];
    
}

- (void)changeCount {
    
    NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
    EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
    
    for (GirdModel *model in _dataArray) {
        model.isSelect = NO;
        for (EGShoppingCart *obj in item.ItemList) {
            if ([model.CaseID isEqualToString:obj.CaseID]) {
                model.isSelect = YES;
            }
        }
    }
    self.donationsLabel.text = [NSString stringWithFormat:@"%ld",item.NumberOfItems];
    if (item.NumberOfItems < 1) {
        self.donationsView.hidden = YES;
    }else{
        self.donationsView.hidden = NO;
    }
    [_tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    
    if (_isFavouritePush) {
        [self AddCaseFavourite:_caseId];
    }
    _cartLabel.hidden = NO;
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
