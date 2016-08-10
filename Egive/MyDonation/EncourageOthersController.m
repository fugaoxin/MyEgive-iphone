//
//  EncourageOthersController.m
//  Egive
//
//  Created by sinogz on 15/9/15.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EncourageOthersController.h"
#import "EGUtility.h"
#import "ContactListController.h"
#import "DDMenuController.h"
#import "HomeViewController.h"
#import "MyDonationViewController.h"
#import "AppDelegate.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "Constants.h"
#import "EncourageOthersController.h"
@interface EncourageOthersController ()<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>
{
    CGFloat margin;
    CGFloat buttonH;
    NSString *recodString;
}

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIButton *cancelBtn;
@property (nonatomic, strong)UIButton *confirmBtn;
@property (nonatomic, strong)UIButton *addNewDonatorBtn;

@property (nonatomic, assign)CGFloat cellHeight;

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *titleArray;
@property (nonatomic, strong)NSMutableArray *caseIDArray;
@property(retain,nonatomic)NSMutableArray *recordList;
@end

@implementation EncourageOthersController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = EGLocalizedString(@"呼籲募捐", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 33, 33);
    [rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"address_book"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
//    _titleArray = [[NSMutableArray alloc] init];
//    _caseIDArray = [[NSMutableArray alloc] init];
//    if (_ItemList.count > 0) {
//        for (EGShoppingCart *proj in _ItemList) {
//            NSString *title = proj.Title;
//            NSString *caseId = proj.CaseID;
//            [_titleArray addObject:title];
//            [_caseIDArray addObject:caseId];
//        }
//    }

    [self setupSubView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubView
{
    margin = 10;
    CGFloat width = kScreenW - margin*2;
    _cellHeight = 50;
    CGFloat posY = 0;
    buttonH = 30;
    
    //
    ContactModel *model = [[ContactModel alloc] init];
    model.name = @"";
    model.email = @"";
    [self.dataArray addObject:model];
    
    
    //tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, posY, kScreenW, kScreenH - 64) style:UITableViewStylePlain];
    //[tableView setBackgroundColor:[UIColor grayColor]];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.sectionHeaderHeight = 0.f;
    tableView.sectionFooterHeight = 0.f;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    // button
//    posY = CGRectGetMaxY(tableView.frame) + 10;
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(margin, posY, width, buttonH);
//    [button setTitle:@"增加呼吁对象" forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:14];
//    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//    button.layer.cornerRadius = 4;
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    button.backgroundColor = kPurpleColor;
//    [button addTarget:self action:@selector(addNewDonators:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    _addNewDonatorBtn = button;
    
    CGFloat buttonW = (width - margin)/2;
    CGFloat posX = margin;
    posY = kScreenH - buttonH - 10;
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(posX, posY, buttonW, buttonH);
    [cancelBtn setTitle:EGLocalizedString(@"取消", nil) forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    cancelBtn.layer.cornerRadius = 4;
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.backgroundColor = kGreenBtnColor;
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    posX = CGRectGetMaxX(cancelBtn.frame) + margin;
    confirmBtn.frame = CGRectMake(posX, posY, buttonW, buttonH);
    [confirmBtn setTitle:EGLocalizedString(@"Common_button_confirm", nil) forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    confirmBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    confirmBtn.layer.cornerRadius = 4;
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.backgroundColor = kGreenBtnColor;
    [confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    _confirmBtn = confirmBtn;
}

// 选择通讯录联系人
- (void)rightAction:(UIButton *)button
{
    __weak typeof(self)weakSelf = self;
    
    ContactListController * vc = [[ContactListController alloc] initWithNibName:@"ContactListController" bundle:nil];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.dismissBlock = ^(NSMutableArray *contactList) {
        
        for (ContactModel *model in weakSelf.dataArray) {
            NSInteger count = contactList.count;
            for (NSInteger i = count - 1; i >= 0; i--) {
                ContactModel *obj = contactList[i];
         
                if ([obj.email isEqualToString:model.email] || !obj.isChecked) {
                    [contactList removeObject:obj];
                }
                
            }
        }
        if (contactList.count) {
            [weakSelf.dataArray addObjectsFromArray:contactList];
            [weakSelf.tableView reloadData];
        }
    };
    [self presentViewController:vc animated:NO completion:nil];
}
- (void)addNewDonators:(UIButton *)button
{
    // Empty Item
    ContactModel *model = [[ContactModel alloc] init];
    model.name = @"";
    model.email = @"";
    [_dataArray addObject:model];
    
    [_tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

- (void)cancelAction:(UIButton *)button
{
    MyLog(@"cancelAction:(UIButton *)button");
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:@"1" forKey:@"EGIVE_AFTER_DONATE"];
    BOOL cansync = [standardUserDefaults synchronize];
    if (!cansync) {
        MyLog(@"!cansync");
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^ {
        [self dismissViewControllerAnimated:YES completion:nil];
    });
    
//    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//    MyDonationViewController * vc = [[MyDonationViewController alloc] init];
//    [self.navigationController setViewControllers:[NSArray arrayWithObject:vc] animated:YES];
}

- (void)confirmAction:(UIButton *)button
{
    
      [self getEmailDetaile];
    //[self displaySystemEmail:_dataArray];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self tapAction];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section) {
        return 1;
    }
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section) {
        return 10;
    }
    return 0.1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        EncourageOthersCell *cell = [EncourageOthersCell cellWithTableView:tableView];
        ContactModel *model = _dataArray[indexPath.row];
        cell.email.text = model.email;
        cell.delObjectBlock = ^(EncourageOthersCell *cell){
            [_dataArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [tableView reloadData];
        };
        
        cell.update = ^(EncourageOthersCell *cell, NSString * emailString){
            
             //NSIndexPath *indexPath = [tableView indexPathForCell:cell];
            model.email = emailString;
            
        };
        
        return cell;
    } else {
        static NSString *ID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(10, 0, kScreenW - 20, buttonH);
            [button setTitle:EGLocalizedString(@"增加呼吁对象", nil) forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            button.layer.cornerRadius = 4;
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor = kPurpleColor;
            [button addTarget:self action:@selector(addNewDonators:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:button];
            _addNewDonatorBtn = button;
            cell.backgroundColor = [UIColor whiteColor];
        }
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)displaySystemEmail:(NSMutableArray *)emailArray{
    
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
    if (!mailViewController) {
        // 在设备还没有添加邮件账户的时候mailViewController为空，下面的present view controller会导致程序崩溃，这里要作出判断
        
        MyLog(@"设备还没有添加邮件账户");
        return;
    }
    mailViewController.mailComposeDelegate = self;
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < emailArray.count; i ++) {
        ContactModel *obj = emailArray[i];
        [arr addObject:obj.email];
    }
//    NSArray *toRecipients = [NSArray arrayWithObjects:@"info@egive4u.org",@"",nil];
    [mailViewController setToRecipients: arr];
    
    // 2.设置邮件主题
    [mailViewController setSubject:@""];
    if ([EGUtility getAppLang]==1) {
        [mailViewController setSubject:@"請支持Eigve專案"];
    }else if ([EGUtility getAppLang]==2){
        [mailViewController setSubject:@"请支持Eigve专案"];
    }else{
        [mailViewController setSubject:@"Please Support Eigve Project"];
    }
//    if (_titleArray.count >0) {
//        [mailViewController setSubject:_titleArray[0]];
//    }else
//    {
//        [mailViewController setSubject:@""];
//    }
    
    
//    if (_titleArray.count>0) {
//        // 3.设置邮件主体内容
//        if ([EGUtility getAppLang]==1) {
//            [mailViewController setMessageBody:[NSString stringWithFormat:@"我剛剛贊助了Eigve - %@，您也來支持！ - %@\n請瀏覽: http://www.egive4u.org/\n\n意贈慈善基金\nEgive For You Charity Foundation\n電話: (852) 2210 2600\n電郵: info@egive4u.org",_titleArray[0],_caseIDArray[0]] isHTML:NO];
//        }else if ([EGUtility getAppLang]==2){
//            [mailViewController setMessageBody:[NSString stringWithFormat:@"我刚刚赞助了Eigve - %@，您也来支持！ - %@\n请浏览: http://www.egive4u.org/\n\n意赠慈善基金\nEgive For You Charity Foundation\n电話: (852) 2210 2600\n电邮: info@egive4u.org",_titleArray[0],_caseIDArray[0]] isHTML:NO];
//        }else{
//            [mailViewController setMessageBody:[NSString stringWithFormat:@"I just made a donation to support Egive - %@, let's join me and support Egive! - %@\nVisit us at www.egive4u.org\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: \ninfo@egive4u.org",_titleArray[0],_caseIDArray[0]] isHTML:NO];
//        }
//    }else{
//    
//        
//    }

   
//    // 3.设置邮件主体内容
//    if ([EGUtility getAppLang]==1) {
//        [mailViewController setMessageBody:[NSString stringWithFormat:@"我剛剛贊助了Eigve ，您也來支持！ \n請瀏覽: http://www.egive4u.org/\n\n意贈慈善基金\nEgive For You Charity Foundation\n電話: (852) 2210 2600\n電郵: info@egive4u.org"] isHTML:NO];
//    }else if ([EGUtility getAppLang]==2){
//        [mailViewController setMessageBody:[NSString stringWithFormat:@"我刚刚赞助了Eigve，您也来支持！\n请浏览: http://www.egive4u.org/\n\n意赠慈善基金\nEgive For You Charity Foundation\n电話: (852) 2210 2600\n电邮: info@egive4u.org"] isHTML:NO];
//    }else{
//        [mailViewController setMessageBody:[NSString stringWithFormat:@"I just made a donation to support Egive. Let's join me and support Egive! \nVisit us at www.egive4u.org\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: \ninfo@egive4u.org"] isHTML:NO];
//    }
    // 3.设置邮件主体内容
    for (EGDonationRecord *record in _recordList) {
        
        recodString  = [NSString stringWithFormat:@"%@ - http://www.egive4u.org/CaseDetail.aspx?CaseID=%@",record.CaseTitle,record.CaseID];
        recodString  = [NSString stringWithFormat:@"%@\n",recodString];
    }

    if ([EGUtility getAppLang]==1) {
        [mailViewController setMessageBody:[NSString stringWithFormat:@"我剛剛在Egive上贊助了以下項目:\n\n%@\n您也来支持！\n\n請瀏覽: www.egive4u.org\n\n意贈慈善基金\nEgive For You Charity Foundation\n電話: (852) 2210 2600\n電郵: info@egive4u.org",recodString] isHTML:NO];
    }else if ([EGUtility getAppLang]==2){
    
        [mailViewController setMessageBody:[NSString stringWithFormat:@"我刚刚在Egive上赞助了以下项目:\n\n%@\n您也来支持！\n\n请浏览: www.egive4u.org\n\n意赠慈善基金\nEgive For You Charity Foundation\n电话: (852) 2210 2600\n电邮: info@egive4u.org",recodString] isHTML:NO];
    }else{
        [mailViewController setMessageBody:[NSString stringWithFormat:@"I have just made a donation on the following case(s) in Egive:\n\n%@\n Let's join me and support Egive! \n\nVisit us at www.egive4u.org\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: \ninfo@egive4u.org",recodString] isHTML:NO];
    }

    
    
    // 4.添加附件
    //    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Icon@2x.png" ofType:@"jpg"];
    //    NSData *attachmentData = [NSData dataWithContentsOfFile:imagePath];
    //    [mailViewController addAttachmentData:attachmentData mimeType:@"image/jpeg" fileName:@"天堂之珠：仙本那"];
    //
//    UIImage *addPic = [UIImage imageNamed: @"Icon@2x.png"];
//    NSData *imageData = UIImagePNGRepresentation(addPic);
//    [mailViewController addAttachmentData: imageData mimeType: @"" fileName: @"Icon.png"];
//     [self presentViewController:mailViewController animated:YES completion:nil];
    // 添加一张图片
//    UIImage *addPic = [UIImage imageNamed: @""];
//    NSData *imageData = UIImagePNGRepresentation(addPic);
//    [mailViewController addAttachmentData: imageData mimeType: @"" fileName: @""];
    // 5.呼出发送视图
    [self presentViewController:mailViewController animated:YES completion:nil];
    
}
-(void)getEmailDetaile{

    __weak __typeof(self)weakself = self;

    MemberModel *member = [ShowMenuView sharedInstance].member;
    NSString *memberID = member.MemberID ? member.MemberID : @"";
    NSUserDefaults *Defaults  = [[NSUserDefaults alloc] init];
    NSString *DonationID  =[Defaults objectForKey:@"DonationID"];
    
   [EGMyDonationRequestAdapter getDonationRecordWithMemberID:memberID DonationID:DonationID success:^(EGGetDonationRecordResult *result) {
    
         weakself.recordList = [NSMutableArray array];
         [weakself.recordList addObjectsFromArray:result.RecordList];
         [Defaults setObject:@"" forKey:@"DonationID"];
         [self displaySystemEmail:_dataArray];
       
       
   } failure:^(NSError *error) {
       
   }];

}


#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    //    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = EGLocalizedString(@"用户取消编辑邮件", nil);
            
            break;
        case MFMailComposeResultSaved:
            msg = EGLocalizedString(@"用户成功保存邮件", nil);
            break;
        case MFMailComposeResultSent:
            msg = EGLocalizedString(@"用户点击发送，将邮件放到队列中，还没发送", nil);
            
            [self home];
            
            
            break;
        case MFMailComposeResultFailed:
            msg = EGLocalizedString(@"用户试图保存或者发送邮件失败", nil);
            break;
        default:
            msg = @"";
            break;
    }
    //    [self alertWithMessage:msg];
    
}

-(void) home {
    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    HomeViewController * vc = [[HomeViewController alloc] init];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:vc] animated:YES];
}

@end
