//
//  RegisterViewController.m
//  Egive
//
//  Created by sino on 15/7/21.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "Constants.h"
#import "RegisterViewController.h"
#import "UIView+ZJQuickControl.h"
#import "AlertViewController.h"
#import "LoginViewController.h"
#import "NSString+RegexKitLite.h"
#import "GlobalMacro.h"
#import "EGUtility.h"
#import "AppDelegate.h"
#import "TPKeyboardAvoidingScrollView.h"


#import "MBProgressHUD.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface RegisterViewController ()<UIScrollViewDelegate,UITextFieldDelegate, UIPickerViewDelegate>{
//    UIScrollView * _one;
    UIView * _oneView;  //个人登记页面
    UIView * _twoView;  //机构登记
    UIView * _commitBgView;

    UIButton * _typeButton;
    UIButton * _helpTypeButton;
    
    BOOL _isEamil;
    BOOL _isVolunteer;
    BOOL _orgIsEamil;
    BOOL _orgIsVolunteer;
    BOOL _isOther;
    BOOL _isBelongTo;

    UIButton * _noEmailButton;
    UILabel * _note;
    UILabel * _belongLabel;
    NSMutableArray * _belongCd;
    NSMutableArray * _belongDesp;
    NSInteger  _selectedIndex;
    
    UIView * _volunteerView; //成为义工View
   
    NSMutableArray * _arr;
    UITextField * _dateStart;
    UITextField * _dateEnd;
    
    UITextField * _textField1;  UITextField * _textField2;  UITextField * _textField3;
    UITextField * _textField4;  UITextField * _textField5;
    UITextField * _textField7;  UITextField * _textField8;  UITextField * _textField9;
    UITextField * _textField10; UITextField * _textField11; UITextField * _textField12;
    UITextField * _textField13; UITextField * _textField14; UITextField * _textField15; UITextField * _districtField1;
    UITextField * _textField16; UITextField * _textField17;
    UITextField * _telField; UITextField * _telDistrictField; UITextField * _telDistrictFieldOrg;
    UITextField * _editing;
    
    NSInteger selectedDistrict;
    NSInteger selectedBelongTo;
    NSInteger selectedBusiness;
    UITextField* otherBussessNumbertextField;
    int isotherflag;
}
@property (strong, nonatomic) TPKeyboardAvoidingScrollView * one;
@property (strong, nonatomic) TPKeyboardAvoidingScrollView * twoScrollView;
@property (strong, nonatomic)UIView * personalView;
@property (strong, nonatomic)UIView * organizationView;
@property (copy, nonatomic) NSMutableArray * arr1;
@property (strong, nonatomic)UITextField * userName;
@property (strong, nonatomic)UITextField * passWord;
@property (strong, nonatomic)UITextField * confirmPsw;
@property (strong, nonatomic)UITextField * lastNameCh;
@property (strong, nonatomic)UITextField * nameCh;
@property (strong, nonatomic)UITextField * lastNameEn;
@property (strong, nonatomic)UITextField * nameEn;
@property (strong, nonatomic)UITextField * email;
@property (strong, nonatomic)UITextField * belongTo;
@property (strong, nonatomic)UIButton * mrButton;
@property (strong, nonatomic)UIButton * mrsButton;
@property (strong, nonatomic)UIButton * missButton;
@property (copy, nonatomic) NSString * sexType;
@property (copy, nonatomic) NSString * isSelEmail;
@property (strong, nonatomic) UIButton * isEmailButton;
@property (strong, nonatomic) UIButton * noEmailButton;
@property (strong, nonatomic) UITextField * otherRegion;
@property (strong, nonatomic) UIButton * yButton; //愿意
@property (strong, nonatomic) UIButton * nButton; //暂不考虑
@property (strong, nonatomic) UIButton * commitButton;
@property (copy, nonatomic) NSString * CorporationType;
@property (strong, nonatomic) UITextField * textField6;
@property (strong, nonatomic) NSString * BusinessRegistrationType;
@property (strong, nonatomic) NSString * addressCountry;
@property (strong, nonatomic) NSMutableArray * registrationTypeOptions;
@property (copy, nonatomic)  NSString * registerResult;
@property (copy, nonatomic) NSMutableArray * volunteerInterestArr;
@property (copy, nonatomic) NSMutableArray * availableTimeArr;
@property (strong, nonatomic) AlertViewController * alertVc;
@property (nonatomic) int flag;
@property (copy, nonatomic) NSString * backName;
@property (strong, nonatomic) UIImageView * lineView;
@property (nonatomic)BOOL isSuccessful1;
@property (nonatomic)BOOL isSuccessful; // 是否已经提交注册成功
@property (strong, nonatomic) UIView * testView;
@property (copy, nonatomic) NSDictionary *fbdata;
@property (copy, nonatomic) NSDictionary *wbdata;
@property (strong, nonatomic) LoginViewController *theParentVC;
@property (strong, nonatomic) UIPickerView *pickerViewPopup;
@property (strong, nonatomic) UIPickerView *pickerViewPopupBelongTo;
@property (strong, nonatomic) UIPickerView *pickerViewPopupBusiness;
@property (strong, nonatomic) UILabel * selBtn;
@property (strong, nonatomic) NSArray * regionArr;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property(nonatomic)BOOL *userNameLoginFlag;
@end
@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // _userNameLoginFlag=1;
    isotherflag=0;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults objectForKey:@"FACEBOOK_REG_REQ"] != nil && [[standardUserDefaults objectForKey:@"FACEBOOK_REG_REQ"] isEqualToString:@"1"])
    {
       // MyLog(@"FACEBOOK_REG_REQ");
        _fbdata = [standardUserDefaults objectForKey:@"FACEBOOK_DETAIL"];
    } else if ([standardUserDefaults objectForKey:@"WEIBO_REG_REQ"] != nil && [[standardUserDefaults objectForKey:@"WEIBO_REG_REQ"] isEqualToString:@"1"])
    {
       // MyLog(@"WEIBO_REG_REQ");
        _wbdata = [standardUserDefaults objectForKey:@"WEIBO_DETAIL"];
    }
    
    // Do any additional setup after loading the view.
    self.title = EGLocalizedString(@"意赠之友登记表格", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    _selectedIndex = 0;
    _flag = 0; //标记发送个人注册还是企业注册
    _sexType = @"R";
    _addressCountry = @"HK";
    _CorporationType = @"C"; //默认商业类型
    _BusinessRegistrationType = @"B";
    _volunteerInterestArr = [[NSMutableArray alloc] init];
    _availableTimeArr = [[NSMutableArray alloc] init];
    [self createRegisterUI];
    _isSuccessful1 = NO;
    _isSuccessful = NO;
    _isBelongTo = NO;
    __weak typeof(self) weakSelf = self;
    _alertVc = [[AlertViewController alloc] initWithNibName:@"AlertViewController" bundle:nil];;
    [_alertVc setAction:^(AlertViewController *vc) {
        if (weakSelf.flag == 1) {
           [weakSelf PostIndividualUserInfo];
//            UIAlertView *alertView = [[UIAlertView alloc] init];
//            alertView.delegate = weakSelf;
//            alertView.message = EGLocalizedString(@"注册成功!请点击确定按钮返回登入页面!", nil);
//            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
//            [alertView show];
        }else if (weakSelf.flag == 2){
//            UIAlertView *alertView = [[UIAlertView alloc] init];
//            alertView.delegate = weakSelf;
//            alertView.message = EGLocalizedString(@"注册成功!请点击确定按钮返回登入页面!", nil);
//            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
//            [alertView show];
            [weakSelf PostEnterpriseUserInfo];
        }
    }];
    
   

}

-(void) moveViews
{
//    NSArray *views = [NSArray arrayWithObjects:_mrButton,
//                       _mrsButton,
//                       _missButton,
//                       _isEmailButton,
//                       _lastNameCh,
//                       _nameCh,
//                       _lastNameEn,
//                       _nameEn,
//                       _email, nil];
//    for (UIView *v in views) {
//        [v setFrame:CGRectMake(v.frame.origin.x, v.frame.origin.y - 60, v.frame.size.width, v.frame.size.height)];
//    }
//    
//    _passWord.text = @"";
//    _passWord.hidden = YES;
//    _confirmPsw.text = @"";
//    _confirmPsw.hidden = YES;
//    [[self.view viewWithTag:77] setHidden:YES];
    _passWord.text = @"";
    _passWord.placeholder = EGLocalizedString(@"password_not_require", nil);
    _passWord.enabled = NO;
  //_passWord.hidden = YES;
    _confirmPsw.text = @"";
    _confirmPsw.placeholder = EGLocalizedString(@"password_not_require", nil);
    _confirmPsw.enabled = NO;
    
    _textField2.enabled=NO;
    _textField3.enabled=NO;
    
    _textField2.placeholder=EGLocalizedString(@"password_not_require", nil);
    _textField3.placeholder=EGLocalizedString(@"password_not_require", nil);
    //_confirmPsw.hidden = YES;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    if ([pickerView isEqual:_pickerViewPopup]) {
        NSMutableArray * districtArr = [[NSMutableArray alloc] init];
        [districtArr addObject:@""];
        [districtArr addObject:EGLocalizedString(@"Central and Western", nil)];
        [districtArr addObject:EGLocalizedString(@"Eastern", nil)];
        [districtArr addObject:EGLocalizedString(@"Southern", nil)];
        [districtArr addObject:EGLocalizedString(@"Wan Chai", nil)];
        [districtArr addObject:EGLocalizedString(@"Sham Shui Po", nil)];
        [districtArr addObject:EGLocalizedString(@"Kowloon City", nil)];
        [districtArr addObject:EGLocalizedString(@"Kwun Tong", nil)];
        [districtArr addObject:EGLocalizedString(@"Wong Tai Sin", nil)];
        [districtArr addObject:EGLocalizedString(@"Yau Tsim Mong", nil)];
        [districtArr addObject:EGLocalizedString(@"Islands", nil)];
        [districtArr addObject:EGLocalizedString(@"Kwai Tsing", nil)];
        [districtArr addObject:EGLocalizedString(@"North", nil)];
        [districtArr addObject:EGLocalizedString(@"Sai Kung", nil)];
        [districtArr addObject:EGLocalizedString(@"Sha Tin", nil)];
        [districtArr addObject:EGLocalizedString(@"Tai Po", nil)];
        [districtArr addObject:EGLocalizedString(@"Tsuen Wan", nil)];
        [districtArr addObject:EGLocalizedString(@"Tuen Mun", nil)];
        [districtArr addObject:EGLocalizedString(@"Yuen Long", nil)];
        selectedDistrict = row;
        _districtField1.text = [districtArr objectAtIndex:row];
//        [pickerView removeFromSuperview];
        _pickerViewPopupBelongTo.hidden = YES;
         _pickerViewPopup.hidden = YES;
        _pickerViewPopupBusiness.hidden = YES;
    }else if ([pickerView isEqual:_pickerViewPopupBusiness]){
        NSMutableArray * districtArr = [[NSMutableArray alloc] init];
        [districtArr addObject:EGLocalizedString(@"不適用", nil)];
        [districtArr addObject:EGLocalizedString(@"商業登記號碼", nil)];
        [districtArr addObject:EGLocalizedString(@"香港社團注冊證明書編號", nil)];
        [districtArr addObject:EGLocalizedString(@"稅局檔號", nil)];
        selectedBusiness = row;
        _selBtn.text = [NSString stringWithFormat:@"%@",[districtArr objectAtIndex:row]];
        if ([_selBtn.text length] < 1) {
            _selBtn.text = EGLocalizedString(@"不適用", nil);
            _selBtn.textColor = [UIColor grayColor];
        }
        _selBtn.textColor = [UIColor blackColor];
        //[pickerView removeFromSuperview];
        _pickerViewPopupBelongTo.hidden = YES;
        _pickerViewPopup.hidden = YES;
        _pickerViewPopupBusiness.hidden = YES;
    }else {
        _isBelongTo = YES;
        selectedBelongTo = row;
        if (_belongDesp.count != 0) {
            _belongLabel.text = [NSString stringWithFormat:@"  %@",[_belongDesp objectAtIndex:row]];
        }
        if ([_belongLabel.text length] < 1) {
            _belongLabel.text = EGLocalizedString(@"Register_belongto", nil);
            _belongLabel.textColor = [UIColor grayColor];
        }
        _belongLabel.textColor = [UIColor blackColor];
        //[pickerView removeFromSuperview];
        _pickerViewPopupBelongTo.hidden = YES;
         _pickerViewPopup.hidden = YES;
        _pickerViewPopupBusiness.hidden = YES;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if ([pickerView isEqual:_pickerViewPopup]) {
        NSMutableArray * districtArr = [[NSMutableArray alloc] init];
        [districtArr addObject:@""];
        [districtArr addObject:EGLocalizedString(@"Central and Western", nil)];
        [districtArr addObject:EGLocalizedString(@"Eastern", nil)];
        [districtArr addObject:EGLocalizedString(@"Southern", nil)];
        [districtArr addObject:EGLocalizedString(@"Wan Chai", nil)];
        [districtArr addObject:EGLocalizedString(@"Sham Shui Po", nil)];
        [districtArr addObject:EGLocalizedString(@"Kowloon City", nil)];
        [districtArr addObject:EGLocalizedString(@"Kwun Tong", nil)];
        [districtArr addObject:EGLocalizedString(@"Wong Tai Sin", nil)];
        [districtArr addObject:EGLocalizedString(@"Yau Tsim Mong", nil)];
        [districtArr addObject:EGLocalizedString(@"Islands", nil)];
        [districtArr addObject:EGLocalizedString(@"Kwai Tsing", nil)];
        [districtArr addObject:EGLocalizedString(@"North", nil)];
        [districtArr addObject:EGLocalizedString(@"Sai Kung", nil)];
        [districtArr addObject:EGLocalizedString(@"Sha Tin", nil)];
        [districtArr addObject:EGLocalizedString(@"Tai Po", nil)];
        [districtArr addObject:EGLocalizedString(@"Tsuen Wan", nil)];
        [districtArr addObject:EGLocalizedString(@"Tuen Mun", nil)];
        [districtArr addObject:EGLocalizedString(@"Yuen Long", nil)];

        return [districtArr objectAtIndex:row];
    }else if ([pickerView isEqual:_pickerViewPopupBusiness]){
        
        NSMutableArray * districtArr = [[NSMutableArray alloc] init];
        [districtArr addObject:EGLocalizedString(@"不適用", nil)];
        [districtArr addObject:EGLocalizedString(@"商業登記號碼", nil)];
        [districtArr addObject:EGLocalizedString(@"香港社團注冊證明書編號", nil)];
        [districtArr addObject:EGLocalizedString(@"稅局檔號", nil)];

        return [districtArr objectAtIndex:row];
    }else {
        return [_belongDesp objectAtIndex:row];
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    if ([thePickerView isEqual:_pickerViewPopup]) {
        return 19;
    }else if ([thePickerView isEqual:_pickerViewPopupBusiness])
    {
        return 4;
    }
    else {
        return _belongDesp.count;
    }
}


- (void)viewWillDisappear:(BOOL)animated{
    dispatch_async(dispatch_get_main_queue(), ^{
        _fbdata = nil;
        _wbdata = nil;
        _userName.text = @"";
        _lastNameCh.text = @"";
        _lastNameEn.text = @"";
        _nameCh.text = @"";
        _nameEn.text = @"";
        _email.text = @"";
        _passWord.text = @"";
        _confirmPsw.text = @"";
        _belongLabel.text = EGLocalizedString(@"Register_belongto", nil);
        
        _textField2.text=@"";
        _textField3.text=@"";
        _textField1.text=@"";
    });
}

- (void)viewDidDisappear:(BOOL)animated
{
   // MyLog(@"viewDidDisappear");
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:@"0" forKey:@"FACEBOOK_REG_REQ"];
    [standardUserDefaults setObject:@"0" forKey:@"WEIBO_REG_REQ"];
    [standardUserDefaults synchronize];
}

- (void)leftAction{
    _isSuccessful = NO;
    _isSuccessful1 = NO;
    
    _passWord.text = @"";
    _passWord.placeholder = EGLocalizedString(@"Register_mpwsTextfile", nil);
    _passWord.enabled = YES;
    //_passWord.hidden = YES;
    _confirmPsw.text = @"";
    _confirmPsw.placeholder = EGLocalizedString(@"Register_comfirmpwsTextfile", nil);
    _confirmPsw.enabled = YES;
    
    _textField2.enabled=YES;
    _textField3.enabled=YES;
    _textField2.placeholder=EGLocalizedString(@"Register_mpwsTextfile", nil);
    _textField3.placeholder=EGLocalizedString(@"Register_comfirmpwsTextfile", nil);
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 创建页面UI
- (void)createRegisterUI{
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenSize.width, 35)];
    topView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.view addSubview:topView];
    
    _personalView = [[UIView alloc] initWithFrame:CGRectMake(0, 32, ScreenSize.width/2, 3)];
    _personalView.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    [topView addSubview:_personalView];
    
    _organizationView = [[UIView alloc] initWithFrame:CGRectMake(ScreenSize.width/2, 32, ScreenSize.width/2,3)];
    _organizationView.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    _organizationView.hidden = YES;
    [topView addSubview:_organizationView];
    __weak typeof(self) weakSelf = self;
    
    _personalButton = [self.view addImageButtonWithFrame:CGRectMake(0, 68, ScreenSize.width/2, 28) title:EGLocalizedString(@"Register_personalButton_title", nil) backgroud:nil action:^(UIButton *button) {
        weakSelf.pickerViewPopupBelongTo.hidden = YES;
        weakSelf.pickerViewPopup.hidden = YES;
        
        weakSelf.personalView.hidden = NO;
        weakSelf.organizationView.hidden = YES;
        weakSelf.orgCommitButton.hidden = YES;
        weakSelf.commitButton.hidden = NO;
        [weakSelf.organizationButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [weakSelf.organizationButton setImage:[UIImage imageNamed:@"registration_company_nor.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"registration_person_sel.png"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1] forState:UIControlStateNormal];
        [weakSelf.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }];
    [_personalButton setTitleColor:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1] forState:UIControlStateNormal];
    _personalButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_personalButton setImage:[UIImage imageNamed:@"registration_person_sel.png"] forState:UIControlStateNormal];
    
    _organizationButton = [self.view addImageButtonWithFrame:CGRectMake(ScreenSize.width/2, 68, ScreenSize.width/2, 28*Scene_Scale.y) title:EGLocalizedString(@"Register_organizationButton_title", nil) backgroud:nil action:^(UIButton *button) {
        weakSelf.pickerViewPopupBelongTo.hidden = YES;
        weakSelf.pickerViewPopup.hidden = YES;
        
        weakSelf.personalView.hidden = YES;
        weakSelf.organizationView.hidden = NO;
        weakSelf.orgCommitButton.hidden = NO;
        weakSelf.commitButton.hidden = YES;
        [weakSelf.personalButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [weakSelf.personalButton setImage:[UIImage imageNamed:@"registration_person_nor.png"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"registration_company_sel.png"] forState:UIControlStateNormal];
        [weakSelf.scrollView setContentOffset:CGPointMake(ScreenSize.width, 0) animated:YES];
    }];
    _organizationButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_organizationButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_organizationButton setImage:[UIImage imageNamed:@"registration_company_nor.png"] forState:UIControlStateNormal];
  
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, ScreenSize.width, ScreenSize.height-30)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(ScreenSize.width*2,0);
    [self.view addSubview:_scrollView];
    
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];

    //个人登入页面
    _one = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height-35)];
    _one.bounces = NO;
    _one.showsVerticalScrollIndicator = NO;
    _one.contentSize = CGSizeMake(ScreenSize.width, 580 + 100);
    //    one.hidden = YES;
    [_scrollView addSubview:_one];
    //加载个人登入页面xib文件
    NSArray * arr1 = [[NSBundle mainBundle] loadNibNamed:@"PersonalLogin" owner:nil options:nil];
    _oneView = arr1[0];
    _oneView.userInteractionEnabled = YES;
    _oneView.frame = CGRectMake(0, 0, ScreenSize.width, ScreenSize.height+200);
    [_one addSubview:_oneView];
    [_oneView addGestureRecognizer:tap0];
    
//    self.LoadScrollView = [[[NSBundle mainBundle] loadNibNamed:@"RegisterAlertView" owner:self options:nil] objectAtIndex:0];
//    [[[UIApplication sharedApplication] keyWindow] addSubview:self.LoadScrollView];
    
    //获取个人登入页面TextField
    _userName = [[UITextField alloc]init];
    _userName = (UITextField *)[self.view viewWithTag:1];
    _userName.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _userName.placeholder = EGLocalizedString(@"Register_userNameTextfile", nil);
    
    if (_fbdata != nil) {
//        NSString *fbemail = [_fbdata objectForKey:@"email"];
//        NSString *fbemailname = [fbemail componentsSeparatedByString:@"@"][0];
        _userName.text = [_fbdata objectForKey:@"name"];
    }
    
    _passWord = [[UITextField alloc]init];
    _passWord = (UITextField *)[self.view viewWithTag:2];
    _passWord.placeholder = EGLocalizedString(@"Register_mpwsTextfile", nil);
    
    _confirmPsw = [[UITextField alloc]init];
    _confirmPsw = (UITextField *)[self.view viewWithTag:3];
    _confirmPsw.placeholder = EGLocalizedString(@"Register_comfirmpwsTextfile", nil);
    
    UILabel * pswnoteLabel = (UILabel *)[self.view viewWithTag:77];
    pswnoteLabel.text = EGLocalizedString(@"Register_noteLabel_title", nil);
    
    _lastNameCh = [[UITextField alloc]init];
    _lastNameCh = (UITextField *)[self.view viewWithTag:4];
    _lastNameCh.placeholder = EGLocalizedString(@"Register_lastNameCh", nil);
    
    _nameCh = [[UITextField alloc]init];
    _nameCh = (UITextField *)[self.view viewWithTag:5];
    _nameCh.placeholder = EGLocalizedString(@"Register_nameCh", nil);
    
    _lastNameEn = [[UITextField alloc]init];
    _lastNameEn = (UITextField *)[self.view viewWithTag:6];
    _lastNameEn.placeholder = EGLocalizedString(@"Register_lastNameEn", nil);
    
    _nameEn = [[UITextField alloc]init];
    _nameEn = (UITextField *)[self.view viewWithTag:7];
    _nameEn.placeholder = EGLocalizedString(@"Register_nameEh", nil);
    
    if (_fbdata != nil) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self moveViews];
            
        });
        
        NSString *fbname = [_fbdata objectForKey:@"name"];
        NSArray *fbnameparts = [fbname componentsSeparatedByString:@" "];
        if ([self isZhongWenFirst:fbnameparts[0]]) {
            _lastNameCh.text = fbnameparts[0];
        }else{
        
            _lastNameEn.text = fbnameparts[0];
        }
    }
    
    if (_fbdata != nil) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self moveViews];
        });
        
        NSString *fbname = [_fbdata objectForKey:@"name"];
        NSArray *fbnameparts = [fbname componentsSeparatedByString:@" "];
        if ([fbnameparts count] > 1) {
            if ([self isZhongWenFirst:fbnameparts[1]]) {
                
                _nameCh.text = fbnameparts[1];
            }else{
            
                _nameEn.text = fbnameparts[1];
            }
        }
    }
    
    _email = [[UITextField alloc]init];
    _email = (UITextField *)[self.view viewWithTag:8];
    _email.placeholder = EGLocalizedString(@"Register_email", nil);
    
    UILabel * emailNoteLabel = (UILabel *)[self.view viewWithTag:40];
    emailNoteLabel.text = EGLocalizedString(@"Register_org_noteLabel1_title", nil);
    
    if (_fbdata != nil) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self moveViews];
        });
        NSString *fbemail = [_fbdata objectForKey:@"email"];
        _email.text = fbemail;
    }
    
    if (_wbdata != nil) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self moveViews];
        });
        
        // TODO WEIBO EMAIL
        // NSString *wbemail = [_fbdata objectForKey:@"email"];
        // NSString *wbemailname = [wbemail componentsSeparatedByString:@"@"][0];
        NSString *wbname = [_wbdata objectForKey:@"userName"];
        _userName.text = wbname;
        _textField1.text=wbname;
        
    }
    
//    if (_wbdata != nil) {
//        NSString *wbname = [_wbdata objectForKey:@"userName"];
//        NSArray *wbnameparts = [wbname componentsSeparatedByString:@" "];
//        _lastNameCh.text = wbnameparts[0];
//        _lastNameEn.text = wbnameparts[0];
//    }
//    if (_wbdata != nil) {
//        NSString *wbname = [_wbdata objectForKey:@"userName"];
//        NSArray *wbnameparts = [wbname componentsSeparatedByString:@" "];
//        if ([wbnameparts count] > 1) {
//            _nameCh.text = wbnameparts[1];
//            _nameEn.text = wbnameparts[1];
//        }
//    }
    if (_wbdata != nil){
        NSString *wbemail = [_fbdata objectForKey:@"email"];
        _email.text = wbemail;
    }
    if (_wbdata == nil && _wbdata == nil) {
        _passWord.text = @"";
        _passWord.text = @"";
        _confirmPsw.placeholder = EGLocalizedString(@"Register_comfirmpwsTextfile", nil);
        _passWord.placeholder = EGLocalizedString(@"Register_mpwsTextfile", nil);
    }
    
    _belongTo = [[UITextField alloc]init];
    _belongTo.placeholder = EGLocalizedString(@"Register_belongto", nil);
    _belongTo = (UITextField *)[self.view viewWithTag:9];
    UIView *RedView = [UIView new];
    RedView.backgroundColor = [UIColor redColor];
    RedView.frame = (CGRect){0,0,100,30};
    NSArray * options = _model.BelongToOptions[@"options"];
   // MyLog(@"optionsoptionsoptions = %@", options);
    _belongDesp = [[NSMutableArray alloc] init];
    _belongCd = [[NSMutableArray alloc] init];
    
    UILabel * noteLabel = (UILabel *)[self.view viewWithTag:1234];
    noteLabel.numberOfLines=0;
    noteLabel.text = EGLocalizedString(@"Register_IsEmailNote", nil);
    
    for (NSDictionary * opDict in options) {
        
        [_belongDesp addObject:opDict[@"Desp"]];
        [_belongCd addObject:opDict[@"Cd"]];
    }
    
//    NSArray * ageArr = @[_belongDesp];
//    _downMenu = [[EGDropDownMenu alloc] initWithFrame:CGRectMake(21, 285, ScreenSize.width-42, 23) Array:ageArr selectedColor:[UIColor grayColor]];
//    _downMenu.delegate = self;
//    [_oneView addSubview:_downMenu];
    _pickerViewPopupBelongTo = [[UIPickerView alloc] initWithFrame:CGRectMake(0, ScreenSize.height - 200 + ((IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) ? 20 : 0), ScreenSize.width , 200)];
    _pickerViewPopupBelongTo.delegate = self;
    _pickerViewPopupBelongTo.showsSelectionIndicator = YES;
    _pickerViewPopupBelongTo.hidden = YES;
    _pickerViewPopupBelongTo.backgroundColor = [UIColor whiteColor];
    [_pickerViewPopupBelongTo selectRow:selectedBelongTo inComponent:0 animated:YES];
    [self.view addSubview:_pickerViewPopupBelongTo];


    
//    UIButton *_belongBtn = [_oneView addImageButtonWithFrame:CGRectMake(0, 280, ScreenSize.width, 30) title:nil backgroud:nil action:^(UIButton *button) {
//    
//        _pickerViewPopupBelongTo.hidden = NO;
//    }];
//    
//    _belongLabel = [_oneView addLabelWithFrame:CGRectMake(20, 303, ScreenSize.width-40, 25) text: [NSString stringWithFormat:@"  %@",EGLocalizedString(@"Register_belongto", nil)]];
//    _belongLabel.font = [UIFont systemFontOfSize:13];
//    _belongLabel.textColor = [UIColor grayColor];
//    
    
    _belongLabel = (UILabel *)[_oneView viewWithTag:70];
    _belongLabel.userInteractionEnabled=YES;
    _belongLabel.text = EGLocalizedString(@"Register_belongto", nil);
    _belongLabel.font = [UIFont systemFontOfSize:13];
    _belongLabel.textColor = [UIColor grayColor];
    UITapGestureRecognizer *belongLabeltap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(belongLabeltapAction)];
    [_belongLabel addGestureRecognizer:belongLabeltap];

    
    _mrButton = (UIButton *)[_oneView viewWithTag:101];
    [_mrButton setTitle:EGLocalizedString(@"先生/Mr.", nil) forState:UIControlStateNormal];
    [_mrButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_left_sel.png"] forState:UIControlStateSelected];
    [_mrButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_mrButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    [_mrButton addTarget:self action:@selector(sexAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _mrsButton = (UIButton *)[_oneView viewWithTag:102];
    [_mrsButton setTitle:EGLocalizedString(@"女士/Mrs.", nil) forState:UIControlStateNormal];
    [_mrsButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_middle_sel.png"] forState:UIControlStateSelected];
    [_mrsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_mrsButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    [_mrsButton addTarget:self action:@selector(sexAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _missButton = (UIButton *)[_oneView viewWithTag:103];
    [_missButton setTitle:EGLocalizedString(@"小姐/Miss.", nil) forState:UIControlStateNormal];
    [_missButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_right_sel.png"] forState:UIControlStateSelected];
    [_missButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_missButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    [_missButton addTarget:self action:@selector(sexAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_fbdata != nil) {
        NSString *gender = [_fbdata objectForKey:@"gender"];
        if (![gender isEqualToString:@"male"]) {
            _missButton.selected = YES;
            _sexType = @"M";
        }
    } else if (_wbdata != nil) {
        NSString *gender = [_wbdata objectForKey:@"gender"];
        if (![gender isEqualToString:@"m"]) {
            _missButton.selected = YES;
            _sexType = @"M";
        }
    } else {
        _mrButton.selected = YES;
    }
    
    //是否允许收到电邮资讯按钮 － 是
    _isEmailButton = (UIButton *)[_oneView viewWithTag:104];
    [_isEmailButton setTitle:EGLocalizedString(@"Register_isEmailButton_title", nil) forState:UIControlStateNormal];
    [_isEmailButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_middle_sel.png"] forState:UIControlStateSelected];
    [_isEmailButton addTarget:self action:@selector(isEmailButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //是否允许收到电邮资讯按钮 － 否
    _noEmailButton = (UIButton *)[_oneView viewWithTag:105];
    [_noEmailButton setTitle:EGLocalizedString(@"Register_noEmailButton_title", nil) forState:UIControlStateNormal];
    //_noEmailButton.selected=YES;
    [_noEmailButton setTitleColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:62/255.0 alpha:1] forState:UIControlStateNormal];
   //[_noEmailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _isEamil = NO;
    [_noEmailButton addTarget:self action:@selector(isEmailButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_noEmailButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_middle_sel.png"] forState:UIControlStateSelected];
    
    //创建点击“是”按钮弹出的视图
    _emailView = [[UIView alloc] initWithFrame:CGRectMake(20, 380, ScreenSize.width-40, 200)];
    _emailView.backgroundColor = [UIColor whiteColor];
    _emailView.hidden = YES;
    [_oneView addSubview:_emailView];
    
    UILabel * emailViewTitle = [_emailView addLabelWithFrame:CGRectMake(0, 0, 300, 40) text:EGLocalizedString(@"请选取你喜欢的专案类别(可选择多项):", nil)];
    emailViewTitle.font = [UIFont systemFontOfSize:14];
    emailViewTitle.numberOfLines = 2;
    emailViewTitle.textColor = [UIColor grayColor];
    

    _arr = [[NSMutableArray alloc] init];
    NSArray * emailViewTitleArray = @[EGLocalizedString(@"助学", nil),EGLocalizedString(@"安老", nil),EGLocalizedString(@"助医", nil),EGLocalizedString(@"扶贫", nil),EGLocalizedString(@"紧急援助", nil),EGLocalizedString(@"其他", nil),EGLocalizedString(@"意赠行动", nil),EGLocalizedString(@"全部", nil)];
    for (int i = 0; i < 8; i ++) {
        _typeButton = [_emailView addImageButtonWithFrame:CGRectMake(i%2*(ScreenSize.width/2), i/2*45+38, 20, 20) title:nil backgroud:@"cart_checkbox_nor.png" action:^(UIButton *button) {
            
            if (button.tag == 110) {
                UIButton *btn = [weakSelf.emailView viewWithTag:117];
                btn.selected=NO;
                [_arr removeObject:@"L,"];
                
                if (button.selected) {
                    button.selected = NO;
                    [_arr removeObject:@"S,"];
                }else{
                button.selected = YES;
                [_arr addObject:@"S,"];
                }
                
            }else if (button.tag == 111){
                UIButton *btn = [weakSelf.emailView viewWithTag:117];
                btn.selected=NO;
                [_arr removeObject:@"L,"];
                if (button.selected) {
                    button.selected = NO;
                     [_arr removeObject:@"E,"];
                }else{
                    button.selected = YES;
                    [_arr addObject:@"E,"];
                }
                
            }else if (button.tag == 112){
                UIButton *btn = [weakSelf.emailView viewWithTag:117];
                btn.selected=NO;
                [_arr removeObject:@"L,"];
                if (button.selected) {
                    button.selected = NO;
                     [_arr removeObject:@"M,"];
                }else{
                    button.selected = YES;
                    [_arr addObject:@"M,"];
                }
                
            }else if (button.tag == 113){
                UIButton *btn = [weakSelf.emailView viewWithTag:117];
                btn.selected=NO;
                [_arr removeObject:@"L,"];
                if (button.selected) {
                    button.selected = NO;
                     [_arr removeObject:@"P,"];
                }else{
                    button.selected = YES;
                     [_arr addObject:@"P,"];
                }
                
            }else if (button.tag == 114){
                UIButton *btn = [weakSelf.emailView viewWithTag:117];
                btn.selected=NO;
                [_arr removeObject:@"L,"];
                if (button.selected) {
                    button.selected = NO;
                     [_arr removeObject:@"U,"];
                }else{
                    button.selected = YES;
                     [_arr addObject:@"U,"];
                }
                
            }else if (button.tag == 115){
                UIButton *btn = [weakSelf.emailView viewWithTag:117];
                btn.selected=NO;
                [_arr removeObject:@"L,"];
                if (button.selected) {
                    button.selected = NO;
                     [_arr removeObject:@"O,"];
                }else{
                    
                    button.selected = YES;
                     [_arr addObject:@"O,"];
                }
                

            }else if (button.tag == 116){
                UIButton *btn = [weakSelf.emailView viewWithTag:117];
                btn.selected=NO;
                [_arr removeObject:@"L,"];
                if (button.selected) {
                    button.selected = NO;
                     [_arr removeObject:@"A,"];
                }else{
                    button.selected = YES;
                     [_arr addObject:@"A,"];
                }
                
            }else if (button.tag == 117){
                if (button.selected){
                    for (int i = 0; i < 8; i ++) {
                        UIButton * button = (UIButton *)[self.view viewWithTag:110+i];
                        button.selected = NO;
                    }
                     [_arr removeAllObjects];
                    
                }else{
                    for (int i = 0; i < 8; i ++) {
                        UIButton * button = (UIButton *)[self.view viewWithTag:110+i];
                        button.selected = YES;
                    }
                    [_arr removeAllObjects];
                    NSArray * DonationInterest = @[@"S",@"E",@"M",@"P",@"U",@"O",@"A",@"L"];
                    for (int j=0; j<DonationInterest.count; j++) {
                        NSString *str = [NSString stringWithFormat:@"%@,",DonationInterest[j]];
                        [_arr addObject:str];
                        
                    }

                }
                
            }
    
        }];
        _typeButton.tag = 110+i;
        [_typeButton setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
        
        UILabel * label = [_emailView addLabelWithFrame:CGRectMake(i%2*(ScreenSize.width/2)+25, i/2*45+28, 80, 40) text:emailViewTitleArray[i]];
        label.numberOfLines = 2;
        label.font = [UIFont boldSystemFontOfSize:12];
        
    }
    
    //义工选项视图
    _volunteerView = [[UIView alloc] initWithFrame:CGRectMake(20, 465, ScreenSize.width-40, 800)];
    _volunteerView.hidden = YES;
    [_oneView addSubview:_volunteerView];
    
    UITapGestureRecognizer * voTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_volunteerView addGestureRecognizer:voTap];
    
    [self createVoView]; //义工选项UI
    _note = [_oneView addLabelWithFrame:CGRectMake(20, 390, ScreenSize.width-40, 70) text:EGLocalizedString(@"Register_noteLabel3_title", nil)];
    _note.numberOfLines = 0;
    _note.font = [UIFont systemFontOfSize:14];
    // “愿意”按钮
    _yButton = [_oneView addImageButtonWithFrame:CGRectMake(20, 460, ScreenSize.width/2-20, 25) title:EGLocalizedString(@"Register_yButton_title", nil) backgroud:@"comment_segment_left_nor.png" action:^(UIButton *button) {
        
        _telField.hidden = NO;
        _telDistrictField.hidden = NO;
        
        _nButton.selected = NO;
        button.selected = YES;

       
    } ];
    _yButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _yButton.layer.cornerRadius = 4;
    [_yButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_left_sel.png"] forState:UIControlStateSelected];
    [_yButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_yButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    //”暂不考虑“按钮
    _nButton = [_oneView addImageButtonWithFrame:CGRectMake(ScreenSize.width/2, 460, ScreenSize.width/2-20, 25) title:EGLocalizedString(@"Register_nButton_title", nil) backgroud:@"comment_segment_right_nor.png" action:^(UIButton *button) {
        
        _telField.hidden = YES;
        _telDistrictField.hidden = YES;
        _telField.text = @"";
        _telDistrictField.text = @"852";
        
//        _isVolunteer = NO;
        _volunteerView.hidden = YES;
        _yButton.selected = NO;
        button.selected = YES;

        
    }];
    [_nButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_nButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];

    
    _telDistrictField = [[UITextField alloc] initWithFrame:CGRectMake(20, 470, 75, 25)];
    _telDistrictField.text = @"852";
    _telDistrictField.delegate = self;
    _telDistrictField.tag = 913;
    _telDistrictField.keyboardType = UIKeyboardTypeNumberPad;
    _telDistrictField.font = [UIFont systemFontOfSize:12];
    _telDistrictField.borderStyle = UITextBorderStyleRoundedRect;
    _telDistrictField.hidden = YES;
    [_oneView addSubview:_telDistrictField];
    
    _telField = [[UITextField alloc] initWithFrame:CGRectMake(105, 470, ScreenSize.width-125, 25)];
    _telField.placeholder = EGLocalizedString(@"Register_org_number", nil);
    _telField.delegate = self;
    _telField.tag = 813;
    _telField.keyboardType = UIKeyboardTypeNumberPad;
    _telField.font = [UIFont systemFontOfSize:12];
    _telField.borderStyle = UITextBorderStyleRoundedRect;
    _telField.hidden = YES;
    [_oneView addSubview:_telField];
    
    if ( IS_IPAD) {
        
        _telDistrictField.frame = CGRectMake(20, ScreenSize.height+90 , 75, 25);
        _telField.frame = CGRectMake(105, ScreenSize.height+90 , ScreenSize.width-125, 25);
    }
  
    if (IS_IPHONE_4_OR_LESS){
//        _individualButton3.frame = CGRectMake(20, ScreenSize.height - 90, 75, 25);
        _telDistrictField.frame = CGRectMake(20, ScreenSize.height+20 , 75, 25);
        _telField.frame = CGRectMake(105, ScreenSize.height+20 , ScreenSize.width-125, 25);
    }
    
    if (IS_IPHONE_5){
        
        _telDistrictField.frame = CGRectMake(20, ScreenSize.height-60 , 75, 25);
        _telField.frame = CGRectMake(105, ScreenSize.height-60 , ScreenSize.width-125, 25);
    }

    if (IS_IPHONE_6P) {
//        _individualButton3.frame = CGRectMake(20, ScreenSize.height - 260, 75, 25);
        _telDistrictField.frame = CGRectMake(20, ScreenSize.height - 230, 75, 25);
        _telField.frame = CGRectMake(105, ScreenSize.height - 230, ScreenSize.width-125, 25);
    }
    
      if (IS_IPHONE_6) {
        
        _telDistrictField.frame = CGRectMake(20, 500, 75, 25);
        _telField.frame = CGRectMake(105, 500, ScreenSize.width-125, 25);
        
    }
    
    _nButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _nButton.selected = YES;
    _nButton.layer.cornerRadius = 4;
    [_nButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_right_sel.png"] forState:UIControlStateSelected];
    _commitBgView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenSize.height-35, ScreenSize.width, 35)];
    _commitBgView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.view addSubview:_commitBgView];
    //提交按钮
    _commitButton = [_commitBgView addImageButtonWithFrame:CGRectMake(20, 2.5, ScreenSize.width-40, 30) title:EGLocalizedString(@"Register_commitButton_title", nil) backgroud:nil action:^(UIButton *button) {
                    weakSelf.flag = 1;
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSString *faceBookString = [NSString stringWithFormat:@"%@",[standardUserDefaults objectForKey:@"FACEBOOK_REG_REQ"]];
        NSString *weiBoString = [NSString stringWithFormat:@"%@",[standardUserDefaults objectForKey:@"WEIBO_REG_REQ"]];
        
        if ([faceBookString isEqualToString:@"1"] || [weiBoString isEqualToString:@"1"]){
            if (![NSString isEmpty:weakSelf.userName.text andNote:EGLocalizedString(@"请输入登入名称", nil)]){
                if([NSString validateUserName:weakSelf.userName.text]){
                    
                if (([weakSelf.lastNameCh.text isEqualToString:@""]&&[weakSelf.nameCh.text isEqualToString:@""]&&[weakSelf.lastNameEn.text isEqualToString:@""]&&[weakSelf.nameEn.text isEqualToString:@""])){

                                    UIAlertView *alertView = [[UIAlertView alloc] init];
                                    alertView.message = EGLocalizedString(@"请输入中文[姓]", nil);
                                    [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                                    [alertView show];
        
                                }else if (((![weakSelf.lastNameCh.text isEqualToString:@""] && [weakSelf.nameCh.text isEqualToString:@""]) || ([weakSelf.lastNameCh.text isEqualToString:@""] && ![weakSelf.nameCh.text isEqualToString:@""]))){
                                    
                                    if ([weakSelf.lastNameCh.text isEqualToString:@""]){
                                        
                                        UIAlertView *alertView = [[UIAlertView alloc] init];
                                        alertView.message = EGLocalizedString(@"请输入中文[姓]", nil);
                                        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                                        [alertView show];
                                        
                                    }else{
                                        
                                        UIAlertView *alertView = [[UIAlertView alloc] init];
                                        alertView.message = EGLocalizedString(@"FirstNameRegerst", nil);
                                        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                                        [alertView show];
                                        
                                    }
                                    
                                    //weakSelf.lastNameEn.text=@"";
                                    //weakSelf.nameEn.text=@"";
                                    
                                }else if (((![weakSelf.lastNameEn.text isEqualToString:@""]&&[weakSelf.nameEn.text isEqualToString:@""]) || ([weakSelf.lastNameEn.text isEqualToString:@""]&&![weakSelf.nameEn.text isEqualToString:@""])) ){
                                    
                                    if ([weakSelf.lastNameEn.text isEqualToString:@""]) {
                                        UIAlertView *alertView = [[UIAlertView alloc] init];
                                        alertView.message = EGLocalizedString(@"请输入英文[姓]", nil);
                                        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                                        [alertView show];
                                        
                                    }else{
                                        UIAlertView *alertView = [[UIAlertView alloc] init];
                                        alertView.message = EGLocalizedString(@"FirstEnNameRegerst", nil);
                                        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                                        [alertView show];
                                        
                                    }
                                    
                                    
                                }else if ((![weakSelf isZhongWenFirst:weakSelf.lastNameCh.text]&& ![weakSelf.lastNameCh.text isEqualToString:@""] )|| (![weakSelf isZhongWenFirst:weakSelf.nameCh.text]&&![weakSelf.nameCh.text isEqualToString:@""])){
                                    
                                    UIAlertView *alertView = [[UIAlertView alloc] init];
                                    alertView.message = EGLocalizedString(@"chneseName",nil);
                                    [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                                    [alertView show];
                                    
                                }else if (![weakSelf pipeizimu:weakSelf.lastNameEn.text] || ![weakSelf pipeizimu:weakSelf.nameEn.text]){
                                    
                                    UIAlertView *alertView = [[UIAlertView alloc] init];
                                    alertView.message = EGLocalizedString(@"englishName",nil);
                                    [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                                    [alertView show];
                                    
                                }else{
                                    
                                    if (![NSString isEmpty:weakSelf.email.text andNote:EGLocalizedString(@"邮箱不能为空", nil)]){
                                        
                                        if ([NSString isEmail:weakSelf.email.text]){
                                            
                                            if ([weakSelf belong:_isBelongTo]){
                                                
                                                if ([self phoneNumber:_telField.text]) {
                                                  if ([self checkEmailfromEgive]){
                                                    if (_arr.count==0 && _isEamil){
                                                        
                                                        UIAlertView *alertView = [[UIAlertView alloc] init];
                                                        alertView.message = EGLocalizedString(@"请选取您喜欢的专案类别",nil);
                                                        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                                                        [alertView show];
                                                        
                                                    }else{
                                                        
                                                        weakSelf.alertVc.model = weakSelf.model;
                                                        weakSelf.alertVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
                                                        [weakSelf.view.window.rootViewController presentViewController:weakSelf.alertVc animated:YES completion:nil];
                                                    }
                                                    
                                                  }} } }}
                                    
                                
                    
        
                    }
                }}
            
            
        }else{
        
        if (![NSString isEmpty:weakSelf.userName.text andNote:EGLocalizedString(@"请输入登入名称", nil)]){
            if([NSString validateUserName:weakSelf.userName.text]){
        
                    
            if ((_wbdata != nil || _fbdata != nil || ![NSString isEmpty:weakSelf.passWord.text andNote:EGLocalizedString(@"密码不能为空", nil)])){
                
                if ([weakSelf checkPassWordLength:weakSelf.passWord.text]) {
                    
                
                    if ([weakSelf confirmPass:weakSelf.confirmPsw.text]){
                       
                    if ([weakSelf LoginPass:weakSelf.passWord.text andConfirm:weakSelf.confirmPsw.text]){
                        
                     if (([weakSelf.lastNameCh.text isEqualToString:@""]&&[weakSelf.nameCh.text isEqualToString:@""]&&[weakSelf.lastNameEn.text isEqualToString:@""]&&[weakSelf.nameEn.text isEqualToString:@""])){
                         
                            UIAlertView *alertView = [[UIAlertView alloc] init];
                            alertView.message = EGLocalizedString(@"请输入中文[姓]", nil);
                            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                            [alertView show];
                         
    
                     }else if (((![weakSelf.lastNameCh.text isEqualToString:@""] && [weakSelf.nameCh.text isEqualToString:@""]) || ([weakSelf.lastNameCh.text isEqualToString:@""] && ![weakSelf.nameCh.text isEqualToString:@""]))){
                         
                         if ([weakSelf.lastNameCh.text isEqualToString:@""]){
                             
                             UIAlertView *alertView = [[UIAlertView alloc] init];
                             alertView.message = EGLocalizedString(@"请输入中文[姓]", nil);
                             [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                             [alertView show];
                             
                         }else{
                             
                             UIAlertView *alertView = [[UIAlertView alloc] init];
                             alertView.message = EGLocalizedString(@"FirstNameRegerst", nil);
                             [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                             [alertView show];
                             
                          }
                         
                          //weakSelf.lastNameEn.text=@"";
                          //weakSelf.nameEn.text=@"";

                     }else if (((![weakSelf.lastNameEn.text isEqualToString:@""]&&[weakSelf.nameEn.text isEqualToString:@""]) || ([weakSelf.lastNameEn.text isEqualToString:@""]&&![weakSelf.nameEn.text isEqualToString:@""])) ){
                         
                         if ([weakSelf.lastNameEn.text isEqualToString:@""]) {
                             UIAlertView *alertView = [[UIAlertView alloc] init];
                             alertView.message = EGLocalizedString(@"请输入英文[姓]", nil);
                             [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                             [alertView show];
                             
                         }else{
                             UIAlertView *alertView = [[UIAlertView alloc] init];
                             alertView.message = EGLocalizedString(@"FirstEnNameRegerst", nil);
                             [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                             [alertView show];
                             
                         }

                     
                     }else if ((![weakSelf isZhongWenFirst:weakSelf.lastNameCh.text]&& ![weakSelf.lastNameCh.text isEqualToString:@""] )|| (![weakSelf isZhongWenFirst:weakSelf.nameCh.text]&&![weakSelf.nameCh.text isEqualToString:@""])){
                            
                            UIAlertView *alertView = [[UIAlertView alloc] init];
                            alertView.message = EGLocalizedString(@"chneseName",nil);
                            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                            [alertView show];
                         
                        }else if (![weakSelf pipeizimu:weakSelf.lastNameEn.text] || ![weakSelf pipeizimu:weakSelf.nameEn.text]){
                            
                            UIAlertView *alertView = [[UIAlertView alloc] init];
                            alertView.message = EGLocalizedString(@"englishName",nil);
                            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                            [alertView show];
                            
                        }else{
                            
                        if (![NSString isEmpty:weakSelf.email.text andNote:EGLocalizedString(@"邮箱不能为空", nil)]){
                                
                        if ([NSString isEmail:weakSelf.email.text]){
                            
                            if ([weakSelf belong:_isBelongTo]){
                                                
                                if ([self phoneNumber:_telField.text]){
                                if ([self checkEmailfromEgive]){
                                                
                                if (_arr.count==0 && _isEamil){
                                                    
                                                    UIAlertView *alertView = [[UIAlertView alloc] init];
                                                    alertView.message = EGLocalizedString(@"请选取您喜欢的专案类别",nil);
                                                    [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                                                    [alertView show];
                                                    
                                }else{
                                    
                                                weakSelf.alertVc.model = weakSelf.model;
                                                weakSelf.alertVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
                                                [weakSelf.view.window.rootViewController presentViewController:weakSelf.alertVc animated:YES completion:nil];
                                }
                                
                            }
//                                                if (!weakSelf.isSuccessful1){
//            
//                                                    [weakSelf PostIndividualUserInfo];
//            
//                                                }else{
//                                                    
//                                                    weakSelf.alertVc.model = weakSelf.model;
//                                                    weakSelf.alertVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//                                                    [weakSelf.view.window.rootViewController presentViewController:weakSelf.alertVc animated:YES completion:nil];
                                                  // }
                                                
                                                }} }//else{
//                                                UIAlertView *alertView = [[UIAlertView alloc] init];
//                                                alertView.message = EGLocalizedString(@"请选择所属机构", nil);
//                                                [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
//                                                [alertView show];
            
                                            //}
            
                                        }
            
                                    }
                                }
                               }//else{
//                                UIAlertView *alertView = [[UIAlertView alloc] init];
//                                alertView.message = EGLocalizedString(@"密码不一致", nil);
//                                [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
//                                [alertView show];
//                            }
                        }
            }}}}
   
        }];
    
    [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _commitButton.layer.cornerRadius = 2;
    _commitButton.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    
//    NSArray * arr = [[NSBundle mainBundle] loadNibNamed:@"OrganizationLogin" owner:nil options:nil];
//    _twoView = arr[0];
//    _twoView.frame = CGRectMake(0, 0, ScreenSize.width, _twoView.bounds.size.height);
    
    //机构登入页面
    _twoScrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(ScreenSize.width, 0, ScreenSize.width, ScreenSize.height-35)];
    //    scrollView.pagingEnabled = YES;
    _twoScrollView.bounces = NO;
    _twoScrollView.userInteractionEnabled = YES;
    _twoScrollView.showsVerticalScrollIndicator = NO;
    [_scrollView addSubview:_twoScrollView];
    
    [self createOrganizationLoginUI];

    _twoScrollView.contentSize = CGSizeMake(0,1075+20);
    [_twoScrollView addGestureRecognizer:tap];
    
    [self EntrisethirdPartyLogin];
    [self setTextFieldDelegate];
    
}


-(BOOL)checkOrganizationEmailfromEgive{


    if ( _orgButton5.selected==NO && _orgButton55.selected==NO) {
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"receivenewsandupdatefromEgive", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        return false;
    }
    
    return true;

}
-(BOOL)checkEmailfromEgive{

    if (_noEmailButton.selected==NO && _isEmailButton.selected==NO) {
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"receivenewsandupdatefromEgive", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        return false;
    }

    return true;

}

-(BOOL)checkPassWordLength:(NSString*)PassString{
   
    if (PassString.length<6) {
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"密码最少需要6个字元", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
        
    }else{
    
       
        return true;
    
    }

}

//-(BOOL)checkUserNameForenterprise:(NSString*)userName{
//  
//    [self PostEnterpriseUserInfo];
//    //MyLog(@"%d",_userNameLoginFlag);
//    
//    return _userNameLoginFlag;
//
//
//
//}
//
////验证用户名是否已经被注册
//-(BOOL)checkUserName:(NSString*)userName{
//    
//    [self PostIndividualUserInfo];
//    //MyLog(@"%d",_userNameLoginFlag);
//    
//    return _userNameLoginFlag;
//    
//}

-(BOOL)confirmPass:(NSString*)ConfirmPass{

    if ([ConfirmPass isEqualToString:@""]){
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"请输入确认密码", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
        
    }else{
        
        return true;
    }

}

-(BOOL)LoginPass:(NSString*)loginPass andConfirm:(NSString*)ConfirmPass{
   
    if (![loginPass isEqualToString:ConfirmPass]){
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"密码不一致", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
        
    }else{
    
        return true;
    }

}
-(BOOL)phoneNumber:(NSString*)phone{
   
    
   // MyLog(@"%@",phone);
    if ([phone isEqualToString:@""] && self.yButton.selected) {
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"请输入[联络电话]", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
        
    }else{
    
        return true;
    }
  
}

-(BOOL)belong:(BOOL)belong{
  
    if (!belong) {
       
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"请选择所属机构", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
        
    }else{
    
    
        return true;
    }
}


-(void)belongLabeltapAction{

     _pickerViewPopupBelongTo.hidden = NO;

}
-(void)dismissKeyboard {
    [_editing resignFirstResponder];

    _pickerViewPopupBelongTo.hidden = YES;
     _pickerViewPopup.hidden = YES;
    _pickerViewPopupBusiness.hidden = YES;

    [self tapResetFram];

}
-(void)tapResetFram{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
}

#pragma mark - 机构登记
- (void)createOrganizationLoginUI{
    
    __weak typeof(self) weakSelf = self;
    NSArray * buttonTitle = @[EGLocalizedString(@"企業", nil),EGLocalizedString(@"社團組織", nil),EGLocalizedString(@"非牟利組織", nil),EGLocalizedString(@"其他", nil)];
    NSArray * norBg = @[@"comment_segment_left_nor.png",@"comment_segment_middle_nor.png",@"comment_segment_middle_nor.png",@"comment_segment_right_nor.png"];
    NSArray * selBg = @[@"comment_segment_left_sel.png",@"comment_segment_middle_sel.png",@"comment_segment_middle_sel.png",@"comment_segment_right_sel.png",];
    
    //获取商业登记类型数据
    NSArray * options = _model.BusinessRegistrationTypeOptions[@"options"];
    _registrationTypeOptions = [[NSMutableArray alloc] init];
    for (NSDictionary * opDict in options) {
    
        NSDictionary * dict = [[NSDictionary alloc]initWithObjectsAndKeys:opDict[@"Desp"],@"Desp",opDict[@"Cd"],@"Cd",nil];
        [_registrationTypeOptions addObject:dict];
    }

    int width = (ScreenSize.width-40)/4;
    for (int i = 0; i < 4; i ++){
        _orgButton1 = [_twoScrollView addImageButtonWithFrame:CGRectMake(i*width+20, 10, width, 25) title:buttonTitle[i] backgroud:norBg[i] action:^(UIButton *button) {
            
            for (int i = 0; i < _registrationTypeOptions.count; i++) {
                UIButton * button = (UIButton *)[weakSelf.twoScrollView viewWithTag:30+i];
                button.selected = NO;
            }
            
            if (button.tag == 30) {
                //_isOther=NO;
                 weakSelf.selBtn.text=@"";
                button.selected = YES;
                weakSelf.testView.hidden = YES;
                weakSelf.BusinessRegistrationType = @"B";
//                NSDictionary * dict = weakSelf.registrationTypeOptions[i+2];
//                weakSelf.textField6.placeholder = dict[@"Desp"];
                weakSelf.textField6.placeholder = EGLocalizedString(@"商业登记号码", nil);
                weakSelf.textField6.hidden = NO;
                weakSelf.CorporationType = @"C";
                [weakSelf resetFram];
                weakSelf.lineView.frame = CGRectMake(10, 225, ScreenSize.width-20, 2);
            }else if (button.tag == 31){
                //_isOther=NO;
               // MyLog(@"button.tag = %ld", (long)button.tag);
                 weakSelf.selBtn.text=@"";
                weakSelf.testView.hidden = YES;
                weakSelf.BusinessRegistrationType = @"C";
                button.selected = YES;
//                NSDictionary * dict = weakSelf.registrationTypeOptions[i+2];
//                weakSelf.textField6.placeholder = dict[@"Desp"];
                weakSelf.textField6.placeholder = EGLocalizedString(@"香港社团注册证明书编号", nil);
                weakSelf.textField6.hidden = NO;
                weakSelf.CorporationType = @"O";
                [weakSelf resetFram];
                weakSelf.lineView.frame = CGRectMake(10, 225, ScreenSize.width-20, 2);
            }else if (button.tag == 32){
                //_isOther=NO;
               // MyLog(@"button.tag = %ld", (long)button.tag);
                 weakSelf.selBtn.text=@"";
                weakSelf.testView.hidden = YES;
                weakSelf.BusinessRegistrationType = @"T";
                button.selected = YES;
//                weakSelf.textField66.hidden = YES;
//                NSDictionary * dict = weakSelf.registrationTypeOptions[i+2];
//                weakSelf.textField6.placeholder = dict[@"Desp"];
                weakSelf.textField6.placeholder = EGLocalizedString(@"税局档号", nil);
                weakSelf.textField6.hidden = NO;
                weakSelf.CorporationType = @"N";
                weakSelf.lineView.frame = CGRectMake(10, 225, ScreenSize.width-20, 2);
                [weakSelf resetFram];
            
            }else{
                 weakSelf.selBtn.text=EGLocalizedString(@"不適用", nil);
               // MyLog(@"button.tag = %ld", (long)button.tag);
                _isOther = YES;
                weakSelf.BusinessRegistrationType = @"";
                weakSelf.testView.hidden = NO;
                weakSelf.CorporationType = @"E";
                button.selected = YES;
//                weakSelf.textField6.placeholder = EGLocalizedString(@"稅局檔號", nil);
                weakSelf.textField6.hidden = YES;
                weakSelf.otherText1 = [[UITextField alloc] initWithFrame:CGRectMake(20, 45, ScreenSize.width-40, 25)];
                weakSelf.otherText1.placeholder = EGLocalizedString(@"请说明", nil);
                [weakSelf.otherText1 setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
                weakSelf.otherText1.delegate = weakSelf;
                weakSelf.otherText1.font = [UIFont systemFontOfSize:12];
                weakSelf.otherText1.borderStyle = UITextBorderStyleRoundedRect;
                [weakSelf.twoScrollView addSubview:weakSelf.otherText1];
                
                [weakSelf touchNoButtonAction]; //收起电邮资讯选项
                
                weakSelf.twoScrollView.contentSize = CGSizeMake(0,1075+70+20);
//                weakSelf.orgCommitButton.frame = CGRectMake(20, 940+70, ScreenSize.width-40, 30);
                weakSelf.view1.frame = CGRectMake(0, 40+35, ScreenSize.width, 230);
                weakSelf.view2.frame = CGRectMake(0, 270+70, ScreenSize.width, 580+50);
                weakSelf.view3.frame = CGRectMake(0, 850+70+50, ScreenSize.width, 80);
//                weakSelf.lineView.frame = CGRectMake(10, 225 - 35, ScreenSize.width-20, 2);
                weakSelf.lineView.frame = CGRectMake(10, 225+70, ScreenSize.width-20, 2);
            }
            
        }];
        _orgButton1.tag = 30+i;
        _orgButton1.titleLabel.font = [UIFont systemFontOfSize:13];
        [_orgButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_orgButton1 setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
        [_orgButton1 setBackgroundImage:[UIImage imageNamed:selBg[i]] forState:UIControlStateSelected];
        if (i == 0) {
            _orgButton1.selected = YES;
        }
    }
    


    _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 40, ScreenSize.width, 230)];
//    _view1.backgroundColor = [UIColor orangeColor];
    [_twoScrollView addSubview:_view1];
    
    _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, ScreenSize.width-40, 30)];
    _textField1.placeholder = EGLocalizedString(@"Register_userNameTextfile", nil);
    _textField1.delegate = self;
    _textField1.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    _textField1.tag = 801;
    _textField1.font = [UIFont systemFontOfSize:14];
    _textField1.borderStyle = UITextBorderStyleRoundedRect;
    NSString *wbname = [_wbdata objectForKey:@"userName"];
    //  MyLog(@"wbname wbname = %@", wbname);
    [_view1 addSubview:_textField1];
    
    _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(20, 50, ScreenSize.width/2-25, 30)];
    _textField2.placeholder = EGLocalizedString(@"Register_mpwsTextfile", nil);
    _textField2.delegate = self;
    _textField2.tag = 802;
    _textField2.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [_textField2 setSecureTextEntry:YES];
    _textField2.font = [UIFont systemFontOfSize:14];
    _textField2.borderStyle = UITextBorderStyleRoundedRect;
    [_view1 addSubview:_textField2];
    
    _textField3 = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2+5, 50, ScreenSize.width/2-25, 30)];
    _textField3.placeholder = EGLocalizedString(@"Register_comfirmpwsTextfile", nil);
    _textField3.delegate = self;
    _textField3.tag = 803;
    _textField3.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [_textField3 setSecureTextEntry:YES];
    _textField3.font = [UIFont systemFontOfSize:14];
    _textField3.borderStyle = UITextBorderStyleRoundedRect;
    [_view1 addSubview:_textField3];
    
    UILabel * label1 = [_view1 addLabelWithFrame:CGRectMake(20, 75, ScreenSize.width-40, 40) text:EGLocalizedString(@"Register_noteLabel_title", nil)];
    label1.numberOfLines=2;
    label1.textColor = [UIColor grayColor];
    label1.font = [UIFont systemFontOfSize:14];
    
    _textField4 = [[UITextField alloc] initWithFrame:CGRectMake(20, 115, ScreenSize.width-40, 30)];
    _textField4.placeholder = EGLocalizedString(@"Register_org_orgNameCh_textFile", nil);
    _textField4.delegate = self;
    _textField4.tag = 804;
    _textField4.font = [UIFont systemFontOfSize:14];
    _textField4.borderStyle = UITextBorderStyleRoundedRect;
    [_view1 addSubview:_textField4];
    
    _textField5 = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, ScreenSize.width-40, 30)];
    _textField5.placeholder = EGLocalizedString(@"Register_org_orgNameEn_textFile", nil);
    _textField5.delegate = self;
    _textField5.tag = 805;
    _textField5.font = [UIFont systemFontOfSize:14];
    _textField5.borderStyle = UITextBorderStyleRoundedRect;
    [_view1 addSubview:_textField5];
    

    _textField6 = [[UITextField alloc] initWithFrame:CGRectMake(20, 185, ScreenSize.width-40, 30)];
    _textField6.placeholder = EGLocalizedString(@"商业登记编号", nil);
    _textField6.delegate = self;
    _textField6.tag = 806;
    _textField6.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _textField6.font = [UIFont systemFontOfSize:14];
    _textField6.borderStyle = UITextBorderStyleRoundedRect;
    [_view1 addSubview:_textField6];

    _lineView = [_view1 addImageViewWithFrame:CGRectMake(10, 225, ScreenSize.width-20, 2) image:@"Line@2x.png"];

    
    //第二个view 从联络人姓名 —— "是否"按钮
    _view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 270, ScreenSize.width, 580+50)];
//    _view2.backgroundColor = [UIColor yellowColor];
    _view2.userInteractionEnabled = YES;
    [_twoScrollView addSubview:_view2];
    
    UILabel * label2 = [_view2 addLabelWithFrame:CGRectMake(20, 5, ScreenSize.width/2, 25) text:EGLocalizedString(@"聯絡人姓名", nil)];
    label2.font = [UIFont boldSystemFontOfSize:15];
    
    NSArray * orgTitle = @[EGLocalizedString(@"先生/Mr.", nil),EGLocalizedString(@"女士/Mrs.", nil),EGLocalizedString(@"小姐/Miss.", nil)];
    NSArray * orgNorBg = @[@"comment_segment_left_nor.png",@"comment_segment_middle_nor.png",@"comment_segment_right_nor.png"];
    NSArray * orgSelBg = @[@"comment_segment_left_sel.png",@"comment_segment_middle_sel.png",@"comment_segment_right_sel.png",];
    int width1 = (ScreenSize.width-40)/3;
    for (int i = 0; i < 3; i ++) {
          _orgButton2 = [_view2 addImageButtonWithFrame:CGRectMake(i*width1+20, 40, width1, 25) title:orgTitle[i] backgroud:orgNorBg[i] action:^(UIButton *button) {
              
              for (int i = 0; i < 3; i ++){
                  UIButton * button = (UIButton *)[weakSelf.view2 viewWithTag:40+i];
                  button.selected = NO;
              }
              if (button.tag == 40) {
                  _sexType = @"R";
                  button.selected = YES;
              }else if (button.tag == 41){
                  _sexType = @"S";
                  button.selected = YES;
              }else{
                  _sexType = @"M";
                  button.selected = YES;
              }
              
          }];
        _orgButton2.tag = 40 +i;
        _orgButton2.titleLabel.font = [UIFont systemFontOfSize:14];
        [_orgButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_orgButton2 setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
        [_orgButton2 setBackgroundImage:[UIImage imageNamed:orgSelBg[i]] forState:UIControlStateSelected];
        if (i == 0) {
            _orgButton2.selected = YES;
        }
    }
  
    _textField7 = [[UITextField alloc] initWithFrame:CGRectMake(20, 75, ScreenSize.width/2-25, 30)];
    _textField7.placeholder = EGLocalizedString(@"Register_lastNameCh", nil);
    _textField7.delegate = self;
    _textField7.tag = 807;
    _textField7.font = [UIFont systemFontOfSize:14];
    _textField7.borderStyle = UITextBorderStyleRoundedRect;
    [_view2 addSubview:_textField7];
    
    _textField8 = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2+5, 75, ScreenSize.width/2-25, 30)];
    _textField8.placeholder = EGLocalizedString(@"Register_nameCh", nil);
    _textField8.delegate = self;
    _textField8.tag = 808;
    _textField8.font = [UIFont systemFontOfSize:14];
    _textField8.borderStyle = UITextBorderStyleRoundedRect;
    [_view2 addSubview:_textField8];
    
    _textField9 = [[UITextField alloc] initWithFrame:CGRectMake(20, 115, ScreenSize.width/2-25, 30)];
    _textField9.placeholder = EGLocalizedString(@"Register_lastNameEn", nil);
    _textField9.delegate = self;
    _textField9.tag = 809;
    _textField9.font = [UIFont systemFontOfSize:14];
    _textField9.borderStyle = UITextBorderStyleRoundedRect;
    [_view2 addSubview:_textField9];
    
    _textField10 = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2+5, 115, ScreenSize.width/2-25, 30)];
    _textField10.placeholder = EGLocalizedString(@"Register_nameEh", nil);
    _textField10.delegate = self;
    _textField10.tag = 810;
    _textField10.font = [UIFont systemFontOfSize:14];
    _textField10.borderStyle = UITextBorderStyleRoundedRect;
    [_view2 addSubview:_textField10];

    _textField11 = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, ScreenSize.width-40, 30)];
    _textField11.placeholder = EGLocalizedString(@"Register_org_position_textFile", nil);
    _textField11.delegate = self;
    _textField11.tag = 811;
    _textField11.font = [UIFont systemFontOfSize:14];
    _textField11.borderStyle = UITextBorderStyleRoundedRect;
    [_view2 addSubview:_textField11];
    
    _textField12 = [[UITextField alloc] initWithFrame:CGRectMake(20, 185, ScreenSize.width-40, 30)];
    _textField12.placeholder = EGLocalizedString(@"Register_email", nil);
    _textField12.delegate = self;
    _textField12.tag = 812;
    _textField12.keyboardType = UIKeyboardTypeEmailAddress;
    _textField12.font = [UIFont systemFontOfSize:14];
    _textField12.borderStyle = UITextBorderStyleRoundedRect;
    [_view2 addSubview:_textField12];
    
    UILabel * label3 = [_view2 addLabelWithFrame:CGRectMake(20, 210, ScreenSize.width-40, 40) text:EGLocalizedString(@"Register_noteLabel1_title", nil)];
    label3.textColor = [UIColor grayColor];
    label3.numberOfLines = 2;
    label3.font = [UIFont boldSystemFontOfSize:13];
    
    
    _telDistrictFieldOrg = [[UITextField alloc] initWithFrame:CGRectMake(20, 260, 75, 30)];
    _telDistrictFieldOrg.text = @"852";
    _telDistrictFieldOrg.delegate = self;
    _telDistrictFieldOrg.tag = 913;
    _telDistrictFieldOrg.keyboardType = UIKeyboardTypeNumberPad;
    _telDistrictFieldOrg.font = [UIFont systemFontOfSize:14];
    _telDistrictFieldOrg.borderStyle = UITextBorderStyleRoundedRect;
    _telDistrictFieldOrg.hidden = NO;
    [_view2 addSubview:_telDistrictFieldOrg];
    
    _textField13 = [[UITextField alloc] initWithFrame:CGRectMake(105, 260, ScreenSize.width-125, 30)];
    _textField13.placeholder = EGLocalizedString(@"Register_org_number", nil);
    _textField13.delegate = self;
    _textField13.tag = 813;
    _textField13.keyboardType = UIKeyboardTypeNumberPad;
    _textField13.font = [UIFont systemFontOfSize:14];
    _textField13.borderStyle = UITextBorderStyleRoundedRect;
    [_view2 addSubview:_textField13];
    
    UILabel * label4 = [_view2 addLabelWithFrame:CGRectMake(20, 290, ScreenSize.width-40, 40) text:EGLocalizedString(@"Register_org_address", nil)];
    label4.font = [UIFont systemFontOfSize:14];
    
    _textField14 = [[UITextField alloc] initWithFrame:CGRectMake(20, 340, 100, 25)];
    _textField14.placeholder = EGLocalizedString(@"Register_org_region1", nil);
    _textField14.delegate = self;
    _textField14.tag = 814;
    _textField14.font = [UIFont systemFontOfSize:13];
    _textField14.borderStyle = UITextBorderStyleRoundedRect;
    [_view2 addSubview:_textField14];
    
    _textField15 = [[UITextField alloc] initWithFrame:CGRectMake(130, 340, ScreenSize.width-150, 30)];
    _textField15.placeholder = EGLocalizedString(@"Register_org_region2", nil);
    _textField15.delegate = self;
    _textField15.tag = 815;
    _textField15.font = [UIFont systemFontOfSize:14];
    _textField15.borderStyle = UITextBorderStyleRoundedRect;
    [_view2 addSubview:_textField15];
    
    _textField16 = [[UITextField alloc] initWithFrame:CGRectMake(20, 380, ScreenSize.width-40, 30)];
    _textField16.placeholder = EGLocalizedString(@"Register_org_region3", nil);
    _textField16.delegate = self;
    _textField16.tag = 816;
    _textField16.font = [UIFont systemFontOfSize:14];
    _textField16.borderStyle = UITextBorderStyleRoundedRect;
    [_view2 addSubview:_textField16];
    
    _textField17 = [[UITextField alloc] initWithFrame:CGRectMake(20, 420, ScreenSize.width-40, 30)];
    _textField17.placeholder = EGLocalizedString(@"Register_org_region4", nil);
    _textField17.delegate = self;
    _textField17.tag = 817;
    _textField17.font = [UIFont systemFontOfSize:14];
    _textField17.borderStyle = UITextBorderStyleRoundedRect;
    [_view2 addSubview:_textField17];

    
    _pickerViewPopup = [[UIPickerView alloc] initWithFrame:CGRectMake(0, ScreenSize.height - 200 + ((IS_IPHONE_5 || IS_IPHONE_4_OR_LESS || IS_IPAD) ? 20 : 0), ScreenSize.width , 200)];
    
    _pickerViewPopup.delegate = self;
    _pickerViewPopup.showsSelectionIndicator = YES;
    _pickerViewPopup.hidden = YES;
    _pickerViewPopup.backgroundColor = [UIColor whiteColor];
    [_pickerViewPopup selectRow:selectedDistrict inComponent:0 animated:YES];
    [self.view addSubview:_pickerViewPopup];
    UITextField *orgtextField3 = [[UITextField alloc] initWithFrame:CGRectMake(20, 460, 80, 25)];
    orgtextField3.font = [UIFont systemFontOfSize:14];
    orgtextField3.placeholder= EGLocalizedString(@"Register_org_selRegion", nil);
    orgtextField3.enabled = NO;
    orgtextField3.textColor=[UIColor blackColor];
    orgtextField3.borderStyle = UITextBorderStyleRoundedRect;
    [_view2 addSubview:orgtextField3];
    
//    _orgButton4 = [_view2 addImageButtonWithFrame:CGRectMake(20, 460, 80, 25) title:EGLocalizedString(@"Register_org_selRegion", nil) backgroud:nil action:^(UIButton *button) {
//        _pickerViewPopup.hidden = NO;
//        [_editing resignFirstResponder]; //回收键盘
//        [weakSelf tapResetFram]; //回收fram
//    }];
//    _orgButton4.titleLabel.font = [UIFont systemFontOfSize:12];
//    _orgButton4.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);

    _districtField1 = [[UITextField alloc] initWithFrame:CGRectMake(110, 460, ScreenSize.width-130, 25)];
    _districtField1.placeholder = @"";
    _districtField1.font = [UIFont systemFontOfSize:12];
    _districtField1.enabled = YES;
    _districtField1.borderStyle = UITextBorderStyleRoundedRect;
    [_view2 addSubview:_districtField1];
    

    NSArray * region = @[EGLocalizedString(@"Register_org_regionButton", nil),EGLocalizedString(@"Register_org_otherButton", nil)];
    NSArray * regNorBg = @[@"comment_segment_left_nor.png",@"comment_segment_right_nor.png"];
    NSArray * regSelBg = @[@"comment_segment_left_sel.png",@"comment_segment_right_sel.png",];
    int width2 = (ScreenSize.width-40)/2;
    for (int i = 0; i < 2; i ++) {
        _orgButton3 = [_view2 addImageButtonWithFrame:CGRectMake(i*width2+20, 460+50, width2, 25) title:region[i] backgroud:regNorBg[i] action:^(UIButton *button) {
            
            for (int i = 0; i < 2; i ++) {
                UIButton * button = (UIButton *)[weakSelf.view2 viewWithTag:45+i];
                button.selected = NO;
            }
            
            if (button.tag == 45){
                _addressCountry = @"香港";
                button.selected = YES;
                weakSelf.otherRegion.hidden = YES;
            }else{
              _addressCountry = _otherRegion.text;
              button.selected = YES;
              weakSelf.otherRegion.hidden = NO;
            }
            
        }];
        _orgButton3.tag = 45 +i;
        _orgButton3.titleLabel.font = [UIFont systemFontOfSize:14];
        [_orgButton3 setBackgroundImage:[UIImage imageNamed:regSelBg[i]] forState:UIControlStateSelected];
        if (i == 0) {
            _orgButton3.selected = YES;
        }
        [_orgButton3 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_orgButton3 setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    }
    UILabel * label5 = [_view2 addLabelWithFrame:CGRectMake(20, 485+50, ScreenSize.width-150, 60) text:EGLocalizedString(@"Register_org_noteLabel2_title", nil)];
    label5.textColor = [UIColor grayColor];
    label5.numberOfLines = 0;
    label5.font = [UIFont boldSystemFontOfSize:14];

    _otherRegion = [[UITextField alloc] initWithFrame:CGRectMake(label5.frame.size.width+25, 490+60, ScreenSize.width-label5.frame.size.width-50, 25)];
   //_otherRegion.placeholder = EGLocalizedString(@"请说明", nil);
    _otherRegion.delegate = self;
    _otherRegion.hidden = YES;
    _otherRegion.tag = 28;
    _otherRegion.layer.borderColor=[[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1]CGColor];
    _otherRegion.font = [UIFont systemFontOfSize:12];
    _otherRegion.borderStyle = UITextBorderStyleRoundedRect;
    [_view2 addSubview:_otherRegion];
    UILabel * label6 = [_view2 addLabelWithFrame:CGRectMake(20, 532+60, ScreenSize.width/2+20, 40) text:EGLocalizedString(@"Register_IsEmailNote", nil)];
    label6.numberOfLines = 2;
    label6.font = [UIFont systemFontOfSize:13];
    

    _view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 850+50, ScreenSize.width, 80)];
    [_twoScrollView addSubview:_view3];
//    _view3.backgroundColor = [UIColor redColor];
    //创建点击“是”按钮弹出的视图
    _orgEmailView = [[UIView alloc] initWithFrame:CGRectMake(20, 855, ScreenSize.width-40, 200)];
    _orgEmailView.backgroundColor = [UIColor whiteColor];
    _orgEmailView.hidden = YES;
    [_twoScrollView addSubview:_orgEmailView];
    
    UILabel * emailViewTitle = [_orgEmailView addLabelWithFrame:CGRectMake(0, 0, 300, 35) text:EGLocalizedString(@"请选取你喜欢的专案类别(可选择多项):", nil)];
    emailViewTitle.font = [UIFont systemFontOfSize:13];
    emailViewTitle.numberOfLines=2;
    emailViewTitle.textColor = [UIColor grayColor];
    
    _arr1 = [[NSMutableArray alloc] init];
    NSArray * emailViewTitleArray = @[EGLocalizedString(@"助学", nil),EGLocalizedString(@"安老", nil),EGLocalizedString(@"助医", nil),EGLocalizedString(@"扶贫", nil),EGLocalizedString(@"紧急援助", nil),EGLocalizedString(@"其他", nil),EGLocalizedString(@"意赠行动", nil),EGLocalizedString(@"全部", nil)];
    for (int i = 0; i < 8; i ++) {
        _typeButton = [_orgEmailView addImageButtonWithFrame:CGRectMake(i%2*(ScreenSize.width/2), i/2*45+38, 20, 20) title:nil backgroud:@"cart_checkbox_nor.png" action:^(UIButton *button) {
            
            if (button.tag == 110) {
                UIButton *btn = [weakSelf.orgEmailView viewWithTag:117];
                btn.selected=NO;
                [_arr1 removeObject:@"L,"];
                if (button.selected) {
                    button.selected = NO;
                    [_arr1 removeObject:@"S,"];
                }else{
                    button.selected = YES;
                    [_arr1 addObject:@"S,"];
                }
                
            }else if (button.tag == 111){
                UIButton *btn = [weakSelf.orgEmailView viewWithTag:117];
                btn.selected=NO;
                [_arr1 removeObject:@"L,"];
                if (button.selected) {
                    button.selected = NO;
                    [_arr1 removeObject:@"E,"];
                }else{
                    button.selected = YES;
                    [_arr1 addObject:@"E,"];
                }
                
            }else if (button.tag == 112){
                UIButton *btn = [weakSelf.orgEmailView viewWithTag:117];
                btn.selected=NO;
                [_arr1 removeObject:@"L,"];
                if (button.selected) {
                    button.selected = NO;
                    [_arr1 removeObject:@"M,"];
                }else{
                    button.selected = YES;
                    [_arr1 addObject:@"M,"];
                }
                
            }else if (button.tag == 113){
                UIButton *btn = [weakSelf.orgEmailView viewWithTag:117];
                btn.selected=NO;
                [_arr1 removeObject:@"L,"];
                if (button.selected) {
                    button.selected = NO;
                    [_arr1 removeObject:@"P,"];
                }else{
                    button.selected = YES;
                    [_arr1 addObject:@"P,"];
                }
                
            }else if (button.tag == 114){
                UIButton *btn = [weakSelf.orgEmailView viewWithTag:117];
                btn.selected=NO;
                [_arr1 removeObject:@"L,"];
                if (button.selected) {
                    button.selected = NO;
                    [_arr1 removeObject:@"U,"];
                }else{
                    button.selected = YES;
                    [_arr1 addObject:@"U,"];
                }
                
            }else if (button.tag == 115){
                UIButton *btn = [weakSelf.orgEmailView viewWithTag:117];
                btn.selected=NO;
                [_arr1 removeObject:@"L,"];
                if (button.selected) {
                    button.selected = NO;
                    [_arr1 removeObject:@"O,"];
                }else{
                    
                    button.selected = YES;
                    [_arr1 addObject:@"O,"];
                }
            }else if (button.tag == 116){
                UIButton *btn = [weakSelf.orgEmailView viewWithTag:117];
                btn.selected=NO;
                [_arr1 removeObject:@"L,"];
                if (button.selected) {
                    button.selected = NO;
                    [_arr1 removeObject:@"A,"];
                }else{
                    button.selected = YES;
                    [_arr1 addObject:@"A,"];
                }
                
            }else if (button.tag == 117){
                
                if (button.selected) {
                    for (int i = 0; i < 8; i ++) {
                        UIButton * button = (UIButton *)[_twoScrollView viewWithTag:110+i];
                        button.selected = NO;
                    }

                    [_arr1 removeAllObjects];
                }else{
                    for (int i = 0; i < 8; i ++) {
                        UIButton * button = (UIButton *)[_twoScrollView viewWithTag:110+i];
                        button.selected = YES;
                    }

                    [_arr1 removeAllObjects];
                    NSArray * DonationInterest = @[@"S",@"E",@"M",@"P",@"U",@"O",@"A",@"L"];
                    for (int j=0; j<DonationInterest.count; j++) {
                        NSString *str = [NSString stringWithFormat:@"%@,",DonationInterest[j]];
                        [_arr1 addObject:str];

                    }
                
                }
            }
            
        }];
        _typeButton.tag = 110+i;
        [_typeButton setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
        
        UILabel * label = [_orgEmailView addLabelWithFrame:CGRectMake(i%2*(ScreenSize.width/2)+25, i/2*45+28, 80, 40) text:emailViewTitleArray[i]];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 2;
        label.font = [UIFont boldSystemFontOfSize:13];
        
    }

    //创建“是“按钮
    int width3 = (ScreenSize.width/2-70)/2;
    
    UILabel * label7 = [_view3 addLabelWithFrame:CGRectMake(20, 0, ScreenSize.width-40, 60) text:EGLocalizedString(@"Register_noteLabel3_title", nil)];
    label7.numberOfLines = 0;
    label7.font = [UIFont systemFontOfSize:15];
    _orgButton5 = [_view2 addImageButtonWithFrame:CGRectMake(ScreenSize.width/2+50, 535+65, (ScreenSize.width/2-70)/2, 25) title:EGLocalizedString(@"Register_isEmailButton_title", nil) backgroud:@"comment_segment_middle_nor.png" action:^(UIButton *button) {
        
        _isSelEmail = @"1";
        //标记是不是展开了
        _orgIsEamil = YES;
        _orgButton55.selected = NO;
        button.selected = YES;
        if (_orgIsVolunteer) {
            if (_isOther) {
                _view3.frame = CGRectMake(0, 850+200+80+50, ScreenSize.width, 80);
                [_twoScrollView setContentOffset:CGPointMake(0, 550) animated:YES];
                _orgEmailView.hidden = NO;
                _orgVolunteerView.frame = CGRectMake(20, 930+200+80+50, ScreenSize.width-40, 780);
                _twoScrollView.contentSize = CGSizeMake(0,1075+200+780+80+50+20);
                //                weakSelf.orgCommitButton.frame = CGRectMake(20, 940+200+780+80, ScreenSize.width-40, 30);
                
            }else{
                _view3.frame = CGRectMake(0, 850+200+50, ScreenSize.width, 80);
                [_twoScrollView setContentOffset:CGPointMake(0, 550) animated:YES];
                _orgEmailView.hidden = NO;
                _orgVolunteerView.frame = CGRectMake(20, 930+200+50, ScreenSize.width-40, 780);
                _twoScrollView.contentSize = CGSizeMake(0,1075+200+780+50+20);
                //                weakSelf.orgCommitButton.frame = CGRectMake(20, 940+200+780, ScreenSize.width-40, 30);
            }
        }else{
            if (_isOther) {
                _orgEmailView.hidden = NO;
                _orgEmailView.frame = CGRectMake(20, 850+50+70, ScreenSize.width-40, 200);
                _view3.frame = CGRectMake(0, 850+200+50+70, ScreenSize.width, 80);
                _twoScrollView.contentSize = CGSizeMake(0,1075+200+70+20);
                [_twoScrollView setContentOffset:CGPointMake(0, 700) animated:YES];
                //                 weakSelf.orgCommitButton.frame = CGRectMake(20, 940+200+80, ScreenSize.width-40, 30);
            }else{
                
                _view3.frame = CGRectMake(0, 850+200+50, ScreenSize.width, 80);
                _orgEmailView.frame = CGRectMake(20, 850+50, ScreenSize.width-40, 200);
                [_twoScrollView setContentOffset:CGPointMake(0, 550) animated:YES];
                _orgEmailView.hidden = NO;
                _twoScrollView.contentSize = CGSizeMake(0,1075+200+50+20);
                //                weakSelf.orgCommitButton.frame = CGRectMake(20, 940+200, ScreenSize.width-40, 30);
                
            }
            
        }
        
    }];
    
    _orgButton5.titleLabel.font = [UIFont systemFontOfSize:13];
    [_orgButton5 setBackgroundImage:[UIImage imageNamed:@"comment_segment_middle_sel.png"] forState:UIControlStateSelected];
    [_orgButton5 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_orgButton5 setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    //”否“按钮
    _orgButton55 = [_view2 addImageButtonWithFrame:CGRectMake(ScreenSize.width/2+50+width3, 535+65, width3, 25) title:EGLocalizedString(@"Register_noEmailButton_title", nil) backgroud:@"comment_segment_middle_nor.png" action:^(UIButton *button) {
        _isSelEmail = @"0";
        [weakSelf touchNoButtonAction];
    }];
    _orgButton55.titleLabel.font = [UIFont systemFontOfSize:13];
    [_orgButton55 setBackgroundImage:[UIImage imageNamed:@"comment_segment_middle_sel.png"] forState:UIControlStateSelected];
    [_orgButton55 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_orgButton55 setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    //_orgButton55.selected=YES;
    _orgIsEamil=NO;
    
//    [[_orgButton5 superview] bringSubviewToFront:_orgButton5];
    

    // “愿意”按钮
    _orgIsButton = [_view3 addImageButtonWithFrame:CGRectMake(20, 60, ScreenSize.width/2-20, 25) title:EGLocalizedString(@"Register_yButton_title", nil) backgroud:@"comment_segment_left_nor.png" action:^(UIButton *button) {
        //标记是否展开
//        _orgIsVolunteer = YES;
        
        _orgNoButton.selected = NO;
        button.selected = YES;

    } ];
    _orgIsButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_orgIsButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_left_sel.png"] forState:UIControlStateSelected];
    [_orgIsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_orgIsButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    //”暂不考虑“按钮
    _orgNoButton = [_view3 addImageButtonWithFrame:CGRectMake(ScreenSize.width/2, 60, ScreenSize.width/2-20, 25) title:EGLocalizedString(@"Register_nButton_title", nil) backgroud:@"comment_segment_right_nor.png" action:^(UIButton *button) {
        _orgIsButton.selected = NO;
        _orgNoButton.selected = YES;
//        [weakSelf touchNoConsiderAction];
        
    }];
    _orgNoButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _orgNoButton.selected = YES;
    [_orgNoButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_right_sel.png"] forState:UIControlStateSelected];
    [_orgNoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_orgNoButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];

    
    //义工选项视图
    _orgVolunteerView = [[UIView alloc] initWithFrame:CGRectMake(20, 930, ScreenSize.width-40, 780)];
    _orgVolunteerView.hidden = YES;
    [_twoScrollView addSubview:_orgVolunteerView];
    
    [self createOrgVoView];
    
    //企业注册
    _orgCommitButton = [_commitBgView addImageButtonWithFrame:CGRectMake(20, 2.5, ScreenSize.width-40, 30) title:EGLocalizedString(@"Register_commitButton_title", nil) backgroud:nil action:^(UIButton *button){
        weakSelf.flag = 2;
      //  MyLog(@"%d",_isOther);
        
        //faceBook Weibo
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSString *faceBookString = [NSString stringWithFormat:@"%@",[standardUserDefaults objectForKey:@"FACEBOOK_REG_REQ"]];
        NSString *weiBoString = [NSString stringWithFormat:@"%@",[standardUserDefaults objectForKey:@"WEIBO_REG_REQ"]];
        if ([faceBookString isEqualToString:@"1"] || [weiBoString isEqualToString:@"1"]){
            
            if (_isOther==YES){
                if (![NSString isEmpty:weakSelf.otherText1.text andNote:EGLocalizedString(@"请输入其他请註明", nil)]){
                    if (![NSString isEmpty:_textField1.text andNote:EGLocalizedString(@"请输入登入名称", nil)]){
                        if ([NSString validateUserName:_textField1.text]){
                            
                                            if (![NSString isEmpty:_textField4.text andNote:EGLocalizedString(@"机构名称不能为空", nil)]){
                                                if ([self enterprise:_textField5.text]){
                                                    
                                                    
                                                    
                                                    
                                                    [self checkErrorMessage:otherBussessNumbertextField.text];
                                                    
                                                    
                                                    
                                                    
                                                }}}}}
                
            }else{
                
                if (![NSString isEmpty:_textField1.text andNote:EGLocalizedString(@"请输入登入名称", nil)]){
                    if ([NSString validateUserName:_textField1.text]){
                       
                                        if (![NSString isEmpty:_textField4.text andNote:EGLocalizedString(@"机构名称不能为空", nil)]){
                                            if ([self enterprise:_textField5.text]){
                                                
                                                
                                                [self checkErrorMessage:_textField6.text];
                                                
                                                
                                            }}}}}
        
        
        
        }else{
        
        if (_isOther==YES){
        if (![NSString isEmpty:weakSelf.otherText1.text andNote:EGLocalizedString(@"请输入其他请註明", nil)]){
                if (![NSString isEmpty:_textField1.text andNote:EGLocalizedString(@"请输入登入名称", nil)]){
                    if ([NSString validateUserName:_textField1.text]){
                        if (![NSString isEmpty:_textField2.text andNote:EGLocalizedString(@"密码不能为空", nil)]) {
                            if ([weakSelf checkPassWordLength:_textField2.text]) {
                            if ([weakSelf confirmPass:_textField3.text ]) {
                                if ([weakSelf LoginPass:_textField2.text andConfirm:_textField3.text]){
                                    if (![NSString isEmpty:_textField4.text andNote:EGLocalizedString(@"机构名称不能为空", nil)]){
                                        if ([self enterprise:_textField5.text]){
                                            
                                            
                                                [self checkErrorMessage:otherBussessNumbertextField.text];
                                                
                                            
                                            
                                            
                                        }}}}}}}}}
            
        }else{
            
            if (![NSString isEmpty:_textField1.text andNote:EGLocalizedString(@"请输入登入名称", nil)]){
                if ([NSString validateUserName:_textField1.text]){
                    if (![NSString isEmpty:_textField2.text andNote:EGLocalizedString(@"密码不能为空", nil)]){
                        
                        if ([weakSelf checkPassWordLength:_textField2.text]) {
                        if ([weakSelf confirmPass:_textField3.text ]) {
                            if ([weakSelf LoginPass:_textField2.text andConfirm:_textField3.text]){
                                if (![NSString isEmpty:_textField4.text andNote:EGLocalizedString(@"机构名称不能为空", nil)]){
                                    if ([self enterprise:_textField5.text]){
                                        
                                        
                                        [self checkErrorMessage:_textField6.text];
                                        
                                        
                                    }}}}}}}}}
    
        
        
        
          

        } }];
    
    
    
    _orgCommitButton.hidden = YES;
    [_orgCommitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _orgCommitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _orgCommitButton.layer.cornerRadius = 2;
    _orgCommitButton.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];

    _testView = [[UIView alloc] initWithFrame:CGRectMake(21, 186+75, ScreenSize.width-42, 70)];
//    _testView.backgroundColor = [UIColor greenColor];
    _testView.hidden = YES;
    [_twoScrollView addSubview:_testView];
    _regionArr = @[@[EGLocalizedString(@"不適用", nil),EGLocalizedString(@"商業登記號碼", nil),EGLocalizedString(@"香港社團注冊證明書編號", nil),EGLocalizedString(@"稅局檔號", nil)]];
    _regionDownMenu = [[EGDropDownMenu alloc] initWithFrame:CGRectMake(0, 0, _testView.frame.size.width, 23) Array:_regionArr selectedColor:[UIColor grayColor]];
    _regionDownMenu.delegate = self;
//    [_testView addSubview:_regionDownMenu];


    
    _selBtn = [_testView addLabelWithFrame:CGRectMake(0, 0,_testView.frame.size.width, 25) text:nil];
    _selBtn.font = [UIFont systemFontOfSize:13];
    _selBtn.textColor = [UIColor grayColor];
    _selBtn.layer.borderWidth = 1;
    _selBtn.layer.cornerRadius = 4;
    _selBtn.layer.borderColor=[[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1]CGColor];

    
    _pickerViewPopupBusiness = [[UIPickerView alloc] initWithFrame:CGRectMake(0, ScreenSize.height - 200 + ((IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) ? 20 : 0), ScreenSize.width , 200)];
    _pickerViewPopupBusiness.delegate = self;
    _pickerViewPopupBusiness.showsSelectionIndicator = YES;
    _pickerViewPopupBusiness.hidden = YES;
    _pickerViewPopupBusiness.backgroundColor = [UIColor whiteColor];
    [_pickerViewPopupBusiness selectRow:selectedBusiness inComponent:0 animated:YES];
    [self.view addSubview:_pickerViewPopupBusiness];
    
    [_testView addImageButtonWithFrame:CGRectMake(0, 0, _testView.frame.size.width, 23) title:nil backgroud:nil action:^(UIButton *button) {
        weakSelf.pickerViewPopupBusiness.hidden = NO;
    }];
    
    otherBussessNumbertextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 40,_testView.frame.size.width, 25)];
    otherBussessNumbertextField.delegate = self;
    otherBussessNumbertextField.layer.borderColor=[[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1]CGColor];
    [otherBussessNumbertextField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    otherBussessNumbertextField.font = [UIFont systemFontOfSize:12];
    otherBussessNumbertextField.borderStyle = UITextBorderStyleRoundedRect;
    [_testView addSubview:otherBussessNumbertextField];

}


-(void)checkErrorMessage:(NSString*)bussnessNumber{
    
    MyLog(@"%@",_selBtn.text);
    
  if ([_selBtn.text isEqualToString:EGLocalizedString(@"不適用", nil)]){
      if ([self BusinessReg:bussnessNumber]){
        
      if(([_textField7.text isEqualToString:@""]&&[_textField8.text isEqualToString:@""]&&[_textField9.text isEqualToString:@""]&&[_textField8.text isEqualToString:@""])){
          UIAlertView *alertView = [[UIAlertView alloc] init];
          alertView.message = EGLocalizedString(@"请输入[联络人姓名(中)(姓)]", nil);
          [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
          [alertView show];
          
      }else if (((![_textField7.text isEqualToString:@""] && [_textField8.text isEqualToString:@""]) || ([_textField7.text isEqualToString:@""] && ![_textField8.text isEqualToString:@""]))){
          
          if ([_textField7.text isEqualToString:@""]){
              
              UIAlertView *alertView = [[UIAlertView alloc] init];
              alertView.message = EGLocalizedString(@"请输入[联络人姓名(中)(姓)]", nil);
              [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
              [alertView show];
              
          }else{
              
              UIAlertView *alertView = [[UIAlertView alloc] init];
              alertView.message = EGLocalizedString(@"请输入[联络人姓名(中)(名)]", nil);
              [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
              [alertView show];
              
          }
          
      }else if (((![_textField9.text isEqualToString:@""]&&[_textField10.text isEqualToString:@""]) || ([_textField9.text isEqualToString:@""]&&![_textField10.text isEqualToString:@""])) ){
          
          if ([_textField9.text isEqualToString:@""]) {
              UIAlertView *alertView = [[UIAlertView alloc] init];
              alertView.message = EGLocalizedString(@"请输入[联络人姓名(英)(姓)]", nil);
              [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
              [alertView show];
              
          }else{
              UIAlertView *alertView = [[UIAlertView alloc] init];
              alertView.message = EGLocalizedString(@"请输入[联络人姓名(英)(名)]", nil);
              [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
              [alertView show];
              
          }
          
      }else if ((![self isZhongWenFirst:_textField7.text]&&![_textField7.text isEqualToString:@""]) || (![self isZhongWenFirst:_textField8.text]&&![_textField8.text isEqualToString:@""])){
          
          UIAlertView *alertView = [[UIAlertView alloc] init];
          alertView.message = EGLocalizedString(@"联络人姓名(中)内请输入中文",nil);
          [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
          [alertView show];
          
      }else if (![self pipeizimu:_textField9.text] || ![self pipeizimu:_textField10.text]){
          
          UIAlertView *alertView = [[UIAlertView alloc] init];
          alertView.message = EGLocalizedString(@"联络人姓名(英)内请输入英文",nil);
          [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
          [alertView show];
          
      }else{
          
          if (![NSString isEmpty:_textField11.text andNote:EGLocalizedString(@"职位不能为空", nil)]) {
              if (![NSString isEmpty:_textField12.text andNote:EGLocalizedString(@"邮箱不能为空", nil)]) {
                  if ([NSString isEmail:_textField12.text]){
                      if (![NSString isEmpty:_textField13.text andNote:EGLocalizedString(@"联络电话不能为空", nil)]){
                          if ([self address:_textField14.text andRegister_org_region2:_textField15.text andRegister_org_region3:_textField16.text  andRegister_org_region4:_textField17.text  andRegister_org_region5:_districtField1.text]) {
                              if([self HkorOther]){
                                if ([self checkOrganizationEmailfromEgive]) {
                              if ((_arr1.count==0 && _orgIsEamil)){
                                  UIAlertView *alertView = [[UIAlertView alloc] init];
                                  alertView.message = EGLocalizedString(@"请选取您喜欢的专案类别",nil);
                                  [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                                  [alertView show];
                                  
                              }else{
                                  
                                  self.alertVc.model = self.model;
                                  self.alertVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
                                  [self.view.window.rootViewController presentViewController:self.alertVc animated:YES completion:nil];
                              }
                            }
                              
                          }
                      }
                  }
              }
              }}}}
  

       
   }else{

 if([self BusinessRegistrationNo:bussnessNumber]){
    
  if(([_textField7.text isEqualToString:@""]&&[_textField8.text isEqualToString:@""]&&[_textField9.text isEqualToString:@""]&&[_textField8.text isEqualToString:@""])){
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"请输入[联络人姓名(中)(姓)]", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        
    }else if (((![_textField7.text isEqualToString:@""] && [_textField8.text isEqualToString:@""]) || ([_textField7.text isEqualToString:@""] && ![_textField8.text isEqualToString:@""]))){
        
        if ([_textField7.text isEqualToString:@""]){
            
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"请输入[联络人姓名(中)(姓)]", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            
        }else{
            
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"请输入[联络人姓名(中)(名)]", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            
        }

    }else if (((![_textField9.text isEqualToString:@""]&&[_textField10.text isEqualToString:@""]) || ([_textField9.text isEqualToString:@""]&&![_textField10.text isEqualToString:@""]))){
        
        if ([_textField9.text isEqualToString:@""]){
            
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"请输入[联络人姓名(英)(姓)]", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"请输入[联络人姓名(英)(名)]", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            
        }
        
    }else if ((![self isZhongWenFirst:_textField7.text]&&![_textField7.text isEqualToString:@""]) || (![self isZhongWenFirst:_textField8.text]&&![_textField8.text isEqualToString:@""])){
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"联络人姓名(中)内请输入中文",nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
    }else if (![self pipeizimu:_textField9.text] || ![self pipeizimu:_textField10.text]){
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"联络人姓名(英)内请输入英文",nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
    }else{
        if (![NSString isEmpty:_textField11.text andNote:EGLocalizedString(@"职位不能为空", nil)]){
            if (![NSString isEmpty:_textField12.text andNote:EGLocalizedString(@"邮箱不能为空", nil)]) {
                if ([NSString isEmail:_textField12.text]){
                    if (![NSString isEmpty:_textField13.text andNote:EGLocalizedString(@"联络电话不能为空", nil)]){
                        if ([self address:_textField14.text andRegister_org_region2:_textField15.text andRegister_org_region3:_textField16.text  andRegister_org_region4:_textField17.text  andRegister_org_region5:_districtField1.text]) {
                            if ([self HkorOther]) {
                             if ([self checkOrganizationEmailfromEgive]) {
                            if ((_arr1.count==0 && _orgIsEamil)){
                                UIAlertView *alertView = [[UIAlertView alloc] init];
                                alertView.message = EGLocalizedString(@"请选取您喜欢的专案类别",nil);
                                [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                                [alertView show];
                                
                            }else{
                                
                                self.alertVc.model = self.model;
                                self.alertVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
                                [self.view.window.rootViewController presentViewController:self.alertVc animated:YES completion:nil];
                            }
                            }
                            
                        }
                    }
                }
            }
        }}
    }}}
   
   

}


-(BOOL)enterprise:(NSString*)enterpriseEng{

    if (![self pipeizimu:enterpriseEng] && ![enterpriseEng isEqualToString:@""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"机构名称(英)不接受中文输入", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
    }else{
        return true;
        
    }
}

//判断是否选择了香港或者其他
-(BOOL)HkorOther{

    MyLog(@"self.otherRegion.text=%@",self.otherRegion.text);
    UIButton *btn = (UIButton*)[self.view2 viewWithTag:46];
    if (btn.selected && [self isEmpty:self.otherRegion.text]){
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"hkorother", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
    
        return false;
        
    }

    return  true;
    
}
-(BOOL) isEmpty:(NSString *) str {
    
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}
-(BOOL)address: (NSString*)Register_org_region1 andRegister_org_region2:(NSString*)Register_org_region2  andRegister_org_region3:(NSString*)Register_org_region3  andRegister_org_region4:(NSString*)Register_org_region4 andRegister_org_region5:(NSString*)Register_org_region5 {

    if ([Register_org_region1 isEqualToString:@""]&&[Register_org_region2 isEqualToString:@""]&&[Register_org_region3 isEqualToString:@""]&&[Register_org_region4 isEqualToString:@""]&&[Register_org_region5 isEqualToString:@""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"请输入[机构地址]", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
    }



    return true;
}

-(BOOL)chicheckENLastName:(NSString*)LastName{
    if (![self pipeizimu:LastName] && ![LastName isEqualToString:@""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"联络人姓名(英)内请输入英文", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
    }else{
        return true;
        
    }
}

-(BOOL)chicheckfirstName:(NSString*)firstName{
    

    if (![self isZhongWenFirst:firstName] && ![firstName isEqualToString:@""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"联络人姓名(中)内请输入first中文", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
    }else{
        return true;
        
    }
    
    
}

-(BOOL)EngcheckName:(NSString*)Engname{
  
    if (![self pipeizimu:Engname] && ![Engname isEqualToString:@""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"englishName",nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
    
       
        return false;
    }


        return true;
}

-(BOOL)chicheckLastName:(NSString*)LastName{


    if (![self isZhongWenFirst:LastName] && ![LastName isEqualToString:@""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"联络人姓名(中)内请输入中文", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
    }else{
        return true;
    
     }
}
-(BOOL)chiLastName:(NSString*)LastName andfirst:(NSString*)first{
   
    if ([LastName  isEqualToString:@""] && [first isEqualToString:@""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"请输入[联络人姓名(中)(姓)]", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
        
    }else if ([LastName  isEqualToString:@""] && ![first isEqualToString:@""]){
    
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"请输入[联络人姓名(中)(姓)]", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
    
    }else if (![LastName  isEqualToString:@""] && [first isEqualToString:@""]){
    
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"请输入[联络人姓名(中)(名)]", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
    
    }
       return true;
}

-(BOOL)BusinessReg:(NSString*)Business{
    
    if ([self isBusinessRegistrationNUmber:Business]){
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"商业登记号码/香港社团注册证明书编号/税局档号", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        return false;
        
    }else{
        return true;
    }
    
    return true;



}

-(BOOL)BusinessRegistrationNo:(NSString*)BusinessRegistrationNo{
  
    if (([self isBusinessRegistrationNUmber:BusinessRegistrationNo] || [BusinessRegistrationNo isEqualToString:@""])){
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"商业登记号码/香港社团注册证明书编号/税局档号", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        return false;
        
    }else{
        return true;
    }

    return true;
}


-(BOOL)isBusinessRegistrationNUmber:(NSString*)bussessNumber{

    for (int j=0; j<bussessNumber.length; j++) {
        unichar ch = [bussessNumber characterAtIndex:j];
        if (0x4e00 < ch  && ch < 0x9fff)
        {
            return true;
        }
        
        
    }
        return false;

}
//是否是纯数字
-(BOOL)isNumText:(NSString *)str{
    NSString * regex = @"^[0-9\\s]*$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
}
#pragma mark - 下拉列表
- (void)dropDownMenu:(EGDropDownMenu *)dropDownMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (dropDownMenu == _regionDownMenu) {
        
        
    }else
        _selectedIndex = indexPath.row;
    
}
#pragma mark - 发送注册信息
- (void)SaveMemberInfo:(MemberModel *)model{
    
   // MyLog(@"%@",model.BusinessRegistrationType);
    [self showLoadingAlert];
  //  MyLog(@"%@",model.MemberID);
//    MyLog(@"VolunteerInterest --------------- %@",model.VolunteerInterest);
//    MyLog(@"AvailableTime --------------- %@",model.AvailableTime);
    
//    NSNumber *ts = [NSNumber numberWithDouble: [[NSDate date] timeIntervalSince1970]]; // testing purpose
//    NSString *fbID = _fbdata != nil ? [NSString stringWithFormat:@"%@%@", [_fbdata objectForKey:@"id"], ts] : @""; // testing purpose
    long lang = [EGUtility getAppLang];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *fbID = _fbdata != nil ? [_fbdata objectForKey:@"id"] : @"";
    NSString *wbID = _wbdata != nil ? [_wbdata objectForKey:@"usid"] : @"";
    NSString *base64 = _fbdata != nil ? (NSString*)[standardUserDefaults objectForKey:@"FACEBOOK_PICTURE"] : @"";
    if ([base64 isEqualToString:@""]) {
        
        base64 = _wbdata != nil ? (NSString*)[standardUserDefaults objectForKey:@"WEIBO_PICTURE"] : @"";
    }
    
    NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <SaveMemberInfo xmlns=\"egive.appservices\"><MemberID></MemberID><MemberType>%@</MemberType><CorporationType>%@</CorporationType><CorporationType_Other>%@</CorporationType_Other><LoginName>%@</LoginName><Password>%@</Password><ConfirmPassword>%@</ConfirmPassword><ProfilePicBase64String>%@</ProfilePicBase64String><CorporationChiName>%@</CorporationChiName><CorporationEngName>%@</CorporationEngName><BusinessRegistrationType>%@</BusinessRegistrationType><BusinessRegistrationNo>%@</BusinessRegistrationNo><ChiNameTitle>%@</ChiNameTitle><ChiLastName>%@</ChiLastName><ChiFirstName>%@</ChiFirstName><EngNameTitle>%@</EngNameTitle><EngLastName>%@</EngLastName><EngFirstName>%@</EngFirstName><Sex>%@</Sex><AgeGroup></AgeGroup><Email>%@</Email><TelCountryCode>%@</TelCountryCode><TelNo>%@</TelNo><AddressRoom>%@</AddressRoom><AddressBldg>%@</AddressBldg><AddressEstate>%@</AddressEstate><AddressStreet>%@</AddressStreet><AddressDistrict>%@</AddressDistrict><AddressCountry>%@</AddressCountry><EducationLevel></EducationLevel><Position>%@</Position><BelongTo>%@</BelongTo><HowToKnoweGive></HowToKnoweGive><HowToKnoweGive_Other></HowToKnoweGive_Other><AcceptEDM>%d</AcceptEDM><DonationInterest>%@</DonationInterest><JoinVolunteer>%d</JoinVolunteer><VolunteerType>%@</VolunteerType><VolunteerStartDate>%@</VolunteerStartDate><VolunteerEndDate>%@</VolunteerEndDate><VolunteerInterest>%@</VolunteerInterest><VolunteerInterest_Other>%@</VolunteerInterest_Other><AvailableTime>%@</AvailableTime><AvailableTime_Other>%@</AvailableTime_Other><AppToken>%@</AppToken><FaceBookID>%@</FaceBookID><WeiboID>%@</WeiboID><Lang>%ld</Lang></SaveMemberInfo></soap:Body></soap:Envelope>",model.MemberType,model.CorporationType,model.CorporationType_Other,model.LoginName,(_fbdata != nil || _wbdata != nil) ? @"" : model.password,(_fbdata != nil || _wbdata != nil) ? @"" : model.password,base64,model.CorporationChiName,model.CorporationEngName,model.BusinessRegistrationType,model.BusinessRegistrationNo,model.ChiNameTitle,model.ChiLastName,model.ChiFirstName,model.EngNameTitle,model.EngLastName,model.EngFirstName,model.Sex,model.Email,model.TelCountryCode,model.TelNo,model.AddressRoom,model.AddressBldg,model.AddressEstate,model.AddressStreet,_districtField1.text,model.AddressCountry,model.Position,model.BelongTo, model.AcceptEDM,model.DonationInterest,model.JoinVolunteer,model.VolunteerType,model.VolunteerStartDate,model.VolunteerEndDate,model.VolunteerInterest,model.VolunteerInterest_Other,model.AvailableTime,model.AvailableTime_Other,model.AppToken, fbID, wbID,lang];
       // MyLog(@"soapMessage ======= %@",soapMessage);
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
            //
            //        // 服务器给我们返回的包得头部信息
            //        MyLog(@"%@", operation.response);
            [self removeLoadingAlert];
            NSString * dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSDictionary * dict = [NSString parseJSONStringToNSDictionary:dataString];
            NSUInteger l = [[NSString captureData:dataString] length];
            NSRange range = {1,l-2};
            NSString * str = [NSString stringWithFormat:@"%@",[NSString captureData:dataString]];
            _registerResult = [str substringWithRange:range];
           // MyLog(@"-----------------%@",_registerResult);

            if (dict != nil) {
                if (self.flag == 1) {
                    _isSuccessful1 = YES;
                    if (_fbdata != nil) {
                       // MyLog(@"set EGIVE_SOCIAL_ID");
                        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
                        [standardUserDefaults setObject:@"1" forKey:[NSString stringWithFormat:@"fb%@", fbID]];
                        [standardUserDefaults synchronize];
                    }
                    if (_wbdata != nil) {
                      //  MyLog(@"set EGIVE_SOCIAL_ID");
                        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
                        [standardUserDefaults setObject:wbID forKey:@"EGIVE_SOCIAL_ID"];
                        [standardUserDefaults setObject:@"1" forKey:[NSString stringWithFormat:@"wb%@", wbID]];
                        [standardUserDefaults synchronize];
                    }
                }
                _isSuccessful = YES;
                _registerResult = dict[@"MemberID"];
                _backName = model.LoginName;
                if (_fbdata == nil && _wbdata == nil) {
//                    self.alertVc.model = self.model;
//                    self.alertVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//                    [self.view.window.rootViewController presentViewController:self.alertVc animated:YES completion:nil];
                }
                
                if (_fbdata != nil){
                    _fbdata = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _fbdata = nil;
                        _wbdata = nil;
                        _userName.text = @"";
                        _lastNameCh.text = @"";
                        _lastNameEn.text = @"";
                        _nameCh.text = @"";
                        _nameEn.text = @"";
                        _email.text = @"";
                        _passWord.text = @"";
                        _confirmPsw.text = @"";
                    });
                    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
                    [standardUserDefaults setObject:@"0" forKey:@"FACEBOOK_REG_REQ"];
                    [standardUserDefaults setObject:@"0" forKey:@"WEIBO_REG_REQ"];
                    [standardUserDefaults synchronize];
                    
                    [_theParentVC requestLoginApiData:@"facebook"];
                }
                
                if (_wbdata != nil) {
                    _wbdata = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _fbdata = nil;
                        _wbdata = nil;
                        _userName.text = @"";
                        _lastNameCh.text = @"";
                        _lastNameEn.text = @"";
                        _nameCh.text = @"";
                        _nameEn.text = @"";
                        _email.text = @"";
                        _passWord.text = @"";
                        _confirmPsw.text = @"";
                    });
                    
                    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
                    [standardUserDefaults setObject:@"0" forKey:@"FACEBOOK_REG_REQ"];
                    [standardUserDefaults setObject:@"0" forKey:@"WEIBO_REG_REQ"];
                    [standardUserDefaults synchronize];
                    
                    [_theParentVC requestLoginApiData:@"weibo"];
                }
                
                UIAlertView *alertView = [[UIAlertView alloc] init];
                alertView.delegate = self;
                alertView.message = EGLocalizedString(@"注册成功!请点击确定按钮返回登入页面!", nil);
                [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                [alertView show];

            }else{
                
                
                if ([_registerResult isEqualToString:@"\"Error(5005)\""]||[_registerResult isEqualToString:@"Error(5005)"]) {
                    
                    UIAlertView *alertView = [[UIAlertView alloc] init];
                    alertView.message = EGLocalizedString(@"电邮已被注册", nil);
                    [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                    [alertView show];
                    
                }else if ([_registerResult isEqualToString:@"Error(5003)"]){
                    
                     //_userNameLoginFlag=false;
                    UIAlertView *alertView = [[UIAlertView alloc] init];
                    alertView.message = EGLocalizedString(@"此账号已被注册", nil);
                    [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                    [alertView show];
                
                    
                   
                
                }else{
                
                    UIAlertView *alertView = [[UIAlertView alloc] init];
                    alertView.message = _registerResult;
                    [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                    [alertView show];
                   
                
                }
                
               
                
            }
           

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
           // MyLog(@"%@", operation.request.allHTTPHeaderFields);
            // 服务器给我们返回的包得头部信息
           // MyLog(@"%@", operation.response);
            // 返回的数据
            //MyLog(@"success = %@", error);
            [self removeLoadingAlert];
        }];
        
        [operation start];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==1009 || alertView.tag==1010){
        
    }else{
    if (self.Action) {
        _Action(_backName);
    }
    _isSuccessful = NO;
    _isSuccessful1 = NO;
    if (_fbdata != nil || _wbdata != nil) {
        _fbdata = nil;
        _wbdata = nil;
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        [_theParentVC preformUpdateLoginFields: [standardUserDefaults objectForKey:@"EGIVE_LOGIN"] andPassword:[standardUserDefaults objectForKey:@"EGIVE_PASSWORD"]];
    }
    [self.navigationController popViewControllerAnimated:YES];
  }
}


#pragma mark - 所有fram回到初始位置
- (void)resetFram{
    if (_isOther) {
        _isOther = NO;
        self.otherText1.hidden = YES;
        [self touchNoButtonAction];
//        [self touchNoConsiderAction];
        self.twoScrollView.contentSize = CGSizeMake(0,1075+20);
//        self.orgCommitButton.frame = CGRectMake(20, 940, ScreenSize.width-40, 30);
        self.view1.frame = CGRectMake(0, 40, ScreenSize.width, 230);
        self.view2.frame = CGRectMake(0, 270, ScreenSize.width, 580+50);
        self.view3.frame = CGRectMake(0, 850+50, ScreenSize.width, 80);
        //_selBtn.text = EGLocalizedString(@"不適用", nil);
        _selBtn.text=@"";
        _pickerViewPopupBusiness.hidden = YES;
        _pickerViewPopup.hidden = YES;
    }
}

#pragma mark - 点击否执行的方法
- (void)touchNoButtonAction{
    //标记是不是展开了
    _orgIsEamil = NO;
    _orgButton5.selected = NO;
    _orgButton55.selected = YES;
    
    if (_orgIsVolunteer) {
        if (_isOther) {
            _view3.frame = CGRectMake(0, 850+50, ScreenSize.width, 80);
            _orgEmailView.hidden = YES;
//            self.orgCommitButton.frame = CGRectMake(20, 940+70, ScreenSize.width-40, 30);
            _twoScrollView.contentSize = CGSizeMake(0,1075+780+50);
            _orgVolunteerView.frame = CGRectMake(20, 930+70+50, ScreenSize.width-40, 780);
//            self.orgCommitButton.frame = CGRectMake(20, 940+780+70, ScreenSize.width-40, 30);
        }else{
            _view3.frame = CGRectMake(0, 850+50, ScreenSize.width, 80);
            _orgEmailView.hidden = YES;
            _twoScrollView.contentSize = CGSizeMake(0,1075+50);
//            self.orgCommitButton.frame = CGRectMake(20, 940, ScreenSize.width-40, 30);
            _twoScrollView.contentSize = CGSizeMake(0,1075+780+50);
            _orgVolunteerView.frame = CGRectMake(20, 930+50, ScreenSize.width-40, 780);
//            self.orgCommitButton.frame = CGRectMake(20, 940+780, ScreenSize.width-40, 30);
        }
        
    }else{
        if (_isOther) {
            _view3.frame = CGRectMake(0, 850+50+70, ScreenSize.width, 80);
            _orgEmailView.hidden = YES;
            _twoScrollView.contentSize = CGSizeMake(0,1075+50+70);
//            self.orgCommitButton.frame = CGRectMake(20, 940+70, ScreenSize.width-40, 30);
        }else{
            _view3.frame = CGRectMake(0, 850+50, ScreenSize.width, 80);
            _orgEmailView.hidden = YES;
            _twoScrollView.contentSize = CGSizeMake(0,1075+50);
//            self.orgCommitButton.frame = CGRectMake(20, 940, ScreenSize.width-40, 30);
        }
        
    }
    
    //_twoScrollView.contentSize  = CGSizeMake(_twoScrollView.contentSize.width, _twoScrollView.contentSize.height + 50);
}

#pragma mark - 点击暂不考虑执行的方法
- (void)touchNoConsiderAction{
    
    _orgIsVolunteer = NO;
    if (_orgIsEamil) {
        if (_isOther) {
            _orgIsButton.selected = NO;
            _orgNoButton.selected = YES;
            _orgVolunteerView.hidden = YES;
            _twoScrollView.contentSize = CGSizeMake(0,1075+200+80);
//            self.orgCommitButton.frame = CGRectMake(20, 940+200+80, ScreenSize.width-40, 30);
        }else{
            _orgIsButton.selected = NO;
            _orgNoButton.selected = YES;
            _orgVolunteerView.hidden = YES;
            _twoScrollView.contentSize = CGSizeMake(0,1075+200);
//            self.orgCommitButton.frame = CGRectMake(20, 940+200, ScreenSize.width-40, 30);
            
        }
    }else{
        if (_isOther) {
            _orgIsButton.selected = NO;
            _orgNoButton.selected = YES;
            _orgVolunteerView.hidden = YES;
            _twoScrollView.contentSize = CGSizeMake(0,1075+70);
//            self.orgCommitButton.frame = CGRectMake(20, 940+70, ScreenSize.width-40, 30);
        }else{
            
            _orgIsButton.selected = NO;
            _orgNoButton.selected = YES;
            _orgVolunteerView.hidden = YES;
            _twoScrollView.contentSize = CGSizeMake(0,1075);
//            self.orgCommitButton.frame = CGRectMake(20, 940, ScreenSize.width-40, 30);
        }
        
        
    }

}

#pragma mark - 选择性别
- (void)sexAction:(UIButton *)button{
    
    UIButton * mrButton = (UIButton *)[_oneView viewWithTag:101];
    UIButton * mrsButton = (UIButton *)[_oneView viewWithTag:102];
    UIButton * missButton = (UIButton *)[_oneView viewWithTag:103];
    if (button.tag == 101) {
        mrButton.selected = YES;
        mrsButton.selected = NO;
        missButton.selected = NO;
        _sexType = @"R";
    }else if (button.tag == 102){
        mrButton.selected = NO;
        mrsButton.selected = YES;
        missButton.selected = NO;
        _sexType = @"S";
    }else if (button.tag == 103){
        mrButton.selected = NO;
        mrsButton.selected = NO;
        missButton.selected = YES;
        _sexType = @"M";
    }

}
#pragma mark - 是否接收电邮资讯事件方法
- (void)isEmailButtonAction:(UIButton *)button{
    _pickerViewPopupBelongTo.hidden=YES;
   // MyLog(@"(void)isEmailButtonAction:(UIButton *)button{");
    _isEmailButton.backgroundColor = [UIColor whiteColor];
    [_isEmailButton setTitleColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:62/255.0 alpha:1] forState:UIControlStateNormal];
    _noEmailButton.backgroundColor = [UIColor whiteColor];
    [_noEmailButton setTitleColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:62/255.0 alpha:1] forState:UIControlStateNormal];
    if (button.tag == 104) {
        _isEamil = YES;
        _isSelEmail = @"1";
       button.backgroundColor = [UIColor colorWithRed:98/255.0 green:185/255.0 blue:62/255.0 alpha:1];
      [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _noEmailButton.selected=NO;
        _isEmailButton.selected=YES;
        if (_isVolunteer) {
            _volunteerView.frame = CGRectMake(20, 465+200, ScreenSize.width-40, 800);
            _volunteerView.hidden = NO;
            [_one setContentOffset:CGPointMake(0, 350) animated:YES];
            _emailView.hidden = NO;
            _note.frame = CGRectMake(20, 590, ScreenSize.width-40, 65);
            _yButton.frame = CGRectMake(20, 600+30, ScreenSize.width/2-20, 25);
            _nButton.frame = CGRectMake(ScreenSize.width/2, 600+30, ScreenSize.width/2-20, 25);
            _one.contentSize = CGSizeMake(ScreenSize.width, 568+820+300);
            _oneView.frame = CGRectMake(0, 0, ScreenSize.width, 568+820+200);
            _individualButton3.frame = CGRectMake(20, ScreenSize.height - 180+200, 75, 25);
            _telField.frame = CGRectMake(105, 500+200, ScreenSize.width-125, 25);

        }else{
            [_one setContentOffset:CGPointMake(0, 200) animated:YES];
            _one.contentSize = CGSizeMake(ScreenSize.width, 568+300);
            _oneView.frame = CGRectMake(0, 0, ScreenSize.width, 568+200);
            _emailView.hidden = NO;
            _note.frame = CGRectMake(20, 560+30, ScreenSize.width-40, 65);
            _yButton.frame = CGRectMake(20, 600+50, ScreenSize.width/2-20, 25);
            _nButton.frame = CGRectMake(ScreenSize.width/2, 600+50, ScreenSize.width/2-20, 25);
            _individualButton3.frame = CGRectMake(20, 470+200, 75, 25);
             _telDistrictField.frame = CGRectMake(20, 500+200, 75, 25);
            _telField.frame = CGRectMake(105,500+200, ScreenSize.width-125, 25);
        }

    }else{
        
        for (int i = 0; i < 8; i ++) {
            UIButton * button = (UIButton *)[_emailView viewWithTag:110+i];
            button.selected = NO;
        }
        _noEmailButton.selected=YES;
        _isEmailButton.selected=NO;
        _isSelEmail = @"0";
        _isEamil = NO;
        button.backgroundColor = [UIColor colorWithRed:98/255.0 green:185/255.0 blue:62/255.0 alpha:1];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        if (_isVolunteer) {
            _one.contentSize = CGSizeMake(ScreenSize.width, 568+820);
            _oneView.frame = CGRectMake(0, 0, ScreenSize.width, 568+820);
            _emailView.hidden = YES;
            _note.frame = CGRectMake(20, 390, ScreenSize.width-40, 65);
            _yButton.frame = CGRectMake(20, 600-165, ScreenSize.width/2-20, 25);
            _nButton.frame = CGRectMake(ScreenSize.width/2, 600-165, ScreenSize.width/2-20, 25);
            _volunteerView.frame = CGRectMake(20, 465, ScreenSize.width-40, 800+100);
            _individualButton3.frame = CGRectMake(20, 500, 75, 25);
            _telField.frame = CGRectMake(105, 500, ScreenSize.width-125, 25);
            
        }else{
//            _one.contentSize = CGSizeMake(ScreenSize.width, 568);
            _one.contentSize = CGSizeMake(ScreenSize.width, 580 + 100);
            _oneView.frame = CGRectMake(0, 0, ScreenSize.width, 568);
            _emailView.hidden = YES;
            _note.frame = CGRectMake(20, 390, ScreenSize.width-40, 65);
            _yButton.frame = CGRectMake(20, 450, ScreenSize.width/2-20, 25);
            _nButton.frame = CGRectMake(ScreenSize.width/2, 450, ScreenSize.width/2-20, 25);
            _individualButton3.frame = CGRectMake(20, ScreenSize.height - 180, 75, 25);
            _telField.frame = CGRectMake(105, 500, ScreenSize.width-125, 25);
           _telDistrictField.frame = CGRectMake(20, 500, 75, 25);
            CGPoint bottomOffset = CGPointMake(0, 0);
            [_one setContentOffset:bottomOffset animated:YES];
        }
    }
    
}

#pragma mark - 个人登记的义工选项视图
- (void)createVoView{
    
    __weak typeof(self) weakSelf = self;
    
    UILabel * label1 = [_volunteerView addLabelWithFrame:CGRectMake(0, 0, 160, 25) text:EGLocalizedString(@"义工服务意向", nil)];
    label1.font = [UIFont systemFontOfSize:12];
    
    UILabel * label2 = [_volunteerView addLabelWithFrame:CGRectMake(0, 30, 160, 25) text:EGLocalizedString(@"我愿意成为意赠慈善基金的:", nil)];
    label2.font = [UIFont systemFontOfSize:12];
    
    _shortVolunteer = [_volunteerView addImageButtonWithFrame:CGRectMake(0, 70, ScreenSize.width/2 -20, 25) title:@"长期义工" backgroud:@"comment_segment_left_nor.png" action:^(UIButton *button) {
        weakSelf.longVolunteer.selected = NO;
        button.selected = YES;
        
    }];
    _shortVolunteer.titleLabel.font = [UIFont systemFontOfSize:14];
    [_shortVolunteer setBackgroundImage:[UIImage imageNamed:@"comment_segment_left_sel.png"] forState:UIControlStateSelected];

    _longVolunteer = [_volunteerView addImageButtonWithFrame:CGRectMake(ScreenSize.width/2 -20, 70, ScreenSize.width/2-20, 25) title:EGLocalizedString(@"短期义工", nil) backgroud:@"comment_segment_right_nor.png" action:^(UIButton *button) {
        
        weakSelf.shortVolunteer.selected = NO;
        button.selected = YES;
    }];
    _longVolunteer.titleLabel.font = [UIFont systemFontOfSize:14];
    _longVolunteer.selected = YES;
    [_longVolunteer setBackgroundImage:[UIImage imageNamed:@"comment_segment_right_sel.png"] forState:UIControlStateSelected];
    
    
    _dateStart = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, ScreenSize.width/2-21, 30)];
    _dateStart.placeholder = @"由(YYYY/MM/DD)";
    _dateStart.delegate = self;
    _dateStart.font = [UIFont systemFontOfSize:12];
    _dateStart.borderStyle = UITextBorderStyleRoundedRect;
    [_volunteerView addSubview:_dateStart];
    
    _dateEnd = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2-19, 100, ScreenSize.width/2-21, 30)];
    _dateEnd.placeholder = @"至(YYYY/MM/DD)";
    _dateEnd.delegate = self;
    _dateEnd.font = [UIFont systemFontOfSize:12];
    _dateEnd.borderStyle = UITextBorderStyleRoundedRect;
    [_volunteerView addSubview:_dateEnd];
    
    UILabel * noteLabel = [_volunteerView addLabelWithFrame:CGRectMake(0, 135, 200, 25) text:EGLocalizedString(@"有关协助之项目:(可选择多项)", nil)];
    noteLabel.textColor = [UIColor grayColor];
    noteLabel.font = [UIFont boldSystemFontOfSize:12];
    
    UIButton * firstButton = [_volunteerView addImageButtonWithFrame:CGRectMake(0, 170, 20, 20) title:nil backgroud:@"cart_checkbox_nor.png" action:^(UIButton *button) {
        
        if (button.selected) {
            button.selected = NO;
            [weakSelf.volunteerInterestArr removeObject:@"Admin,"];
        }else
            button.selected = YES;
        [weakSelf.volunteerInterestArr addObject:@"Admin,"];
    }];
    [firstButton setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
    
    
    UILabel * firstLabel = [_volunteerView addLabelWithFrame:CGRectMake(30, 165, ScreenSize.width-60, 40) text:EGLocalizedString(@"办事处行政服务:(资料输入,信件处理,一般行政工作等)", nil)];
    firstLabel.numberOfLines = 2;
    firstLabel.font = [UIFont boldSystemFontOfSize:12];
    
   
    NSArray * emailViewTitleArray = @[EGLocalizedString(@"印刷品设计", nil),EGLocalizedString(@"活动联络", nil),EGLocalizedString(@"编辑", nil),EGLocalizedString(@"翻译(中英/英中)", nil),EGLocalizedString(@"文稿撰写", nil),EGLocalizedString(@"摄影", nil),EGLocalizedString(@"協辦籌款活動(不定期舉辦)", nil),EGLocalizedString(@"探访", nil),EGLocalizedString(@"其他", nil)];
    for (int i = 0; i < 9; i ++) {
        _helpTypeButton = [_volunteerView addImageButtonWithFrame:CGRectMake(i%2*(ScreenSize.width/2), i/2*45+210, 20, 20) title:nil backgroud:@"cart_checkbox_nor.png" action:^(UIButton *button) {
            
            if (button.tag == 120) {
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.volunteerInterestArr removeObject:@"Print,"];
                }else{
                    button.selected = YES;
                    [weakSelf.volunteerInterestArr addObject:@"Print,"];
                }
                
                
            }else if (button.tag == 121){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.volunteerInterestArr removeObject:@"Contact,"];
                }else{
                    button.selected = YES;
                    [weakSelf.volunteerInterestArr addObject:@"Contact,"];
                }
                
            }else if (button.tag == 122){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.volunteerInterestArr removeObject:@"Editing,"];
                }else{
                    button.selected = YES;
                    [weakSelf.volunteerInterestArr addObject:@"Editing,"];
                }
            }else if (button.tag == 123){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.volunteerInterestArr removeObject:@"Translate,"];
                }else{
                    button.selected = YES;
                    [weakSelf.volunteerInterestArr addObject:@"Translate,"];
                }
            }else if (button.tag == 124){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.volunteerInterestArr removeObject:@"Write,"];
                }else{
                    button.selected = YES;
                    [weakSelf.volunteerInterestArr addObject:@"Write,"];
                }
            }else if (button.tag == 125){
                if (button.selected) {
                    button.selected = NO;
                     [weakSelf.volunteerInterestArr removeObject:@"Photo,"];
                }else{
                    button.selected = YES;
                    [weakSelf.volunteerInterestArr addObject:@"Photo,"];
                }
            }else if (button.tag == 126){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.volunteerInterestArr removeObject:@"Event,"];
                }else{
                    button.selected = YES;
                    [weakSelf.volunteerInterestArr addObject:@"Event,"];
                }
                
            }else if (button.tag == 127){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.volunteerInterestArr removeObject:@"Visit,"];
                }else{
                    button.selected = YES;
                    [weakSelf.volunteerInterestArr addObject:@"Visit,"];
                }
            }else if (button.tag == 128){
                if (button.selected) {
                    button.selected = NO;
                }else
                    button.selected = YES;
            }
            
        }];
        _helpTypeButton.tag = 120+i;
        [_helpTypeButton setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
        
        UILabel * label = [_volunteerView addLabelWithFrame:CGRectMake(i%2*(ScreenSize.width/2)+30, i/2*45+202, ScreenSize.width/2-35, 40) text:emailViewTitleArray[i]];
        label.numberOfLines = 2;
        label.font = [UIFont boldSystemFontOfSize:12];
        
    }
    
    _noteText = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2-80,388 , ScreenSize.width/2+30, 25)];
    _noteText.placeholder = EGLocalizedString(@"请说明", nil);
    _noteText.delegate = self;
    _noteText.font = [UIFont systemFontOfSize:12];
    _noteText.borderStyle = UITextBorderStyleRoundedRect;
    [_volunteerView addSubview:_noteText];
    
    UILabel * timeLabel = [_volunteerView addLabelWithFrame:CGRectMake(0, 425, 200, 25) text:EGLocalizedString(@"可服务的时间(可选择多项)", nil)];
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.font = [UIFont boldSystemFontOfSize:12];
    
    
    NSArray * timeTitleArray = @[EGLocalizedString(@"星期一", nil),EGLocalizedString(@"星期二", nil),EGLocalizedString(@"星期三", nil),EGLocalizedString(@"星期四", nil),EGLocalizedString(@"星期五", nil),EGLocalizedString(@"星期六", nil),EGLocalizedString(@"星期日", nil),EGLocalizedString(@"任何时间", nil),EGLocalizedString(@"上午10时至下午1时", nil),EGLocalizedString(@"下午2時至下午5時", nil),EGLocalizedString(@"上午10時至下午5時", nil),EGLocalizedString(@"晚上7時至9時", nil),EGLocalizedString(@"其他", nil)];
    for (int i = 0; i < 13; i ++) {
        _timesButton = [_volunteerView addImageButtonWithFrame:CGRectMake(i%2*(ScreenSize.width/2), i/2*45+460, 20, 20) title:nil backgroud:@"cart_checkbox_nor.png" action:^(UIButton *button) {
            
            if (button.tag == 130) {
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Mon,"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Mon,"];
                }
                
            }else if (button.tag == 131){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Tues,"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Tues,"];
                }
                
            }else if (button.tag == 132){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Wed,"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Wed,"];
                }

                
            }else if (button.tag == 133){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Thurs,"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Thurs,"];
                }

                
            }else if (button.tag == 134){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Fri,"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Fri,"];
                }

                
            }else if (button.tag == 135){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Sat,"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Sat,"];
                }

                
            }else if (button.tag == 136){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Sun,"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Sun,"];
                }

                
            }else if (button.tag == 137){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"All,"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"All,"];
                }

                
            }else if (button.tag == 138){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Morning,"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Morning,"];
                }

                
            }else if (button.tag == 139){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Afternoon,"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Afternoon,"];
                }

                
            }else if (button.tag == 140){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Evening,"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Evening,"];
                }

                
            }else if (button.tag == 141){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"WholeDay,"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"WholeDay,"];
                }

                
            }else{
                if (button.selected) {
                    button.selected = NO;
                }else
                    button.selected = YES;
            }
            
        }];
        _timesButton.tag = 130+i;
        [_timesButton setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
        
        UILabel * label = [_volunteerView addLabelWithFrame:CGRectMake(i%2*(ScreenSize.width/2)+30, i/2*45+460, ScreenSize.width/2-35, 20) text:timeTitleArray[i]];
        label.numberOfLines = 2;
        label.font = [UIFont boldSystemFontOfSize:12];
        
    }

    _noteTimeText = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2-80,728 , ScreenSize.width/2+30, 25)];
    _noteTimeText.placeholder = @"请说明";
    _noteTimeText.delegate = self;
    _noteTimeText.font = [UIFont systemFontOfSize:12];
    _noteTimeText.borderStyle = UITextBorderStyleRoundedRect;
    [_volunteerView addSubview:_noteTimeText];
}

#pragma mark - 机构登记的义工选项视图
- (void)createOrgVoView{
    
    __weak typeof(self) weakSelf = self;
    
    UILabel * label1 = [_orgVolunteerView addLabelWithFrame:CGRectMake(0, 0, 160, 25) text:EGLocalizedString(@"义工服务意向", nil)];
    label1.font = [UIFont systemFontOfSize:12];
    
    UILabel * label2 = [_orgVolunteerView addLabelWithFrame:CGRectMake(0, 30, 160, 25) text:EGLocalizedString(@"我愿意成为意赠慈善基金的:", nil)];
    label2.font = [UIFont systemFontOfSize:12];
    
    _orgShortVolunteer = [_orgVolunteerView addImageButtonWithFrame:CGRectMake(0, 70, ScreenSize.width/2 -20, 25) title:EGLocalizedString(@"长期义工", nil) backgroud:@"comment_segment_left_nor.png" action:^(UIButton *button) {
        weakSelf.orgLongVolunteer.selected = NO;
        button.selected = YES;
        
    }];
    _orgShortVolunteer.titleLabel.font = [UIFont systemFontOfSize:14];
    _orgShortVolunteer.layer.cornerRadius = 4;
    [_orgShortVolunteer setBackgroundImage:[UIImage imageNamed:@"comment_segment_left_sel.png"] forState:UIControlStateSelected];
    
    _orgLongVolunteer = [_orgVolunteerView addImageButtonWithFrame:CGRectMake(ScreenSize.width/2 -20, 70, ScreenSize.width/2-20, 25) title:EGLocalizedString(@"短期义工", nil) backgroud:@"comment_segment_right_nor.png" action:^(UIButton *button) {
        
        weakSelf.orgShortVolunteer.selected = NO;
        button.selected = YES;
    }];
    _orgLongVolunteer.titleLabel.font = [UIFont systemFontOfSize:14];
    _orgLongVolunteer.selected = YES;
    _orgLongVolunteer.layer.cornerRadius = 4;
    [_orgLongVolunteer setBackgroundImage:[UIImage imageNamed:@"comment_segment_right_sel.png"] forState:UIControlStateSelected];
    
    
    _dateStart = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, ScreenSize.width/2-21, 30)];
    _dateStart.placeholder = @"由(YYYY/MM/DD)";
    _dateStart.delegate = self;
    _dateStart.font = [UIFont systemFontOfSize:12];
    _dateStart.borderStyle = UITextBorderStyleRoundedRect;
    [_orgVolunteerView addSubview:_dateStart];
    
    _dateEnd = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2-19, 100, ScreenSize.width/2-21, 30)];
    _dateEnd.placeholder = @"至(YYYY/MM/DD)";
    _dateEnd.delegate = self;
    _dateEnd.font = [UIFont systemFontOfSize:12];
    _dateEnd.borderStyle = UITextBorderStyleRoundedRect;
    [_orgVolunteerView addSubview:_dateEnd];
    
    UILabel * noteLabel = [_orgVolunteerView addLabelWithFrame:CGRectMake(0, 135, 200, 25) text:EGLocalizedString(@"有关协助之项目:(可选择多项)", nil)];
    noteLabel.textColor = [UIColor grayColor];
    noteLabel.font = [UIFont boldSystemFontOfSize:12];
    
    UIButton * firstButton = [_orgVolunteerView addImageButtonWithFrame:CGRectMake(0, 170, 20, 20) title:nil backgroud:@"cart_checkbox_nor.png" action:^(UIButton *button) {
        
        if (button.selected) {
            button.selected = NO;
            [weakSelf.volunteerInterestArr removeObject:@"Admin"];
        }else
            button.selected = YES;
        [weakSelf.volunteerInterestArr addObject:@"Admin"];
    }];
    [firstButton setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
    
    
    UILabel * firstLabel = [_orgVolunteerView addLabelWithFrame:CGRectMake(30, 165, ScreenSize.width-60, 40) text:EGLocalizedString(@"办事处行政服务:(资料输入,信件处理,一般行政工作等)", nil)];
    firstLabel.numberOfLines = 2;
    firstLabel.font = [UIFont boldSystemFontOfSize:12];
    
    
    NSArray * emailViewTitleArray = @[EGLocalizedString(@"印刷品设计", nil),EGLocalizedString(@"活动联络", nil),EGLocalizedString(@"编辑", nil),EGLocalizedString(@"翻译(中英/英中)", nil),EGLocalizedString(@"文稿撰写", nil),EGLocalizedString(@"摄影", nil),EGLocalizedString(@"協辦籌款活動(不定期舉辦)", nil),EGLocalizedString(@"探访", nil),EGLocalizedString(@"其他", nil)];
    for (int i = 0; i < 9; i ++) {
        _helpTypeButton = [_orgVolunteerView addImageButtonWithFrame:CGRectMake(i%2*(ScreenSize.width/2), i/2*45+210, 20, 20) title:nil backgroud:@"cart_checkbox_nor.png" action:^(UIButton *button) {
            
            if (button.tag == 120) {
                if (button.selected){
                    button.selected = NO;
                    [weakSelf.volunteerInterestArr removeObject:@"Print"];
                }else{
                    button.selected = YES;
                    [weakSelf.volunteerInterestArr addObject:@"Admin"];
                }
                
                
            }else if (button.tag == 121){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.volunteerInterestArr removeObject:@"Contact"];
                }else{
                    button.selected = YES;
                    [weakSelf.volunteerInterestArr addObject:@"Contact"];
                }
                
            }else if (button.tag == 122){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.volunteerInterestArr removeObject:@"Editing"];
                }else{
                    button.selected = YES;
                    [weakSelf.volunteerInterestArr addObject:@"Editing"];
                }
            }else if (button.tag == 123){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.volunteerInterestArr removeObject:@"Translate"];
                }else{
                    button.selected = YES;
                    [weakSelf.volunteerInterestArr addObject:@"Translate"];
                }
            }else if (button.tag == 124){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.volunteerInterestArr removeObject:@"Write"];
                }else{
                    button.selected = YES;
                    [weakSelf.volunteerInterestArr addObject:@"Write"];
                }
            }else if (button.tag == 125){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.volunteerInterestArr removeObject:@"Photo"];
                }else{
                    button.selected = YES;
                    [weakSelf.volunteerInterestArr addObject:@"Photo"];
                }
            }else if (button.tag == 126){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.volunteerInterestArr removeObject:@"Event"];
                }else{
                    button.selected = YES;
                    [weakSelf.volunteerInterestArr addObject:@"Event"];
                }
                
            }else if (button.tag == 127){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.volunteerInterestArr removeObject:@"Visit"];
                }else{
                    button.selected = YES;
                    [weakSelf.volunteerInterestArr addObject:@"Visit"];
                }
            }else if (button.tag == 128){
                if (button.selected) {
                    button.selected = NO;
                }else
                    button.selected = YES;
            }
            
        }];
        _helpTypeButton.tag = 120+i;
        [_helpTypeButton setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
        
        UILabel * label = [_orgVolunteerView addLabelWithFrame:CGRectMake(i%2*(ScreenSize.width/2)+30, i/2*45+202, ScreenSize.width/2-35, 40) text:emailViewTitleArray[i]];
        label.numberOfLines = 2;
        label.font = [UIFont boldSystemFontOfSize:12];
        
    }
    
    _noteText = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2-80,388 , ScreenSize.width/2+30, 25)];
    _noteText.placeholder = EGLocalizedString(@"请说明", nil);
    _noteText.layer.borderColor=[[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1]CGColor];
    _noteText.delegate = self;
    _noteText.font = [UIFont systemFontOfSize:12];
    _noteText.borderStyle = UITextBorderStyleRoundedRect;
    [_orgVolunteerView addSubview:_noteText];
    
    UILabel * timeLabel = [_orgVolunteerView addLabelWithFrame:CGRectMake(0, 425, 200, 25) text:EGLocalizedString(@"可服务的时间(可选择多项)", nil)];
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.font = [UIFont boldSystemFontOfSize:12];
    
    NSArray * timeTitleArray = @[EGLocalizedString(@"星期一", nil),EGLocalizedString(@"星期二", nil),EGLocalizedString(@"星期三", nil),EGLocalizedString(@"星期四", nil),EGLocalizedString(@"星期五", nil),EGLocalizedString(@"星期六", nil),EGLocalizedString(@"星期日", nil),EGLocalizedString(@"任何时间", nil),EGLocalizedString(@"上午10时至下午1时", nil),EGLocalizedString(@"下午2時至下午5時", nil),EGLocalizedString(@"上午10時至下午5時", nil),EGLocalizedString(@"晚上7時至9時", nil),EGLocalizedString(@"其他", nil)];
    for (int i = 0; i < 13; i ++) {
        _timesButton = [_orgVolunteerView addImageButtonWithFrame:CGRectMake(i%2*(ScreenSize.width/2), i/2*45+460, 20, 20) title:nil backgroud:@"cart_checkbox_nor.png" action:^(UIButton *button) {
            
            if (button.tag == 130) {
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Mon"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Mon"];
                }
                
            }else if (button.tag == 131){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Tues"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Tues"];
                }
                
            }else if (button.tag == 132){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Wed"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Wed"];
                }
                
                
            }else if (button.tag == 133){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Thurs"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Thurs"];
                }
                
                
            }else if (button.tag == 134){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Fri"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Fri"];
                }
                
                
            }else if (button.tag == 135){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Sat"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Sat"];
                }
                
                
            }else if (button.tag == 136){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Sun"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Sun"];
                }
                
                
            }else if (button.tag == 137){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"All"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"All"];
                }
                
                
            }else if (button.tag == 138){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Morning"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Morning"];
                }
                
                
            }else if (button.tag == 139){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Afternoon"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Afternoon"];
                }
                
                
            }else if (button.tag == 140){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"Evening"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"Evening"];
                }
                
                
            }else if (button.tag == 141){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.availableTimeArr removeObject:@"WholeDay"];
                }else{
                    button.selected = YES;
                    [weakSelf.availableTimeArr addObject:@"WholeDay"];
                }

            }else{
                if (button.selected) {
                    button.selected = NO;
                }else
                    button.selected = YES;
            }
            
        }];
        _timesButton.tag = 130+i;
        [_timesButton setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
        
        UILabel * label = [_orgVolunteerView addLabelWithFrame:CGRectMake(i%2*(ScreenSize.width/2)+30, i/2*45+460, ScreenSize.width/2-35, 20) text:timeTitleArray[i]];
        label.numberOfLines = 2;
        label.font = [UIFont boldSystemFontOfSize:12];
        
    }
    
    _noteTimeText = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2-80,728 , ScreenSize.width/2+30, 25)];
    _noteTimeText.placeholder = EGLocalizedString(@"请说明", nil);
    _noteTimeText.delegate = self;
    _noteTimeText.font = [UIFont systemFontOfSize:12];
    _noteTimeText.borderStyle = UITextBorderStyleRoundedRect;
    [_orgVolunteerView addSubview:_noteTimeText];
}


#pragma mark 点击空白回收键盘
-(void)tapAction{

    for (int i = 1; i <= 9; i ++) {
        UITextField * textField = (UITextField *)[self.view viewWithTag:i];
        [textField resignFirstResponder];
    }
    [_dateStart resignFirstResponder];
    [_dateEnd resignFirstResponder];
    [_noteText resignFirstResponder];
    [_noteTimeText resignFirstResponder];

    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0, 0, _oneView.frame.size.width, _oneView.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    
}
#pragma mark 设置TextField代理
- (void)setTextFieldDelegate{
    
    for (int i = 1; i <= 9; i ++) {
        UITextField * textField = [[UITextField alloc]init];
        textField = (UITextField *)[self.view viewWithTag:i];
        textField.layer.borderColor=[[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1]CGColor];
        textField.layer.cornerRadius=3.0f;
        textField.layer.masksToBounds=YES;
        textField.layer.borderWidth= 1.0f;
        [textField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
        textField.delegate = self;
    }
    for (int i = 1; i <= 17; i ++) {
        UITextField * textField = [[UITextField alloc]init];
        textField = (UITextField *)[self.view viewWithTag:800+i];
        textField.layer.borderColor=[[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1]CGColor];
        [textField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
        textField.delegate = self;
    }
}

#pragma mark - UITextFieldDelegate
//解决虚拟键盘挡住UITextField的方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    _pickerViewPopupBelongTo.hidden=YES;
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];

    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if (textField.text.length + string.length > 50) {
//        return NO;
//    }
//    
//     NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
////    if (textField==_nameCh ||textField==_lastNameCh ) {
////        if (![self isZhongWenFirst:toBeString]) {
////            
////            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:EGLocalizedString(@"chneseName",nil) delegate:self cancelButtonTitle:nil otherButtonTitles:EGLocalizedString(@"Common_button_confirm",nil), nil];
////            alertView.tag=1009;
////            [alertView show];
////            return NO;
////            
////        }
//    
//   // }else
//      if (textField==_textField9 ||textField==_textField10){
//    
//        if (![self pipeizimu:toBeString]){
//            
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:EGLocalizedString(@"englishName",nil) delegate:self cancelButtonTitle:nil otherButtonTitles:EGLocalizedString(@"Common_button_confirm",nil), nil];
//           alertView.tag=1010;
//        [alertView show];
//            return NO;
//        
//        }
//    
//    }
//    
//    return YES;
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _editing = textField;
 
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    int page = point.x/ScreenSize.width;
    if (page == 1) {
        _personalView.hidden = YES;
        _organizationView.hidden = NO;
        _commitButton.hidden = YES;
        _orgCommitButton.hidden = NO;
        [self.personalButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.personalButton setImage:[UIImage imageNamed:@"registration_person_nor.png"] forState:UIControlStateNormal];
        [self.organizationButton setTitleColor:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]forState:UIControlStateNormal];
        [self.organizationButton setImage:[UIImage imageNamed:@"registration_company_sel.png"] forState:UIControlStateNormal];
        
        self.pickerViewPopupBelongTo.hidden = YES;
        self.pickerViewPopup.hidden = YES;
    }else{
        _personalView.hidden = NO;
        _organizationView.hidden = YES;
        _commitButton.hidden = NO;
        _orgCommitButton.hidden = YES;
        [self.organizationButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.organizationButton setImage:[UIImage imageNamed:@"registration_company_nor.png"] forState:UIControlStateNormal];
        [self.personalButton setImage:[UIImage imageNamed:@"registration_person_sel.png"] forState:UIControlStateNormal];
        [self.personalButton setTitleColor:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1] forState:UIControlStateNormal];
        
        self.pickerViewPopupBelongTo.hidden = YES;
        self.pickerViewPopup.hidden = YES;
    }

}

- (void)PostIndividualUserInfo{
    
   // if ([_isSelEmail isEqualToString:@"1"] || [_isSelEmail isEqualToString:@"0"]){
        if (_yButton.selected || _nButton.selected) {
            MemberModel * model = [[MemberModel alloc] init];
            model.MemberType = @"P";
            model.Position = @"";
            model.TelNo = _telField.text;
            model.TelCountryCode = _telDistrictField.text;
            model.LoginName = _userName.text;
            model.password = _passWord.text;
            model.BusinessRegistrationType=@"";
            model.BusinessRegistrationNo=@"";
            model.CorporationType=@"";
            model.CorporationType_Other=@"";
            model.ChiNameTitle = _sexType;
            model.EngNameTitle = _sexType;
            if ([_sexType isEqualToString:@"R"]) {
                model.Sex = @"M";
            }else{
                model.Sex = @"F";
            }
            model.ChiLastName = _lastNameCh.text;
            model.ChiFirstName = _nameCh.text;
            model.EngLastName = _lastNameEn.text;
            model.EngFirstName = _nameEn.text;
            model.Email = [_email.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            //model.AddressCountry = _addressCountry;
            model.AddressRoom = @"";
            model.AddressBldg = @"";
            model.AddressEstate = @"";
            model.AddressStreet = @"";
            model.AddressDistrict = @"";
            model.AddressCountry=@"香港";
//            model.BelongTo = _belongCd[selectedBelongTo];
//            model.BelongTo = @"Other";
            model.BelongTo = [_belongCd objectAtIndex:selectedBelongTo];
            NSLog(@"model.BelongTo:%@",model.BelongTo);
            if ([_isSelEmail isEqualToString:@"1"]) {
                model.AcceptEDM = YES;
                
            }else{
                model.AcceptEDM = NO;
            }
            if (_yButton.selected) {
                model.JoinVolunteer = YES;
                if (_shortVolunteer.selected) {
                    model.VolunteerType = @"L";
                }else{
                    model.VolunteerType = @"S";
                }
                model.VolunteerStartDate = _dateStart.text;
                model.VolunteerEndDate = _dateEnd.text;
                NSMutableString * muStr = [[NSMutableString alloc] init];
                for (int i = 0; i < _volunteerInterestArr.count; i ++) {
                    [muStr appendString:_volunteerInterestArr[i]];
                }
                if (_volunteerInterestArr.count > 0) {
                    model.VolunteerInterest = muStr;
                    //MyLog(@"model.VolunteerInterest==%@",model.VolunteerInterest);
                }else{
                    model.VolunteerInterest = @" ";
                }
                
                NSMutableString * muStr1 = [[NSMutableString alloc] init];
                for (int i = 0; i < _availableTimeArr.count; i ++) {
                    [muStr1 appendString:_availableTimeArr[i]];
                }
                if (_availableTimeArr.count > 0) {
                    model.AvailableTime = muStr;
                    //MyLog(@"model.AvailableTi===%@",model.AvailableTime);
                }else{
                    model.AvailableTime = @" ";
                }
                
            }else{
                   model.JoinVolunteer = NO;
            }
            NSMutableString * muStr = [[NSMutableString alloc] init];
            for (int i = 0; i < _arr.count; i ++) {
                [muStr appendString:_arr[i]];
            }
            if (_arr.count > 0) {
                model.DonationInterest = muStr;
            }else{
                model.DonationInterest = @" ";
            }
            model.VolunteerType = @" ";
            model.VolunteerStartDate = @" ";
            model.VolunteerEndDate = @" ";
            model.VolunteerInterest_Other = @" ";
            model.AvailableTime_Other = @" ";
            NSString *Apptoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"GetendpointArn"];
            model.AppToken =Apptoken;
            [self SaveMemberInfo:model];
        }
//    }else{
//        UIAlertView *alertView = [[UIAlertView alloc] init];
//        alertView.message = EGLocalizedString(@"请选择是否定期收到电邮咨询!", nil);
//        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
//        [alertView show];
//    }

}
- (void)PostEnterpriseUserInfo {
    
    //if (![NSString isEmpty:_textField4.text andNote:EGLocalizedString(@"請輸入機構名稱(中)", nil)]) {
           // if (![NSString isEmpty:_textField13.text andNote:EGLocalizedString(@"請輸入電話", nil)]) {
                //if ([_isSelEmail isEqualToString:@"1"] || [_isSelEmail isEqualToString:@"0"]) {
                    
                    if (_yButton.selected || _nButton.selected) {
                        MemberModel * model = [[MemberModel alloc] init];
                        model.MemberType = @"C";
                        model.CorporationType = _CorporationType;
                        if ([model.CorporationType isEqualToString:@"E"])
                        {
                            model.CorporationType_Other = _otherText1.text;
                        } else {
                            model.CorporationType_Other = @"";
                        }
                        model.CorporationChiName = _textField4.text;
                        model.CorporationEngName = _textField5.text;
                        model.BusinessRegistrationType = _BusinessRegistrationType;
                        if(_isOther){
                            
                            model.BusinessRegistrationNo = otherBussessNumbertextField.text;
                            
                        }else{
                            model.BusinessRegistrationNo = _textField6.text;
                        }
                        model.Position = _textField11.text;
                        model.TelNo = _textField13.text;
                        model.TelCountryCode = _telDistrictFieldOrg.text;
                        model.LoginName = _textField1.text;
                        model.password = _textField2.text;
                        model.ChiNameTitle = _sexType;
                        model.EngNameTitle = _sexType;
                        if ([_sexType isEqualToString:@"R"]) {
                            model.Sex = @"M";
                        }else{
                            model.Sex = @"F";
                        }
                        model.ChiLastName = _textField7.text;
                        model.ChiFirstName = _textField8.text;
                        model.EngLastName = _textField9.text;
                        model.EngFirstName = _textField10.text;
                        model.Email = [_textField12.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                        UIButton * button = (UIButton *)[self.view2 viewWithTag:46];
                        if (button.selected){
                            
                            
                             model.AddressCountry = _otherRegion.text;
                            
                            
                        }else{
                            
                        
                            model.AddressCountry = @"香港";
                            
                            
                        }
                        model.AddressRoom = _textField14.text;
                        model.AddressBldg = _textField15.text;
                        model.AddressEstate = _textField16.text;
                        model.AddressStreet = _textField17.text;
                        model.AddressDistrict = _districtField1.text;
                        model.BelongTo = @"Other";
                        if ([_isSelEmail isEqualToString:@"1"]) {
                            model.AcceptEDM = YES;
                        }else{
                            model.AcceptEDM = NO;
                        }
                        
                        if (_orgIsButton.selected) {
                            model.JoinVolunteer = YES;
                            if (_shortVolunteer.selected) {
                                model.VolunteerType = @"L";
                            }else{
                                model.VolunteerType = @"S";
                            }
                            model.VolunteerStartDate = _dateStart.text;
                            model.VolunteerEndDate = _dateEnd.text;
                            //协助之项目
                            NSMutableString * muStr = [[NSMutableString alloc] init];
                            for (int i = 0; i < _volunteerInterestArr.count; i ++) {
                                [muStr appendString:_volunteerInterestArr[i]];
                            }
                            if (_arr1.count > 0) {
                                model.VolunteerInterest = muStr;
                            }else{
                                model.VolunteerInterest = @" ";
                            }
                            
                            //可服务时间
                            NSMutableString * muStr1 = [[NSMutableString alloc] init];
                            for (int i = 0; i < _availableTimeArr.count; i ++) {
                                [muStr1 appendString:_availableTimeArr[i]];
                            }
                            if (_arr1.count > 0) {
                                model.AvailableTime = muStr;
                            }else{
                                model.AvailableTime = @" ";
                            }
                            
                        }else{
                            model.JoinVolunteer = NO;
                        }
                        NSMutableString * muStr = [[NSMutableString alloc] init];
                        
                        //选择专案类别
                        for (int i = 0; i < _arr1.count; i ++) {
                            [muStr appendString:_arr1[i]];
                        }
                        if (_arr1.count > 0) {
                            model.DonationInterest = muStr;
                        }else{
                            model.DonationInterest = @" ";
                        }
                        
                        model.VolunteerType = @" ";
                        model.VolunteerStartDate = @" ";
                        model.VolunteerEndDate = @" ";
                        model.VolunteerInterest = @" ";
                        model.VolunteerInterest_Other = @" ";
                        model.AvailableTime = @" ";
                        model.AvailableTime_Other = @" ";
                        NSString *Apptoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"GetendpointArn"];
                        model.AppToken = Apptoken;
                        [self SaveMemberInfo:model];
                    }
                    
               // }  //else{
//                    UIAlertView *alertView = [[UIAlertView alloc] init];
//                    alertView.message = EGLocalizedString(@"请选择是否定期收到电邮咨询!", nil);
//                    [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
//                    [alertView show];
                //}
           // }
        //}
    }

-(void)EntrisethirdPartyLogin{

    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    
    _fbdata = nil;
    _wbdata = nil;
    
    if ([standardUserDefaults objectForKey:@"FACEBOOK_REG_REQ"] != nil && [[standardUserDefaults objectForKey:@"FACEBOOK_REG_REQ"] isEqualToString:@"1"])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self moveViews];
        });

        // MyLog(@"FACEBOOK_REG_REQ");
        _fbdata = [standardUserDefaults objectForKey:@"FACEBOOK_DETAIL"];
        
        if (_fbdata != nil) {
            //            NSString *fbemail = [_fbdata objectForKey:@"email"];
            //            NSString *fbemailname = [fbemail componentsSeparatedByString:@"@"][0];
            _userName.text = [_fbdata objectForKey:@"name"];
            _textField1.text=[_fbdata objectForKey:@"name"];
        }
        
        if (_fbdata != nil) {
            //            NSString *fbname = [_fbdata objectForKey:@"name"];
            //            NSArray *fbnameparts = [fbname componentsSeparatedByString:@" "];
            //            _lastNameCh.text = [_fbdata objectForKey:@"last_name"];//fbnameparts[0];
            //            _lastNameEn.text = [_fbdata objectForKey:@"last_name"];//fbnameparts[0];
            
            if ([self isZhongWenFirst:[_fbdata objectForKey:@"last_name"]]){
                //_lastNameCh.text = [_fbdata objectForKey:@"last_name"];//fbnameparts[0];
                
            }else{
                //_lastNameEn.text = [_fbdata objectForKey:@"last_name"];//fbnameparts[0];
            }
        }
        
        if (_fbdata != nil) {
            //            NSString *fbname = [_fbdata objectForKey:@"name"];
            //            NSArray *fbnameparts = [fbname componentsSeparatedByString:@" "];
            //            if ([fbnameparts count] > 1) {
            //                _nameCh.text = [_fbdata objectForKey:@"first_name"];//fbnameparts[1];
            //                _nameEn.text = [_fbdata objectForKey:@"first_name"];//fbnameparts[1];
            //            }
            if ([self isZhongWenFirst:[_fbdata objectForKey:@"first_name"]]) {
                
                //_nameCh.text = [_fbdata objectForKey:@"first_name"];//fbnameparts[1];
            }else{
                
                //_nameEn.text = [_fbdata objectForKey:@"first_name"];//fbnameparts[1];
            }
        }
        
        if (_fbdata != nil) {
            NSString *fbemail = [_fbdata objectForKey:@"email"];
            //_email.text = fbemail;
        }
        
        if (_fbdata != nil) {
          
            
            _textField2.placeholder=EGLocalizedString(@"此项不需要填写", nil);
            _textField3.placeholder=EGLocalizedString(@"此项不需要填写", nil);
        }
        
    } else if ([standardUserDefaults objectForKey:@"WEIBO_REG_REQ"] != nil && [[standardUserDefaults objectForKey:@"WEIBO_REG_REQ"] isEqualToString:@"1"])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self moveViews];
        });

        //  MyLog(@"WEIBO_REG_REQ");
        _wbdata = [standardUserDefaults objectForKey:@"WEIBO_DETAIL"];
        // WEIBO
        //  MyLog(@"%@", _wbdata);
        if (_wbdata != nil){
            // TODO WEIBO EMAIL
            //        NSString *wbemail = [_fbdata objectForKey:@"email"];
            //        NSString *wbemailname = [wbemail componentsSeparatedByString:@"@"][0];
            NSString *wbname = [_wbdata objectForKey:@"userName"];
            //  MyLog(@"wbname wbname = %@", wbname);
            //_userName.text = wbname;
            _textField1.text=wbname;
            
            
        }
        
        //        if (_wbdata != nil){
        //            NSString *wbname = [_wbdata objectForKey:@"userName"];
        //            NSArray *wbnameparts = [wbname componentsSeparatedByString:@" "];
        //            _lastNameCh.text = wbnameparts[0];
        ////            _lastNameEn.text = wbnameparts[0];
        //        }
        //
        //        if (_wbdata != nil){
        //            NSString *wbname = [_wbdata objectForKey:@"userName"];
        //            NSArray *wbnameparts = [wbname componentsSeparatedByString:@" "];
        //            if ([wbnameparts count] > 1) {
        //                _nameCh.text = wbnameparts[1];
        ////                _nameEn.text = wbnameparts[1];
        //            }
        //        }
        
        if (_wbdata != nil) {
            
//            NSString *wbemail = [_fbdata objectForKey:@"email"];
//            _email.text = wbemail;
        }
        
        if (_wbdata != nil) {
    
            
            _textField2.placeholder=EGLocalizedString(@"此项不需要填写", nil);
            _textField3.placeholder=EGLocalizedString(@"此项不需要填写", nil);
        }
    }



}

-(void) thirdPartyLogin:(LoginViewController *)parentVC
{
    _theParentVC = parentVC;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    
    _fbdata = nil;
    _wbdata = nil;
    
    if ([standardUserDefaults objectForKey:@"FACEBOOK_REG_REQ"] != nil && [[standardUserDefaults objectForKey:@"FACEBOOK_REG_REQ"] isEqualToString:@"1"])
    {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self moveViews];
        });

        // MyLog(@"FACEBOOK_REG_REQ");
        _fbdata = [standardUserDefaults objectForKey:@"FACEBOOK_DETAIL"];
        
        if (_fbdata != nil) {
            //            NSString *fbemail = [_fbdata objectForKey:@"email"];
            //            NSString *fbemailname = [fbemail componentsSeparatedByString:@"@"][0];
            _userName.text = [_fbdata objectForKey:@"name"];
        }
        
        if (_fbdata != nil) {
            //            NSString *fbname = [_fbdata objectForKey:@"name"];
            //            NSArray *fbnameparts = [fbname componentsSeparatedByString:@" "];
            //            _lastNameCh.text = [_fbdata objectForKey:@"last_name"];//fbnameparts[0];
            //            _lastNameEn.text = [_fbdata objectForKey:@"last_name"];//fbnameparts[0];
            
            if ([self isZhongWenFirst:[_fbdata objectForKey:@"last_name"]]){
                _lastNameCh.text = [_fbdata objectForKey:@"last_name"];//fbnameparts[0];
                
            }else{
                _lastNameEn.text = [_fbdata objectForKey:@"last_name"];//fbnameparts[0];
            }
        }
        
        if (_fbdata != nil) {
            //            NSString *fbname = [_fbdata objectForKey:@"name"];
            //            NSArray *fbnameparts = [fbname componentsSeparatedByString:@" "];
            //            if ([fbnameparts count] > 1) {
            //                _nameCh.text = [_fbdata objectForKey:@"first_name"];//fbnameparts[1];
            //                _nameEn.text = [_fbdata objectForKey:@"first_name"];//fbnameparts[1];
            //            }
            if ([self isZhongWenFirst:[_fbdata objectForKey:@"first_name"]]) {
                
                _nameCh.text = [_fbdata objectForKey:@"first_name"];//fbnameparts[1];
            }else{
                
                _nameEn.text = [_fbdata objectForKey:@"first_name"];//fbnameparts[1];
            }
        }
        
        if (_fbdata != nil) {
            NSString *fbemail = [_fbdata objectForKey:@"email"];
            _email.text = fbemail;
        }
        
        if (_fbdata != nil) {
            _passWord.placeholder = EGLocalizedString(@"此项不需要填写", nil);
            
            _confirmPsw.placeholder = EGLocalizedString(@"此项不需要填写", nil);
            
           
        }
        
    } else if ([standardUserDefaults objectForKey:@"WEIBO_REG_REQ"] != nil && [[standardUserDefaults objectForKey:@"WEIBO_REG_REQ"] isEqualToString:@"1"])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self moveViews];
        });

        //  MyLog(@"WEIBO_REG_REQ");
        _wbdata = [standardUserDefaults objectForKey:@"WEIBO_DETAIL"];
        // WEIBO
        //  MyLog(@"%@", _wbdata);
        if (_wbdata != nil){
            // TODO WEIBO EMAIL
            //        NSString *wbemail = [_fbdata objectForKey:@"email"];
            //        NSString *wbemailname = [wbemail componentsSeparatedByString:@"@"][0];
            NSString *wbname = [_wbdata objectForKey:@"userName"];
            //  MyLog(@"wbname wbname = %@", wbname);
            _userName.text = wbname;
            _textField1.text=wbname;
            
            
        }
        
        //        if (_wbdata != nil){
        //            NSString *wbname = [_wbdata objectForKey:@"userName"];
        //            NSArray *wbnameparts = [wbname componentsSeparatedByString:@" "];
        //            _lastNameCh.text = wbnameparts[0];
        ////            _lastNameEn.text = wbnameparts[0];
        //        }
        //
        //        if (_wbdata != nil){
        //            NSString *wbname = [_wbdata objectForKey:@"userName"];
        //            NSArray *wbnameparts = [wbname componentsSeparatedByString:@" "];
        //            if ([wbnameparts count] > 1) {
        //                _nameCh.text = wbnameparts[1];
        ////                _nameEn.text = wbnameparts[1];
        //            }
        //        }
        
        if (_wbdata != nil) {
            NSString *wbemail = [_fbdata objectForKey:@"email"];
            _email.text = wbemail;
        }
        
        if (_wbdata != nil) {
            _passWord.placeholder = EGLocalizedString(@"此项不需要填写", nil);
            _confirmPsw.placeholder = EGLocalizedString(@"此项不需要填写", nil);
            

        }
    }
}


-(BOOL)pipeizimu:(NSString *)str{
            //判断是否以字母开头
            NSString *ZIMU = @"^[A-Za-z\\s]*$";
            NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
            
            if ([regextestA evaluateWithObject:str] == YES)
            {
                return YES;
            }
            else
            {
                return NO;
            }
}


-(BOOL)isZhongWenFirst:(NSString *)str{
    
    NSString *ZIMU = @"^[\u4e00-\u9fa5\\s]*$";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
    
    if ([regextestA evaluateWithObject:str] == YES)
    {
        return YES;
    }
    else
    {
        
        return NO;
        
    }

}


- (void)showLoadingAlert{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.progressHUD = [MBProgressHUD showHUDAddedTo:app.window animated:NO];
    [app.window addSubview:self.progressHUD];
    self.progressHUD.dimBackground = YES;
}

- (void)removeLoadingAlert{
    
    [self.progressHUD hide:YES];
    
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
