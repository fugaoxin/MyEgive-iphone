//
//  ConfirmViewController.m
//  Egive
//
//  Created by sino on 15/8/26.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ConfirmViewController.h"
#import "EGUtility.h"
#import "UIView+ZJQuickControl.h"
#import "ZJScreenAdaptation.h"
#import "ZJScreenAdaptationMacro.h"
#import "LoginViewController.h"
#import "EncourageOthersController.h"
#import "ContactListController.h"
#import "EGAlertViewController.h"
#import "Constants.h"

#define ScreenSize [UIScreen mainScreen].bounds.size




#define kTagSegmentedControl1    100
#define kTagReceiptView          101
#define kTagSegmentedControl2    102
#define kTagAcknowledgementView  103
#define kTagConfirmView          104


@interface ConfirmViewController ()<UIGestureRecognizerDelegate>{
    MDHTMLLabel *_htmlLabel;
}
@property(nonatomic, strong)UIScrollView * scrollView;

@property (nonatomic, strong) EGGetAndSaveShoppingCartResult *model;
@property (nonatomic, assign) NSInteger offSetY;

@end

@implementation ConfirmViewController

- (id)initWithDataModel:(EGGetAndSaveShoppingCartResult *)model
{
    if (self = [super init]) {
        
        _model = model;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = EGLocalizedString(@"mydonation_comfirm_title", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{

    
    for (UIView *view in self.view.subviews) {
        
        [view removeFromSuperview];
    }
    
    MemberModel *member = [ShowMenuView sharedInstance].member;
    _offSetY = 0;
    NSInteger margin = 8.0;
    NSInteger width = 320 - margin*2;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    
    CGRect rect = CGRectZero;
    rect.size.width = kScreenW;
    rect.size.height = kScreenH - 50;
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.contentSize = CGSizeMake(0, 568-64-50);
    //scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    if (!member) {
        //  未登录提示
        UIView * noteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        noteView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        [scrollView addSubview:noteView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginTap)];
        tap.delegate = self;
        [noteView addGestureRecognizer:tap];
        
        UILabel * noteLabel = [noteView addLabelWithFrame:CGRectMake(margin, 3, width-30, 70) text:nil];
        noteLabel.font = [UIFont systemFontOfSize:13];
        //noteLabel.backgroundColor = [UIColor redColor];
        noteLabel.numberOfLines = 0;
        
        //跳转到登录页的Button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(width-20, 13, 25, 29);
        [btn  setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(ChangeToLog) forControlEvents:UIControlEventTouchUpInside];
        [noteView addSubview:btn];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat: @"%@",EGLocalizedString(@"如需捐款收据及储存捐款记录,请先注册为意赠之友,或现为意赠之友,请按此登入", nil)]];
        
        NSInteger lang = [EGUtility getAppLang];
        if (lang==3) {
            NSRange contentRange = {[attributedString length] - 6,6};
            [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
            [attributedString addAttribute:NSForegroundColorAttributeName value:kGreenBtnColor range:contentRange];
            //[content addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://www.baidu.com"] range:contentRange];
            noteLabel.attributedText = attributedString;
        }else{
            NSRange contentRange = {[attributedString length] - 2,2};
            [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
            [attributedString addAttribute:NSForegroundColorAttributeName value:kGreenBtnColor range:contentRange];
            //[content addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://www.baidu.com"] range:contentRange];
            noteLabel.attributedText = attributedString;
        }
        
        //        [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        //        [attributedString addAttribute:NSForegroundColorAttributeName value:kGreenBtnColor range:contentRange];
        //        //[content addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://www.baidu.com"] range:contentRange];
        //        noteLabel.attributedText = attributedString;
        
        _offSetY = 50;
    }
    
    _offSetY +=20;
    UILabel * label1 = [scrollView addLabelWithFrame:CGRectMake(margin, _offSetY, 150, 25) text:EGLocalizedString(@"专案标题", nil)];
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = [UIColor grayColor];
    
    UILabel * label2 = [scrollView addLabelWithFrame:CGRectMake(160, _offSetY, 140, 25) text:EGLocalizedString(@"捐助金额", nil)];
    label2.font = [UIFont systemFontOfSize:15];
    label2.textAlignment = NSTextAlignmentRight;
    label2.textColor = [UIColor grayColor];
    
    _offSetY += 30;
    
    [scrollView addImageViewWithFrame:CGRectMake(20, _offSetY, width, 2) image:@"Line@2x.png"];
    
    for (EGShoppingCart *proj in _model.ItemList) {
        NSString *title = proj.Title;
        NSString *amt = [NSString stringWithFormat:@"HK$ %ld", proj.DonateAmt];
        UILabel *caseName = [scrollView addLabelWithFrame:CGRectMake(margin, _offSetY-10, 320/2+30, 50) text:title];
        caseName.numberOfLines=0;
        caseName.font = [UIFont systemFontOfSize:13];
        //caseName.backgroundColor = [UIColor redColor];
        
        UILabel *caseAmt = [scrollView addLabelWithFrame:CGRectMake(320/2-10, _offSetY, 320/2-5, 30) text:amt];
        caseAmt.textAlignment = NSTextAlignmentRight;
        caseAmt.font = [UIFont systemFontOfSize:13];
        
        [scrollView addImageViewWithFrame:CGRectMake(margin, _offSetY + 30, width, 2) image:@"Line@2x.png"];
        
        _offSetY += 30;
    }
    
    UIView * sumView = [[UIView alloc] initWithFrame:CGRectMake(0, _offSetY, 320, 30)];
    sumView.backgroundColor = [UIColor colorWithRed:240/255.0 green:248/255.0 blue:233/255.0 alpha:1];
    [scrollView addSubview:sumView];
    
    UILabel * label3 = [scrollView addLabelWithFrame:CGRectMake(margin, _offSetY, 150, 30) text:EGLocalizedString(@"捐款总额", nil)];
    label3.font = [UIFont systemFontOfSize:15];
    
    NSString *totalDonateAmt = [NSString stringWithFormat:@"HK$ %ld",_model.TotalDonateAmt];
    _donSumMoney = [scrollView addLabelWithFrame:CGRectMake(320/2-5, _offSetY, 320/2-5, 30) text:totalDonateAmt];
    _donSumMoney.font = [UIFont systemFontOfSize:15];
    _donSumMoney.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    _donSumMoney.textAlignment = NSTextAlignmentRight;
    _offSetY += 40;
    
    NSArray *segmentedArray = @[EGLocalizedString(@"需要捐款收据", nil),EGLocalizedString(@"不需要捐款收据", nil)];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(margin, _offSetY, width, 25);
    segmentedControl.tag = kTagSegmentedControl1;
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor colorWithRed:110/255.0 green:184/255.0 blue:43/255.0 alpha:1];
    [segmentedControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:segmentedControl];

    
    _offSetY += 35;
    
    UIView * receiptView = [[UIView alloc] initWithFrame:CGRectMake(margin, _offSetY, width, 55)];
    receiptView.tag = kTagReceiptView;
    [scrollView addSubview:receiptView];
    
    _receiptName = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
    _receiptName.placeholder =EGLocalizedString(@"捐款收据名称", nil) ;
    _receiptName.font = [UIFont systemFontOfSize:14];
    _receiptName.delegate = self;
    _receiptName.borderStyle = UITextBorderStyleRoundedRect;
    [receiptView addSubview:_receiptName];
    NSString *name = @"";
    //    if ([EGUtility getAppLang] == EN) {
    //
    //        if ([member.MemberType isEqualToString:@"P"]) {
    //            name = [NSString stringWithFormat:@"%@%@",member.EngLastName,member.EngFirstName];
    //        } else if([member.MemberType isEqualToString:@"C"]) {
    //            name = member.CorporationEngName;
    //        }
    //    } else {
    //        if ([member.MemberType isEqualToString:@"P"]) {
    //            name = [NSString stringWithFormat:@"%@%@",member.ChiLastName,member.ChiFirstName];
    //        } else if([member.MemberType isEqualToString:@"C"]) {
    //            name = member.CorporationChiName;
    //        }
    //    }
    if ([member.MemberType isEqualToString:@"P"]) {
        if (![member.ChiLastName isEqualToString:@""]) {
            name = [NSString stringWithFormat:@"%@%@",member.ChiLastName,member.ChiFirstName];
        }else{
            name = [NSString stringWithFormat:@"%@%@",member.EngLastName,member.EngFirstName];
        }
         _receiptName.userInteractionEnabled = YES;
    } else if([member.MemberType isEqualToString:@"C"]) {
        if (![member.CorporationChiName isEqualToString:@""]) {
            name = member.CorporationChiName;
        }else{
            name = member.CorporationEngName;
        }
        _receiptName.userInteractionEnabled = NO;
    }
    
    _receiptName.text = name;
    
    if (member && ![member.MemberType isEqualToString:@"P"]){
    
        UILabel * label4 = [receiptView addLabelWithFrame:CGRectMake(0, 30, width, 40) text:EGLocalizedString(@"必须与机构注册文件相同", nil)];
        label4.numberOfLines=0;
        label4.font = [UIFont systemFontOfSize:15];
        label4.textColor = [UIColor grayColor];
    
    }else{
    
    UILabel * label4 = [receiptView addLabelWithFrame:CGRectMake(0, 30, width, 40) text:EGLocalizedString(@"必须与身份证明文件相同", nil)];
    label4.numberOfLines=0;
    label4.font = [UIFont systemFontOfSize:15];
    label4.textColor = [UIColor grayColor];
        
    }
    
    _offSetY += 70;
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[EGLocalizedString(@"网上鸣谢", nil),EGLocalizedString(@"无需鸣谢", nil)]];
    seg.frame = CGRectMake(margin, _offSetY, width, 25);
    seg.selectedSegmentIndex = 0;
    seg.tag = kTagSegmentedControl2;
    seg.tintColor = [UIColor colorWithRed:110/255.0 green:184/255.0 blue:43/255.0 alpha:1];;
    [seg addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:seg];
    
    // 機構:Cannot be changed by use
    if (member && ![member.MemberType isEqualToString:@"P"]){
        seg.enabled = NO;
    } else {
        seg.enabled = YES;
    }
    
    _offSetY += 35;
    
    UIView * acknowledgementView = [[UIView alloc] initWithFrame:CGRectMake(margin, _offSetY, width, 100)];
    acknowledgementView.tag = kTagAcknowledgementView;
    //acknowledgementView.backgroundColor=[UIColor redColor];
    [scrollView addSubview:acknowledgementView];
    
    _thankName = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
    _thankName.placeholder =EGLocalizedString(@"网上鸣谢名称", nil);
    _thankName.font = [UIFont systemFontOfSize:14];
    _thankName.delegate = self;
    _thankName.borderStyle = UITextBorderStyleRoundedRect;
    _thankName.enabled=YES;
    [acknowledgementView addSubview:_thankName];
    //    _thankName.text = member ? name : @"";
    _thankName.text = member.LoginName;
    
    UILabel * label5 = [acknowledgementView addLabelWithFrame:CGRectMake(0, 30, width,40) text:EGLocalizedString(@"将用作计算累计捐款之用", nil)];
    label5.numberOfLines=0;
    label5.font = [UIFont systemFontOfSize:15];
    label5.textColor = [UIColor grayColor];
    
    _offSetY += 65;
    
    if (!member){
        
        _emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 70, width, 30)];
        _emailTextField.placeholder =EGLocalizedString(@"Register_email", nil); //电邮地址
        _emailTextField.font = [UIFont systemFontOfSize:14];
        _emailTextField.delegate = self;
        _emailTextField.borderStyle = UITextBorderStyleRoundedRect;
        _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
        _emailTextField.enabled=YES;
       
        [acknowledgementView addSubview:_emailTextField];
        
        UILabel * label = [acknowledgementView addLabelWithFrame:CGRectMake(0, 100, width, 25) text:EGLocalizedString(@"将用作日后联络之用", nil)];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor grayColor];
        _offSetY += 65;
        
    }else if (![member.MemberType isEqualToString:@"P"]){
        
        acknowledgementView.userInteractionEnabled=NO;
    
    }

    //=================================
    UIView * confirmView = [[UIView alloc] initWithFrame:CGRectMake(margin, _offSetY, width, 100)];
    confirmView.tag = kTagConfirmView;
    //confirmView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:confirmView];
    
    _confirmInfoButton = [confirmView addImageButtonWithFrame:CGRectMake(0,  8, 20, 20) title:nil backgroud:@"cart_checkbox_nor.png" action:^(UIButton *button) {
        if (button.selected) {
            button.selected = NO;
        }else
            button.selected = YES;
    }];
    [_confirmInfoButton setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
    
    UILabel * label6 = [confirmView addLabelWithFrame:CGRectMake(30, 0, width - 30,35) text:EGLocalizedString(@"本人确认以上捐款资料准确无误", nil)];
    label6.numberOfLines =2;
    label6.font = [UIFont systemFontOfSize:14];
    
    _agreeButton = [confirmView addImageButtonWithFrame:CGRectMake(0, 50, 20, 20) title:nil backgroud:@"cart_checkbox_nor.png" action:^(UIButton *button) {
        if (button.selected) {
            button.selected = NO;
        }else
            button.selected = YES;
    }];
    [_agreeButton setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
    
    //    UILabel * label7 = [confirmView addLabelWithFrame:CGRectMake(30, 30, width - 30, 40) text:@"本人已阅读及清楚明白以上捐款声明,并同意有关善款安排。"];
    //    label7.font = [UIFont systemFontOfSize:13];
    //    label7.numberOfLines = 2;
    MDHTMLLabel *htmlLabel = [[MDHTMLLabel alloc] init];
    htmlLabel.delegate = self;
    _htmlLabel = htmlLabel;
    htmlLabel.numberOfLines = 0;
    htmlLabel.font = [UIFont systemFontOfSize:14];
    htmlLabel.linkAttributes = @{
                                 NSForegroundColorAttributeName: kGreenBtnColor,
                                 NSFontAttributeName: [UIFont systemFontOfSize:14],
                                 NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    
    htmlLabel.activeLinkAttributes = @{
                                       NSForegroundColorAttributeName: kGreenBtnColor,
                                       NSFontAttributeName: [UIFont systemFontOfSize:14],
                                       NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    
    //NSString *htmlString = @"<p>本人已阅读及清楚明白以上<a href=\"www.baidu.com\">捐款声明</a>,并同意有关善款安排。</p>";//[htmlString stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    NSString *htmlString = EGLocalizedString(@"本人已阅读及清楚明白以上捐款声明,并同意有关善款安排", nil);
    
    if (!member) {
        htmlString = EGLocalizedString(@"本人已阅读及清楚明白以上捐款声明，并同意有关善款安排及不获发捐款收据", nil);
    }
    
    htmlLabel.htmlText = htmlString;
    [confirmView addSubview:htmlLabel];
    
    htmlLabel.frame = CGRectMake(30, 38, width - 30, 60);
    //=================================
    _offSetY += 70;
    _scrollView.contentSize = CGSizeMake(0, _offSetY+30);
    
    rect.size.height = 50;
    rect.origin.y = kScreenH - 50;
    
    UIView * bottomView = [[UIView alloc] initWithFrame:rect];
    bottomView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.view addSubview:bottomView];
    
    __weak __typeof(self)weakself = self;
    
    rect = (CGRect){20,10,kScreenW - 40,30};
    UIButton * tapButton = [bottomView addImageButtonWithFrame:rect title:EGLocalizedString(@"MyDonation_ContinueButton2", nil) backgroud:nil action:^(UIButton *button) {
        [weakself checkOutShoppingCart];
    }];
    tapButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [tapButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tapButton.layer.cornerRadius = 4;
    tapButton.backgroundColor = [UIColor colorWithRed:110/255.0 green:184/255.0 blue:43/255.0 alpha:1];
//    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:EGLocalizedString(@"MyDonation_ContinueButton", nil)];
//    [commentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [commentString length])];
//    [commentString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, [commentString length])];
//    [tapButton setAttributedTitle:commentString forState:UIControlStateNormal];
    
    //判斷是否弹出呼吁募捐
    if (_isPaySuccessful) {
        //[self testAction];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testAction) name:@"isPaySuccessful" object:nil];
    
    // Default as “Receipt is required”
    if (!member) {
        segmentedControl.selectedSegmentIndex = 1;
        [segmentedControl sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

-(void)segmentChaneg:(UISegmentedControl *)seg{
    int index = seg.selectedSegmentIndex;
    
    
}

-(void)ChangeToLog{

    LoginViewController * vc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[MDHTMLLabel class]]) {
        
        return NO;
        
    }
    
    return YES;
}

#pragma mark
- (void)HTMLLabel:(MDHTMLLabel *)label didSelectLinkWithURL:(NSURL *)URL
{
    //MyLog(@"Did select link with URL: %@", URL.absoluteString);
    NotesForDonations * vc = [[NotesForDonations alloc] initWithNibName:@"BaseNotesController" bundle:nil];;
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)updateSubViewFrame:(BOOL)hidden tag:(NSInteger)tag offSet:(CGFloat)offSet
{
    NSInteger height = hidden ? -heightEx(offSet) : heightEx(offSet);
    
    for (UIView *view in _scrollView.subviews) {
        if (view.tag > tag) {
            CGRect frame = view.frame;
            frame.origin.y += height;
            view.frame = frame;
        }
    }
    CGSize size = _scrollView.contentSize;
    size.height += height;
    _scrollView.contentSize = size;
}

#pragma mark actions
-(void)segmentAction:(UISegmentedControl *)Seg
{
    MemberModel *member = [ShowMenuView sharedInstance].member;
    //UISegmentedControl *seg1 = (UISegmentedControl*)[self.scrollView viewWithTag:kTagSegmentedControl1];
    //UISegmentedControl *seg2 = (UISegmentedControl*)[self.scrollView viewWithTag:kTagSegmentedControl2];
    NSInteger Index = Seg.selectedSegmentIndex;
    NSInteger tag = Seg.tag + 1;
    UIView *view = [self.scrollView viewWithTag:tag];
    
    switch (Index) {
        case 0:
        {
            if (Seg.tag == kTagSegmentedControl1 && !member) {
                //direct user to M3.1 Login page if tap on “Receipt is required”
                Seg.selectedSegmentIndex = 1;
                [self directToLoginPage];
                
                return;
            }
            
            if (Seg.tag==kTagSegmentedControl1 && member) {
                _htmlLabel.htmlText = EGLocalizedString(@"本人已阅读及清楚明白以上捐款声明,并同意有关善款安排", nil);
            }
            view.hidden = NO;
            
        }
            break;
        case 1:
        {
            if (Seg.tag==kTagSegmentedControl1 && member) {
                _htmlLabel.htmlText = EGLocalizedString(@"本人已阅读及清楚明白以上捐款声明，并同意有关善款安排及不获发捐款收据", nil);
            }
            view.hidden = YES;
        }
            break;
        default:
            break;
    }
    if (Seg.tag == kTagSegmentedControl1) {
        [self updateSubViewFrame:view.hidden tag:tag offSet:55];
    } else {
        CGFloat offSet = member ? 55:120;
        [self updateSubViewFrame:view.hidden tag:tag offSet:offSet];
    }
}

#pragma mark 跳转到登录界面
- (void)directToLoginPage
{
    MyLog(@"%s",__func__);
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"如需捐款收据及储存捐款记录,请先登录后再操作" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    alert.tag = 100;
//    [alert show];
    
    __weak typeof(self)weakSelf = self;
    EGAlertViewController * vc = [[EGAlertViewController alloc] initWithTitle:EGLocalizedString(@"捐款收据", nil) message:EGLocalizedString(@"如需收据请先注册成为会员", nil) cancelButtonTitle:EGLocalizedString(@"取消", nil) otherButtonTitles:EGLocalizedString(@"登入/注册", nil)];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.completedBlock = ^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            MyLog(@"clicked cancelBtn");
        } else {
            MyLog(@"clicked confirmBtn");
            [weakSelf loginTap];
        }
    };
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)loginTap
{
    LoginViewController * vc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        [self loginTap];
    }
}


#pragma mark 提交捐款请求
- (void)checkOutShoppingCart
{
//    __weak typeof(self)weakSelf = self;
//    EGAlertViewController * vc = [[EGAlertViewController alloc] initWithTitle:@"呼籲募捐" message:@"感激你的慷慨捐输，请呼吁身边的朋友共襄善举，发扬大爱精神！" cancelButtonTitle:@"取消" otherButtonTitles:@"確定"];
//    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    vc.completedBlock = ^(NSInteger buttonIndex) {
//        if (buttonIndex == 0) {
//            MyLog(@"clicked cancelBtn");
//        } else {
//            MyLog(@"clicked confirmBtn");
//            EncourageOthersController * vc = [[EncourageOthersController alloc] init];
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//            vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//            [weakSelf presentViewController:nav animated:YES completion:nil];
//        }
//    };
//    [self presentViewController:vc animated:NO completion:^{
//        
//    }];
    
//    ContactListController * vc = [[ContactListController alloc] initWithNibName:@"ContactListController" bundle:nil];
//    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    [self presentViewController:vc animated:YES completion:nil];

//    return;
    
    MemberModel *member = [ShowMenuView sharedInstance].member;
    
    NSString *errorMsg = nil;
    // 1.
    if (!_confirmInfoButton.selected) {
        errorMsg = EGLocalizedString(@"請選擇[本人確認以上捐款資料準確無誤。]", nil);
    }else if (!_agreeButton.selected) {
        errorMsg = EGLocalizedString(@"請選擇[本人已閱讀及清楚明白以上捐款聲明，並同意有關善款安排及不獲發捐款收據。]", nil);
    }
//    else if (_emailTextField && _emailTextField.text.length && [NSString isEmail:_emailTextField.text]) {
//        errorMsg = EGLocalizedString(@"無效的[電郵地址]!", nil);
//    }
    if (errorMsg) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:errorMsg delegate:self cancelButtonTitle:EGLocalizedString(@"Common_button_confirm", nil) otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    NSString *displayName = _thankName.text.length ? _thankName.text : EGLocalizedString(@"無名氏", nil);
    NSString *nameOnReceipt = _receiptName.text.length ? _receiptName.text : nil;
    // 不需要则置空
    if ([self.scrollView viewWithTag:kTagAcknowledgementView].hidden) {
        displayName = @"";
    }
    if ([self.scrollView viewWithTag:kTagReceiptView].hidden) {
        nameOnReceipt = @"";
    }
    EGCheckOutShoppingCartRequest *request = [[EGCheckOutShoppingCartRequest alloc] init];
    request.MemberID = _model.MemberID ? _model.MemberID : @"";
    request.CookieID = _model.CookieID ? _model.CookieID : @"";
    request.DisplayName = displayName;
    request.NameOnReceipt = nameOnReceipt;
    request.Email = _emailTextField ? _emailTextField.text : member.Email;
    request.AppToken=member.AppToken;
    //__weak __typeof(self)weakself = self;
    [EGMyDonationRequestAdapter checkOutShoppingCart:request success:^(NSString *result) {
        NSDictionary *dict = [NSString parseJSONStringToNSDictionary:result];
        MyLog(@"%@",dict);
        if (dict) {
            NSUserDefaults *Defaults = [[NSUserDefaults alloc] init];
            NSString *CustomParameter = dict[@"CustomParameter"];
            [Defaults setObject:CustomParameter forKey:@"DonationID"];
            NSString *url = [NSString stringWithFormat:@"%@/SendDataToPaypal.aspx?CustomParameter=%@&lang=1", SITE_URL, CustomParameter];
            url =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        } else {
            NSString *msg = [NSString captureData:result];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:EGLocalizedString(@"提示", nil) message:msg delegate:self cancelButtonTitle:EGLocalizedString(@"Common_button_confirm", nil) otherButtonTitles:nil, nil];
            [alertView show];
        }
        MyLog(@"result:%@",result);
        
    } failure:^(NSError *error) {
        MyLog(@"%@",error);
    }];
}
- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)hideProgress{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    __weak typeof(self)weakSelf = self;
    EGAlertViewController * vc = [[EGAlertViewController alloc] initWithTitle:EGLocalizedString(@"呼籲募捐", nil) message:EGLocalizedString(@"感激你的慷慨捐输，请呼吁身边的朋友共襄善举，发扬大爱精神！", nil) cancelButtonTitle:EGLocalizedString(@"取消", nil) otherButtonTitles:EGLocalizedString(@"Common_button_confirm", nil)];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.completedBlock = ^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            MyLog(@"clicked cancelBtn");
            NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
            [standardUserDefaults setObject:@"1" forKey:@"EGIVE_AFTER_DONATE"];
            [standardUserDefaults synchronize];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            MyLog(@"clicked confirmBtn");
            EncourageOthersController * vc = [[EncourageOthersController alloc] init];
            //            if (_model.ItemList.count >0) {
            //                vc.ItemList = _model.ItemList;
            //            }
            
            //            [self dismissViewControllerAnimated:YES completion:nil];
            NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
            [standardUserDefaults setObject:@"1" forKey:@"EGIVE_AFTER_DONATE"];
            //            [standardUserDefaults setObject:@"1" forKey:@"EGIVE_AFTER_DONATE_GOTO_"];
            [standardUserDefaults synchronize];
            [self.navigationController popViewControllerAnimated:YES];
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self.navigationController presentViewController:nav animated:YES completion:nil];
            //            [weakSelf presentViewController:nav animated:YES completion:nil];
        }
    };
    [self presentViewController:vc animated:NO completion:^{
        
    }];
    
    return;
}

- (void)testAction{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [self performSelector:@selector(hideProgress) withObject:nil afterDelay:5.0];

   


    
//        ContactListController * vc = [[ContactListController alloc] initWithNibName:@"ContactListController" bundle:nil];
//        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//        [self presentViewController:vc animated:YES completion:nil];
    
    
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
