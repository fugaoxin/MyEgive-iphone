//
//  ActivityViewController.m
//  Egive
//
//  Created by sino on 15/7/29.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ActivityViewController.h"
#import "UIView+ZJQuickControl.h"
#import "ForeshowCell.h"
#import "ScoopCell.h"
#import "ReleaseCenterCell.h"
#import "ForeshowDetailController.h"
#import "ScoopDetailController.h"
#import "MJRefresh.h"
#import "ReleaseDtlViewController.h"
#import "MyDonationViewController.h"
#import "Constants.h"
//#import "ZJScreenAdaptation.h"
//#import "ZJScreenAdaptationMacro.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface ActivityViewController ()
{
    int _menuFlag;
    int nowYear;
}
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,strong) EGDropDownMenu *dropDownMenu;
@property (strong,nonatomic) NSMutableArray *eventDtlList;
@property (strong,nonatomic) NSMutableArray *announcementList;

@end

@implementation ActivityViewController

- (NSMutableArray *)eventDtlList
{
    if (!_eventDtlList) {
        _eventDtlList = [NSMutableArray array];
    }
    return _eventDtlList;
}
- (NSMutableArray *)announcementList
{
    if (!_announcementList) {
        _announcementList = [NSMutableArray array];
    }
    return _announcementList;
}

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = EGLocalizedString(@"MenuView_InformationButton_title", nil);
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
    [rightButton addTarget:self action:@selector(activityRightAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_cart@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _dataArray = [[NSMutableArray alloc] init];
    _selectedIndex = 0;
    
    [self createTopView];
    [self createTabaleView];
    [self createFooterButton];
    [self createMenuUI];
    
}

- (void)activityRightAction{
    MyDonationViewController *vc = [[MyDonationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 顶部Menu按钮
- (void)createTopView {

    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64,ScreenSize.width, 30)];
    topView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.view addSubview:topView];
    
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, 94, ScreenSize.width, 35)];
    downView.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    downView.hidden = YES;
    [self.view addSubview:downView];
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    nowYear=[locationString intValue];
    MyLog(@"%@",locationString);
    
   // NSArray *testArray = @[@[@"2015", @"2014"]];
     NSArray *testArray = @[@[locationString, [NSString stringWithFormat:@"%d",([locationString intValue]-1)]]];
    EGDropDownMenu *menu = [[EGDropDownMenu alloc] initWithFrame:CGRectMake(5, 99, ScreenSize.width-10, 25) Array:testArray selectedColor:[UIColor grayColor]];
    menu.delegate = self;
    [self.view addSubview:menu];
    _dropDownMenu = menu;
    
//    UILabel * label = [downView addLabelWithFrame:CGRectMake(10, 5, 300, 25) text:@"  全部"];
//    label.font = [UIFont systemFontOfSize:14];
//    label.userInteractionEnabled = YES;
//    label.backgroundColor = [UIColor whiteColor];
//    
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(downAction)];
//    UIImageView * tapImage = [downView addImageViewWithFrame:CGRectMake(280, 12, 15, 10) image:@"downMune.png"];
//    tapImage.userInteractionEnabled = YES;
//   [tapImage addGestureRecognizer:tap];
    
    NSArray * titleArray = @[EGLocalizedString(@"DonationInfo_foreshowButton2", nil),EGLocalizedString(@"DonationInfo_scoopButton", nil),EGLocalizedString(@"DonationInfo_releaseButton", nil)];
    _menuFlag = 1;
    __weak typeof(self) weakSelf = self;
    
    for (int i = 0; i < titleArray.count; i ++) {
        _menuButton = [topView addImageButtonWithFrame:CGRectMake(i*(ScreenSize.width/3), 0, ScreenSize.width/3, 30) title:titleArray[i] backgroud:nil action:^(UIButton *button) {
            
            for (int i = 0; i < 3; i ++){
                
                UIButton * button = (UIButton *)[weakSelf.view viewWithTag:200+i];
                button.selected = NO;
                UIView * view = (UIView *)[weakSelf.view viewWithTag:205+i];
                view.hidden = YES;

            }
            
            if (button.tag == 200) {
                UIView * view = (UIView *)[weakSelf.view viewWithTag:205];
                view.hidden = NO;
                button.selected = YES;
                downView.hidden = YES;
                menu.hidden = YES;
                _menuFlag = 1;
                weakSelf.tableView.frame = CGRectMake(0, 64+30, ScreenSize.width, ScreenSize.height-120);
                weakSelf.tableView.contentSize = CGSizeMake(0, 0);
                [weakSelf.eventDtlList removeAllObjects];
                weakSelf.tableView.header.hidden = NO;
                weakSelf.tableView.footer.hidden = NO;
                [weakSelf GetEventDtlListWithEventTp:@"P" startRowNo:1];
                [weakSelf.tableView reloadData];
                
            }else if (button.tag == 201){
                _menuFlag = 2;
                UIView * view = (UIView *)[weakSelf.view viewWithTag:206];
                view.hidden = NO;
                button.selected = YES;
                downView.hidden = NO;
                menu.hidden = NO;
                weakSelf.tableView.frame = CGRectMake(0, 64+30+35, ScreenSize.width, ScreenSize.height-160);
                weakSelf.tableView.contentSize = CGSizeMake(0, 0);
                [weakSelf.eventDtlList removeAllObjects];
                weakSelf.tableView.header.hidden = NO;
                weakSelf.tableView.footer.hidden = NO;
                _dropDownMenu.selectedRow = 0;
                [weakSelf GetEventDtlListWithEventTp:@"R" startRowNo:1];
                [weakSelf.tableView reloadData];
                
            }else if (button.tag == 202){
                _menuFlag = 3;
                UIView * view = (UIView *)[weakSelf.view viewWithTag:207];
                view.hidden = NO;
                button.selected = YES;
                downView.hidden = NO;
                menu.hidden = YES;
                weakSelf.tableView.frame = CGRectMake(0, 64+30, ScreenSize.width, ScreenSize.height-120);
                weakSelf.tableView.contentSize = CGSizeMake(0, 0);
                weakSelf.tableView.header.hidden = YES;
                weakSelf.tableView.footer.hidden = YES;
                _dropDownMenu.selectedRow = 0;
                [weakSelf GetAnnouncementCentreList];
                [weakSelf.tableView reloadData];
            }
        }];
        _menuButton.tag = 200 +i;
        [_menuButton setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]];
        _menuButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_menuButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_menuButton setTitleColor:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1] forState:UIControlStateSelected];
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(i*(kScreenW/3),27, kScreenW/3, 3)];
        lineView.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
        lineView.tag = 205+i;
        lineView.hidden = YES;
        [topView addSubview:lineView];
        if (_menuButton.tag == 200) {
            lineView.hidden =NO;
            _menuButton.selected = YES;
            weakSelf.tableView.header.hidden = NO;
            weakSelf.tableView.footer.hidden = NO;
            [self GetEventDtlListWithEventTp:@"P" startRowNo:1];
        }
    }
}

- (void)createTabaleView {

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+30, ScreenSize.width, ScreenSize.height-125) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    [self setupRefreshController];
}

/**
 *  设置刷新控制器
 */
- (void)setupRefreshController
{
    // 添加下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    
    // 设置header
    _tableView.header = header;
    
    // 添加上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 隐藏刷新状态的文字
    //footer.refreshingTitleHidden = YES;
    
    // 隐藏状态
    //footer.stateLabel.hidden = YES;
    
//    [footer setTitle:@"More..." forState:MJRefreshStateIdle];
//    [footer setTitle:@"Loading..." forState:MJRefreshStateRefreshing];
//    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
//    
//    // 设置footer
//    _tableView.footer = footer;
    
}

- (void)loadNewData
{
    NSString *EventTp = @"R";
    NSInteger Year = nowYear;
    if (_menuFlag == 1) {
        EventTp = @"P";
        Year=0;
    } else {
        Year = [[_dropDownMenu getTitleByIndex:_selectedIndex] integerValue];
    }
    [self.eventDtlList removeAllObjects];
    [self GetEventDtlListWithEventTp:EventTp startRowNo:1 Year:Year];
}

- (void)loadMoreData
{
    NSInteger StartRowNo = 1;
    NSString *EventTp = @"R";
    NSInteger Year = nowYear;
    if (_menuFlag == 1) {
        EventTp = @"P";
    
    } else {
        Year = [[_dropDownMenu getTitleByIndex:_selectedIndex] integerValue];
    }
    
    NSMutableArray *dataArray = [self dataArrayBymenuFlag:_menuFlag];
    EGEventDtl *lastObj = [dataArray lastObject];
    if (lastObj) {
        StartRowNo = [dataArray count] + 1;
    }
    [self GetEventDtlListWithEventTp:EventTp startRowNo:StartRowNo Year:Year];
}



// Retrieve list of event according to selected type
- (void)GetEventDtlListWithEventTp:(NSString *)EventTp startRowNo:(NSInteger)startRowNo
{
    
    if ([EventTp isEqualToString:@"P"]) {
        
        [self GetEventDtlListWithEventTp:EventTp startRowNo:startRowNo Year:0];
    }else{
    
        [self GetEventDtlListWithEventTp:EventTp startRowNo:startRowNo Year:nowYear];
     }
    
}
- (void)GetEventDtlListWithEventTp:(NSString *)EventTp startRowNo:(NSInteger)startRowNo Year:(NSInteger)Year
{
    long lang = [EGUtility getAppLang];
    NSString *yearstring=@"";
    if (Year==0) {
        
        yearstring = @"";
        
    }else{
    
        yearstring = [NSString stringWithFormat:@"%ld",(long)Year];
    
    }
    
    //MyLog(@"%d",Year);
   // NSURL *url = [EGUtility requestURL];
   // MyLog(@"url.host:%@",url.host);
    NSString * soapMessage =[NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <GetEventDtlList xmlns=\"egive.appservices\"><Lang>%ld</Lang><EventTp>%@</EventTp><Year>%@</Year><SearchText></SearchText><StartRowNo>%ld</StartRowNo><NumberOfRows>10</NumberOfRows></GetEventDtlList></soap:Body></soap:Envelope>", lang, EventTp, yearstring,(long)startRowNo];
    
    __weak ActivityViewController *weakself = self;
    
    [EGDIRequestAdapter getEventDtlListWithSoapMsg:soapMessage success:^(EGGetEventDtlListResult *result){
        
         MyLog(@"%@",result);
        
        [weakself.eventDtlList addObjectsFromArray:result.ItemList];
        
        
        //接到推送跳转到详情页面
        if (_InboxFlag==1){
            
        for (int i=0; i<weakself.eventDtlList.count; i++){
            EGEventDtl *eventDtl =weakself.eventDtlList[i];
            if ([self.MsgId isEqualToString:eventDtl.EventID]){
                EGEventDtl *eventDtl = _eventDtlList[i];
                ForeshowDetailController * vc = [[ForeshowDetailController alloc] initWithEventDtl:eventDtl];
                [self.navigationController pushViewController:vc animated:YES];
                _InboxFlag=0;
            }
            
        }
        
        
      }
        
        MyLog(@"%@",weakself.eventDtlList);
        
        [weakself.tableView reloadData];
        
        if (_eventDtlList.count < result.TotalNumberOfItems) {
            _tableView.footer.hidden = NO;
        } else {
            _tableView.footer.hidden = YES;
        }
        //停止刷新状态
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
    } failure:^(NSError *error) {
        
        //停止刷新状态
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        [weakself.tableView reloadData];
    }];
}

// Get list of items in announcement centre
- (void)GetAnnouncementCentreList
{
    AppLang lang = [EGUtility getAppLang];
    
    __weak ActivityViewController *weakself = self;
    [self.eventDtlList removeAllObjects];
    [self.announcementList removeAllObjects];
    [EGDIRequestAdapter getAnnouncementCentreListWithLang:lang success:^(EGGetAnnouncementCentreListResult *result) {
        
        [weakself.announcementList addObjectsFromArray:result.itemlist];
        [weakself.tableView reloadData];
        _tableView.footer.hidden = YES;
        
    } failure:^(NSError *error) {
        
        [weakself.tableView reloadData];
    }];
}

#pragma mark 标签对应模型
- (NSMutableArray *)dataArrayBymenuFlag:(int)menuFlag
{
    if (menuFlag == 1 || menuFlag == 2) {
        
        return _eventDtlList;
        
    } else if (menuFlag == 3) {
        
        return _announcementList;
        
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_menuFlag > 2) {
        return 70;
    }
    
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[self dataArrayBymenuFlag:_menuFlag] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_menuFlag == 1) {
        if (_eventDtlList.count > 0){
            ForeshowCell * cell = [ForeshowCell cellWithTableView:tableView];
            cell.eventDtl = _eventDtlList[indexPath.row];
            return cell;
        }else{
            static NSString * cellID = @"Cell";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            }
            return cell;
        }
        
    }else if (_menuFlag == 2){
        static NSString * cellID = @"scoopCell";
        ScoopCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[ScoopCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        EGEventDtl *eventDtl = _eventDtlList[indexPath.row];
        if (eventDtl.Img.count) {
            NSString *ImgURL = eventDtl.Img[0][@"ImgURL"];
            NSURL *url = [NSURL URLWithString:SITE_URL];
            url = [url URLByAppendingPathComponent:ImgURL];
            [cell.leftImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
//            cell.leftImage.contentMode = UIViewContentModeScaleAspectFit;
        } else {
            //img is nil
            cell.leftImage.image = [UIImage imageNamed:@"dummy_case_related_default@2x.png"];
//            cell.leftImage.contentMode = UIViewContentModeScaleAspectFit;
        }
        
        cell.titleLabel.text = eventDtl.Title;
        cell.describe.text = eventDtl.Desp;
        cell.date.text = [NSString stringWithDataString:eventDtl.EventStartDate];
       // MyLog(@"eventDtl.EventStartDate:%@",eventDtl.EventStartDate);
        return cell;
        
    }else{
        
        static NSString * cellID = @"cell";
        ReleaseCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[ReleaseCenterCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        
        EGAnnouncement *announcement = _announcementList[indexPath.row];
        
        cell.title.text = announcement.Title;
        cell.date.text = [NSString stringWithDataString:announcement.PublishDate format:@"yyyy/MM/dd"];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (_menuFlag == 1){
        
        EGEventDtl *eventDtl = _eventDtlList[indexPath.row];
        ForeshowDetailController * vc = [[ForeshowDetailController alloc] initWithEventDtl:eventDtl];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (_menuFlag == 2) {
        EGEventDtl *eventDtl = _eventDtlList[indexPath.row];
        ScoopDetailController * vc = [[ScoopDetailController alloc] initWithEventDtl:eventDtl];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (_menuFlag == 3) {
        EGAnnouncement *announcement = _announcementList[indexPath.row];
        ReleaseDtlViewController * vc = [[ReleaseDtlViewController alloc] init];
        vc.TitleLabel = announcement.Title;
        vc.PublishDate = announcement.PublishDate;
        vc.URL = announcement.FilePath.length > 0 ? [[NSURL URLWithString:SITE_URL] URLByAppendingPathComponent:announcement.FilePath] : [NSURL URLWithString:announcement.URL];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark filter
- (void)dropDownMenu:(EGDropDownMenu *)dropDownMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedIndex = indexPath.row;
    [self loadNewData];
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
