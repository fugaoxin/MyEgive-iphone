//
//  MyDonationViewController.m
//  Egive
//  adaptation
//  Created by sino on 15/7/30.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "MyDonationViewController.h"
#import "UIView+ZJQuickControl.h"
#import "DonationRecordCell.h"
#import "GirdViewController.h"
#import "RecordDtlViewController.h"
#import "GirdViewPagedController.h"
#import "ZJScreenAdaptation.h"
#import "ZJScreenAdaptationMacro.h"
#import "HomeViewController.h"
#define ScreenSize [UIScreen mainScreen].bounds.size

#define kTagFeeLabel 9999

#define kTagTotalAmtLab 99
#define kTagDonateBtn   100
#define kTagNewProjBtn  101
#define kTagGoOnBtn     102
@interface MyDonationViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    UIView * _topView;
}
@property (nonatomic,strong) EGDropDownMenu *dropDownMenu;
@property (nonatomic, strong) NSMutableArray *recordList;
@property (nonatomic, strong) EGGetAndSaveShoppingCartResult *result;

@property (nonatomic, strong) NSMutableArray * cells;

@property (nonatomic, assign) NSInteger offSetY;
@property (nonatomic, strong) UIView * bottomView;
@property (nonatomic, assign) NSInteger totalAmt;

@property (nonatomic, assign)CGFloat currentY;
@property (nonatomic, assign) BOOL isAddedTopView;

@end

@implementation MyDonationViewController

- (NSMutableArray *)recordList
{
    if (!_recordList) {
        _recordList = [NSMutableArray array];
    }
    return _recordList;
}

- (NSMutableArray *)cells
{
    if (!_cells) {
        _cells = [NSMutableArray array];
    }
    return _cells;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = EGLocalizedString(@"MyDonation_Title", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    leftButton.transform = CGAffineTransformScale(leftButton.transform, 0.85, 0.85);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;

    _offSetY = 0;
    _shoppingCart = [[EGGetAndSaveShoppingCartResult alloc] init];
    
    //    [self addObserver:self forKeyPath:@"numberOfCheckedItems"options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

//[self addObserver:self forKeyPath:@"numberOfCheckedItems"options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];

//        [self getDonationRecord];
//        [self getAndSaveShoppingCart];
    
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSString *EGIVE_AFTER_DONATE = [standardUserDefaults objectForKey:@"EGIVE_AFTER_DONATE"];
        if ([EGIVE_AFTER_DONATE isEqualToString:@"1"]) {
    
            MyLog(@"dispatch_after(dispatch_time");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                __weak typeof(self) weakSelf = self;
                for (int i = 0; i < 3; i ++) {
                    UIButton * button = (UIButton *)[weakSelf.view viewWithTag:230+i];
                    button.selected = NO;
                    UIView * view = (UIView *)[weakSelf.view viewWithTag:235+i];
                    view.hidden = YES;
                }
                UIView * view = (UIView *)[weakSelf.view viewWithTag:236];
                view.hidden = NO;
                UIButton *button = (UIButton*)[self.view viewWithTag:321];
                button.selected = YES;
                weakSelf.scrollView.hidden = YES;
                weakSelf.recordView.hidden = NO;
                weakSelf.noteView.hidden = YES;
                [weakSelf getDonationRecord];
                [standardUserDefaults setObject:@"0" forKey:@"EGIVE_AFTER_DONATE"];
                [standardUserDefaults synchronize];
    
            });
            
        }

    [self createTopView];
    [self createSelectedUI];
    [self createDonationNote];
    [self createRecordUI];
    [self createMenuUI];
    [self createFooterButton];
    
    
    
    
}
- (void)leftAction{
    if ([[self.navigationController viewControllers] count] > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        
        HomeViewController * vc = [[HomeViewController alloc] init];
        [self.navigationController setViewControllers:[NSArray arrayWithObject:vc] animated:YES];
    }
}


-(void)viewWillAppear:(BOOL)animated{
    
    if (_MyDonationFlag==1) {
        
        UIButton * button = (UIButton *)[self.view viewWithTag:231];
        UIView * view = (UIView *)[self.view viewWithTag:236];
        view.hidden = NO;
        button.selected = YES;
        self.scrollView.hidden = YES;
        self.recordView.hidden = NO;
        self.noteView.hidden = YES;
        [self getDonationRecord];

        
    }else{
        [self getDonationRecord];
    }
  [self getAndSaveShoppingCart];
     _isAddedTopView = false;
  
    [self getShoppingCartDisclaimer];

}


//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    _isAddedTopView = false;
//    
//    [self getDonationRecord];
//    [self getAndSaveShoppingCart];
//    [self getShoppingCartDisclaimer];
//    
//    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//    NSString *EGIVE_AFTER_DONATE = [standardUserDefaults objectForKey:@"EGIVE_AFTER_DONATE"];
//    
//    if ([EGIVE_AFTER_DONATE isEqualToString:@"1"]) {
//        
//        MyLog(@"dispatch_after(dispatch_time");
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//            __weak typeof(self) weakSelf = self;
//            for (int i = 0; i < 3; i ++) {
//                UIButton * button = (UIButton *)[weakSelf.view viewWithTag:230+i];
//                button.selected = NO;
//                UIView * view = (UIView *)[weakSelf.view viewWithTag:235+i];
//                view.hidden = YES;
//            }
//            UIView * view = (UIView *)[weakSelf.view viewWithTag:236];
//            view.hidden = NO;
//            UIButton *button = (UIButton*)[self.view viewWithTag:321];
//            button.selected = YES;
//            weakSelf.scrollView.hidden = YES;
//            weakSelf.recordView.hidden = NO;
//            weakSelf.noteView.hidden = YES;
//            [weakSelf getDonationRecord];
//            [standardUserDefaults setObject:@"0" forKey:@"EGIVE_AFTER_DONATE"];
//            [standardUserDefaults synchronize];
//            
//        });
//        
//    }
//}


-(void)viewWillDisappear:(BOOL)animated{
NSArray *testArray = @[@[[NSString stringWithFormat:@"%@", EGLocalizedString(@"不包括手续费", nil)], [NSString stringWithFormat:@"%@", EGLocalizedString(@"MyDonation_HKpoundage", nil)]]];
    EGDropDownMenu *menu = [[EGDropDownMenu alloc] initWithFrame:CGRectMake(20, 45, 280, 30) Array:testArray selectedColor:[UIColor grayColor]];
    menu.delegate = self;
    menu.selectedRow = 1;
    menu.layer.cornerRadius = 3;
    menu.layer.borderColor = [[UIColor grayColor] CGColor];
    menu.layer.borderWidth = 1;
    [_scrollView addSubview:menu];
    _dropDownMenu = menu;

}

#pragma mark - 顶部Menu按钮
- (void)createTopView {
    if (ScreenSize.height == 667) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 54, 320, 35)];
    }else if (ScreenSize.height == 736)
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, 320, 35)];
    else{
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 35)];
    }
    
    _topView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.view addSubview:_topView];
    
    NSArray * titleArray = @[EGLocalizedString(@"MyDonation_selectedButton", nil),EGLocalizedString(@"MyDonation_recordButton", nil),EGLocalizedString(@"MyDonation_designationButton", nil)];
    __weak typeof(self) weakSelf = self;
    
    for (int i = 0; i < titleArray.count;i++){
        
        _menuButton = [_topView addImageButtonWithFrame2:CGRectMake(i*(320/3), 0, 320/3, 35) title:titleArray[i] backgroud:nil action:^(UIButton *button) {
            
            for (int i = 0; i < 3; i ++) {
                UIButton * button = (UIButton *)[weakSelf.view viewWithTag:230+i];
                button.selected = NO;
                UIView * view = (UIView *)[weakSelf.view viewWithTag:235+i];
                view.hidden = YES;
            }
            if (button.tag == 230) {
                button.selected = YES;
                UIView * view = (UIView *)[weakSelf.view viewWithTag:235];
                view.hidden = NO;
                weakSelf.scrollView.hidden = NO;
                weakSelf.recordView.hidden = YES;
                weakSelf.noteView.hidden = YES;
                
            }else if (button.tag == 231){
                UIView * view = (UIView *)[weakSelf.view viewWithTag:236];
                view.hidden = NO;
                button.selected = YES;
                weakSelf.scrollView.hidden = YES;
                weakSelf.recordView.hidden = NO;
                weakSelf.noteView.hidden = YES;
                [weakSelf getDonationRecord];
                
            }else if (button.tag == 232){
                UIView * view = (UIView *)[weakSelf.view viewWithTag:237];
                view.hidden = NO;
                button.selected = YES;
                weakSelf.scrollView.hidden = YES;
                weakSelf.recordView.hidden = YES;
                weakSelf.noteView.hidden = NO;
            }
        }];
        _menuButton.tag = 230 +i;
        [_menuButton setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]];
        _menuButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_menuButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_menuButton setTitleColor:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1] forState:UIControlStateSelected];
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(i*(320/3),35, 320/3, 3)];
        lineView.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
        lineView.tag = 235+i;
        lineView.hidden = YES;
        [_topView addSubview:lineView];
        if ([EGUtility getAppLang] == 3) {
            _menuButton.frame= CGRectMake(i*(320/3), 0, 320/3, 30);
            _menuButton.titleLabel.numberOfLines = 2;
        }
        
//        if (_isByPush){
////            UIView * view = (UIView *)[weakSelf.view viewWithTag:236];
////            view.hidden = NO;
////            _menuButton.selected = YES;
////            weakSelf.scrollView.hidden = YES;
////            weakSelf.recordView.hidden = NO;
////            weakSelf.noteView.hidden = YES;
////            [weakSelf getDonationRecord];
//        }else if(_menuButton.tag == 230) {
//            
//            _menuButton.selected = YES;
//            lineView.hidden = NO;
//        }
    }
}

#pragma mark - 已选专案
- (void)createSelectedUI{
    
    CGRect rect = CGRectMake(0,110,320, 568-94);
    rect.size.width = kScreenW;
    rect.size.height = kScreenH - rect.origin.y;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:rect];
    _scrollView.contentSize = CGSizeMake(0, 568-60-80);
    [self.view addSubview:_scrollView];
}

- (void)addTopView{
    
    _isAddedTopView = true;
    __weak typeof(self) weakSelf = self;
    _hkButton = [_scrollView addImageButtonWithFrame:CGRectMake(20, 10, 320/2-20, 25) title:EGLocalizedString(@"ButtonTitleHK", nil) backgroud:@"comment_segment_left_nor.png" action:^(UIButton *button) {
         [weakSelf getHKornonHKDisclaimer:@"HK"];
        button.selected = YES;
        weakSelf.nhkButton.selected = NO;
        
        weakSelf.rate = 3.9;
        [[NSUserDefaults standardUserDefaults] setObject:@"HK" forKey:@"ShoppingCartLocation"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        weakSelf.shoppingCart.Location = EGLocalizedString(@"MyDonation_HK", nil);
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [weakSelf.dropDownMenu setItemName:[NSString stringWithFormat:@"%@", EGLocalizedString(@"MyDonation_HKpoundage", nil)] AtIndex:indexPath];
        
        for (EGShoppingCartCell *cell in weakSelf.cells){
            
            
                [cell reloadData];
            
        }
       
        // 计算捐款总额
        _totalAmt = 0;
        for (EGShoppingCartCell *obj in weakSelf.cells) {
            if (obj.IsChecked) {
                _totalAmt += obj.donateAmt;
            }
        }
        NSString *totalAmt = [NSString stringWithFormat:@"HK$ %ld",weakSelf.totalAmt];
        UILabel *label = (UILabel *)[weakSelf.bottomView viewWithTag:kTagTotalAmtLab];
        label.text = totalAmt;
    } ];
    _hkButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _hkButton.selected = YES;
    [_hkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_hkButton setTitleColor:[UIColor colorWithRed:70.0/255.0 green:180.0/255.0 blue:4.0/255.0 alpha:1] forState:UIControlStateNormal];
    [_hkButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_left_sel.png"] forState:UIControlStateSelected];
    
    _nhkButton = [_scrollView addImageButtonWithFrame:CGRectMake(320/2, 10, 320/2-20, 25) title:EGLocalizedString(@"ButtonTitleNoHK", nil) backgroud:@"comment_segment_right_nor.png" action:^(UIButton *button) {
        [weakSelf getHKornonHKDisclaimer:@"nonHK"];
        button.selected = YES;
        weakSelf.hkButton.selected = NO;
        weakSelf.rate = 4.4;
        [[NSUserDefaults standardUserDefaults] setObject:@"nonHK" forKey:@"ShoppingCartLocation"];
        [[NSUserDefaults standardUserDefaults] synchronize];
         weakSelf.shoppingCart.Location = EGLocalizedString(@"MyDonation_noHK", nil);
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [weakSelf.dropDownMenu setItemName:[NSString stringWithFormat:@"%@", EGLocalizedString(@"MyDonation_noHKpoundage", nil)] AtIndex:indexPath];
        
        UILabel *label = (UILabel*)[weakSelf.scrollView viewWithTag:kTagFeeLabel];
        label.text = [NSString stringWithFormat:EGLocalizedString(@"MyDonation_noHKpoundage", nil),weakSelf.rate];
        for (EGShoppingCartCell *cell in weakSelf.cells) {
            [cell reloadData];
        }
        // 计算捐款总额
        _totalAmt = 0;
        for (EGShoppingCartCell *obj in weakSelf.cells) {
            if (obj.IsChecked) {
                _totalAmt += obj.donateAmt;
            }
        }
        NSString *totalAmt = [NSString stringWithFormat:@"HK$ %ld",weakSelf.totalAmt];
        UILabel *label1 = (UILabel *)[weakSelf.bottomView viewWithTag:kTagTotalAmtLab];
        label1.text = totalAmt;
    }];
    [_nhkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_nhkButton setTitleColor:[UIColor colorWithRed:70.0/255.0 green:180.0/255.0 blue:4.0/255.0 alpha:1] forState:UIControlStateNormal];
    _nhkButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_nhkButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_right_sel.png"] forState:UIControlStateSelected];
    
    NSArray *testArray = @[@[[NSString stringWithFormat:@"%@", EGLocalizedString(@"不包括手续费", nil)], [NSString stringWithFormat:@"%@", EGLocalizedString(@"MyDonation_HKpoundage", nil)]]];

    EGDropDownMenu *menu = [[EGDropDownMenu alloc] initWithFrame:CGRectMake(20, 45, 280, 30) Array:testArray selectedColor:[UIColor grayColor]];
    menu.delegate = self;
    menu.selectedRow = 1;
    menu.layer.cornerRadius = 3;
    menu.layer.borderColor = [[UIColor grayColor] CGColor];
    menu.layer.borderWidth = 1;
    [_scrollView addSubview:menu];
    _dropDownMenu = menu;
    
    // 是否包括手續費
    menu.selectedRow = _result.DonateWithCharge ? 1:0;
    
    
    //[prompt addImageViewWithFrame:CGRectMake(320-60, 10, 15, 10) image:@"downMune.png"];
    
    
    [_scrollView addImageViewWithFrame:CGRectMake(0, 88, 320, 3) image:@"Line@2x.png"];
    
    _offSetY = 90;
}

- (void)addBottomView
{
    for (UIView *view in _bottomView.subviews ) {
        
        [view removeFromSuperview];
    }
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _offSetY + 20, 320, 80)];
    bottomView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [_scrollView addSubview:bottomView];
    _bottomView = bottomView;
    
    UILabel * sumLabel = [bottomView addLabelWithFrame:CGRectMake(20, 5, 50, 25) text:EGLocalizedString(@"MyDonation_Thetotalamountof", nil)];
    sumLabel.font = [UIFont boldSystemFontOfSize:16];
    
    _totalAmt = _result.TotalDonateAmt;
    NSString *totalAmt = [NSString stringWithFormat:@"HK$ %ld",_totalAmt];
    UILabel * sumMoney = [bottomView addLabelWithFrame:CGRectMake(70, 5, 230, 25) text:totalAmt];
    sumMoney.textAlignment = NSTextAlignmentRight;
    sumMoney.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    sumMoney.font = [UIFont boldSystemFontOfSize:16];
    sumMoney.tag = kTagTotalAmtLab;
    
    __weak __typeof(self)weakSelf = self;
    UIButton * tapButton = [bottomView addImageButtonWithFrame:CGRectMake(20, 40, 280, 30) title:EGLocalizedString(@"点击行善", nil) backgroud:nil action:^(UIButton *button) {
        [weakSelf newProjAction:button];
    }];
    tapButton.tag = kTagDonateBtn;
    tapButton.titleLabel.font = [UIFont systemFontOfSize:14];
    tapButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    tapButton.layer.cornerRadius = 4;
    [tapButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tapButton setImage:[UIImage imageNamed:@"cart_more_case@2x.png"] forState:UIControlStateNormal];
    tapButton.backgroundColor = [UIColor colorWithRed:110/255.0 green:184/255.0 blue:43/255.0 alpha:1];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 40, 135, 30);
    button1.tag = kTagNewProjBtn;
    [button1 setTitle:EGLocalizedString(@"MyDonation_AddButton", nil) forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:14];
    button1.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    button1.layer.cornerRadius = 4;
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor colorWithRed:110/255.0 green:184/255.0 blue:43/255.0 alpha:1];
    [button1 addTarget:self action:@selector(newProjAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button1];
    button1.hidden = YES;
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(165, 40, 135, 30);
    button2.tag = kTagGoOnBtn;
    [button2 setTitle:EGLocalizedString(@"MyDonation_ContinueButton", nil) forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:14];
    button2.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    button2.layer.cornerRadius = 4;
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor colorWithRed:110/255.0 green:184/255.0 blue:43/255.0 alpha:1];
    [button2 addTarget:self action:@selector(goOnAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button2];
    button2.hidden = YES;
    
    for (EGShoppingCart *item in _result.ItemList) {
        if (item.IsChecked) {
            tapButton.hidden = YES;
            button1.hidden = NO;
            button2.hidden = NO;
        }
    }

    EGShoppingCartCell *cellnumber = [self.cells objectAtIndex:0];
    cellnumber.tipLabel2.hidden=YES;
    _offSetY += 140;
}

#pragma mark - 捐款记录
- (void)createRecordUI{
    
    _recordView = [[UIView alloc]initWithFrame:CGRectMake(0,110,ScreenSize.width, ScreenSize.height-64-65)];
    _recordView.hidden = YES;
    [self.view addSubview:_recordView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 568-154) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_recordView addSubview:_tableView];
    
}

#pragma mark - 捐款须知
- (void)createDonationNote{
    CGRect rect = CGRectMake(0,100,0, 0);
    rect.size.width = kScreenW;
    rect.size.height = kScreenH - rect.origin.y - 20;
    
    _noteView = [[UIScrollView alloc]initWithFrame:rect];
    _noteView.hidden = YES;
    //_noteView.contentSize = CGSizeMake(0, 568-60-80);
    //_noteView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_noteView];
    _currentY = 10;
}

- (void)addViewWithItem:(EGShoppingCart*)item
{
    if (item.IsChecked) {
        self.shoppingCart.NumberOfItems++;
    }
    __weak __typeof(self)weakself = self;
    
    EGShoppingCartCell *cell = [[EGShoppingCartCell alloc] initWithFrame:CGRectMake(0, _offSetY, 320, 220) item:item block:^(EGShoppingCartCell *cell, NSInteger tag) {
        if (tag) {
            weakself.shoppingCart.NumberOfItems = cell.numberOfCheckedItems;
            UIButton *btn0 = (UIButton *)[weakself.bottomView viewWithTag:kTagDonateBtn];
            UIButton *btn1 = (UIButton *)[weakself.bottomView viewWithTag:kTagNewProjBtn];
            UIButton *btn2 = (UIButton *)[weakself.bottomView viewWithTag:kTagGoOnBtn];
            if (weakself.numberOfCheckedItems) {
                btn0.hidden = YES;
                btn1.hidden = NO;
                btn2.hidden = NO;
            } else {
                btn0.hidden = NO;
                btn1.hidden = YES;
                btn2.hidden = YES;
            }
            
            for (EGShoppingCartCell *obj in weakself.cells) {
                if (obj != cell) {
                    [obj reloadData];
                }
            }
        }
        //计算捐款总额
        _totalAmt = 0;
        for (EGShoppingCartCell *obj in weakself.cells) {
            if (obj.IsChecked) {
                _totalAmt += obj.donateAmt;
            }
        }
        NSString *totalAmt = [NSString stringWithFormat:@"HK$ %ld",_totalAmt];
        UILabel *label = (UILabel *)[weakself.bottomView viewWithTag:kTagTotalAmtLab];
        label.text = totalAmt;
        
        [weakself saveShoppingCartItem:cell];
    }];
    cell.backgroundColor = [UIColor colorWithRed:240/255.0 green:248/255.0 blue:233/255.0 alpha:1];
    [_scrollView addSubview:cell];
    
    //    if (self.shoppingCart.ItemList.count>1) {
    //        if (self.shoppingCart.NumberOfItems ==1 ) {
    //
    //            [cell.checkBox sendActionsForControlEvents:UIControlEventTouchUpInside];
    //        }
    //    }else if (self.shoppingCart.ItemList.count ==1){
    //        if (self.shoppingCart.NumberOfItems ==1 ) {
    //
    //            [cell.checkBox sendActionsForControlEvents:UIControlEventTouchUpInside];
    //        }
    //        if (!item.IsChecked) {
    //            [cell.checkBox sendActionsForControlEvents:UIControlEventTouchUpInside];
    //        }
    //    }
    
    cell.dataSource = self;
    
    [_scrollView addImageViewWithFrame:CGRectMake(0, _offSetY + 220 - 1, 320, 2) image:@"Line@2x.png"];
    _offSetY += 222;
    
    [self.cells addObject:cell];
}

- (void)setupScrollView
{
    _offSetY = 0;
    _scrollView.contentSize = CGSizeMake(0, 568-60-80);
    for (UIView *v in [_scrollView subviews]) {
        [v removeFromSuperview];
    }
    
    //顶部view
    if (!_isAddedTopView) {
        [self addTopView];
    }
    
    MyLog(@"%@",_result);
    if ([_result.Location isEqualToString:EGLocalizedString(@"MyDonation_HK", nil)]) {
        self.rate = 3.9;
        self.hkButton.selected = YES;
        self.nhkButton.selected = NO;
        //NSString *name = [NSString stringWithFormat:@"香港捐款,包括手续费(%.01f%%＋HKD$2.35)",self.rate];
        NSString *name = EGLocalizedString(@"MyDonation_HKpoundage", nil);
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.dropDownMenu setItemName:name AtIndex:indexPath];
    } else if ([_result.Location isEqualToString:EGLocalizedString(@"MyDonation_noHK", nil)]) {
        self.rate = 4.4;
        self.nhkButton.selected = YES;
        self.hkButton.selected = NO;
        
        NSString *name = EGLocalizedString(@"MyDonation_noHKpoundage", nil);
        
        MyLog(@"%@",name);
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.dropDownMenu setItemName:name AtIndex:indexPath];
        
    }
    [self.cells removeAllObjects];
    for (EGShoppingCart *item in _result.ItemList) {
        [self addViewWithItem:item];
    }
    //底部view
    [self addBottomView];
    
    //_bottomView.frame = CGRectMake(0, _offSetY + 20, 320, 80);
    _scrollView.contentSize = CGSizeMake(0, _offSetY);
}



#pragma mark actions
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view.superview isKindOfClass:[UITableViewCell class]]) {
        return NO;
    }
    
    return YES;
}

- (void)tap:(UIGestureRecognizer*)Recognizer
{
    for (EGShoppingCartCell *cell in self.cells){
        [cell.textField resignFirstResponder];
    }
}

- (void)newProjAction:(UIButton *)button
{
    GirdViewController * vc = [[GirdViewController alloc] init];
    vc.isAddJump = YES;
    [self.navigationController pushViewController:vc animated:YES];
    //    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    //    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    //    [menuController setRootController:navController animated:YES];
}

- (void)goOnAction:(UIButton *)button
{
    EGGetAndSaveShoppingCartResult *model = [[EGGetAndSaveShoppingCartResult alloc] init];
    model.TotalDonateAmt = _totalAmt;
    model.MemberID = _result.MemberID;
    model.CookieID = _result.CookieID;
    NSMutableArray *list = [NSMutableArray array];
    NSString *errorMsg = nil;
    
    for (EGShoppingCartCell *cell in self.cells) {
        if (cell.IsChecked) {
            if (cell.donateAmt < cell.item.MinDonateAmt) {
                errorMsg =EGLocalizedString(@"捐款資料有誤，請檢查項目內容再試", nil);
                break;
            }
            model.NumberOfItems++;
            EGShoppingCart *item = [[EGShoppingCart alloc] init];
            item.Title = cell.item.Title;
            item.DonateAmt = cell.donateAmt;
            [list addObject:item];
        }
    }
    model.ItemList = list;
    if (!model.NumberOfItems) {
        errorMsg = EGLocalizedString(@"捐款資料有誤，請檢查項目內容再試", nil);
    }
    if (errorMsg) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:errorMsg delegate:self cancelButtonTitle:EGLocalizedString(@"Common_button_confirm", nil) otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    if (_totalAmt > 1000000) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:EGLocalizedString(@"捐款金额不能超过1,000,000", nil) delegate:self cancelButtonTitle:EGLocalizedString(@"Common_button_confirm", nil) otherButtonTitles:nil, nil];
        [alertView show];
        return;
        
    }
    
    //[self getAndSaveShoppingCart];
    ConfirmViewController * vc = [[ConfirmViewController alloc] initWithDataModel:model];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark requests
- (void)getAndSaveShoppingCart
{
#if 0
    NSString *jsonString = @"{\"MemberID\":\"fd4af834-5025-4a3e-808e-78f4bd8f61db\",\"CookieID\":\"\",\"NumberOfItems\":4,\"DonateWithCharge\":true,\"Location\":\"非香港\",\"ItemList\":[{\"CaseID\":\"cc68e892-c826-48c6-abaa-573c53c9a240\",\"Title\":\"支持意贈\",\"IsChecked\":false,\"PayOption1\":100,\"PayOption2\":500,\"PayOption3\":1000,\"SelectedOption\":500,\"ItemMsg\":\"\",\"DonateAmt\":524,\"ReceiveAmt\":500,\"MinDonateAmt\":20},{\"CaseID\":\"19856c3e-02f5-4451-9b1e-c6d0f7ee7ee6\",\"Title\":\"福安至安心計劃\",\"IsChecked\":true,\"PayOption1\":2500,\"PayOption2\":1000,\"PayOption3\":500,\"SelectedOption\":500,\"ItemMsg\":\"\",\"DonateAmt\":524,\"ReceiveAmt\":500,\"MinDonateAmt\":20},{\"CaseID\":\"53fd6c82-a78d-48f5-922f-8c41c36ffcd7\",\"Title\":\"新生命培訓計劃\",\"IsChecked\":true,\"PayOption1\":500,\"PayOption2\":1000,\"PayOption3\":2500,\"SelectedOption\":500,\"ItemMsg\":\"\",\"DonateAmt\":524,\"ReceiveAmt\":500,\"MinDonateAmt\":20},{\"CaseID\":\"a054136c-aa14-41ce-9466-88f20ed75610\",\"Title\":\"童心暑期天地2015健康FUN FUN營\",\"IsChecked\":true,\"PayOption1\":500,\"PayOption2\":1000,\"PayOption3\":2500,\"SelectedOption\":1500,\"ItemMsg\":\"\",\"DonateAmt\":1570,\"ReceiveAmt\":1500,\"MinDonateAmt\":20}],\"TotalDonateAmt\":3142,\"TotalReceiveAmt\":3000}";
    
    NSDictionary * dict = [NSString parseJSONStringToNSDictionary:jsonString];
    _result=[EGGetAndSaveShoppingCartResult objectWithKeyValues:dict];
    MyLog(@"%@",_result);
    if ([_result.Location isEqualToString:EGLocalizedString(@"MyDonation_noHK", nil)]) {
        _rate = 4.4;
        [_nhkButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    } else if ([_result.Location isEqualToString:EGLocalizedString(@"MyDonation_HK", nil)]){
        _rate = 3.9;
        [_hkButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    for (EGShoppingCart *item in _result.ItemList) {
        [self addViewWithItem:item];
    }
    _bottomView.frame = CGRectMake(0, _offSetY + 20, 320, 80);
    
    _scrollView.contentSize = CGSizeMake(0, _offSetY + 200);
#else
    //    NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
    //    if (shopCartDict) {
    //        _result = shopCartDict[@"shopItem"];
    //
    //        self.shoppingCart.MemberID = _result.MemberID;
    //        self.shoppingCart.CookieID = _result.CookieID;
    //        self.shoppingCart.NumberOfItems = 0;
    //        self.shoppingCart.DonateWithCharge = _result.DonateWithCharge;
    //        self.shoppingCart.Location = _result.Location;
    //        NSMutableArray *arrar = [NSMutableArray arrayWithArray:_result.ItemList];
    //        self.shoppingCart.ItemList = arrar;
    //        self.shoppingCart.TotalDonateAmt = _result.TotalDonateAmt;
    //        self.shoppingCart.TotalReceiveAmt = _result.TotalReceiveAmt;
    //
    //        [self setupScrollView];
    //
    //
    //        return;
    //    }
    MemberModel *member = [ShowMenuView sharedInstance].member;
    EGGetAndSaveShoppingCartRequest *request = [[EGGetAndSaveShoppingCartRequest alloc] init];
    request.lang = [EGUtility getAppLang];
    NSString *Location = [[NSUserDefaults standardUserDefaults] objectForKey:@"ShoppingCartLocation"];
    BOOL DonateWithCharge = [[NSUserDefaults standardUserDefaults] boolForKey:@"DonateWithCharge"];

    NSUserDefaults *locationDefaults  =[[NSUserDefaults alloc] init];
    request.LocationCode = [locationDefaults objectForKey:@"locationCode"];
    //request.LocationCode = @"HK";
    request.DonateWithCharge = YES;
    request.MemberID = member ? member.MemberID :@"";
    if ([request.MemberID isEqualToString:@""]) {
        
        request.CookieID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }else{
        
        request.CookieID=@"";
    }
    
    request.StartRowNo = 1;
    request.NumberOfRows = 20;
    
    __weak __typeof(self)weakSelf = self;
    [EGMyDonationRequestAdapter getGetAndSaveShoppingCart:request success:^(EGGetAndSaveShoppingCartResult *result) {
        
        weakSelf.result = result;
        weakSelf.shoppingCart.MemberID = result.MemberID;
        weakSelf.shoppingCart.CookieID = result.CookieID;
        weakSelf.shoppingCart.NumberOfItems = 0;
        weakSelf.shoppingCart.DonateWithCharge = result.DonateWithCharge;
        weakSelf.shoppingCart.Location = result.Location;
        NSMutableArray *arrar = [NSMutableArray arrayWithArray:result.ItemList];
        weakSelf.shoppingCart.ItemList = arrar;
        weakSelf.shoppingCart.TotalDonateAmt = result.TotalDonateAmt;
        weakSelf.shoppingCart.TotalReceiveAmt = result.TotalReceiveAmt;
        
        
       [weakSelf setupScrollView];
        
        MyLog(@"%@",result.Location);
        
    } failure:^(NSError *error) {
        MyLog(@"%@",error);
    }];
    
#endif
}

/**
 *  Add/ update selected case to shopping cart and update total donation amount
 */
- (void)saveShoppingCartItem:(EGShoppingCartCell *)cell
{
    EGSaveShoppingCartItemRequest *request = [[EGSaveShoppingCartItemRequest alloc] init];
    request.MemberID = _result.MemberID?_result.MemberID:@"";
    request.CookieID = _result.CookieID;
    request.CaseID = cell.item.CaseID;
    if (self.shoppingCart.DonateWithCharge) {
        request.DonateAmt = cell.receiveAmt;
    } else {
        request.DonateAmt = cell.donateAmt;
    }
    request.IsChecked = cell.IsChecked;
    
    //__weak __typeof(self)weakself = self;
    
    [EGMyDonationRequestAdapter saveShoppingCartItem:request success:^(NSString *result) {
        
    } failure:^(NSError *error) {
        MyLog(@"%@",error);
    }];
}

#pragma mark 获取捐款记录
- (void)getDonationRecord
{
    _recordList = [[NSMutableArray alloc] init];
    MemberModel *member = [ShowMenuView sharedInstance].member;
    NSString *memberID = member.MemberID ? member.MemberID : @"";
    
    __weak __typeof(self)weakself = self;
    [EGMyDonationRequestAdapter getDonationRecordWithMemberID:memberID DonationID:@"" success:^(EGGetDonationRecordResult *result) {
       
#if 0
        NSString *testJson = @"{\"TotalNumberOfRecord\":13,\"RecordList\":[{\"DonateDate\":\"2015/07/20\",\"CaseCategory\":\"其他\",\"CaseTitle\":\"支持意贈\",\"CaseRegion\":\"香港\",\"Amt\":\"107\"},{\"DonateDate\":\"2015/07/15\",\"CaseCategory\":\"意贈行動\",\"CaseTitle\":\"「鼓舞飛揚2015」－ 青少年鼓樂工作坊\",\"CaseRegion\":\"香港\",\"Amt\":\"2,500\"},{\"DonateDate\":\"2015/07/15\",\"CaseCategory\":\"意贈行動\",\"CaseTitle\":\"「3A熱飯」在佐敦\",\"CaseRegion\":\"香港\",\"Amt\":\"2,500\"},{\"DonateDate\":\"2015/07/15\",\"CaseCategory\":\"其他\",\"CaseTitle\":\"支持意贈\",\"CaseRegion\":\"香港\",\"Amt\":\"100\"},{\"DonateDate\":\"2015/06/12\",\"CaseCategory\":\"其他\",\"CaseTitle\":\"支持意贈\",\"CaseRegion\":\"香港\",\"Amt\":\"521\"},{\"DonateDate\":\"2015/06/04\",\"CaseCategory\":\"意贈行動\",\"CaseTitle\":\"世界創意思維活動競賽 2015\",\"CaseRegion\":\"香港\",\"Amt\":\"521\"},{\"DonateDate\":\"2015/05/08\",\"CaseCategory\":\"緊急援助\",\"CaseTitle\":\"不幸家庭殮葬費\",\"CaseRegion\":\"香港\",\"Amt\":\"24\"},{\"DonateDate\":\"2015/05/06\",\"CaseCategory\":\"助醫\",\"CaseTitle\":\"梁婆婆陪診費\",\"CaseRegion\":\"香港\",\"Amt\":\"20\"},{\"DonateDate\":\"2015/05/06\",\"CaseCategory\":\"緊急援助\",\"CaseTitle\":\"因水災無飯開\",\"CaseRegion\":\"香港\",\"Amt\":\"20\"},{\"DonateDate\":\"2015/05/06\",\"CaseCategory\":\"助學\",\"CaseTitle\":\"劉小姐自力更生\",\"CaseRegion\":\"香港\",\"Amt\":\"20\"},{\"DonateDate\":\"2015/05/05\",\"CaseCategory\":\"其他\",\"CaseTitle\":\"支持意贈\",\"CaseRegion\":\"香港\",\"Amt\":\"100\"},{\"DonateDate\":\"2015/03/30\",\"CaseCategory\":\"意贈行動\",\"CaseTitle\":\"拍攝生活照\",\"CaseRegion\":\"香港\",\"Amt\":\"24\"},{\"DonateDate\":\"2015/03/30\",\"CaseCategory\":\"助醫\",\"CaseTitle\":\"梁婆婆陪診費\",\"CaseRegion\":\"香港\",\"Amt\":\"521\"}]}";
        NSDictionary * dict = [NSString parseJSONStringToNSDictionary:testJson];
        EGGetDonationRecordResult *testResult=[EGGetDonationRecordResult objectWithKeyValues:dict];
#endif
        
        MyLog(@"%@",result);
        
        @synchronized(self){
            
            _MyDonationFlag=0;
            weakself.recordList = [NSMutableArray array];
            [weakself.recordList addObjectsFromArray:result.RecordList];
            [weakself.tableView reloadData];
            
            if (_pushFlag==1){
                
            for (int k=0; k<self.recordList.count; k++){
                
                EGDonationRecord *record = _recordList[k];
                
                if ([record.CaseID isEqualToString:[_caseId uppercaseString]]) {
                    
                    RecordDtlViewController * vc = [[RecordDtlViewController alloc] init];
                    vc.record = record;
                    [self.navigationController pushViewController:vc animated:YES];
                    _pushFlag=0;
                }
                
               }
            }
            
        }
    } failure:^(NSError *error) {
        MyLog(@"error:%@",error);
    }];
}

#pragma maek HK or nonHK
-(void)getHKornonHKDisclaimer:(NSString*)hkOrnonHK{

    MemberModel *member = [ShowMenuView sharedInstance].member;
    NSString *LocationCode = [ShowMenuView sharedInstance].LocationCode;
    MyLog(@"%@",LocationCode);
    //[[NSUserDefaults standardUserDefaults] setObject:locationCode forKey:@"locationCode"];
    NSString *memberID = member ? member.MemberID : @"";
    // NSString *locCode = LocationCode ?  LocationCode:@"HK";
    __weak __typeof(self)weakself = self;
    [EGMyDonationRequestAdapter getShoppingCartDisclaimerWithLocationCode:hkOrnonHK memberID:memberID success:^(NSString *result){
        
        MyLog(@"%@",result);
        for (UIView *view in _noteView.subviews) {
            
            [view removeFromSuperview];
        }
        _currentY=10;
        [weakself parseHTML:result];
        
    } failure:^(NSError *error) {
        MyLog(@"%@",error);
    }];
}

#pragma mark 捐款须知
- (void)getShoppingCartDisclaimer{
    MemberModel *member = [ShowMenuView sharedInstance].member;
    NSString *LocationCode = [ShowMenuView sharedInstance].LocationCode;
    
    MyLog(@"%@",LocationCode);
    //[[NSUserDefaults standardUserDefaults] setObject:locationCode forKey:@"locationCode"];
    NSUserDefaults *locationDefaults  =[[NSUserDefaults alloc] init];
    NSString *memberID = member ? member.MemberID : @"";
   // NSString *locCode = LocationCode ?  LocationCode:@"HK";
    NSString *locCode = [locationDefaults objectForKey:@"locationCode"];
    MyLog(@"%@",[locationDefaults objectForKey:@"locationCode"]);
    __weak __typeof(self)weakself = self;
    [EGMyDonationRequestAdapter getShoppingCartDisclaimerWithLocationCode:locCode memberID:memberID success:^(NSString *result){
        
          MyLog(@"%@",result);
        for (UIView *view in _noteView.subviews) {
            
            [view removeFromSuperview];
        }
         _currentY=10;
        [weakself parseHTML:result];
        
    } failure:^(NSError *error) {
          MyLog(@"%@",error);
    }];
}
#pragma mark HTML数据解析
- (void)parseHTML:(NSString*)htmlString
{
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br /><br />" withString:@"</p><p>"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"</span>" withString:@"</span></p><p>"];
    
    NSData *dataTitle=[htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];

    NSArray *elements=[xpathParser searchWithXPathQuery:@"//p"];

    [self parseElements:elements];
}

-(void)parseElements:(NSArray *)elements
{
    for (TFHppleElement *element in elements) {
        NSArray *childs=[element children];
        if (childs.count) {
            [self parseElements:childs];
        } else {
            //没有子节点
            if ([element.tagName isEqualToString:@"span"]) {
                //MyLog(@"tagName:%@, content:%@", element.tagName, element.content);
                [self addTitleText:element.content font:kTitleFontH2];
            } else if ([element.tagName isEqualToString:@"p"]) {
                //MyLog(@"tagName:%@, content:%@", element.tagName, element.content);
                [self addSubText:element.content];
            }
        }
    }
}
//添加文章标题
- (void)addTitleText:(NSString *)content font:(UIFont*)font{
    FDLabelView *titleView = [[FDLabelView alloc] initWithFrame:CGRectMake(10, _currentY, 300, 0)];
    //titleView.backgroundColor = [UIColor redColor];
    titleView.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    //titleView.backgroundColor = [UIColor redColor];
    titleView.font = kTitleFontH2;
    titleView.minimumScaleFactor = 0.50;
    titleView.numberOfLines = 0;
    titleView.text = content;
    titleView.lineHeightScale = 0.90;
    titleView.fixedLineHeight = 25;
    titleView.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
    titleView.fdTextAlignment = FDTextAlignmentLeft;
    titleView.fdAutoFitMode = FDAutoFitModeAutoHeight;
    titleView.fdLabelFitAlignment = FDLabelFitAlignmentCenter;
    titleView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    [_noteView addSubview:titleView];
    _currentY += titleView.visualTextHeight;
    [_noteView setContentSize:CGSizeMake(320, _currentY)];
}

//添加文章段落
- (void)addSubText:(NSString *)content {
    FDLabelView *titleView = [[FDLabelView alloc] initWithFrame:CGRectMake(10, _currentY, 300, 0)];
    titleView.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.00];
    titleView.textColor = [UIColor blackColor];
    //titleView.backgroundColor = [UIColor redColor];
    titleView.font = [UIFont systemFontOfSize:15];
    titleView.minimumScaleFactor = 0.50;
    titleView.numberOfLines = 0;
    titleView.text = content;
    titleView.lineHeightScale = 0.80;
    titleView.fixedLineHeight = 20;
    titleView.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
    titleView.fdTextAlignment = FDTextAlignmentLeft;
    titleView.fdAutoFitMode = FDAutoFitModeAutoHeight;
    titleView.fdLabelFitAlignment = FDLabelFitAlignmentCenter;
    titleView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    [_noteView addSubview:titleView];
    
    _currentY += titleView.visualTextHeight;
    
    [_noteView setContentSize:CGSizeMake(320, _currentY)];
    
    titleView.debug = NO;
}

#pragma mark delegates
- (BOOL)donateWithCharge
{
    return self.shoppingCart.DonateWithCharge;
}

- (NSInteger)numberOfCheckedItems
{
    return self.shoppingCart.NumberOfItems;
}

- (NSString *)Location
{
    if ([self.shoppingCart.Location isEqualToString:EGLocalizedString(@"MyDonation_HK", nil)]){
        return @"HK";
    }
    return @"nonHK";
}

- (void)dropDownMenu:(EGDropDownMenu *)dropDownMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        self.shoppingCart.DonateWithCharge = NO;
    } else if (indexPath.row == 1) {
        self.shoppingCart.DonateWithCharge = YES;
    }
    [[NSUserDefaults standardUserDefaults] setBool:self.shoppingCart.DonateWithCharge forKey:@"DonateWithCharge"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    for (EGShoppingCartCell *cell in self.cells) {
        [cell reloadData];
    }
    // 计算捐款总额
    _totalAmt = 0;
    for (EGShoppingCartCell *obj in self.cells) {
        if (obj.IsChecked) {
            _totalAmt += obj.donateAmt;
        }
    }
    NSString *totalAmt = [NSString stringWithFormat:@"HK$ %ld",(long)self.totalAmt];
    UILabel *label1 = (UILabel *)[self.bottomView viewWithTag:kTagTotalAmtLab];
    label1.text = totalAmt;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _recordList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * cellID = @"cell";
    DonationRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[DonationRecordCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
       
    }
    
    EGDonationRecord *record = _recordList[indexPath.row];
    
    cell.title.text = record.CaseTitle;
    cell.date.text = [NSString stringWithDataString:record.DonateDate format:@"yyyy/MM/dd"];
    cell.money.text = [NSString stringWithFormat:@"HK$ %@", record.Amt];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EGDonationRecord *record = _recordList[indexPath.row];
    RecordDtlViewController * vc = [[RecordDtlViewController alloc] init];
    vc.record = record;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITextFieldDelegate
//解决虚拟键盘挡住UITextField的方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 280 - (self.view.frame.size.height - 216.0);//键盘高度216;
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
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
