//
//  BlessingViewController.m
//  Egive
//
//  Created by sino on 15/9/2.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "Constants.h"
#import "BlessingViewController.h"
#import "ShowMenuView.h"
#import "CommentModel.h"
#import "LoginViewController.h"
#import "EGUtility.h"
#import "SendBlessingsViewController.h"
#import "EGEditBlessingController.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface BlessingViewController ()
{
    UIAlertView * _delectAlertView;
    UIAlertView * _alertView;
    NSInteger _flag;
    NSDictionary * _dataDict;
}
@property (nonatomic) BOOL isEdit;
@property (strong, nonatomic) MemberModel * item;
@property (strong, nonatomic) NSMutableArray * flagArr;
@property (copy, nonatomic) NSMutableArray * iconArray;
@end

@implementation BlessingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // self.title = [NSString stringWithFormat:@"%@(%ld)", EGLocalizedString(@"送祝福", nil), _commentsArray.count];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //判断用户是否登入，如登入获取：MemberID
    NSMutableDictionary * dict = [ShowMenuView getUserInfo];
    _item = dict[@"LoginName"];
    
    _isEdit = NO;
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 33, 33);
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_bless@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //获取捐款人基本信息数据
    _dataArray = [[NSMutableArray alloc] init];
    //    _iconArray = [[NSMutableArray alloc] init];
    //    for (NSDictionary * commenDict in _commentsArray) {
    //        NSDictionary * dict = [[NSDictionary alloc]initWithObjectsAndKeys:commenDict[@"CaseCommentID"],@"CaseCommentID",commenDict[@"ImgURL"],@"ImgURL",commenDict[@"MemberName"],@"MemberName",commenDict[@"MemberID"],@"MemberID",commenDict[@"CommentDate"],@"CommentDate",commenDict[@"Comment"],@"Comment",nil];
    //        NSString * commentId = commenDict[@"CaseCommentID"];
    //        CommentModel * model = [[CommentModel alloc] init];
    //        [model setValuesForKeysWithDictionary:commenDict];
    //        [_dataArray addObject:model];
    //        MyLog(@"%@",commenDict[@"Comment"]);
    //    }
    
    
    [self createTableView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    //判断用户是否登入，如登入获取：MemberID
    NSMutableDictionary * dict = [ShowMenuView getUserInfo];
    _item = dict[@"LoginName"];
    
    [self requestApiData:_caseID andMemberID:_item.MemberID];
    
}

#pragma mark - 请求Cell数据
-(void)requestApiData:(NSString *)caseID andMemberID:(NSString *)memberID{
    
    long lang = [EGUtility getAppLang];
    
   // MyLog(@"caseID --------------  %@",caseID);
    if (memberID == NULL) {
        memberID = @"";
    }
    _dataArray = [[NSMutableArray alloc] init];
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCaseDtl xmlns=\"egive.appservices\"><Lang>%ld</Lang><CaseID>%@</CaseID><MemberID>%@</MemberID></GetCaseDtl></soap:Body></soap:Envelope>",lang,caseID,memberID];
    
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
        
        _dataDict = [NSString parseJSONStringToNSDictionary:dataString];
       // MyLog(@"%@",_dataDict);
        _model = [[GirdDetailModel alloc] init];
        [_model setValuesForKeysWithDictionary:_dataDict];
        [_dataArray addObject:_model];
        
        //获取捐款人基本信息数据
        _dataArray = [[NSMutableArray alloc] init];
        for (NSDictionary * commenDict in _model.Comments) {
            
            CommentModel * model = [[CommentModel alloc] init];
            [model setValuesForKeysWithDictionary:commenDict];
            [_dataArray addObject:model];
            //            [_tableView reloadData];
           // MyLog(@"%@",commenDict[@"Comment"]);
            
        }
        self.title = [NSString stringWithFormat:@"%@(%ld)", EGLocalizedString(@"送祝福", nil), (unsigned long)_dataArray.count];
        [_tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
       // MyLog(@"%@", operation.request.allHTTPHeaderFields);
        // 服务器给我们返回的包得头部信息
        //MyLog(@"%@", operation.response);
        // 返回的数据
        //MyLog(@"success = %@", error);
    }];
    
    [operation start];
    
}

- (void)rightAction{
    //    if (_isEdit) {
    //        _isEdit = NO;
    //        [_tableView reloadData];
    //
    //    }else{
    //        if (self.item != nil){
    //            _isEdit = YES;
    //            [_tableView reloadData];
    //        }else{
    //
    //            LoginViewController * vc = [[LoginViewController alloc] init];
    //            [self.navigationController pushViewController:vc animated:YES];
    //        }
    //    }
    if (self.item != nil){
        EGEditBlessingController * vc = [[EGEditBlessingController alloc] init];
        vc.model = _model;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LoginViewController * vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 150;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellID = @"cell";
    BlessingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[BlessingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CommentModel * model = _dataArray[indexPath.row];
    
    if (![model.ImgURL isEqualToString:@""]) {
        NSURL *url = [NSURL URLWithString:SITE_URL];
        url = [url URLByAppendingPathComponent:model.ImgURL];
        [cell.userIcon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"menu_profile_pic_empty@2x.png"]];
        //cell.userIcon.contentMode = UIViewContentModeScaleAspectFit;
    }else{
        [cell.userIcon setImage:[UIImage imageNamed:@"menu_profile_pic@2x.png"]];
    }
    cell.memberName.text = model.MemberName;
    cell.commentDate.text = [model.CommentDate substringWithRange:NSMakeRange(0, model.CommentDate.length-3)];
    cell.comment.text = model.Comment;
    
    NSString* content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"render" ofType:@"html"] encoding:NSUTF8StringEncoding error:NULL];
    content = [content stringByReplacingOccurrencesOfString:@":content:" withString:model.Comment];
    //MyLog(@"%@", content);
    [cell.commentWv loadHTMLString:content baseURL:[[NSBundle mainBundle] bundleURL]];
   // NSString *w = [cell.commentWv stringByEvaluatingJavaScriptFromString:@"document.getElementById('emoji-wysiwyg-editor').clientWidth;"];
   // MyLog(@"getEmojiAreaWidth = %@", w);
    
    //    if ([_item.MemberID isEqualToString:dict[@"MemberID"]]) {
    //
    //    }
    
    if ([_item.MemberID isEqualToString:model.MemberID]) {
        cell.deleteComment.hidden = NO;
    }else{
        cell.deleteComment.hidden = YES;
    }
    
    
    [cell.deleteComment setAction:^(MyBtn * button) {
        _flag = indexPath.row;
        _delectAlertView = [[UIAlertView alloc] init];
        _delectAlertView.delegate = self;
        _delectAlertView.message = EGLocalizedString(@"确定要删除该祝福吗?", nil);
        [_delectAlertView addButtonWithTitle:EGLocalizedString(@"取消", nil)];
        [_delectAlertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [_delectAlertView show];
        
        
        
        // [self DeleteCaseComment:model.CaseCommentID andModel:model];
        
    }];
    
    long numOfLine = [self getNumOfLines:model.Comment];
    long extraLine = numOfLine - 3;
    if (extraLine < 0) extraLine = 0;
    
    cell.view.frame = CGRectMake(10, 30, ScreenSize.width-20, 135+extraLine*13);
    cell.commentWv.frame = CGRectMake(11, 40, ScreenSize.width-22, 125+extraLine*13);
    cell.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentModel * model = _dataArray[indexPath.row];
   
    
    long numOfLine = [self getNumOfLines:model.Comment];
    
    //    MyLog(@"stripped = %@", stripped);
   // MyLog(@"numOfLine = %ld", numOfLine);
    long extraLine = numOfLine - 3;
    if (extraLine < 0)
        extraLine = 0;
    
    return 170.0f + extraLine * 13;
}

- (long)getNumOfLines:(NSString*)content {
    NSString *stripped = [content stringByReplacingOccurrencesOfRegex:@"<[^>]*>" withString:@""];
    long imgCount = [[content componentsSeparatedByString:@"<img "] count] -1;
    long strCount = [content length] - [[content stringByReplacingOccurrencesOfString:@"img " withString:@""] length];
    if ([content length] != 0) {
        strCount /= [content length];
        
    }
    long numOfLine = ([stripped length] + imgCount*5) / 15;
    if (numOfLine < 1) numOfLine = 0;
    if (imgCount > 0) numOfLine += 2;
    if (imgCount > 5) numOfLine += (imgCount % 3)*3;
    if (imgCount > 20) numOfLine += 3;
    if (imgCount > 30) numOfLine += 10;
    if (numOfLine > 5) numOfLine += 2;
    return numOfLine+1;
}

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)DeleteCaseComment:(NSString *)caseCommentId andModel:(CommentModel *)model{
    
    NSString * soapMessage = [NSString stringWithFormat:
                              @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><DeleteCaseComment xmlns=\"egive.appservices\"><CaseCommentID>%@</CaseCommentID></DeleteCaseComment></soap:Body></soap:Envelope>",caseCommentId];
    
    [EGGeneralRequestAdapter postWithHttpsConnection:YES soapMsg:soapMessage success:^(id result) {
        
        NSString *dataString = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
        result = [NSString captureData:dataString];
        
        if ([[NSString captureData:dataString] isEqualToString:@"\"\""]) {
            _alertView = [[UIAlertView alloc] init];
            _alertView.message = EGLocalizedString(@"删除成功!", nil);
            [_alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [_alertView show];
            
            [_dataArray removeObject:model];
            self.title = [NSString stringWithFormat:@"%@(%ld)", EGLocalizedString(@"送祝福", nil), (unsigned long)_dataArray.count];
            [_tableView reloadData];
            
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = result;
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
        }
    } failure:^(NSError * error) {
        
    }];
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    MyLog(@"buttonIndex = %ld",buttonIndex);
    if (alertView == _delectAlertView) {
        if (buttonIndex == 1) {
            CommentModel * model = _dataArray[_flag];
            [self DeleteCaseComment:model.CaseCommentID andModel:model];
        }
    }
    
    
}

-(void)didReceiveMemoryWarning {
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
