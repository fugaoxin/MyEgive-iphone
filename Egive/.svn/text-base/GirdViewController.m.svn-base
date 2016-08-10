//
//  GirdViewController.m
//  Egive
//
//  Created by sino on 15/7/27.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ZJButton.h"
#import "Constants.h"
#import "GirdViewController.h"
#import "MyDonationViewController.h"
#import "UIView+ZJQuickControl.h"
#import "GirdViewCell.h"
#import "GirdTwoCell.h"
#import "GirdDetailViewController.h"
#import "EGGetAndSaveShoppingCartResult.h"
#import "GirdModel.h"
#import "NSString+RegexKitLite.h"
#import "UIKit+AFNetworking.h"
#import "AFNetworking.h"
#import "LoginViewController.h"
#import "AddCaseViewController.h"
#import "EGUtility.h"
#import "MJRefresh.h"

#define ScreenSize [UIScreen mainScreen].bounds.size
#define Tag0 89
#define Tag1 90
#define Tag2 91
#define Tag3 92
#define Tag4 93

@interface GirdViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate, UIPickerViewDelegate>
{
    int tag4Init;
    UISearchBar *_searchBar;
    NSTimer * _timer;
    NSMutableArray * _dataArray;
    BOOL _isSwap;
    NSInteger dropdownSelected;
    BOOL _isGo;
    NSDictionary * _typeImageDict;
    //NSDictionary * _typeImageDict1;
    NSDictionary * _categoryDict;
    NSString * _collectionFlag;
    
    NSMutableArray * CateImageSortarray;
    NSMutableDictionary *CateImageSortdict;
    NSArray *KeyCateArray;
}
@property (strong, nonatomic) EGGetAndSaveShoppingCartResult * shoppItem;
@property (copy, nonatomic) NSMutableArray * ShoppingCartArr;
@property (copy, nonatomic) NSString * collectionFlag;
@property (strong, nonatomic) UILabel * collectionCount;
@property (strong, nonatomic) UILabel * cartLabel;
@property (strong, nonatomic) MemberModel * item;
@property (nonatomic) BOOL isList;
@property (strong, nonatomic)UITableView * tableView;
@property (copy, nonatomic) NSMutableArray * caseIDarr;
@property (copy, nonatomic)NSString * CaseTitle; //搜索内容
@property (strong, nonatomic) UIPickerView *pickerViewPopup;
@property (copy, nonatomic)NSArray * typeArr;
@property (strong, nonatomic) EGDropDownMenu *gdmenu;
@property (strong, nonatomic) UIButton *dropDownBtn;
@property (strong, nonatomic) UIImageView * cellShowImage;
@property(nonatomic)unsigned long StartRowNo;
@end

@implementation GirdViewController

- (id)init {
    self = [super init];
    if (self) {
        tag4Init = Tag0;
    }
    return self;
}

- (id)initWithTag:(int) tag {
    self = [super init];
    if (self) {
        tag4Init = tag;
    }
    return self;
}

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _StartRowNo=1;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = EGLocalizedString(@"MenuView_girdButton_title", nil);
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    _cellShowImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.width/4*3)];
    
    _caseIDarr = [[NSMutableArray alloc] init]; //购物车中的caseID
    
    _ShoppingCartArr = [[NSMutableArray alloc] init];
    NSArray * arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"isCartItem"];
    if (arr) {
        [_ShoppingCartArr addObjectsFromArray:arr];
    }
    
     __weak typeof(self) weakSelf = self;
    _navbutton = [self.navigationController.navigationBar addImageButtonWithFrame:CGRectMake(ScreenSize.width-85, 5, 33, 33) title:nil backgroud:@"header_favourite@2x.png" action:^(UIButton *button) {
        if (weakSelf.item != nil){
            MyAttentionViewController * vc = [[MyAttentionViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            LoginViewController * vc = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    
    _typeImageDict = @{
                       @"O":@"comment_list_type_others.png",//其他
                       @"S":@"comment_list_type_education@2x.png",//助学
                       @"E":@"comment_list_type_elder@2x.png",//助老
                       @"M":@"comment_list_type_medical@2x.png",//助医
                       @"P":@"comment_list_type_poverty@2x.png",//扶贫
                       @"U":@"comment_list_type_emergency@2x.png",//紧急援助
                       @"A":@"comment_list_type_case_list@2x.png"//意赠行动
                       };
    
    
    CateImageSortarray = [[NSMutableArray alloc] initWithObjects:@"O",@"S",@"E",@"M",@"P",@"U",@"A",nil];
    CateImageSortdict = [[NSMutableDictionary alloc] init];
    [CateImageSortdict setObject:@"O" forKey:@"key1"];
    [CateImageSortdict setObject:@"S" forKey:@"key2"];
    [CateImageSortdict setObject:@"E" forKey:@"key3"];
    [CateImageSortdict setObject:@"M" forKey:@"key4"];
    [CateImageSortdict setObject:@"P" forKey:@"key5"];
    [CateImageSortdict setObject:@"U" forKey:@"key6"];
    [CateImageSortdict setObject:@"A" forKey:@"key7"];

    
    
//    _typeImageDict1 = @{@"S":@"comment_list_type_education@2x.png",
//                       @"E":@"comment_list_type_elder@2x.png",
//                       @"U":@"comment_list_type_emergency@2x.png",
//                       @"M":@"comment_list_type_medical@2x.png",
//                       @"P":@"comment_list_type_poverty@2x.png",
//                       @"A":@"comment_list_type_case_list@2x.png",
//                        @"O":@"comment_list_type_others@2x.png"};
    
    
    _categoryDict   = @{@"0":@"", @"1":@"S",@"2":@"E",@"3":@"M",@"4":@"P",@"5":@"U",@"6":@"A",@"7":@"0",};
    
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    [rightButton addTarget:self action:@selector(cartAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_cart@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;

    //购物车右侧数量标示label
    NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
    EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
    
    _cartLabel = [self.navigationController.navigationBar addLabelWithFrame:CGRectMake(ScreenSize.width-30, 18, 18, 18) text:[NSString stringWithFormat:@"%d",item.NumberOfItems]];
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
 
    //收藏右侧数量标示label
    _collectionCount = [self.navigationController.navigationBar addLabelWithFrame:CGRectMake(ScreenSize.width-85, 18, 18, 18) text:@"1"];
    _collectionCount.layer.cornerRadius = 9;
    _collectionCount.layer.masksToBounds = YES;
    _collectionCount.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    _collectionCount.textAlignment = NSTextAlignmentCenter;
    _collectionCount.font = [UIFont systemFontOfSize:11];
    _collectionCount.textColor = [UIColor whiteColor];
    
    
    //定时切换cell中紫色view的数据
     _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    _isSwap = YES;
    //判断用户是否登入，如登入获取：MemberID
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults objectForKey:@"EGIVE_MEMBER_MODEL"]) {
        NSMutableDictionary *m = [[standardUserDefaults objectForKey:@"EGIVE_MEMBER_MODEL"] mutableCopy];
        
        MemberModel * model = [[MemberModel alloc] init];
        [model setValuesForKeysWithDictionary:m];
        [ShowMenuView sharedInstance].member = model;
        
        _item = model;
    }
//    NSMutableDictionary * dict = [ShowMenuView getUserInfo];
//    _item = dict[@"LoginName"];

    _dataArray = [[NSMutableArray alloc] init];
    _collectionFlag = @"N";
    
    [self createTopUI];
    [self createTable];
    
    [self createFooterButton];
    [self createMenuUI];
    [self setupRefreshController];
}

- (void)setupRefreshController
{
    // 添加下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    //header.stateLabel.hidden = YES;

    // 设置header
    _tableView.header = header;
    
    // 添加上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 隐藏刷新状态的文字
    //footer.refreshingTitleHidden = YES;
    
    // 隐藏状态
    //footer.stateLabel.hidden = YES;
//    
    [footer setTitle:EGLocalizedString(@"NomoreDate", nil) forState:MJRefreshStateIdle];
    [footer setTitle:EGLocalizedString(@"Loosenrefreshing", nil) forState:MJRefreshStateRefreshing];
    //[footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
//
//    // 设置footer
     _tableView.footer = footer;
    
}



-(void)loadNewData{
    _StartRowNo=1;
    [_dataArray removeAllObjects];
    [self requestApiData:_collectionFlag andMemberID:_item.MemberID];
}



-(void)loadMoreData{

    
   _StartRowNo=_dataArray.count+1;

    [self requestApiData:_collectionFlag andMemberID:_item.MemberID];

}

-(void)cartAction{
    MyDonationViewController * vc = [[MyDonationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 顶部button
- (void)createTopUI{
    
    NSArray * titleArray = @[EGLocalizedString(@"GirdView_button_title1", nil),EGLocalizedString(@"GirdView_button_title2", nil),EGLocalizedString(@"GirdView_button_title3", nil),EGLocalizedString(@"GirdView_button_title4", nil),EGLocalizedString(@"GirdView_button_title0", nil)];
    
    __weak typeof(self) weakSelf = self;
    UIScrollView *topsc = [[UIScrollView alloc] init];
    topsc.frame = CGRectMake(0, 64, ScreenSize.width, 36);
    
    for (int i = 0; i < titleArray.count; i ++) {
        
        ZJButton *titleButton = [ZJButton buttonWithType:UIButtonTypeCustom];
        titleButton.frame = CGRectMake(i*(ScreenSize.width/4), -64, ScreenSize.width/4, 36);
        [titleButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [titleButton setBackgroundImage:nil forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleButton setAction:^(UIButton *button){
            
            for (int i = 0; i < 5; i ++) {
                
                UIButton * button = (UIButton *)[weakSelf.view viewWithTag:89+i];
                [button setBackgroundColor:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]];
            }
            
            if (button.tag == Tag0){
                
                _CaseTitle = @"";
                _collectionFlag = @"N";
                [button setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
                [self loadNewData];
                //[weakSelf requestApiData:weakSelf.collectionFlag andMemberID:weakSelf.item.MemberID];
                if (self.isHidden == -1) {
                    [weakSelf menuAction];
                }

                
                
            }else if (button.tag == Tag1) {
                _collectionFlag = @"C";
                _CaseTitle = @"";
                [button setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
                [self loadNewData];
                //[weakSelf requestApiData:weakSelf.collectionFlag andMemberID:weakSelf.item.MemberID];
                if (self.isHidden == -1) {
                    [weakSelf menuAction];
                }
                
                
            }else if (button.tag == Tag2){
                _CaseTitle = @"";
                _collectionFlag = @"F";
                [button setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
                [self loadNewData];
               // [weakSelf requestApiData:weakSelf.collectionFlag andMemberID:weakSelf.item.MemberID];
                if (self.isHidden == -1) {
                    [weakSelf menuAction];
                }
            }else if (button.tag == Tag3){
                _collectionFlag = @"Successful";
                _CaseTitle = @"";
                [button setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
                [self loadNewData];
                //[weakSelf requestApiData:weakSelf.collectionFlag andMemberID:weakSelf.item.MemberID];
                if (self.isHidden == -1) {
                    [weakSelf menuAction];
                }
            }else if (button.tag == Tag4){
                
                _collectionFlag = @"ANGELACT";
                _CaseTitle = @"";
                [button setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
                [self loadNewData];
                //[weakSelf requestApiData:weakSelf.collectionFlag andMemberID:weakSelf.item.MemberID];
                if (self.isHidden == -1) {
                    [weakSelf menuAction];
                }
            }
            
    
        }];
        [topsc addSubview:titleButton];
        
//        UIButton * titleButton = [self.view addImageButtonWithFrame:CGRectMake(i*(ScreenSize.width/4), 64, ScreenSize.width/4, 36) title:titleArray[i] backgroud:nil action:^(UIButton *button) {
//
//            for (int i = 0; i < 4; i ++) {
//                UIButton * button = (UIButton *)[weakSelf.view viewWithTag:89+i];
//                [button setBackgroundColor:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]];
//            }
//            
//            if (button.tag == Tag0) {
//                _collectionFlag = @"ANGELACT";
//                _CaseTitle = @"";
//                [button setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
//                [weakSelf requestApiData:weakSelf.collectionFlag andMemberID:weakSelf.item.MemberID];
//                if (self.isHidden == -1) {
//                    [weakSelf menuAction];
//                }
//                
//                
//            }else if (button.tag == Tag1) {
//                _collectionFlag = @"N";
//                 _CaseTitle = @"";
//                [button setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
//                [weakSelf requestApiData:weakSelf.collectionFlag andMemberID:weakSelf.item.MemberID];
//                if (self.isHidden == -1) {
//                    [weakSelf menuAction];
//                }
//                
//                
//            }else if (button.tag == Tag2){
//                 _CaseTitle = @"";
//                _collectionFlag = @"C";
//                [button setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
//                [weakSelf requestApiData:weakSelf.collectionFlag andMemberID:weakSelf.item.MemberID];
//                if (self.isHidden == -1) {
//                    [weakSelf menuAction];
//                }
//            }else if (button.tag == Tag3){
//                _collectionFlag = @"F";
//                 _CaseTitle = @"";
//                [button setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
//                [weakSelf requestApiData:weakSelf.collectionFlag andMemberID:weakSelf.item.MemberID];
//                if (self.isHidden == -1) {
//                    [weakSelf menuAction];
//                }
//            }else if (button.tag == Tag4){
//                 _CaseTitle = @"";
//                _collectionFlag = @"Successful";
//                [button setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
//                [weakSelf requestApiData:weakSelf.collectionFlag andMemberID:weakSelf.item.MemberID];
//                if (self.isHidden == -1) {
//                    [weakSelf menuAction];
//                }
//            }
//        }];
        
        
        titleButton.tag = 89 +i;
        [titleButton setBackgroundColor:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if (_isAddJump) {
            if (titleButton.tag == 91) {
                _CaseTitle = @"";
                _collectionFlag = @"F";
                [self loadNewData];
                //[weakSelf requestApiData:weakSelf.collectionFlag andMemberID:weakSelf.item.MemberID];
                [titleButton setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
            }
        }else if (_isSucPush){
            if (titleButton.tag == 93) {
                _CaseTitle = @"";
                _collectionFlag = @"ANGELACT";
                [self loadNewData];
                //[weakSelf requestApiData:weakSelf.collectionFlag andMemberID:weakSelf.item.MemberID];
                [titleButton setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
            }

            
        } else if(titleButton.tag == 89) {
        
            [titleButton setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
        }
    }

    topsc.contentSize = CGSizeMake(titleArray.count*(ScreenSize.width/4), -30);
    topsc.bounces = NO;
    [self.view addSubview:topsc];
    
    UIView * tooTableView = [[UIView alloc] initWithFrame:CGRectMake(0, 90, ScreenSize.width, 30)];
    [self.view addSubview:tooTableView];
    
    [self.view addImageButtonWithFrame:CGRectMake(5, 104, 30, 30) title:nil backgroud:@"case_add_case@2x.png" action:^(UIButton *button) {
      
        AddCaseViewController * vc = [[AddCaseViewController alloc] init];
        if (_item != nil) {
            vc.isLogin = YES;
            vc.MemberID = weakSelf.item.MemberID;
        }
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    }];
    
    
    [self.view addImageViewWithFrame:CGRectMake(45, 106, 100, 25) image:@"case_picker@2x.png"];
    NSArray *arr = @[@[EGLocalizedString(@"GirdView_selectButton_title", nil),@"助學",@"安老",@"助醫",@"扶貧",@"緊急援助",@"意贈行動",@"其他"]];
    _gdmenu = [[EGDropDownMenu alloc] initWithFrame:CGRectMake(45, 106, 120, 25) Array:arr selectedColor:[UIColor lightGrayColor]];
//    menu.delegate = self;
    [self.view addSubview:_gdmenu];
    
//    UIImageView * searchImage = [self.view addImageViewWithFrame:CGRectMake(150, 107, ScreenSize.width/2-40, 25) image:nil];
    //[searchImage setImage:[UIImage imageNamed:@"case_search.png"]];
    _dropDownBtn = [[UIButton alloc] init];
    _dropDownBtn.frame = CGRectMake(35, 106, 130, 25);
    _dropDownBtn.layer.cornerRadius = 25/2;
    _dropDownBtn.layer.borderWidth = 1;
    _dropDownBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _dropDownBtn.layer.masksToBounds = YES;

    [_dropDownBtn addTarget:self action:@selector(pickerViewPopup:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_dropDownBtn];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(170, 106, ScreenSize.width/2-50, 25)];
    [_searchBar setBackgroundImage:[UIImage alloc]];
    _searchBar.layer.cornerRadius = 25/2;
     _searchBar.layer.borderWidth = 1;
     _searchBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
     _searchBar.layer.masksToBounds = YES;
    _searchBar.delegate = self;
    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _searchBar.placeholder = EGLocalizedString(@"GirdView_search_title", nil);
//    clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_searchBar];
    
    //点击切换list View 按钮
    _isList = NO;
   UIButton * swapListButton = [self.view addImageButtonWithFrame:CGRectMake(ScreenSize.width-40, 104, 30, 30) title:nil backgroud:@"case_listview@2x.png" action:^(UIButton *button) {
        if (weakSelf.isList) {
            _isList = NO;
            button.selected = NO;
        }else{
            _isList = YES;
            button.selected = YES;
        }
       
        [weakSelf.tableView reloadData];
    }];
    [swapListButton setBackgroundImage:[UIImage imageNamed:@"case_posterview@2x.png"] forState:UIControlStateSelected];
    
}

-(void) pickerViewPopup:(id*)target {
    MyLog(@"pickerViewPopup");
  
    _pickerViewPopup = [[UIPickerView alloc] initWithFrame:CGRectMake(0, ScreenSize.height - 200 + ((IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) ? 20 : 0), ScreenSize.width , 200)];
    _pickerViewPopup.delegate = self;
    _pickerViewPopup.showsSelectionIndicator = YES;
    _pickerViewPopup.backgroundColor = [UIColor whiteColor];
    [_pickerViewPopup selectRow:dropdownSelected inComponent:0 animated:YES];
    [self.view addSubview:_pickerViewPopup];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    dropdownSelected = row;
    NSString *caption = @"";
    if (row == 0) {
        caption= EGLocalizedString(@"GirdView_selectButton_title", nil);
        _collectionFlag = @"";
    } else if (row == 1) {
        caption= EGLocalizedString(@"願望一覽", nil);
        _collectionFlag = @"ANGELACT";
    } else if (row == 2) {
        caption= EGLocalizedString(@"祝福之最", nil);
        _collectionFlag = @"ANGELACT5";
    } else if (row == 3) {
        caption= EGLocalizedString(@"助学", nil);
        _collectionFlag = @"S";
    } else if (row == 4) {
        caption= EGLocalizedString(@"安老", nil);
        _collectionFlag = @"E";
    } else if (row == 5) {
        caption= EGLocalizedString(@"助医", nil);
        _collectionFlag = @"M";
    } else if (row == 6) {
        caption= EGLocalizedString(@"扶贫", nil);
        _collectionFlag = @"P";
    } else if (row == 7) {
        caption= EGLocalizedString(@"紧急援助", nil);
        _collectionFlag = @"U";
    } else if (row == 8) {
        caption= EGLocalizedString(@"意赠行动", nil);
        _collectionFlag = @"A";
    } else {
        caption= EGLocalizedString(@"其他", nil);
        _collectionFlag = @"O";
    }
    
    NSArray *arr = @[@[caption]];
    [_gdmenu removeFromSuperview];
    [pickerView removeFromSuperview];
    _gdmenu = [[EGDropDownMenu alloc] initWithFrame:CGRectMake(45,106, 120, 25) Array:arr selectedColor:[UIColor grayColor]];
    [self.view addSubview:_gdmenu];
    
    _CaseTitle = @"";
    [self loadNewData];
    //[self requestApiData:_collectionFlag andMemberID:_item.MemberID];
    [[_dropDownBtn superview] bringSubviewToFront:_dropDownBtn];
    //[_dropDownBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 50)];
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (row == 0) {
        return EGLocalizedString(@"GirdView_selectButton_title", nil);
    } else if (row == 1) {
        return EGLocalizedString(@"願望一覽", nil);
    } else if (row == 2) {
        return EGLocalizedString(@"祝福之最", nil);
    } else if (row == 3) {
        return EGLocalizedString(@"助学", nil);
    } else if (row == 4) {
        return EGLocalizedString(@"安老", nil);
    } else if (row == 5) {
        return EGLocalizedString(@"助医", nil);
    } else if (row == 6) {
        return EGLocalizedString(@"扶贫", nil);
    } else if (row == 7) {
        return EGLocalizedString(@"紧急援助", nil);
    } else if (row == 8) {
        return EGLocalizedString(@"意赠行动", nil);
    } else {
        return EGLocalizedString(@"其他", nil);
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return 10;
}

#pragma mark - 请求Cell数据
-(void)requestApiData:(NSString *)category andMemberID:(NSString *)memberID{
    
    MyLog(@"%@",category);
    
    MyLog(@"%ld",_StartRowNo);
   
    [self showLoadingAlert];
    
    [_searchBar resignFirstResponder];
    [_pickerViewPopup removeFromSuperview];
    
     long lang = [EGUtility getAppLang];
    
    if (memberID == NULL) {
        memberID = @"";
    }
    if (_CaseTitle == NULL) {
        _CaseTitle = @"";
    }
    
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCaseList xmlns=\"egive.appservices\"><Lang>%ld</Lang><Category>%@</Category><CaseTitle>%@</CaseTitle><MemberID>%@</MemberID><StartRowNo>%ld</StartRowNo><NumberOfRows>12</NumberOfRows></GetCaseList></soap:Body></soap:Envelope>",lang,category,_CaseTitle,memberID,_StartRowNo];
    
    MyLog(@"soapMessage = %@", soapMessage);
    
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
       [self removeLoadingAlert];
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary * dict = [[NSDictionary alloc] init];
        dict = [NSString parseJSONStringToNSDictionary:dataString];
        MyLog(@"%@",dict);
        
        if (![dict[@"ItemList"] isEqual:[NSNull null]]) {
        NSArray * listArray = [[NSArray alloc] initWithArray:dict[@"ItemList"]];
        
        @synchronized([self class]){
            //_dataArray = [[NSMutableArray alloc] init];
            for (NSDictionary * listDict in listArray) {
                GirdModel *  model = [[GirdModel alloc] init];
                [model setValuesForKeysWithDictionary:listDict];
                [_dataArray addObject:model];
            }
        }
      }
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
        
        
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,139, ScreenSize.width, ScreenSize.height-80-80) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];

}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_searchBar resignFirstResponder];
    [_pickerViewPopup removeFromSuperview];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isList) {
//        return 100*kScreenH/568;
        return 100;
    }else
//    return 210*kScreenH/568;
        return ScreenSize.width/4*3;
        
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!_isList) {
        static NSString *cellID = @"oneCell";
        GirdViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil)
        {
            cell = [[GirdViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (_isSwap) {
            cell.bgView.hidden = NO;
            cell.bgView1.hidden = YES;
        }else{
            cell.bgView.hidden = YES;
            cell.bgView1.hidden = NO;
        }
        if (_dataArray.count > 0){
            GirdModel * model = _dataArray[indexPath.row];
            NSURL *url = [NSURL URLWithString:SITE_URL];
            url = [url URLByAppendingPathComponent:model.ProfilePicURL];
            if (![model.ProfilePicURL isEqualToString:@""]) {
                [cell.showImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
                cell.showImage.contentMode = UIViewContentModeScaleAspectFill;
                
                CGRect frame = cell.showImage.frame;
                frame.size.height = ScreenSize.width/4*3;
                cell.showImage.frame = frame;
                cell.showImage.clipsToBounds = YES;
                
                
//                cell.showImage.image =[self cutCellImage:cell.showImage.image];
            }else{
                [cell.showImage setImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"]];
//                cell.showImage.contentMode = UIViewContentModeScaleAspectFit;
            }
            
            //收藏按钮
            __weak typeof(self)weakSelf = self;
            [cell.favouriteButton setAction:^(MyBtn * button) {
                
                NSMutableDictionary * dict = [ShowMenuView getUserInfo];
                if ([dict objectForKey:@"LoginName"] != nil) {
                    
                    if (model.Isfavourite) {
                        
                         [weakSelf DeleteCaseFavourite:indexPath];
                        //[_tableView reloadData];
                    }else{
                        
                        [weakSelf AddCaseFavourite:indexPath];

                        //[_tableView reloadData];
                    }
                }else{
//                    UIAlertView *alertView = [[UIAlertView alloc] init];
//                    alertView.message = @"如需收藏请登录后再操作!";
//                    [alertView addButtonWithTitle:@"确定"];
//                    [alertView show];
                    MyAttentionViewController * vc = [[MyAttentionViewController alloc] init];
                    LoginViewController * loginvc = [[LoginViewController alloc] initWithToggleViewController:vc];
                    vc.caseId = model.CaseID;
                    vc.isFavouritePush = YES;
                    [self.navigationController pushViewController:loginvc animated:YES];
//                    LoginViewController * vc = [[LoginViewController alloc] init];
//                    [self.navigationController pushViewController:vc animated:YES];
                }
            }];
           
            cell.succeedImage.hidden = YES;
            if (model.IsSuccess) {
                cell.succeedImage.hidden = NO;
            }
            if (model.Isfavourite == YES) {
                cell.favouriteButton.selected = YES;
            }else{
                cell.favouriteButton.selected = NO;
            }
            
            cell.titleLabel.text = [NSString stringWithFormat:@"%@ (%@)", model.Title, model.Region];
            cell.titleLabel1.text = [NSString stringWithFormat:@"%@ (%@)", model.Title, model.Region];
            cell.progress.progress = model.Percentage/100;
            if (model.Percentage >= 100) {
                cell.proLabel.text = [NSString stringWithFormat:@"100%%"];
            }else{
                cell.proLabel.text = [NSString stringWithFormat:@"%2.f%%",model.Percentage];
            }
            if (ScreenSize.height == 667) {
                if (model.Percentage >= 100) {
                    cell.progressImg.frame = CGRectMake(25+100*(ScreenSize.width/320+0.15), 30,25, 25);
                }else
                cell.progressImg.frame = CGRectMake(25+model.Percentage*(ScreenSize.width/320+0.15), 30,25, 25);
            }else if (ScreenSize.height == 736)
                if (model.Percentage >= 100) {
                    cell.progressImg.frame = CGRectMake(25+100*(ScreenSize.width/320+0.15), 30,25, 25);
                }else
                cell.progressImg.frame = CGRectMake(25+model.Percentage*(ScreenSize.width/320+0.2), 30,25, 25);
            else{
                if (model.Percentage >= 100) {
                    cell.progressImg.frame = CGRectMake(25+100*(ScreenSize.width/320+0.15), 30,25, 25);
                }else
                cell.progressImg.frame = CGRectMake(25+model.Percentage*(ScreenSize.width/320+0.05), 30,25, 25);
            }
            cell.progressImg.hidden = model.Percentage >= 100 ? YES:NO;
            if (model.Percentage < 50) {
                //设置进度条左边的进度颜色
                [cell.progress setProgressTintColor:[UIColor colorWithRed:255/255.0 green:175/255.0 blue:35/255.0 alpha:1]];
                cell.heartImg.image = [UIImage imageNamed:@"comment_progress_heart_nor"];
                [cell.heartImg stopAnimating];
            } else if (model.Percentage < 100) {
                [cell.progress setProgressTintColor:[UIColor colorWithRed:219/255.0 green:128/255.0 blue:29/255.0 alpha:1]];
                cell.heartImg.image = [UIImage imageNamed:@"comment_progress_heart_mid"];
                [cell.heartImg stopAnimating];
            } else {
                [cell.progress setProgressTintColor:[UIColor colorWithRed:199/255.0 green:78/255.0 blue:102/255.0 alpha:1]];
                cell.heartImg.image = [UIImage imageNamed:@"comment_progress_heart_complete"];
                [cell.heartImg startAnimating];
            }
            NSMutableArray *CateArray  =[[NSMutableArray alloc] init];
            KeyCateArray  =[[NSMutableArray alloc] init];
            if ([model.Category length]>1){
                
                NSArray *CaArray = [model.Category componentsSeparatedByString:@","];
                
                for (int j=0; j<CaArray.count; j++){
                    KeyCateArray = [CateImageSortdict allKeysForObject:CaArray[j]];
                    
                    [CateArray addObject:[KeyCateArray objectAtIndex:0]];
                }
                
                NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];//yes升序排列，no,降序排列
                NSArray *myary = [CateArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
                model.Category = [CateImageSortdict objectForKey:[myary objectAtIndex:0]];
                cell.typeImage.image = [UIImage imageNamed:_typeImageDict[model.Category]];
                cell.typeImage1.image = [UIImage imageNamed:_typeImageDict[model.Category]];
    
               
                
            }else{
            
            cell.typeImage.image = [UIImage imageNamed:_typeImageDict[model.Category]];
            cell.typeImage1.image = [UIImage imageNamed:_typeImageDict[model.Category]];
            
            }
//            cell.time.text = [NSString stringWithFormat:@"%@ %@ To Go",model.RemainingValue,model.RemainingUnit];
            AppLang lang = [EGUtility getAppLang];
            
            if (lang==1) { //hk
                cell.time.text = [NSString stringWithFormat:@"剩餘時間:%@ %@",model.RemainingValue,model.RemainingUnit];
            }else if (lang==2){//cn
                cell.time.text = [NSString stringWithFormat:@"剩余时间:%@ %@",model.RemainingValue,model.RemainingUnit];
            }else{
                
            if([[NSString stringWithFormat:@"%@",model.RemainingValue] isEqualToString:@"0"]){
                    
                    cell.time.text = [NSString stringWithFormat:@"%@ %@ To Go",model.RemainingValue,@"Days"];
                }else{
                    cell.time.text = [NSString stringWithFormat:@"%@ %@ To Go",model.RemainingValue,model.RemainingUnit];
                }
            }
            cell.count.text = [NSString stringWithFormat:@"%@",model.DonorCount];
            cell.moneyLabel.text = [NSString stringWithFormat:@"$%@",model.Amt];
            cell.goalMoney.text = [NSString stringWithFormat:@"$%@",model.TargetAmt];
            [cell.button setAction:^(MyBtn * button){
                if (button.selected){
//                    [_ShoppingCartArr removeObject:model.CaseID];
//                    [[NSUserDefaults standardUserDefaults] setObject:_ShoppingCartArr forKey:@"isCartItem"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
                    UIAlertView *alertView = [[UIAlertView alloc] init];
                    alertView.message = EGLocalizedString(@"alert_msg_caseHasAdded", nil);
                    [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                    [alertView show];

                    [_tableView reloadData];
                    
                    
                }else{
                
                    if ([model.RemainingValue intValue] == 0) {
                        UIAlertView *alertView = [[UIAlertView alloc] init];
                        alertView.message = EGLocalizedString(@"alert_msg_caseFinished", nil);
                        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                        [alertView show];
                    }else if (model.IsSuccess) {
                        UIAlertView *alertView = [[UIAlertView alloc] init];
                        alertView.message = EGLocalizedString(@"alert_msg_caseSuccess", nil);
                        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                        [alertView show];
                    } else{
                        [weakSelf saveShoppingCartItem:model.CaseID];
                        UIAlertView *alertView = [[UIAlertView alloc] init];
                        alertView.message = EGLocalizedString(@"alert_msg_saveShoppingCartItemSuccess", nil);
                        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                        [alertView show];
                        [_tableView reloadData];
                    }
                }
            }];
            
            
//            NSArray * arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"isCartItem"];
//            if (arr) {
//                [_ShoppingCartArr addObjectsFromArray:arr];
//            }
            
            if (model.isSelect) {
                cell.button.selected = YES;
            }else{
                cell.button.selected = NO;
            }
            
        }

        return cell;
        
    }else{
        
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
        if (_dataArray.count >0){
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
            }else{
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
            cell.progressImg.hidden = model.Percentage >= 100 ? YES:NO;
            if (model.Percentage < 50) {
                //设置进度条左边的进度颜色
                [cell.progress setProgressTintColor:[UIColor colorWithRed:255/255.0 green:175/255.0 blue:35/255.0 alpha:1]];
                cell.heartImg.image = [UIImage imageNamed:@"comment_progress_heart_nor"];
                [cell.heartImg stopAnimating];
            } else if (model.Percentage < 100) {
                [cell.progress setProgressTintColor:[UIColor colorWithRed:219/255.0 green:128/255.0 blue:29/255.0 alpha:1]];
                cell.heartImg.image = [UIImage imageNamed:@"comment_progress_heart_mid"];
                [cell.heartImg stopAnimating];
            } else {
                [cell.progress setProgressTintColor:[UIColor colorWithRed:199/255.0 green:78/255.0 blue:102/255.0 alpha:1]];
                cell.heartImg.image = [UIImage imageNamed:@"comment_progress_heart_complete"];
                [cell.heartImg startAnimating];
            }
            NSMutableArray *CateArray  =[[NSMutableArray alloc] init];
            KeyCateArray  =[[NSMutableArray alloc] init];
            if ([model.Category length]>1) {
                NSArray *CaArray = [model.Category componentsSeparatedByString:@","];
                
                for (int j=0; j<CaArray.count; j++){
                    KeyCateArray = [CateImageSortdict allKeysForObject:CaArray[j]];
                    
                    [CateArray addObject:[KeyCateArray objectAtIndex:0]];
                }
                
                NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];//yes升序排列，no,降序排列
                NSArray *myary = [CateArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
                model.Category = [CateImageSortdict objectForKey:[myary objectAtIndex:0]];
                cell.typeImage.image = [UIImage imageNamed:_typeImageDict[model.Category]];
                cell.typeImage1.image = [UIImage imageNamed:_typeImageDict[model.Category]];
            }else{
            cell.typeImage.image = [UIImage imageNamed:_typeImageDict[model.Category]];
            cell.typeImage1.image = [UIImage imageNamed:_typeImageDict[model.Category]];
            }
             AppLang lang = [EGUtility getAppLang];
            if (lang==1) {
               cell.time.text = [NSString stringWithFormat:@"剩餘時間: %@ %@",model.RemainingValue,model.RemainingUnit];
                
            }else if (lang==2){
            
                 cell.time.text = [NSString stringWithFormat:@"剩余时间: %@ %@",model.RemainingValue,model.RemainingUnit];
            
            }else{
                
                if ([[NSString stringWithFormat:@"%@",model.RemainingValue] isEqualToString:@"0"]){
                    
                    cell.time.text = [NSString stringWithFormat:@"%@ %@ To Go",model.RemainingValue,@"Days"];
                }else{
            
                    cell.time.text = [NSString stringWithFormat:@"%@ %@ To Go",model.RemainingValue,model.RemainingUnit];
                }
            }
           
            
            cell.count.text = [NSString stringWithFormat:@"%@",model.DonorCount];
            cell.moneyLabel.text = [NSString stringWithFormat:@"$%@",model.Amt];
            cell.goalMoney.text = [NSString stringWithFormat:@"$%@",model.TargetAmt];
            __weak typeof(self)weakSelf = self;
            
            [cell.attentionButton setAction:^(MyBtn * button) {
                NSMutableDictionary * dict = [ShowMenuView getUserInfo];
                if ([dict objectForKey:@"LoginName"] != nil) {
                    if (model.Isfavourite) {
                        
                        [weakSelf DeleteCaseFavourite:indexPath];
                        [_tableView reloadData];
                        
                    }else{
                        
                        [weakSelf AddCaseFavourite:indexPath];
                        [_tableView reloadData];
                    }

                }else{

                    MyAttentionViewController * vc = [[MyAttentionViewController alloc] init];
                    LoginViewController * loginvc = [[LoginViewController alloc] initWithToggleViewController:vc];
                    vc.caseId = model.CaseID;
                    vc.isFavouritePush = YES;
                    [self.navigationController pushViewController:loginvc animated:YES];
//                    LoginViewController * vc = [[LoginViewController alloc] init];
//                    [self.navigationController pushViewController:vc animated:YES];
                }
            }];
            
            cell.succeedImage.hidden = YES;
            if (model.IsSuccess) {
                cell.succeedImage.hidden = NO;
            }
            
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
                    alertView.message = EGLocalizedString(@"alert_msg_caseHasAdded", nil);
                    [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                    [alertView show];
                    [_tableView reloadData];

                }else{
                    
                    if ([model.RemainingValue intValue] == 0) {
                        UIAlertView *alertView = [[UIAlertView alloc] init];
                        alertView.message = EGLocalizedString(@"alert_msg_caseFinished", nil);
                        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                        [alertView show];
                    } else if (model.IsSuccess){
                        UIAlertView *alertView = [[UIAlertView alloc] init];
                        alertView.message = EGLocalizedString(@"alert_msg_caseSuccess", nil);
                        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                        [alertView show];
                    } else{
                        _isGo = YES;
                        [self saveShoppingCartItem:model.CaseID];
                    }

//                    if ([model.RemainingValue intValue] == 0) {
//                        UIAlertView *alertView = [[UIAlertView alloc] init];
//                        alertView.message = EGLocalizedString(@"alert_msg_caseFinished", nil);
//                        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
//                        [alertView show];
//                    }else if (model.IsSuccess) {
//                        UIAlertView *alertView = [[UIAlertView alloc] init];
//                        alertView.message = EGLocalizedString(@"alert_msg_caseSuccess", nil);
//                        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
//                        [alertView show];
//                    } else{
//                        [weakSelf saveShoppingCartItem:model.CaseID];
//                        UIAlertView *alertView = [[UIAlertView alloc] init];
//                        alertView.message = EGLocalizedString(@"alert_msg_saveShoppingCartItemSuccess", nil);
//                        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
//                        [alertView show];
//                        [_tableView reloadData];
//                    }
                }
            }];
            
            if (model.isSelect) {
                cell.donationButton.selected = YES;
                cell.donationButton.backgroundColor = [UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1];
            }else{
                cell.donationButton.selected = NO;
                cell.donationButton.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:0.8];
            }
        }
        
        return cell;
    }
    
}

- (UIImage *)cutCellImage:(UIImage*)cellImage
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((cellImage.size.width / cellImage.size.height) < (_cellShowImage.frame.size.width / _cellShowImage.frame.size.height)) {
        newSize.width = cellImage.size.width;
        newSize.height = cellImage.size.width * _cellShowImage.frame.size.height / _cellShowImage.frame.size.width;
        
        imageRef = CGImageCreateWithImageInRect([cellImage CGImage], CGRectMake(0, fabs(cellImage.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = cellImage.size.height;
        newSize.width = cellImage.size.height * _cellShowImage.frame.size.width / _cellShowImage.frame.size.height;
        
        imageRef = CGImageCreateWithImageInRect([cellImage CGImage], CGRectMake(fabs(cellImage.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArray.count > 0) {
        GirdModel * model = _dataArray[indexPath.row];
        GirdDetailViewController * vc = [[GirdDetailViewController alloc] init];
        vc.girdMdel = model;
        vc.caseID = model.CaseID;
        vc.categoryImg = model.Category;
        vc.nameString=model.Title;
        [self.navigationController pushViewController:vc animated:YES];
    }

}

#pragma mark - 收藏请求
-(void)AddCaseFavourite:(NSIndexPath *)indexPath{
    
    GirdModel * model = _dataArray[indexPath.row];
    NSString* caseID = model.CaseID;
    [self showLoadingAlert];
    if (_item.MemberID == NULL) {
        _item.MemberID = @"";
    }
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><AddCaseFavourite xmlns=\"egive.appservices\"><CaseID>%@</CaseID><MemberID>%@</MemberID></AddCaseFavourite></soap:Body></soap:Envelope>",caseID,_item.MemberID];
    
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
        [self removeLoadingAlert];
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSString *result = [NSString captureData:dataString];
        if ([result isEqual:@"\"\""]) {
             model.Isfavourite=YES;
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"收藏成功", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            
            //[self requestApiData:_collectionFlag andMemberID:_item.MemberID];
            [self.tableView reloadData];
            [self GetMemberFavouriteCount];
        }else{
//            UIAlertView *alertView = [[UIAlertView alloc] init];
//            alertView.message = result;
//            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
//            [alertView show];
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
#pragma mark - 取消收藏请求
-(void)DeleteCaseFavourite:(NSIndexPath *)indexPath{
    
    GirdModel * model = _dataArray[indexPath.row];
    NSString* caseID = model.CaseID;
    [self showLoadingAlert];
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
        [self removeLoadingAlert];
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *result = [NSString captureData:dataString];
        if ([[NSString captureData:dataString] isEqualToString:@"\"\""]) {
            model.Isfavourite=NO;
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"取消成功!", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            [self.tableView reloadData];
            //[self requestApiData:_collectionFlag andMemberID:_item.MemberID];
            [self GetMemberFavouriteCount];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = result;
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
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

//获取用户收藏数
- (void)GetMemberFavouriteCount {
  
    NSString * soapMessage = [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <GetMemberFavouriteCount xmlns=\"egive.appservices\"><MemberID>%@</MemberID></GetMemberFavouriteCount></soap:Body></soap:Envelope>",_item.MemberID];
    MyLog(@"%@",soapMessage);
    [EGGeneralRequestAdapter postWithHttpsConnection:NO soapMsg:soapMessage success:^(id result) {
      
        NSString *dataString = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
        NSDictionary * dict = [NSString parseJSONStringToNSDictionary:dataString];
        if (dict) {
            _collectionCount.text = [NSString stringWithFormat:@"%@",dict[@"Count"]];
            
        }else{
            
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = result;
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
        }
        
    } failure:^(NSError * error) {
      
        MyLog(@"success = %@", error);
    }];
}


- (void)timerAction{
    if (_isSwap) {
        _isSwap = NO;
        
    }else{
        _isSwap = YES;
    }
    
    if (_dataArray.count > 0) {
        NSArray *indexPaths = [_tableView indexPathsForVisibleRows];
        [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    }
//    [_tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    
    MyLog(@"viewWillAppear");
    
    _navbutton.hidden = NO;
    if (_item != nil){
        
        _collectionCount.hidden = NO;
        [self GetMemberFavouriteCount];
        
    }else{
        _collectionCount.hidden = YES;
        
    }
    
//    _dataArray = [[NSMutableArray alloc] init];
//    [_tableView reloadData];
    
    _cartLabel.hidden = NO;
    //购物车右侧数量标示label
    NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
    EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
    if (item.NumberOfItems < 1) {
        _cartLabel.hidden = YES;
        self.donationsView.hidden = YES;
    }else{
        _cartLabel.hidden = NO;
        self.donationsView.hidden = NO;
        
    }
    
    UIButton *button = (UIButton*)[self.view viewWithTag:tag4Init];
    __weak typeof(self) weakSelf = self;
    
    if (tag4Init != Tag0) {
        
        [((UIButton*)[self.view viewWithTag:Tag0]) setBackgroundColor:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]];
    }
    
    if (tag4Init == Tag0) {
       
        [self loadNewData];
      //[self requestApiData:_collectionFlag andMemberID:_item.MemberID];
        
    } else if (tag4Init == Tag1){
        _CaseTitle = @"";
        _collectionFlag = @"C";
        [button setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
        
         [self loadNewData];
        //[weakSelf requestApiData:weakSelf.collectionFlag andMemberID:weakSelf.item.MemberID];
        if (self.isHidden == -1) {
            [weakSelf menuAction];
        }
    }else if (tag4Init == Tag2){
        _CaseTitle = @"";
        _collectionFlag = @"F";
        [button setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
        
         [self loadNewData];
        //[weakSelf requestApiData:weakSelf.collectionFlag andMemberID:weakSelf.item.MemberID];
        if (self.isHidden == -1) {
            [weakSelf menuAction];
        }
    }else if (tag4Init == Tag3){
        _collectionFlag = @"Successful";
        _CaseTitle = @"";
        [button setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
         [self loadNewData];
        //[weakSelf requestApiData:weakSelf.collectionFlag andMemberID:weakSelf.item.MemberID];
        if (self.isHidden == -1) {
            [weakSelf menuAction];
        }
    }else if (tag4Init == Tag4){
        _CaseTitle = @"";
        _collectionFlag = @"ANGELACT";
        [button setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
         [self loadNewData];
        //[weakSelf requestApiData:weakSelf.collectionFlag andMemberID:weakSelf.item.MemberID];
        if (self.isHidden == -1) {
            [weakSelf menuAction];
        }
    }
    
//    [self createFooterButton];
//    [self createMenuUI];
}


- (void)notifyUpdateMemberInfo{

    if (_item != nil) {
        
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    _navbutton.hidden = YES;
    _collectionCount.hidden = YES;
    _cartLabel.hidden = YES;

    if (self.isHidden == -1) {
        [self menuAction];
    }
}
- (void)saveShoppingCartItem:(NSString *)caseId
{
    EGSaveShoppingCartItemRequest *request = [[EGSaveShoppingCartItemRequest alloc] init];
    request.MemberID = _item.MemberID ? _item.MemberID :@"";
    NSString *cookieId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    request.CookieID = cookieId;
    request.CaseID = caseId;
    request.DonateAmt = 500;
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

       _cartLabel.text = [NSString stringWithFormat:@"%d",result.NumberOfItems];
//        EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
        if (result.NumberOfItems < 1) {
            _cartLabel.hidden = YES;
        }else{
            _cartLabel.hidden = NO;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCount" object: nil];
        
        if (_isGo) {
            MyDonationViewController * vc = [[MyDonationViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
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
    self.donationsLabel.text = [NSString stringWithFormat:@"%d",item.NumberOfItems];
    if (item.NumberOfItems < 1) {
        self.donationsView.hidden = YES;
    }else{
        self.donationsView.hidden = NO;
    }
    
    
    [_tableView reloadData];
}

#pragma mark filter
- (void)dropDownMenu:(EGDropDownMenu *)dropDownMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _CaseTitle = @"";
    NSInteger num = indexPath.row;
    //_collectionFlag=_categoryDict[[NSString stringWithFormat:@"%ld",num]];
    [self loadNewData];
    
    //[self requestApiData:_categoryDict[[NSString stringWithFormat:@"%ld",num]] andMemberID:_item.MemberID];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{

}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        _CaseTitle = NULL;
        //_collectionFlag=_categoryDict[[NSString stringWithFormat:@"%d",0]];
        [self loadNewData];

        //[self requestApiData:_categoryDict[[NSString stringWithFormat:@"%d",0]] andMemberID:_item.MemberID];
    }
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    
    MyLog(@"text = %@",searchBar.text);
    _CaseTitle = searchBar.text;
    if (searchBar.text.length < 1) {
        _CaseTitle = NULL;
    }
//    [self requestApiData:_categoryDict[[NSString stringWithFormat:@"%d",0]] andMemberID:_item.MemberID];
}

-(void)chanageSearchBar:(UISearchBar *)searchBar
            cancleTitle:(NSString *)cancleTitle
{
    for (UIView *view in [searchBar.subviews[0] subviews])  {
        if([view isKindOfClass:[UIButton class]])
        {
            UIButton *button = (UIButton *)view;
            [button setTitle:cancleTitle forState:UIControlStateNormal];
        }
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar setShowsCancelButton:NO animated:YES];
    [_searchBar resignFirstResponder];
    
    MyLog(@"text = %@",searchBar.text);
    _CaseTitle = searchBar.text;
    //_collectionFlag=_categoryDict[[NSString stringWithFormat:@"%d",0]];
    [self loadNewData];

    //[self requestApiData:_categoryDict[[NSString stringWithFormat:@"%d",0]] andMemberID:_item.MemberID];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar setShowsCancelButton:NO animated:YES];
    
    MyLog(@"text = %@",searchBar.text);
    _CaseTitle = searchBar.text;
    if (searchBar.text.length < 1) {
        _CaseTitle = NULL;
    }
    //_collectionFlag=_categoryDict[[NSString stringWithFormat:@"%d",0]];
    [self loadNewData];

    //[self requestApiData:_categoryDict[[NSString stringWithFormat:@"%d",0]] andMemberID:_item.MemberID];
    
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
