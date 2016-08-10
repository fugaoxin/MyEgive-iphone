//
//  MemberZoneViewController.m
//  Egive
//
//  Created by zxj on 15/11/12.
//  Copyright © 2015年 sino. All rights reserved.
//

#import "MemberZoneViewController.h"
#import "Constants.h"
#import "UIView+ZJQuickControl.h"
#import "HomeViewController.h"
#import "ShowMenuView.h"
#import "MemberModel.h"
#import "EGDropDownMenu.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "EGUtility.h"
#import "UpdatePwsViewController.h"
#import "MyDonationViewController.h"
#import "UpdatePwsViewController.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface MemberZoneViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,EGDropDownMenuDelegate,UITextFieldDelegate>{
     NSString * _base64Avatar;
     NSArray *regionArray;
     NSArray * _ageGroupArray;
     NSArray * sexArr;
    NSMutableArray * _belongCd;
    NSMutableArray * _belongDesp;
    NSMutableArray * _EducationCd;
    NSMutableArray * _EducationDesp;
    NSMutableArray * _WorkCd;
    NSMutableArray * _WorkDesp;
    NSMutableDictionary *Belongdict;
    NSArray *volunteersbuttonTotalArray;
    NSArray *TimebuttonArray;
    NSArray *HowDoyouKnowButtonArray;
    BOOL _isSelAge;
    BOOL _isSelBelongDown;
    BOOL _isSexBelongDown;
    BOOL _isEducationDown;
    BOOL _isWorkDown;
    NSInteger _selectedIndex;
    NSInteger _sexIndex; //性别标记 0－男，1-女。
    NSInteger _EducationselectedIndex;
    NSInteger _WorkselectedIndex;
    NSString * _ageGroup;
    CGRect contentViewforModifyUIRect;
    CGRect contentViewForConfirmeUIRect;
    NSString *hkOrOther;
    NSURL *PICurl;
 }
@property(retain,nonatomic)NSMutableArray *YorNButtonArray;
@property(retain,nonatomic)NSMutableArray *volunteersButtonArray;
@property(retain,nonatomic)NSMutableArray *HowDoyouKnowEgiveButtonArray;
@property (copy, nonatomic) NSMutableDictionary * shareDict;
@property (strong, nonatomic) MemberModel * item;
@property(retain,nonatomic)UIPickerView *regionPickerView;
@property (strong, nonatomic) EGDropDownMenu *AgeDropDownMenu;
@property (strong, nonatomic) EGDropDownMenu *SexDropDownMenu;
@property (strong, nonatomic) EGDropDownMenu *BelongToDropDownMenu;
@property (strong, nonatomic) EGDropDownMenu *EducationDropDownMenu;
@property (strong, nonatomic) EGDropDownMenu *WorkDropDownMenu;
@property (strong, nonatomic) MemberFormModel * FormModel;
@property (strong, nonatomic) NSMutableDictionary * cdDict;
@property (strong, nonatomic) NSMutableDictionary * ageCdDict; //年龄数据
@property (strong, nonatomic) NSMutableDictionary * EducationCdDict;
@property (strong, nonatomic) NSMutableDictionary * EducationDespDict;
@property (copy, nonatomic) NSMutableArray * arr;
@property (copy, nonatomic) NSMutableArray * volunteerInterestArr;
@property (copy, nonatomic) NSMutableArray * availableTimeArr;
@property (nonatomic) BOOL isEdit;
@property (nonatomic) NSArray *EmaileButton;
@end
@implementation MemberZoneViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layOutWidhView:self.UserInfoDetaileView];
    [self layOutWidhView:self.EmaileViewButtonSeclect];
    [self layOutWidhView:self.volunteersButtonSelectView];
    [self layOutWidhView:self.RegionDetaileAddressView];
    //添加详情UserInfoView
    [self NSLayoutView:self.UserInfoLoadView andSubview:self.UserInfoDetaileView];
    //添加EmaileButton
    [self NSLayoutMoreViewConstraintHeight:self.UserInforDetaileLoadEmaileView andSubview:self.EmaileViewButtonSeclect];
    //添加义工View
    [self NSLayoutMoreViewConstraintHeight:self.volunteersView andSubview:self.volunteersButtonSelectView];
    [self.UserInfoDetaileView setFrame:CGRectMake(0, 0, ScreenSize.width, 2700)];
     _isEdit = NO;
    [self.ScrollView addSubview:self.UserInfoWithIconView];
    self.title = EGLocalizedString(@"会员专区", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    _ageGroupArray = @[@[EGLocalizedString(@"Please_Select", nil),@"0 - 10",@"11 - 20",@"21 - 30",@"31 - 40",@"41 - 50",@"51 - 60",@"61 - 70",@"71 - 80",@"81 - 90",@"90+"]];
     sexArr = @[@[EGLocalizedString(@"男", nil),EGLocalizedString(@"女", nil)]];
    [self CreatNatvitoinBar];
    [self configurationButton];
    [self CreatYorNButton];
    [self CreatUI];
    [self createFooterButton];
    [self createMenuUI];
    //[self layOutForModifyUI];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HiddenregionPickerViewTap)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    [self requestMemberFormData];
    _isSelAge = NO;
    _isSelBelongDown = NO;
    _isSexBelongDown = NO;
    _isEducationDown=NO;
    _isWorkDown=NO;
    _selectedIndex = 0;
    _EducationselectedIndex=0;
    _WorkselectedIndex=0;
    
     NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (([standardUserDefaults objectForKey:@"FACEBOOK_REG_REQ"] != nil && [[standardUserDefaults objectForKey:@"FACEBOOK_REG_REQ"] isEqualToString:@"1"]) || ([standardUserDefaults objectForKey:@"WEIBO_REG_REQ"] != nil && [[standardUserDefaults objectForKey:@"WEIBO_REG_REQ"] isEqualToString:@"1"]) ){
    
        self.ChangethepasswordButton.hidden=YES;
    
    }else{
        self.ChangethepasswordButton.hidden=NO;
        self.ChangethepasswordButton.enabled=NO;
        
    }
    
    [self configurationUILanguage];
    [self borderStyleNone];
    _enLastName.delegate=self;
    _enfirstName.delegate=self;
    _PhoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    _enfirstName.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    _enLastName.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    
}
//配置控件语言
-(void)configurationUILanguage{
     [self.ModifyButton setTitle:EGLocalizedString(@"修改", nil) forState:UIControlStateNormal];
     [self.LoginOutButton setTitle:EGLocalizedString(@"登出", nil) forState:UIControlStateNormal];
     [self.ConfirmButton setTitle:EGLocalizedString(@"完成", nil) forState:UIControlStateNormal];
    self.personalTitle.text = EGLocalizedString(@"个人累积捐款", nil);
    [self.CheckRankingButton setTitle:EGLocalizedString(@"查看排名", nil) forState:UIControlStateNormal];
    self.DonationRecordLabel.text = EGLocalizedString(@"捐款记录", nil);
    self.LoginNameLabel.text =  EGLocalizedString(@"登入名称", nil);
    self.LoginPassLabel.text = EGLocalizedString(@"登入密码", nil);
    [self.ChangethepasswordButton setTitle:EGLocalizedString(@"修改密码", nil) forState:UIControlStateNormal];
    self.NameChLabel.text = EGLocalizedString(@"姓名(中)", nil);
    self.NameEnLabel.text = EGLocalizedString(@"姓名(英)", nil);
    self.EmaileAddressLabel.text = EGLocalizedString(@"Register_email", nil);
    self.EducationLabel.text = EGLocalizedString(@"Educationlevel", nil);
    self.WorkLabel.text = EGLocalizedString(@"Occupation", nil);
    self.BelongLabel.text = EGLocalizedString(@"Register_belongto", nil);
    self.GenderLabel.text = EGLocalizedString(@"性别", nil);
    self.AgeGroupLabel.text = EGLocalizedString(@"年龄组别", nil);
    self.phoneNumberLabel.text = EGLocalizedString(@"Register_org_number", nil);
    [self.HKorOtherSegment setTitle:EGLocalizedString(@"Register_org_regionButton", nil) forSegmentAtIndex:0];
    [self.HKorOtherSegment setTitle:EGLocalizedString(@"Register_org_otherButton", nil) forSegmentAtIndex:1];
    self.ProvireReallyAddress.text = EGLocalizedString(@"Register_org_noteLabel2_title", nil);
    self.HowToKnowEgiveLabel.text = EGLocalizedString(@"你從何處認識「意贈慈善基金」(可選擇多項)", nil);
    self.EgiveWebsiteLabel.text = EGLocalizedString(@"「意贈」網頁", nil);
    self.MagszineLabel.text = EGLocalizedString(@"「意贈」活動/刊物", nil);
    self.FriendLabel.text = EGLocalizedString(@"朋友", nil);
    self.NewsPaperLabel.text = EGLocalizedString(@"報章", nil);
    self.MedicalFacbookLabel.text = EGLocalizedString(@"社交媒體(Facebook、新浪微博等)", nil);
    self.AsaegiveDonnerLabel.text = EGLocalizedString(@"為「意贈」的捐款者", nil);
    self.HowtoKnowEgiveLabel.text = EGLocalizedString(@"其他", nil);
    self.DoyouWishLabel.text = EGLocalizedString(@"Register_IsEmailNote", nil);
     [self.YesButton setTitle:EGLocalizedString(@"Register_isEmailButton_title", nil) forState:UIControlStateNormal];
     [self.NoButton setTitle:EGLocalizedString(@"Register_noEmailButton_title", nil) forState:UIControlStateNormal];
    self.PleaseSelectthemesLabel.text = EGLocalizedString(@"请选取你喜欢的专案类别(可选择多项):", nil);
    self.EducationthemesLabel.text = EGLocalizedString(@"助学", nil);
     self.EdlerlythemesLabel.text = EGLocalizedString(@"安老", nil);
    self.Medicalthemeslabel.text = EGLocalizedString(@"助医", nil);
    self.CommunitythemesLabel.text = EGLocalizedString(@"扶贫", nil);
    self.ReliefthemesLabel.text  = EGLocalizedString(@"紧急援助", nil);
    self.otherThemesLabel.text = EGLocalizedString(@"其他", nil);
    self.EgiveActionthemesLabel.text = EGLocalizedString(@"意赠行动", nil);
    self.ALLthemesLabel.text  = EGLocalizedString(@"全部", nil);
    self.WillyouConsiderBecomingLabel.text = EGLocalizedString(@"Register_noteLabel3_title", nil);
    [self.IdoSegmentControl setTitle:EGLocalizedString(@"Register_yButton_title", nil) forSegmentAtIndex:0];
    [self.IdoSegmentControl setTitle:EGLocalizedString(@"Register_nButton_title", nil) forSegmentAtIndex:1];
    self.willYouConsidertobeLabel.text = EGLocalizedString(@"义工服务意向", nil);
    self.IagreeToJoinLabel.text = EGLocalizedString(@"我愿意成为意赠慈善基金的:", nil);
    [self.LongOrShortSegment setTitle:EGLocalizedString(@"长期义工", nil) forSegmentAtIndex:0];
    [self.LongOrShortSegment setTitle:EGLocalizedString(@"短期义工", nil) forSegmentAtIndex:1];
    self.MySpcialtyLabel.text = EGLocalizedString(@"有关协助之项目:(可选择多项)", nil);
    self.officeAdminiLabel.text = EGLocalizedString(@"办事处行政服务:(资料输入,信件处理,一般行政工作等)", nil);
    self.EventCoordnationLabel.text =EGLocalizedString(@"活动联络", nil);
    self.PrintDesignLabel.text =EGLocalizedString(@"印刷品设计", nil);
    self.EditionLabel.text = EGLocalizedString(@"编辑", nil);
    self.TranslationLabel.text = EGLocalizedString(@"翻译(中英/英中)", nil);
    self.CopywritingLabel.text = EGLocalizedString(@"文稿撰写", nil);
    self.PhotographyLabel.text = EGLocalizedString(@"摄影", nil);
    self.FundraisingLabel.text = EGLocalizedString(@"協辦籌款活動(不定期舉辦)", nil);
    self.VisitLabel.text = EGLocalizedString(@"探访", nil);
    self.MyspecialtyotherLabel.text=EGLocalizedString(@"Register_org_otherButton", nil);
    
    self.AvailableDateLabel.text = EGLocalizedString(@"可服务的时间(可选择多项)", nil);
    
    self.MondayLabel.text = EGLocalizedString(@"星期一",nil);
    self.TuesdayLabel.text=EGLocalizedString(@"星期二",nil);
    self.WendesdayLabel.text=EGLocalizedString(@"星期三",nil);
    self.ThuredayLabel.text=EGLocalizedString(@"星期四",nil);
    self.FridayLabel.text=EGLocalizedString(@"星期五",nil);
    self.StatudyLabel.text=EGLocalizedString(@"星期六",nil);
    self.SundayLabel.text=EGLocalizedString(@"星期日",nil);
    self.AnyTimeLabel.text=EGLocalizedString(@"任何时间",nil);
    self.TenAMLabel.text=EGLocalizedString(@"上午10时至下午1时",nil);
    self.TwoAMLabel.text=EGLocalizedString(@"下午2時至下午5時",nil);
    self.FiveAMlabel.text=EGLocalizedString(@"上午10時至下午5時",nil);
    self.selvenAMLabel.text=EGLocalizedString(@"晚上7時至9時",nil);
    self.AvailabelotherLabel.text=EGLocalizedString(@"其他",nil);
    self.VolunteerPleasestateTexyField.placeholder= EGLocalizedString(@"请说明",nil) ;
    self.TimePleaseState.placeholder = EGLocalizedString(@"请说明",nil) ;
    self.HKorOtherTextField.placeholder=EGLocalizedString(@"请说明",nil) ;
    self.HowDoyouknowEgivePleasestate.placeholder=EGLocalizedString(@"请说明",nil) ;
    self.dateStart.placeholder= EGLocalizedString(@"dataStart",nil);
    self.dateEnd.placeholder= EGLocalizedString(@"dataEnd",nil);
    self.addressDistrict.placeholder = EGLocalizedString(@"Register_org_region1", nil);
    self.addressBldg.placeholder = EGLocalizedString(@"Register_org_region2", nil);
    self.addressEstate.placeholder = EGLocalizedString(@"Register_org_region3", nil);
    self.addressStreet.placeholder = EGLocalizedString(@"Register_org_region4", nil);
    self.RegionLabel.text = EGLocalizedString(@"Register_org_selRegion", nil);
    self.addressTitleLabel.text = EGLocalizedString(@"通讯地址", nil);
    
}

//初始化导航
-(void)CreatNatvitoinBar{
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
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_cart@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    // Do any additional setup after loading the view from its nib.

}
-(void)borderStyleRoundedRect{
    self.EmaileAddress.borderStyle=UITextBorderStyleRoundedRect;
    self.EducationTextField.borderStyle=UITextBorderStyleRoundedRect;
    self.WorkTextField.borderStyle=UITextBorderStyleRoundedRect;
    self.BelongTotextField.borderStyle=UITextBorderStyleRoundedRect;
    self.Sex.borderStyle=UITextBorderStyleRoundedRect;
    self.agetextField.borderStyle=UITextBorderStyleRoundedRect;
    

  }
-(void)borderStyleNone{
    self.EmaileAddress.borderStyle=UITextBorderStyleNone;
    self.EducationTextField.borderStyle=UITextBorderStyleNone;
    self.WorkTextField.borderStyle=UITextBorderStyleNone;
    self.BelongTotextField.borderStyle=UITextBorderStyleNone;
    self.Sex.borderStyle=UITextBorderStyleNone;
    self.agetextField.borderStyle=UITextBorderStyleNone;

}
- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightAction{
    MyDonationViewController *vc = [[MyDonationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
   
}
//个人登录UI
-(void)CreatUI{
    _arr = [[NSMutableArray alloc] init];
    _volunteerInterestArr = [[NSMutableArray alloc] init];
    _availableTimeArr = [[NSMutableArray alloc] init];
    _HowDoyouKnowEgiveButtonArray = [[NSMutableArray alloc] init];
    self.ConfirmButton.hidden=YES;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults objectForKey:@"EGIVE_MEMBER_MODEL"]) {
        NSMutableDictionary *m = [[standardUserDefaults objectForKey:@"EGIVE_MEMBER_MODEL"] mutableCopy];
        MemberModel *model = [[MemberModel alloc] init];
        [model setValuesForKeysWithDictionary:m];
        [ShowMenuView sharedInstance].member = model;
        MyLog(@"%@",m);
        _shareDict = m;
        _item = model;
        MyLog(@"%@",_item.ProfilePicURL);
    }
    //初始化_regionPickerView
    _regionPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, ScreenSize.height - 200 + ((IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) ? 20 : 0), ScreenSize.width , 200)];
    _regionPickerView.delegate = self;
    _regionPickerView.showsSelectionIndicator = YES;
    _regionPickerView.hidden = YES;
    _regionPickerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_regionPickerView];
    //判断用户是否存在该头像
    if ([_item.ProfilePicURL isEqualToString:@""] || _item.ProfilePicURL == nil){
        
        if ([_item.Sex isEqualToString:@"M"] || [_item.ChiNameTitle isEqualToString:@"R"]) {
            //_IconImage.image = [UIImage imageNamed:@"donor_detail_male@2x.png"];
            NSString *urlString = [NSString stringWithFormat:@"%@%@",SITE_URL,@"/Images/default_m.jpg"];
            PICurl = [NSURL URLWithString:urlString];
            [_IconImage sd_setImageWithURL:PICurl placeholderImage:nil];
            
        }else{
            //_IconImage.image = [UIImage imageNamed:@"donor_detail_female@2x.png"];
             NSString *urlString = [NSString stringWithFormat:@"%@%@",SITE_URL,@"/Images/default_f.jpg"];
            PICurl = [NSURL URLWithString:urlString];
            [_IconImage sd_setImageWithURL:PICurl placeholderImage:nil];

        }
    }else{
        
        PICurl = [NSURL URLWithString:SITE_URL];
        PICurl = [PICurl URLByAppendingPathComponent:_item.ProfilePicURL];
        
        MyLog(@"%@",PICurl);
        
        [_IconImage sd_setImageWithURL:PICurl placeholderImage:nil];
    }
    
    UITapGestureRecognizer * imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageTapAction)];
    [_IconImage addGestureRecognizer:imageTap];
    //登入详细资料
     _LoginName.text = _item.LoginName;
     _LoginPassWord.text = @"******";
     _EmaileAddress.text = _item.Email;
    
    _DonamtionAmount.text = [NSString stringWithFormat:@"HKD%@", [_memberTotalDonationAmount stringByReplacingOccurrencesOfString:@"(null) " withString:@"0"]];
    
    
    if ([_item.Sex isEqualToString:@"M"] || [_item.ChiNameTitle isEqualToString:@"R"]) {
        _Sex.text = EGLocalizedString(@"男", nil);
    }else{
        _Sex.text = EGLocalizedString(@"女", nil);
    }
    
    if (![_item.TelCountryCode isEqualToString:@""] && ![_item.TelNo isEqualToString:@""]) {
        
        self.DetailePhoneNumber.text = [NSString stringWithFormat:@"(%@)%@",_item.TelCountryCode,_item.TelNo];
    }
    
    self.PhoneNumber.hidden=YES;
    self.ConturyCodeNumberTextField.hidden=YES;
    self.PhoneNumber.text = _item.TelNo;
    self.ConturyCodeNumberTextField.text = _item.TelCountryCode;
    
    if ( ![_item.AddressBldg isEqualToString:@"(null)"] && ![_item.AddressDistrict isEqualToString:@"(null)"] &&![_item.AddressStreet isEqualToString:@"(null)"]&&![_item.AddressRoom isEqualToString:@"(null)"]&&![_item.AddressEstate isEqualToString:@"(null)"]){
        //显示街道地址
        _addressDistrict.text = _item.AddressRoom;
        _addressBldg.text = _item.AddressBldg;
        _addressEstate.text = _item.AddressEstate;
        _addressStreet.text = _item.AddressStreet;
        _region.text = _item.AddressDistrict;
        
    }
    //地区
     regionArray = @[EGLocalizedString(@"Central and Western", nil),EGLocalizedString(@"Eastern", nil),EGLocalizedString(@"Southern", nil),EGLocalizedString(@"Wan Chai", nil),EGLocalizedString(@"Sham Shui Po", nil),EGLocalizedString(@"Kowloon City", nil),EGLocalizedString(@"Kwun Tong", nil),EGLocalizedString(@"Wong Tai Sin", nil),EGLocalizedString(@"Yau Tsim Mong", nil),EGLocalizedString(@"Islands", nil),EGLocalizedString(@"Kwai Tsing", nil),EGLocalizedString(@"North", nil),EGLocalizedString(@"Sai Kung", nil),EGLocalizedString(@"Sha Tin", nil),EGLocalizedString(@"Tai Po", nil),EGLocalizedString(@"Tsuen Wan", nil),EGLocalizedString(@"Tuen Mun", nil),EGLocalizedString(@"Yuen Long", nil)];
//    //地区PickerView
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(regionPickerViewTap)];
//    self.RegionLabel.userInteractionEnabled = YES;
//    [self.RegionLabel addGestureRecognizer:tap];
    //显示姓名
    self.chfirstName.hidden=YES;
    self.chLastName.hidden=YES;
    self.enfirstName.hidden=YES;
    self.enLastName.hidden=YES;
    self.enName.text= [NSString stringWithFormat:@"%@ %@",_item.EngFirstName,_item.EngLastName];
    self.chNameLabel.text= [NSString stringWithFormat:@"%@%@",_item.ChiLastName,_item.ChiFirstName];
    //判断EmaileButton是否有选中项
    MyLog(@"%@",_item.DonationInterest);
    NSArray * DonationInterestArr = @[@"S",@"E",@"M",@"P",@"U",@"O",@"A",@"L"];
    if ([_item.DonationInterest rangeOfString:@"L"].location !=NSNotFound){
        for (int i = 0; i < self.EmaileButton.count; i ++) {
            UIButton * button = [self.EmaileButton objectAtIndex:i];
            button.selected = YES;
            
            NSString *str = [NSString stringWithFormat:@"%@,",DonationInterestArr[i]];
            [self.arr addObject:str];
        }
    }else{
        for (int i = 0; i < self.EmaileButton.count; i ++){
        if([_item.DonationInterest rangeOfString:DonationInterestArr[i]].location !=NSNotFound){
            UIButton * button = [self.EmaileButton objectAtIndex:i];
            button.selected = YES;
            NSString *str = [NSString stringWithFormat:@"%@,",DonationInterestArr[i]];
            [self.arr addObject:str];
        }
        
            MyLog(@"%@",self.arr);
        }
    }
    //判断义工选项Button是否有选中项
     NSArray * VolunteerInterestArr = @[@"Admin",@"Print",@"Contact",@"Editing",@"Translate",@"Write",@"Photo",@"Event",@"Visit",@"otherVolunteer"];
    //MyLog(@"%d",self.volunteersButtonArray.count);
    for (int i=0; i<volunteersbuttonTotalArray.count; i++){
        MyLog(@"%@",_item.VolunteerInterest);
        
    if([_item.VolunteerInterest rangeOfString:VolunteerInterestArr[i]].location !=NSNotFound){
        UIButton * button = [volunteersbuttonTotalArray objectAtIndex:i];
        button.selected = YES;
        NSString *str = [NSString stringWithFormat:@"%@,",VolunteerInterestArr[i]];
        [self.volunteerInterestArr addObject:str];
    }
     if (i==9 && _item.VolunteerInterest_Other != NULL && ![_item.VolunteerInterest_Other isEqualToString:@""]){
         UIButton * button = [volunteersbuttonTotalArray objectAtIndex:i];
         button.selected = YES;
     }else{
         
         UIButton * button = [volunteersbuttonTotalArray objectAtIndex:9];
         button.selected = NO;
     
     }
    if (_item.JoinVolunteer){
            if (_item.VolunteerInterest_Other != NULL && ![_item.VolunteerInterest_Other isEqualToString:@""]) {
                self.VolunteerPleasestateTexyField.text = _item.VolunteerInterest_Other;
            }
        }
    }
//判断时间选项Button是否有选中项
  NSArray * availabelArr = @[@"Mon",@"Tues",@"Wed",@"Thurs",@"Fri",@"Sat",@"Sun",@"All",@"Morning",@"Afternoon",@"WholeDay",@"Evening",@"timeOther"];
    for (int i=0; i<TimebuttonArray.count; i++) {
    if([_item.AvailableTime rangeOfString:availabelArr[i]].location !=NSNotFound){
        UIButton *btn = [TimebuttonArray objectAtIndex:i];
        btn.selected = YES;
        NSString *str = [NSString stringWithFormat:@"%@,",availabelArr[i]];
        [self.availableTimeArr addObject:str];
    }
    if (i==12 && (![_item.AvailableTime_Other isEqualToString:@""] && _item.AvailableTime_Other != NULL)) {
        UIButton *btn = [TimebuttonArray objectAtIndex:i];
        btn.selected = YES;
    }else{
        UIButton *btn = [TimebuttonArray objectAtIndex:12];
        btn.selected = NO;
     
    }
    if (_item.JoinVolunteer) {
            if (_item.AvailableTime_Other != NULL && ![_item.AvailableTime_Other isEqualToString:@""]) {
                self.TimePleaseState.text = _item.AvailableTime_Other;
            }
        }
}
    
    if ([_item.ChiLastName isEqualToString:@"(null)"]) {
        _chLastName.text = @"";
    }else{
        _chLastName.text = _item.ChiLastName;
    }
    if ([_item.ChiFirstName isEqualToString:@"(null)"]){
        _chfirstName.text = @"";
    }else{
        _chfirstName.text = _item.ChiFirstName;
    }
    
    if ([_item.EngFirstName isEqualToString:@"(null)"]) {
        _enfirstName.text = @"";
    }else{
        _enfirstName.text = _item.EngFirstName;
    }
    if ([_item.EngLastName isEqualToString:@"(null)"]) {
        _enLastName.text = @"";
    }else{
        _enLastName.text = _item.EngLastName;
    }
    if ([_item.AddressBldg isEqualToString:@"(null)"]) {
        _item.AddressBldg = @"";
    }
    if ([_item.AddressDistrict isEqualToString:@"(null)"]) {
        _item.AddressDistrict = @"";
    }
    if ([_item.AddressStreet isEqualToString:@"(null)"]) {
        _item.AddressStreet = @"";
    }
    if ([_item.AddressRoom isEqualToString:@"(null)"]) {
        _item.AddressRoom = @"";
    }
    if ([_item.AddressEstate isEqualToString:@"(null)"]) {
        _item.AddressEstate = @"";
    }
    
    NSArray * titleArr = @[@"Web",@"Event",@"Friend",@"News",@"Social",@"Donor",@"other"];
    
    for (int i=0; i<HowDoyouKnowButtonArray.count; i++) {
    if([_item.HowToKnoweGive rangeOfString:titleArr[i]].location !=NSNotFound)
    {
        UIButton *btn = [HowDoyouKnowButtonArray objectAtIndex:i];
        btn.selected = YES;
        NSString *str = [NSString stringWithFormat:@"%@,",titleArr[i]];
        [self.HowDoyouKnowEgiveButtonArray addObject:str];
    }
    if (i==6 && ![_item.HowToKnoweGive_Other isEqualToString:@""]) {
        UIButton *btn = [HowDoyouKnowButtonArray objectAtIndex:6];
        btn.selected = YES;
    }
    
    }
    if (_item.VolunteerInterest_Other != NULL){
        
        self.HowDoyouknowEgivePleasestate.text = _item.HowToKnoweGive_Other;
    }


    [self layOutForModifyUI];
}

//showDetaile
-(void)showDetaileView{
    if (_item.AcceptEDM){
        for (UIButton *btn in self.YorNButtonArray){
            btn.selected=NO;
            btn.backgroundColor = [UIColor whiteColor];
        }
        _YesButton.selected=YES;
        _YesButton.backgroundColor = [UIColor colorWithRed:94/255.0 green:175/255.0 blue:33/255.0 alpha:1];
        [self NSLayoutMoreViewConstraintHeight:self.UserInforDetaileLoadEmaileView andSubview:self.EmaileViewButtonSeclect];
        if (self.IdoSegmentControl.selectedSegmentIndex==0){
            self.ScrollView.contentSize =CGSizeMake(self.ScrollView.frame.size.width,self.UserInfoWithIconView.frame.size.height);
        }else if (self.IdoSegmentControl.selectedSegmentIndex==1){
            self.ScrollView.contentSize =CGSizeMake(self.ScrollView.frame.size.width,self.UserInfoWithIconView.frame.size.height - self.volunteersButtonSelectView.frame.size.height);
        }else{
            self.ScrollView.contentSize =CGSizeMake(self.ScrollView.frame.size.width,self.UserInfoWithIconView.frame.size.height - self.EmaileViewButtonSeclect.frame.size.height);
        }
        
    }else{
        for (UIButton *btn in self.YorNButtonArray){
            btn.selected=NO;
            btn.backgroundColor = [UIColor whiteColor];
        }
        _NoButton.selected=YES;
        _NoButton.backgroundColor = [UIColor colorWithRed:94/255.0 green:175/255.0 blue:33/255.0 alpha:1];
        [self.EmaileViewButtonSeclect removeFromSuperview];
        self.EmaileConstraintHeight.constant=0;
        if (self.IdoSegmentControl.selectedSegmentIndex==1){
            self.ScrollView.contentSize =CGSizeMake(self.ScrollView.frame.size.width,self.UserInfoWithIconView.frame.size.height - self.EmaileViewButtonSeclect.frame.size.height -self.volunteersButtonSelectView.frame.size.height);
        }else{
            self.ScrollView.contentSize =CGSizeMake(self.ScrollView.frame.size.width,self.UserInfoWithIconView.frame.size.height - self.EmaileViewButtonSeclect.frame.size.height);
        }
    }
    if (_item.JoinVolunteer){
        self.IdoSegmentControl.selectedSegmentIndex = 0;
        //添加义工View
        [self NSLayoutMoreViewConstraintHeight:self.volunteersView andSubview:self.volunteersButtonSelectView];
        if (self.NoButton.selected) {
            self.ScrollView.contentSize =CGSizeMake(self.ScrollView.frame.size.width,self.UserInfoWithIconView.frame.size.height-self.EmaileViewButtonSeclect.frame.size.height);
        }else{
            self.ScrollView.contentSize =CGSizeMake(self.ScrollView.frame.size.width,self.UserInfoWithIconView.frame.size.height);
        }
        
    }else{
        self.IdoSegmentControl.selectedSegmentIndex = 1;
        [self.volunteersButtonSelectView removeFromSuperview];
        self.volunteersConstraintHeight.constant=0;
        if (self.NoButton.selected){
            self.ScrollView.contentSize =CGSizeMake(self.ScrollView.frame.size.width,self.UserInfoWithIconView.frame.size.height - self.volunteersButtonSelectView.frame.size.height-self.EmaileViewButtonSeclect.frame.size.height);
        }else{
            self.ScrollView.contentSize =CGSizeMake(self.ScrollView.frame.size.width,self.UserInfoWithIconView.frame.size.height - self.volunteersButtonSelectView.frame.size.height);
        }
    }
    
    if ([_item.AddressCountry isEqualToString:@"香港"] ||[_item.AddressCountry isEqualToString:@"HK"] ){
        self.HKorOtherSegment.selectedSegmentIndex=0;
        self.ValidEmaileTrallingConstraint.constant=0;
        self.HKorOtherTextField.hidden=YES;
    }else{
         self.HKorOtherSegment.selectedSegmentIndex=1;
        self.ValidEmaileTrallingConstraint.constant=120;
        self.HKorOtherTextField.hidden=NO;
        self.HKorOtherTextField.text=_item.AddressCountry;
    
    }
    if ([_item.VolunteerType isEqualToString:@"L"]) {
        
        self.LongOrShortSegment.selectedSegmentIndex=0;
        _dateStart.text = _item.VolunteerStartDate;
        _dateEnd.text = _item.VolunteerEndDate;
        
    }else{
    
       self.LongOrShortSegment.selectedSegmentIndex=1;
        _dateStart.text = _item.VolunteerStartDate;
        _dateEnd.text = _item.VolunteerEndDate;
        
     }
    
    
}
//约束UIForModifyUI
-(void)layOutForModifyUI{
    [self.RegionDetaileAddressView removeFromSuperview];
    self.ButtonView.userInteractionEnabled=YES;
    self.view.userInteractionEnabled=YES;
    self.UserInforDetaileLoadEmaileView.userInteractionEnabled =NO;
    self.volunteersView.userInteractionEnabled = NO;
    self.UserInfoDetaileView.userInteractionEnabled = NO;
    self.volunteersButtonSelectView.userInteractionEnabled=NO;
    self.UserInfoLoadView.userInteractionEnabled=NO;
    self.UserInfoWithIconView.userInteractionEnabled=YES;
    self.IconImage.userInteractionEnabled=NO;
    self.ChangethepasswordButton.enabled=NO;
    //添加详情地址Label
  self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",_item.AddressDistrict,@" ",_item.AddressStreet,@" ",_item.AddressEstate,@" ",_item.AddressBldg,@" ",_item.AddressRoom];
    //self.addressLabel.backgroundColor=[UIColor redColor];
   self.addressLabel.numberOfLines=0;
    CGSize requiredSize = [[self.addressLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""] sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(ScreenSize.width-10, 10000) lineBreakMode:NSLineBreakByWordWrapping];
    self.addressLabel.frame = CGRectMake(0, 0, ScreenSize.width-10, requiredSize.height);
    self.RegionandStreetConstraintHeight.constant = requiredSize.height;
    contentViewforModifyUIRect = self.UserInfoWithIconView.frame;
    contentViewforModifyUIRect.size.width=ScreenSize.width;
   
    if ([EGUtility getAppLang]==3) {
        
         contentViewforModifyUIRect.size.height = self.UserInfoDetaileView.frame.size.height+self.EmaileViewButtonSeclect.frame.size.height+self.volunteersButtonSelectView.frame.size.height +requiredSize.height+self.PleaseSpecifyView.frame.size.height-1420;
    }else{
       
        contentViewforModifyUIRect.size.height = self.UserInfoDetaileView.frame.size.height+self.EmaileViewButtonSeclect.frame.size.height+self.volunteersButtonSelectView.frame.size.height +requiredSize.height+self.PleaseSpecifyView.frame.size.height-1440;
    }
     MyLog(@"%f",self.UserInfoDetaileView.frame.size.height);
     MyLog(@"%f",contentViewforModifyUIRect.size.height);
    [self.UserInfoWithIconView setFrame:contentViewforModifyUIRect];
     self.UserInfoWithViewIconConstraintHeight.constant =contentViewforModifyUIRect.size.height;
    [self SetScrollViewContentSize:self.ScrollView andView:self.UserInfoWithIconView];
    [self showDetaileView];
}
//约束UIForConfirmeUI
-(void)layOutConfirmeUI{
    //添加详情地址页面
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (([standardUserDefaults objectForKey:@"FACEBOOK_REG_REQ"] != nil && [[standardUserDefaults objectForKey:@"FACEBOOK_REG_REQ"] isEqualToString:@"1"]) || ([standardUserDefaults objectForKey:@"WEIBO_REG_REQ"] != nil && [[standardUserDefaults objectForKey:@"WEIBO_REG_REQ"] isEqualToString:@"1"]) ){
    
        self.ChangethepasswordButton.hidden=YES;
        
    
    }else{
        self.ChangethepasswordButton.hidden=NO;
        self.ChangethepasswordButton.enabled=YES;
    }
    [self NSLayoutMoreViewConstraintHeight:self.RegionDetaileView andSubview:self.RegionDetaileAddressView];
    contentViewForConfirmeUIRect = self.UserInfoWithIconView.frame;
    contentViewForConfirmeUIRect.size.width=ScreenSize.width;
    if ([EGUtility getAppLang]==3) {
        
    contentViewForConfirmeUIRect.size.height = self.UserInfoDetaileView.frame.size.height+self.EmaileViewButtonSeclect.frame.size.height+self.volunteersButtonSelectView.frame.size.height +self.RegionDetaileAddressView.frame.size.height+self.PleaseSpecifyView.frame.size.height-1420;
    }else{
      
    contentViewForConfirmeUIRect.size.height = self.UserInfoDetaileView.frame.size.height+self.EmaileViewButtonSeclect.frame.size.height+self.volunteersButtonSelectView.frame.size.height +self.RegionDetaileAddressView.frame.size.height+self.PleaseSpecifyView.frame.size.height-1440;
    }
     MyLog(@"%f",contentViewForConfirmeUIRect.size.height);
     MyLog(@"%f",self.UserInfoDetaileView.frame.size.height);
    [self.UserInfoWithIconView setFrame:contentViewForConfirmeUIRect];
    [self SetScrollViewContentSize:self.ScrollView andView:self.UserInfoWithIconView];
    self.UserInfoWithViewIconConstraintHeight.constant =contentViewForConfirmeUIRect.size.height;
    [self showDetaileView];
}

-(void)regionPickerViewTap{
    _regionPickerView.hidden = NO;
}
-(void)HiddenregionPickerViewTap{
    _regionPickerView.hidden=YES;
}
#pragma mark - 点击更换头像
-(void)iconImageTapAction{
        UIActionSheet *photoBtnActionSheet =
        [[UIActionSheet alloc] initWithTitle:nil
                                    delegate:self
                           cancelButtonTitle:EGLocalizedString(@"取消", nil)
                      destructiveButtonTitle:nil
                           otherButtonTitles:EGLocalizedString(@"从照片库选取", nil) ,EGLocalizedString(@"拍摄新照片", nil), nil];
        [photoBtnActionSheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
        [photoBtnActionSheet showInView:[self.view window]];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        @try {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
                UIImagePickerController *imgPickerVC = [[UIImagePickerController alloc] init];
                [imgPickerVC setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                [imgPickerVC.navigationBar setBarStyle:UIBarStyleBlack];
                [imgPickerVC setDelegate:self];
                [imgPickerVC setAllowsEditing:NO];
                //显示Image Picker
                [self presentViewController:imgPickerVC animated:YES completion:nil];
            }else {
                MyLog(@"Album is not available.");
            }
        }
        @catch (NSException *exception) {
            //Error
            MyLog(@"Album is not available.");
        }
    }
    if (buttonIndex == 1) {
        //Take Photo with Camera
        @try {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *cameraVC = [[UIImagePickerController alloc] init];
                [cameraVC setSourceType:UIImagePickerControllerSourceTypeCamera];
                [cameraVC.navigationBar setBarStyle:UIBarStyleBlack];
                [cameraVC setDelegate:self];
                [cameraVC setAllowsEditing:NO];
                //显示Camera VC
                [self presentViewController:cameraVC animated:YES completion:nil];
                
            }else {
                MyLog(@"Camera is not available.");
            }
        }
        @catch (NSException *exception) {
            MyLog(@"Camera is not available.");
        }
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    MyLog(@"Image Picker Controller canceled.");
    //Cancel以后将ImagePicker删除
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    MyLog(@"Image Picker Controller did finish picking media.");
    _IconImage.image = info[UIImagePickerControllerOriginalImage];
    MyLog(@"UIImagePickerControllerMediaURL-------------%@",info[UIImagePickerControllerReferenceURL]);
    _base64Avatar = [UIImagePNGRepresentation([self imageWithImage:_IconImage.image convertToSize:CGSizeMake(128, 128)]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    UIImage *image = [self fixOrientation:info[UIImagePickerControllerOriginalImage]];
    [self saveImage:image WithName:@"test.jpg"];
    [self updateIcon];
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}
#pragma mark 保存图片到document
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:NO];
}

//图片旋转90校正
- (UIImage *)fixOrientation:(UIImage *)aImage {
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
//YorNButton初始化andsegment
-(void)CreatYorNButton{
    self.YorNButtonArray = [[NSMutableArray alloc] init];
    [self.YorNButtonArray addObject:self.YesButton];
    [self.YorNButtonArray addObject:self.NoButton];
    //self.YesButton.selected=YES;
    self.YesButton.backgroundColor = [UIColor colorWithRed:94/255.0 green:175/255.0 blue:33/255.0 alpha:1];
    self.YesButton.layer.borderWidth = 1;
    self.YesButton.layer.borderColor = [UIColor colorWithRed:94/255.0 green:175/255.0 blue:33/255.0 alpha:1].CGColor;
    self.NoButton.backgroundColor = [UIColor whiteColor];
    self.NoButton.layer.borderWidth = 1;
    self.NoButton.layer.borderColor = [UIColor colorWithRed:94/255.0 green:175/255.0 blue:33/255.0 alpha:1].CGColor;
}
//SegmentActionAction
- (IBAction)SegmentAction:(UISegmentedControl *)segmentControl{
    if (segmentControl.selectedSegmentIndex == 0){
        //添加义工View
 [self NSLayoutMoreViewConstraintHeight:self.volunteersView andSubview:self.volunteersButtonSelectView];
        if (self.NoButton.selected) {
         self.ScrollView.contentSize =CGSizeMake(self.ScrollView.frame.size.width,self.UserInfoWithIconView.frame.size.height-self.EmaileViewButtonSeclect.frame.size.height);
        }else{
        self.ScrollView.contentSize =CGSizeMake(self.ScrollView.frame.size.width,self.UserInfoWithIconView.frame.size.height);
        }
    }else if (segmentControl.selectedSegmentIndex == 1){
        
        [self.volunteersButtonSelectView removeFromSuperview];
         self.volunteersConstraintHeight.constant=0;
        
        if (self.NoButton.selected) {
          
            self.ScrollView.contentSize =CGSizeMake(self.ScrollView.frame.size.width,self.UserInfoWithIconView.frame.size.height - self.volunteersButtonSelectView.frame.size.height-self.EmaileViewButtonSeclect.frame.size.height);
        }else{
         self.ScrollView.contentSize =CGSizeMake(self.ScrollView.frame.size.width,self.UserInfoWithIconView.frame.size.height - self.volunteersButtonSelectView.frame.size.height);
        }
     }

}
//ButtonAction
- (IBAction)YesOrNoButton:(UIButton*)button{
    for (UIButton *btn in self.YorNButtonArray){
        btn.selected=NO;
        btn.backgroundColor = [UIColor whiteColor];
    }
      button.selected=YES;
      button.backgroundColor = [UIColor colorWithRed:94/255.0 green:175/255.0 blue:33/255.0 alpha:1];
    if(self.YesButton.selected==YES){
        [self NSLayoutMoreViewConstraintHeight:self.UserInforDetaileLoadEmaileView andSubview:self.EmaileViewButtonSeclect];
        if (self.IdoSegmentControl.selectedSegmentIndex==0){
          self.ScrollView.contentSize =CGSizeMake(self.ScrollView.frame.size.width,self.UserInfoWithIconView.frame.size.height);
        }else if (self.IdoSegmentControl.selectedSegmentIndex==1){
            self.ScrollView.contentSize =CGSizeMake(self.ScrollView.frame.size.width,self.UserInfoWithIconView.frame.size.height - self.volunteersButtonSelectView.frame.size.height);
        }else{
            self.ScrollView.contentSize =CGSizeMake(self.ScrollView.frame.size.width,self.UserInfoWithIconView.frame.size.height - self.EmaileViewButtonSeclect.frame.size.height);
         }
    }else if (self.NoButton.selected==YES){
        [self.EmaileViewButtonSeclect removeFromSuperview];
         self.EmaileConstraintHeight.constant=0;
        if (self.IdoSegmentControl.selectedSegmentIndex==1){
       self.ScrollView.contentSize =CGSizeMake(self.ScrollView.frame.size.width,self.UserInfoWithIconView.frame.size.height - self.EmaileViewButtonSeclect.frame.size.height -self.volunteersButtonSelectView.frame.size.height);
        }else{
        self.ScrollView.contentSize =CGSizeMake(self.ScrollView.frame.size.width,self.UserInfoWithIconView.frame.size.height - self.EmaileViewButtonSeclect.frame.size.height);
        }
    }
}
//时间响应方法
- (IBAction)TimeButtonAction:(UIButton*)btn{
    if(btn==self.MondayButton){
        self.MondayButton.selected = !self.MondayButton.selected;
        if (self.MondayButton.selected) {
            [self.availableTimeArr addObject:@"Mon,"];
        }else{
            [self.availableTimeArr removeObject:@"Mon,"];
        }
    }else if (btn==self.TuesdayButton){
        self.TuesdayButton.selected = !self.TuesdayButton.selected;
        if (self.TuesdayButton.selected) {
            [self.availableTimeArr addObject:@"Tues,"];
        }else{
            [self.availableTimeArr removeObject:@"Tues,"];
        }
    }else if (btn==self.WednesdayButton){
        self.WednesdayButton.selected = !self.WednesdayButton.selected;
        if (self.WednesdayButton.selected) {
            [self.availableTimeArr addObject:@"Wed,"];
        }else{
            [self.availableTimeArr removeObject:@"Wed,"];
        }
    
    }else if (btn==self.ThuresdayButton){
        self.ThuresdayButton.selected = !self.ThuresdayButton.selected;
        if (self.ThuresdayButton.selected) {
            [self.availableTimeArr addObject:@"Thurs,"];
        }else{
            [self.availableTimeArr removeObject:@"Thurs,"];
        }
    }else if (btn==self.FridayButton){
        self.FridayButton.selected = !self.FridayButton.selected;
        if (self.FridayButton.selected) {
            [self.availableTimeArr addObject:@"Fri,"];
        }else{
            [self.availableTimeArr removeObject:@"Fri,"];
        }
    }else if (btn==self.statudayButton){
        self.statudayButton.selected = !self.statudayButton.selected;
        if (self.statudayButton.selected) {
            [self.availableTimeArr addObject:@"Sat,"];
        }else{
            [self.availableTimeArr removeObject:@"Sat,"];
        }
    
    }else if (btn==self.sundayButton){
        self.sundayButton.selected = !self.sundayButton.selected;
        if (self.sundayButton.selected) {
            [self.availableTimeArr addObject:@"Sun,"];
        }else{
            [self.availableTimeArr removeObject:@"Sun,"];
        }
    
    
    }else if (btn==self.AnytimeButton){
        self.AnytimeButton.selected = !self.AnytimeButton.selected;
        if (self.AnytimeButton.selected) {
            [self.availableTimeArr addObject:@"All,"];
        }else{
            [self.availableTimeArr removeObject:@"All,"];
        }

    
    }else if (btn==self.TenAMButton){
      
        self.TenAMButton.selected = !self.TenAMButton.selected;
        if (self.TenAMButton.selected) {
            [self.availableTimeArr addObject:@"Morning,"];
        }else{
            [self.availableTimeArr removeObject:@"Morning,"];
        }

    
    }else if (btn==self.twoAMButton){
        self.twoAMButton.selected = !self.twoAMButton.selected;
        if (self.twoAMButton.selected) {
            [self.availableTimeArr addObject:@"Afternoon,"];
        }else{
            [self.availableTimeArr removeObject:@"Afternoon,"];
        }

    
    }else if (btn==self.FiveAMButton){
        self.FiveAMButton.selected = !self.FiveAMButton.selected;
        if (self.FiveAMButton.selected) {
            [self.availableTimeArr addObject:@"WholeDay,"];
        }else{
            [self.availableTimeArr removeObject:@"WholeDay,"];
        }
    
    }else if (btn==self.sevenAMButton){
    
        self.sevenAMButton.selected = !self.sevenAMButton.selected;
        if (self.sevenAMButton.selected) {
            [self.availableTimeArr addObject:@"Evening,"];
        }else{
            [self.availableTimeArr removeObject:@"Evening,"];
        }

    
    }else if (btn==self.TimeOtheButton){
        self.TimeOtheButton.selected = !self.TimeOtheButton.selected;
        if (self.TimeOtheButton.selected) {
            [self.availableTimeArr addObject:@"timeOther,"];
        }else{
            [self.availableTimeArr removeObject:@"timeOther,"];
            self.TimePleaseState.text=@"";
        }

    
      }
}
//义工响应方法
- (IBAction)volunteersBtnAction:(UIButton*)btn{
    
    if (btn==self.officeAdminButton) {
        self.officeAdminButton.selected = !self.officeAdminButton.selected;
        if (self.officeAdminButton.selected) {
            [self.volunteerInterestArr addObject:@"Admin,"];
        }else{
            [self.volunteerInterestArr removeObject:@"Admin,"];
        }
    }else if (btn==self.PrintDesign){
        self.PrintDesign.selected = !self.PrintDesign.selected;
        if (self.PrintDesign.selected) {
            [self.volunteerInterestArr addObject:@"Print,"];
        }else{
            [self.volunteerInterestArr removeObject:@"Print,"];
        }
    }else if(btn==self.EventButton){
        self.EventButton.selected = !self.EventButton.selected;
        if (self.EventButton.selected) {
            [self.volunteerInterestArr addObject:@"Contact,"];
        }else{
            [self.volunteerInterestArr removeObject:@"Contact,"];
        }
    }else if(btn==self.Edition){
        self.Edition.selected = !self.Edition.selected;
        if (self.Edition.selected) {
            [self.volunteerInterestArr addObject:@"Editing,"];
        }else{
            [self.volunteerInterestArr removeObject:@"Editing,"];
        }
    }else if(btn==self.TransiationButton){
        self.TransiationButton.selected = !self.TransiationButton.selected;
        if (self.TransiationButton.selected) {
            [self.volunteerInterestArr addObject:@"Translate,"];
        }else{
            [self.volunteerInterestArr removeObject:@"Translate,"];
        }
    }else if(btn==self.CopywritingButton){
        self.CopywritingButton.selected = !self.CopywritingButton.selected;
        if (self.CopywritingButton.selected) {
            [self.volunteerInterestArr addObject:@"Write,"];
        }else{
            [self.volunteerInterestArr removeObject:@"Write,"];
        }
    }else if(btn==self.photographyButton){
        self.photographyButton.selected = !self.photographyButton.selected;
        if (self.photographyButton.selected) {
            [self.volunteerInterestArr addObject:@"Photo,"];
        }else{
            [self.volunteerInterestArr removeObject:@"Photo,"];
        }
    }else if(btn==self.FundraisingButton){
        self.FundraisingButton.selected = !self.FundraisingButton.selected;
        if (self.FundraisingButton.selected) {
            [self.volunteerInterestArr addObject:@"Event,"];
        }else{
            [self.volunteerInterestArr removeObject:@"Event,"];
        }

    }else if(btn==self.VisitButton){
        self.VisitButton.selected = !self.VisitButton.selected;
        if (self.VisitButton.selected) {
            [self.volunteerInterestArr addObject:@"Visit,"];
        }else{
            [self.volunteerInterestArr removeObject:@"Visit,"];
        }
        
    }else if(btn==self.volunteersotherButton){
        self.volunteersotherButton.selected = !self.volunteersotherButton.selected;
        if (self.volunteersotherButton.selected) {
            [self.volunteerInterestArr addObject:@"otherVolunteer,"];
        }else{
            [self.volunteerInterestArr removeObject:@"otherVolunteer,"];
            self.VolunteerPleasestateTexyField.text=@"";
        }
    }
}

-(int)compareDate:(NSString*)date01 withDate:(NSString*)date02{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy/MM/dd"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result){
            //date02比date01大
        case NSOrderedAscending: ci=1; break;
            //date02比date01小
        case NSOrderedDescending: ci=-1; break;
            //date02=date01
        case NSOrderedSame: ci=0; break;
        default: MyLog(@"erorr dates %@, %@", dt2, dt1); break;
    }
    MyLog(@"%d",ci);
    return ci;
    
}

//EmaileButton
- (IBAction)EmaileButtonAction:(id)sender{
    if (sender==self.EducationButton){
        self.ALLButton.selected=NO;
        [self.arr removeObject:@"L,"];
       self.EducationButton.selected = !self.EducationButton.selected;
        if (self.EducationButton.selected){
            [self.arr addObject:@"S,"];
        }else{
            [self.arr removeObject:@"S,"];
          }
    }else if (sender==self.ElderlyButton){
        self.ALLButton.selected=NO;
        [self.arr removeObject:@"L,"];
     self.ElderlyButton.selected = !self.ElderlyButton.selected;
        if (self.ElderlyButton.selected){
            [self.arr addObject:@"E,"];
        }else{
            [self.arr removeObject:@"E,"];
            
        }
    }else if (sender==self.MedicalButton){
        self.ALLButton.selected=NO;
        [self.arr removeObject:@"L,"];
     self.MedicalButton.selected = !self.MedicalButton.selected;
        if (self.MedicalButton.selected){
            
            [self.arr addObject:@"M,"];
            
        }else{
            [self.arr removeObject:@"M,"];
            
        }
    }else if (sender==self.CommunityButton){
        self.ALLButton.selected=NO;
        [self.arr removeObject:@"L,"];
     self.CommunityButton.selected = !self.CommunityButton.selected;
        if (self.CommunityButton.selected) {
            [self.arr addObject:@"P,"];
            
        }else{
            [self.arr removeObject:@"P,"];
        }
    }else if (sender==self.ReliefButton){
        self.ALLButton.selected=NO;
       [self.arr removeObject:@"L,"];
     self.ReliefButton.selected = !self.ReliefButton.selected;
        if (self.ReliefButton.selected) {
            [self.arr addObject:@"U,"];
            
        }else{
            [self.arr removeObject:@"U,"];
        }
    }else if (sender==self.otherButton){
        self.ALLButton.selected=NO;
        [self.arr removeObject:@"L,"];
     self.otherButton.selected = !self.otherButton.selected;
        if (self.otherButton.selected) {
            [self.arr addObject:@"O,"];
            
        }else{
            [self.arr removeObject:@"O,"];
        }
    }else if (sender==self.EgiveActionButton){
        self.ALLButton.selected=NO;
        [self.arr removeObject:@"L,"];
     self.EgiveActionButton.selected = !self.EgiveActionButton.selected;
        if (self.EgiveActionButton.selected) {
            [self.arr addObject:@"A,"];
        }else{
            [self.arr removeObject:@"A,"];
        }
    }else{
     self.ALLButton.selected = !self.ALLButton.selected;
        if (self.ALLButton.selected){
            
            for (int i = 0; i < self.EmaileButton.count; i ++){
                UIButton * button = [self.EmaileButton objectAtIndex:i];
                button.selected = YES;
            }
            [self.arr removeAllObjects];
           NSArray * DonationInterestArr = @[@"S",@"E",@"M",@"P",@"U",@"O",@"A",@"L"];
            for (int j=0; j<DonationInterestArr.count; j++) {
                 NSString *str = [NSString stringWithFormat:@"%@,",DonationInterestArr[j]];
                [self.arr addObject:str];
                
            }
            //[self.arr addObject:@"L,"];
            
        }else{
            
            
            for (int i = 0; i < self.EmaileButton.count; i ++){
                
                UIButton * button = [self.EmaileButton objectAtIndex:i];
                button.selected = NO;
            }
            [self.arr removeAllObjects];
            //[self.arr removeObject:@"L,"];
            
        }
    }
}
//How do you know Egive?
- (IBAction)HowDoYouKnowAboutEgiveAction:(UIButton*)btn {
   
    if (btn==self.EgiveWebsiteButton) {
        self.EgiveWebsiteButton.selected = !self.EgiveWebsiteButton.selected;
        if (self.EgiveWebsiteButton.selected){
            [self.HowDoyouKnowEgiveButtonArray addObject:@"Web,"];
        }else{
            [self.HowDoyouKnowEgiveButtonArray removeObject:@"Web,"];

         }
        
    }else if (btn==self.EgiveMagazineButton){
        self.EgiveMagazineButton.selected = !self.EgiveMagazineButton.selected;
        if (self.EgiveMagazineButton.selected){
            [self.HowDoyouKnowEgiveButtonArray addObject:@"Event,"];
        }else{
            [self.HowDoyouKnowEgiveButtonArray removeObject:@"Event,"];
            
        }
    
    }else if (btn==self.FriendButton){
        self.FriendButton.selected = !self.FriendButton.selected;
        if (self.FriendButton.selected){
            [self.HowDoyouKnowEgiveButtonArray addObject:@"Friend,"];
        }else{
            [self.HowDoyouKnowEgiveButtonArray removeObject:@"Friend,"];
            
        }
        
    }else if (btn==self.NewspaperButton){
        self.NewspaperButton.selected = !self.NewspaperButton.selected;
        if (self.NewspaperButton.selected){
            [self.HowDoyouKnowEgiveButtonArray addObject:@"News,"];
        }else{
            [self.HowDoyouKnowEgiveButtonArray removeObject:@"News,"];
            
        }
        
    }else if (btn==self.SocialMediaButton){
        self.SocialMediaButton.selected = !self.SocialMediaButton.selected;
        if (self.SocialMediaButton.selected){
            [self.HowDoyouKnowEgiveButtonArray addObject:@"Social,"];
        }else{
            [self.HowDoyouKnowEgiveButtonArray removeObject:@"Social,"];
            
        }
        
    }else if (btn==self.AsaEgiveButton){
        self.AsaEgiveButton.selected = !self.AsaEgiveButton.selected;
        if (self.AsaEgiveButton.selected){
            [self.HowDoyouKnowEgiveButtonArray addObject:@"Donor,"];
        }else{
            [self.HowDoyouKnowEgiveButtonArray removeObject:@"Donor,"];
            
        }
        
    }else if (btn==self.HowDoyouKnowEgiveOtherButton){
        self.HowDoyouKnowEgiveOtherButton.selected = !self.HowDoyouKnowEgiveOtherButton.selected;
        if (self.HowDoyouKnowEgiveOtherButton.selected){
            [self.HowDoyouKnowEgiveButtonArray addObject:@"other"];
        }else{
            [self.HowDoyouKnowEgiveButtonArray removeObject:@"other"];
            
        }
    }
}
//设置Button语言和selectImage
-(void)configurationButton{
    [self CreatvolunteersButton];
    [self CreatButtonSeclectColor:self.YesButton];
    [self CreatButtonSeclectColor:self.NoButton];
    [self EmaileButtonmethod];
       [self timeButton];
    [self HowDoyouKnowButton];
    //初始化头像
    _IconImage.layer.cornerRadius = 45;
    _IconImage.layer.masksToBounds = YES;
    _IconImage.userInteractionEnabled = YES;
}
//查看排名
- (IBAction)CheckRankingAction:(id)sender {
    RankListViewController * vc = [[RankListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//查看捐款记录
- (IBAction)DonationRecordAction:(id)sender{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:@"1" forKey:@"EGIVE_AFTER_DONATE"];
    [standardUserDefaults synchronize];
    MyDonationViewController * vc = [[MyDonationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//修改密码
- (IBAction)ChangePassAction:(id)sender{
   UpdatePwsViewController * vc = [[UpdatePwsViewController alloc] init];
   [self.navigationController pushViewController:vc animated:YES];
}
//How Do you Know Button
-(void)HowDoyouKnowButton{
  
    HowDoyouKnowButtonArray = @[self.EgiveWebsiteButton,self.EgiveMagazineButton,self.FriendButton,self.NewspaperButton,self.SocialMediaButton,self.AsaEgiveButton,self.HowDoyouKnowEgiveOtherButton];
    [self CreatButtonvolunteersSeclectImage:HowDoyouKnowButtonArray];

}
//配置EmaileButton
-(void)EmaileButtonmethod{
    self.EmaileButton =@[self.EducationButton,self.ElderlyButton,self.MedicalButton,self.CommunityButton,self.ReliefButton,self.otherButton,self.EgiveActionButton,self.ALLButton];
    [self CreatButtonvolunteersSeclectImage:self.EmaileButton];
}
//配置时间Button
-(void)timeButton{
    TimebuttonArray = @[self.MondayButton,self.TuesdayButton,self.WednesdayButton,self.ThuresdayButton,self.FridayButton,self.statudayButton,self.sundayButton,self.AnytimeButton,self.TenAMButton,self.twoAMButton,self.FiveAMButton,self.sevenAMButton,self.TimeOtheButton];
    [self CreatButtonvolunteersSeclectImage:TimebuttonArray];

}
//HKorOtherSegment
- (IBAction)HKorOtherSegmentAction:(UISegmentedControl *)segmentControl{
    if (segmentControl.selectedSegmentIndex==0) {
        self.ValidEmaileTrallingConstraint.constant=0;
        self.HKorOtherTextField.hidden=YES;
    }else{
        self.ValidEmaileTrallingConstraint.constant=120;
        self.HKorOtherTextField.hidden=NO;
    
        }
}
//完成Button
- (IBAction)ConfirmButtonAction:(id)sender{
    
    if (([_chLastName.text isEqualToString:@""]&&[_chfirstName.text isEqualToString:@""]&&[_enLastName.text isEqualToString:@""]&&[_enfirstName.text isEqualToString:@""])){
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"请输入[联络人姓名(中)(姓)]M", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        
    }else if (((![_chLastName.text isEqualToString:@""] && [_chfirstName.text isEqualToString:@""]) || ([_chLastName.text isEqualToString:@""] && ![_chfirstName.text isEqualToString:@""]))){
        
        if ([_chLastName.text isEqualToString:@""]){
            
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"请输入[联络人姓名(中)(姓)]M", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            
        }else{
            
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"请输入[联络人姓名(中)(名)]M", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            
        }
        
        
    }else if (((![_enLastName.text isEqualToString:@""]&&[_enfirstName.text isEqualToString:@""]) || ([_enLastName.text isEqualToString:@""]&&![_enfirstName.text isEqualToString:@""])) ){
        
        
        if ([_enLastName.text isEqualToString:@""]) {
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"请输入[联络人姓名(英)(姓)]M", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"请输入[联络人姓名(英)(名)]M", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            
        }
    
    }else if ((![self isZhongWenFirst:_chLastName.text]&&![_chLastName.text isEqualToString:@""]) || (![self isZhongWenFirst:_chfirstName.text]&&![_chfirstName.text isEqualToString:@""])){
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"联络人姓名(中)内请输入中文M",nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
    }else if (![self pipeizimu:_enLastName.text] || ![self pipeizimu:_enfirstName.text]){
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"联络人姓名(英) 内请输入英文M",nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
    }else{
        
        if (![NSString isEmpty:_emaile.text andNote:EGLocalizedString(@"邮箱不能为空", nil)]) {
            if ([NSString isEmail:_emaile.text]){
            
        if (![NSString isEmpty:_PhoneNumber.text andNote:EGLocalizedString(@"联络电话不能为空", nil)]) {
        
            if ([self HkorOther]) {
                
                if ([self selectzhuana:_arr]){
                    
                    if ([self CheckStartTimeforvoluntter:_dateStart.text]) {
                        
                      if ([self CheckEndTimeforvoluntter:_dateEnd.text]){
                          
                        if ([self compareDate:_dateStart.text withDate:_dateEnd.text]==-1) {
                            
                            
                            UIAlertView *alertView = [[UIAlertView alloc] init];
                            alertView.message = EGLocalizedString(@"开始日期必须早于结束日期",nil);
                            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                            [alertView show];
                            
                              
                        }else{
                    
                        [self PostIndividualUserInfo];
                       }
                }
            
            }
            
        }
      }
    
     }
            }}}

}

-(BOOL)chicheckENLastName:(NSString*)LastName{
    
    if (![self pipeizimu:LastName] && ![LastName isEqualToString:@""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"englishName", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
    }else{
        return true;
        
    }
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if (textField.text.length + string.length > 50) {
//        return NO;
//    }
//    
//    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
//        if (textField==_enfirstName ||textField==_enLastName){
//        
//        if (![self pipeizimu:toBeString]) {
//            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:EGLocalizedString(@"englishName",nil) delegate:self cancelButtonTitle:nil otherButtonTitles:EGLocalizedString(@"Common_button_confirm",nil), nil];
//            alertView.tag=1010;
//            [alertView show];
//            return NO;
//            
//        }
//        
//    }
//    
//    return YES;
//}



-(BOOL)chicheckLastName:(NSString*)LastName{
    
    if (![self isZhongWenFirst:LastName] && ![LastName isEqualToString:@""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"联络人姓名(中)内请输入中文M", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
        
    }else{
        return true;
        
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
    
    return NO;
}

-(BOOL)CheckEndTimeforvoluntter:(NSString*)EndDate{
    
    if (![self selectTimeforvoluntter:EndDate] && ![EndDate isEqualToString:@""] && _IdoSegmentControl.selectedSegmentIndex==0) {
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"义工服务结束日期格式无效", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
        
    }else{
        
        return true;
        
    }
    
}

-(BOOL)CheckStartTimeforvoluntter:(NSString*)StartDate{
    
    if (![self selectTimeforvoluntter:StartDate] && ![StartDate isEqualToString:@""] && _IdoSegmentControl.selectedSegmentIndex==0){
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"义工服务开始日期格式无效", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
        
    }else{
    
        return true;
    
    }

}

-(BOOL)selectTimeforvoluntter:(NSString*)Date{
    
    NSString *date = @"^((?!0000)[0-9]{4}([-/.])((0[1-9]|1[0-2])([-/.])(0[1-9]|1[0-9]|2[0-8])|((0[13-9]|1[0-2])([-/.])(29|30))|((0[13578]|1[02])([\\-\\/\\.])31)))|(([0-9]{2}(0[48]|[2468][048]|[13579][26])|(0[48]|[2468][048]|[13579][26])00)([\\-\\/\\.])02([\\-\\/\\.])29$)";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", date];
    
    if ([regextestA evaluateWithObject:Date] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(BOOL)selectzhuana:(NSArray*)array{
    if (array.count==0 && _YesButton.selected){
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"请选取您喜欢的专案类别",nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
        
    }else{
    
        return true;
    
    }
}

//-(BOOL)HKorOther:(NSString*)otherString{
//  
//    if ([otherString isEqualToString:@""]&&self.HKorOtherSegment.selectedSegmentIndex==1) {
//        
//        UIAlertView *alertView = [[UIAlertView alloc] init];
//        alertView.message = EGLocalizedString(@"hkorother", nil);
//        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
//        [alertView show];
//    }
//
//   
//    return true;
//
//}

-(BOOL)address: (NSString*)Register_org_region1 andRegister_org_region2:(NSString*)Register_org_region2  andRegister_org_region3:(NSString*)Register_org_region3  andRegister_org_region4:(NSString*)Register_org_region4 andRegister_org_region5:(NSString*)Register_org_region5 {
    
    if ([Register_org_region1 isEqualToString:@""]&&[Register_org_region2 isEqualToString:@""]&&[Register_org_region3 isEqualToString:@""]&&[Register_org_region4 isEqualToString:@""]&&[Register_org_region5 isEqualToString:@""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"请输入[机构地址]P", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
    }
    
    
    
    return true;
}
//判断是否选择了香港或者其他
-(BOOL)HkorOther{
    
   
    if (self.HKorOtherSegment.selectedSegmentIndex==1 && [self isEmpty:self.HKorOtherTextField.text]){
        
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

//信息修改成功后改变View
-(void)completeUserInfo{
    
    [self borderStyleNone];
    [self layOutForModifyUI];
    self.view.userInteractionEnabled=YES;
    self.UserInforDetaileLoadEmaileView.userInteractionEnabled =NO;
    self.volunteersView.userInteractionEnabled = NO;
    self.UserInfoDetaileView.userInteractionEnabled = NO;
    self.volunteersButtonSelectView.userInteractionEnabled=NO;
    self.UserInfoLoadView.userInteractionEnabled=NO;
    self.UserInfoWithIconView.userInteractionEnabled=NO;
    
    self.ConfirmButton.hidden=YES;
    self.AgeDropDownMenu.hidden=YES;
    _BelongToDropDownMenu.hidden=YES;
    _EducationDropDownMenu.hidden=YES;
    _WorkDropDownMenu.hidden=YES;
    self.chNameLabel.hidden=NO;
    self.enName.hidden=NO;
    self.chfirstName.hidden=YES;
    self.chLastName.hidden=YES;
    self.enfirstName.hidden=YES;
    self.enLastName.hidden=YES;
    self.ConturyCodeNumberTextField.hidden=YES;
    self.PhoneNumber.hidden=YES;
    self.DetailePhoneNumber.hidden=NO;
    self.IconImage.userInteractionEnabled=NO;
    self.SexDropDownMenu.hidden=YES;

}

//修改Button
- (IBAction)ModifyButtonAction:(id)sender{
    [self borderStyleRoundedRect];
    self.UserInforDetaileLoadEmaileView.userInteractionEnabled =YES;
    self.volunteersView.userInteractionEnabled = YES;
    self.UserInfoDetaileView.userInteractionEnabled = YES;
    self.volunteersButtonSelectView.userInteractionEnabled=YES;
    self.UserInfoLoadView.userInteractionEnabled=YES;
    self.UserInfoWithIconView.userInteractionEnabled=YES;
     self.IconImage.userInteractionEnabled=YES;
    self.ConfirmButton.hidden=NO;
    [self layOutConfirmeUI];
    //年龄下拉框
   self.AgeDropDownMenu=[[EGDropDownMenu alloc] initWithFrame:CGRectMake(7, 465, 125, 25) Array:_ageGroupArray selectedColor:[UIColor darkGrayColor]];
    self.AgeDropDownMenu.delegate=self;
    [self.UserInfoDetaileView addSubview:self.AgeDropDownMenu];
    //性别下拉框
    self.SexDropDownMenu=[[EGDropDownMenu alloc] initWithFrame:CGRectMake(7, 395, 125, 25) Array:sexArr selectedColor:[UIColor darkGrayColor]];
    self.SexDropDownMenu.delegate=self;
    [self.UserInfoDetaileView addSubview:self.SexDropDownMenu];
    _BelongToDropDownMenu.hidden=NO;
    _EducationDropDownMenu.hidden=NO;
    _WorkDropDownMenu.hidden=NO;
    self.chNameLabel.hidden=YES;
    self.enName.hidden=YES;
    self.chfirstName.hidden=NO;
    self.chLastName.hidden=NO;
    self.enfirstName.hidden=NO;
    self.enLastName.hidden=NO;
    self.DetailePhoneNumber.hidden=YES;
    self.ConturyCodeNumberTextField.hidden=NO;
    self.PhoneNumber.hidden=NO;
    NSArray *sexArr = @[EGLocalizedString(@"男", nil),EGLocalizedString(@"女", nil)];
    NSInteger *sexNumber = [sexArr indexOfObject:_Sex.text];
    [_SexDropDownMenu setSelectedRow:sexNumber];
    
    if (![_item.AgeGroup isEqualToString:@" "]) {
        
        int num = ([_item.AgeGroup intValue] +1);
        [_AgeDropDownMenu setSelectedRow:num];

    }
    
    NSInteger *number = [_belongCd indexOfObject:[_item.BelongTo uppercaseString]];
    MyLog(@"%@",_belongDesp);
    MyLog(@"number=%ld",number);
    _selectedIndex = number;
    [_BelongToDropDownMenu setSelectedRow:number];
    
    if (![_item.EducationLevel isEqualToString:@" "]) {
        
        NSInteger *Educationnumber = [_EducationCd indexOfObject:[_item.EducationLevel uppercaseString]];
        _EducationselectedIndex = Educationnumber;
        [_EducationDropDownMenu setSelectedRow:Educationnumber];
        
    }
    
    if (![_item.Position isEqualToString:@""]) {
        NSInteger *Worknumber = [_WorkCd indexOfObject:_item.Position];
        _WorkselectedIndex = Worknumber;
        [_WorkDropDownMenu setSelectedRow:Worknumber];
    }
}
//登出Button
- (IBAction)LoginOutButtonAction:(id)sender{
    NSMutableDictionary * dict = [ShowMenuView getUserInfo];
    [dict removeAllObjects];
    [ShowMenuView sharedInstance].member = nil;
    //登出以后移除捐款信息
    NSMutableDictionary * donationDict = [ShowMenuView getDonationAmount];
    [donationDict removeAllObjects];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults removeObjectForKey:@"EGIVE_MEMBER_MODEL"];
    [standardUserDefaults setObject:@"0" forKey:@"FACEBOOK_REG_REQ"];
    [standardUserDefaults setObject:@"0" forKey:@"WEIBO_REG_REQ"];
    [standardUserDefaults synchronize];
    
    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    HomeViewController * vc = [[HomeViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    [menuController setRootController:navController animated:YES];
}
//配置义工Button
-(void)CreatvolunteersButton{
    volunteersbuttonTotalArray = @[self.officeAdminButton,self.PrintDesign,self.EventButton,self.Edition,self.TransiationButton,self.CopywritingButton,self.photographyButton,self.FundraisingButton,self.VisitButton,self.volunteersotherButton];
    [self CreatButtonvolunteersSeclectImage:volunteersbuttonTotalArray];
}
-(void)CreatButtonSeclectImage:(UIButton*)btn{
    [btn setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_nor"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel"] forState:UIControlStateSelected];
}
-(void)CreatButtonvolunteersSeclectImage:(NSArray*)Array{
    for (UIButton *btn in Array) {
        [btn setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_nor"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel"] forState:UIControlStateSelected];
    }
}
-(void)CreatButtonSeclectColor:(UIButton*)btn{

    [btn setTitleColor:[UIColor colorWithRed:94/255.0 green:175/255.0 blue:33/255.0 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

}
//约束方法
-(void)SetScrollViewContentSize:(UIScrollView*)scrollview andView:(UIView *)view{

    [scrollview setContentSize:CGSizeMake(scrollview.frame.size.width,view.frame.size.height)];
}
-(void)NSLayoutMoreViewConstraintHeight:(UIView*)view andSubview:(UIView*)subview{
    if (view==self.UserInforDetaileLoadEmaileView){
         self.EmaileConstraintHeight.constant = subview.frame.size.height;
    }else if (view == self.volunteersView){
        self.volunteersConstraintHeight.constant = subview.frame.size.height;
    }else if (view==self.RegionDetaileView){
        self.RegionConstraintHeight.constant = subview.frame.size.height;
    
    }
      [view addSubview:subview];
}
-(void)NSLayoutView:(UIView*)view andSubview:(UIView*)subview{
    
    for (NSLayoutConstraint *constraint in view.constraints){
        if (constraint.firstAttribute == NSLayoutAttributeHeight){
            constraint.constant = subview.frame.size.height;
            break;
        }
    }
         [view addSubview:subview];
}
-(void)layOutWidhView:(UIView*)view{
    CGRect BigcontentViewRect = view.frame;
    BigcontentViewRect.size.width=ScreenSize.width-10;
    BigcontentViewRect.size.height=view.frame.size.height;
    BigcontentViewRect.origin.x=0;
    [view setFrame:BigcontentViewRect];
}
//PickerView显示地区
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{
    // 返回2表明该控件只包含2列
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return regionArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    
    return [regionArray objectAtIndex:row];
    
}
// 当用户选中UIPickerViewDataSource中指定列、指定列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    
    self.region.text = [regionArray objectAtIndex:row];
}
// UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为
// UIPickerView中指定列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component{
    return ScreenSize.width;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark filter - 下拉列表代理方法
- (void)dropDownMenu:(EGDropDownMenu *)dropDownMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dropDownMenu == _AgeDropDownMenu){
         _isSelAge = YES;
        if (indexPath.row != 0){
            _ageGroup = [NSString stringWithFormat:@"%ld",indexPath.row-1];
        }else{
            _ageGroup = _item.AgeGroup;
        }
    }else if (dropDownMenu == _SexDropDownMenu){
        _isSexBelongDown = YES;
        _sexIndex = indexPath.row;
    }else if (dropDownMenu==_EducationDropDownMenu){
         _isEducationDown=YES;
        if (indexPath.row !=0){
            _EducationselectedIndex=indexPath.row;
            _EducationTextField.text = _EducationDesp[_EducationselectedIndex];
        }else{
           NSInteger *Educationnumber = [_EducationCd indexOfObject:[_item.EducationLevel uppercaseString]];
           _EducationselectedIndex=Educationnumber;
           
        }
    
    }else if (dropDownMenu==_WorkDropDownMenu){
         _isWorkDown=YES;
        if (indexPath.row != 0) {
            _WorkselectedIndex = indexPath.row;
            _WorkTextField.text = _WorkDesp[_WorkselectedIndex];
            
        }else{
          NSInteger *Worknumber = [_WorkCd indexOfObject:_item.Position];
            _WorkselectedIndex = Worknumber;

         }
        
       
    }else{
        _isSelBelongDown = YES;
        _selectedIndex = indexPath.row;
        _BelongTotextField.text = _belongDesp[_selectedIndex];
    }
    
}
#pragma mark - 请求表格数据
-(void)requestMemberFormData{
    long lang = [EGUtility getAppLang];
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <GetMemberForm xmlns=\"egive.appservices\"><Lang>%ld</Lang></GetMemberForm></soap:Body></soap:Envelope>",lang
     ];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        _belongDesp = [[NSMutableArray alloc] init];
        _belongCd = [[NSMutableArray alloc] init];
        _EducationDesp = [[NSMutableArray alloc] init];
        _EducationCd = [[NSMutableArray alloc] init];
        _WorkCd  = [[NSMutableArray alloc] init];
        _WorkDesp = [[NSMutableArray alloc] init];
        //刷新界面
        [self CreatUI];
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary * dict = [NSString parseJSONStringToNSDictionary:dataString];
        MyLog(@"%@",dataString);
        _FormModel = [[MemberFormModel alloc] init];
        [_FormModel setValuesForKeysWithDictionary:dict];
        NSArray * options = _FormModel.BelongToOptions[@"options"];
        NSArray *Educationoptions = _FormModel.EducationLevelOptions[@"options"];
        NSArray *Workoptions = _FormModel.PositionOptions[@"options"];

        MyLog(@"%@",Educationoptions);
        MyLog(@"optionsoptionsoptions = %@", options);
        _belongDesp = [[NSMutableArray alloc] init];
        _belongCd = [[NSMutableArray alloc] init];
        if ([_item.AgeGroup isEqualToString:@" "]){
            _agetextField.text = @"";
        }else{
            NSArray *ageArr3 = @[EGLocalizedString(@"Please_Select", nil),@"0 - 10",@"11 - 20",@"21 - 30",@"31 - 40",@"41 - 50",@"51 - 60",@"61 - 70",@"71 - 80",@"81 - 90",@"90+"];
            int num = [_item.AgeGroup intValue];
            _agetextField.text = ageArr3[num+1];
            
        }
        //获取职业
         NSMutableDictionary *WorkDict = [[NSMutableDictionary alloc] init];
        for (NSDictionary * opDict in Workoptions){
            //if (![opDict[@"Cd"] isEqualToString:@""]) {
                [_WorkDesp addObject:opDict[@"Desp"]];
                [_WorkCd addObject:opDict[@"Cd"]];
                [WorkDict setObject:opDict[@"Desp"] forKey:opDict[@"Cd"]];
            //}
            
        }
        NSArray *Workarray = [_WorkDesp copy];
        NSArray *WorkDetailearray = @[Workarray];
        _WorkDropDownMenu  = [[EGDropDownMenu alloc] initWithFrame:CGRectMake(7, 260, ScreenSize.width-15, 25) Array:WorkDetailearray selectedColor:[UIColor darkGrayColor]];
        _WorkDropDownMenu.hidden = YES;
        _WorkDropDownMenu.delegate = self;
        [self.UserInfoDetaileView addSubview:_WorkDropDownMenu];
        if (![_item.Position isEqualToString:@""]) {
            
         self.WorkTextField.text = [WorkDict objectForKey: _item.Position];
            
        }
        //获取教育程度
        _EducationCdDict = [[NSMutableDictionary alloc] init];
        _EducationDespDict = [[NSMutableDictionary alloc] init];
        for (NSDictionary * opDict in Educationoptions){
            //if (![opDict[@"Cd"] isEqualToString:@""]) {
                
                [_EducationDesp addObject:opDict[@"Desp"]];
                [_EducationCd addObject:opDict[@"Cd"]];
                [_EducationDespDict setObject:opDict[@"Desp"] forKey:opDict[@"Cd"]];
            //}
           
        }
        NSArray *Educationarray = [_EducationDesp copy];
        NSArray *EducationDetailearray = @[Educationarray];
        _EducationDropDownMenu = [[EGDropDownMenu alloc] initWithFrame:CGRectMake(7, 192, ScreenSize.width-15, 25) Array:EducationDetailearray selectedColor:[UIColor darkGrayColor]];
        _EducationDropDownMenu.hidden = YES;
        _EducationDropDownMenu.delegate = self;
        [self.UserInfoDetaileView addSubview:_EducationDropDownMenu];
        self.EducationTextField.text = [_EducationDespDict objectForKey: _item.EducationLevel];
        //获取所属机构数据
        _cdDict = [[NSMutableDictionary alloc] init];
        Belongdict =[[NSMutableDictionary alloc] init];
        for (NSDictionary * opDict in options){
            [_belongDesp addObject:opDict[@"Desp"]];
            [_belongCd addObject:opDict[@"Cd"]];
            [_cdDict setObject:opDict[@"Cd"] forKey:opDict[@"Desp"]];
            [Belongdict setObject:opDict[@"Desp"] forKey:opDict[@"Cd"]];
        }
        NSArray *array = [_belongDesp copy];
        MyLog(@"array=%@",array);
        NSArray * orgArr = @[array];
        //创建所属机构下拉列表
        _BelongToDropDownMenu = [[EGDropDownMenu alloc] initWithFrame:CGRectMake(7, 328, ScreenSize.width-15, 25) Array:orgArr selectedColor:[UIColor darkGrayColor]];
        _BelongToDropDownMenu.hidden = YES;
        _BelongToDropDownMenu.delegate = self;
        [self.UserInfoDetaileView addSubview:_BelongToDropDownMenu];
        //显示BelongTo
        NSString *BelongString = [Belongdict objectForKey:_item.BelongTo];
        MyLog(@"BelongString=%@",BelongString);
        _BelongTotextField.text = BelongString;
        
        
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
//#pragma mark - 修改用户信息请求
- (void)PostIndividualUserInfo{
        MemberModel * model = [[MemberModel alloc] init];
        model.MemberType = @"P";
        model.TelNo = _PhoneNumber.text;
        model.password = @"";
        model.ChiNameTitle =_item.ChiNameTitle;
        model.ChiLastName = _chLastName.text;
        model.ChiFirstName = _chfirstName.text;
        model.EngNameTitle = _item.EngNameTitle;
        model.EngLastName = _enLastName.text;
        model.EngFirstName = _enfirstName.text;
        model.AddressRoom = _addressDistrict.text;
        model.AddressBldg = _addressBldg.text;
        model.AddressEstate = _addressEstate.text;
        model.AddressStreet = _addressStreet.text;
        model.AddressDistrict = _region.text;
        model.TelCountryCode = self.ConturyCodeNumberTextField.text;
        if (self.HKorOtherSegment.selectedSegmentIndex==1) {
             model.AddressCountry = self.HKorOtherTextField.text;
        }else{
            model.AddressCountry=@"香港";
         }
        if (_isSexBelongDown){
            if (_sexIndex == 0) {
                model.Sex = @"M";
                model.ChiNameTitle =@"R";
                model.EngNameTitle = @"R";
            }else{
                model.Sex = @"F";
                model.ChiNameTitle =@"M";
                model.EngNameTitle = @"M";
            }
        }else{
            if ([_item.ChiNameTitle isEqualToString:@"R"]) {
                model.Sex = @"M";
            }else{
                model.Sex = @"F";
            }
        }
        model.Email = [_emaile.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (_isSelAge == NO){
            
            model.AgeGroup = _item.AgeGroup;
            
        }else{
            
            model.AgeGroup = _ageGroup;
            
        }
        if (_isEducationDown==NO){
          
            model.EducationLevel = _item.EducationLevel;
            
        }else{
            
            model.EducationLevel = [_EducationCd objectAtIndex:_EducationselectedIndex];
        
        }
        
        if (_isWorkDown==NO) {
        
            model.Position = _item.Position;
        }else{
            model.Position = [_WorkCd objectAtIndex:_WorkselectedIndex];

        
        }
        if (_isSelBelongDown == NO) {
            MyLog(@"BelongTo-------%@",_cdDict[_item.BelongTo]);
            model.BelongTo = [_item.BelongTo lowercaseString];
        }else{
            model.BelongTo = [_belongCd[_selectedIndex] uppercaseString];
            MyLog(@"model.BelongTo----->%@",model.BelongTo);
            
        }
        //是否收到电邮资讯
        if (_YesButton.selected == YES) {
            model.AcceptEDM = YES;
        }else{
            model.AcceptEDM = NO;
        }
        //是否成为义工
        if (self.IdoSegmentControl.selectedSegmentIndex==0) {
            model.JoinVolunteer = YES;
            if (self.LongOrShortSegment.selectedSegmentIndex==0) {
                model.VolunteerType = @"L";
            }else{
                model.VolunteerType = @"S";
            }
            model.VolunteerStartDate = _dateStart.text;
            model.VolunteerEndDate = _dateEnd.text;
            NSMutableString * muStr = [[NSMutableString alloc] init];
            for (int i = 0; i < _volunteerInterestArr.count; i ++){
                if (i==9 && _item.VolunteerInterest_Other != NULL && ![_item.VolunteerInterest_Other isEqualToString:@""]){
                    [muStr appendString:_volunteerInterestArr[i]];
                }else if (i != 9){
                  [muStr appendString:_volunteerInterestArr[i]];
                
                }
                
            }
                model.VolunteerInterest = muStr;
                MyLog(@"model.VolunteerInterest==%@",model.VolunteerInterest);
            
            NSMutableString * muStr1 = [[NSMutableString alloc] init];
            for (int i = 0; i < _availableTimeArr.count; i++) {
                if (i==12 && (![_item.AvailableTime_Other isEqualToString:@""] && _item.AvailableTime_Other != NULL)){
                    [muStr1 appendString:_availableTimeArr[i]];
                }else if(i != 12){
                    [muStr1 appendString:_availableTimeArr[i]];
                }
            }
                model.AvailableTime = muStr1;
                MyLog(@"model.AvailableTi===%@",model.AvailableTime);
        }else{
            model.JoinVolunteer = NO;
            model.VolunteerType = @" ";
        }
        //电邮资讯
        NSMutableString * muStr3 = [[NSMutableString alloc] init];
        for (int i = 0; i < _arr.count; i ++) {
            [muStr3 appendString:_arr[i]];
        }
        model.DonationInterest = muStr3;
        if (self.volunteersotherButton.selected){
            model.VolunteerInterest_Other = self.VolunteerPleasestateTexyField.text;
        }else{
            model.VolunteerInterest_Other = @" ";
        }
        if (self.TimeOtheButton.selected) {
            model.AvailableTime_Other = self.TimePleaseState.text;
        }else{
            model.AvailableTime_Other = @" ";
        }
        
        NSMutableString * muStr = [[NSMutableString alloc] init];
        for (int i = 0; i < _HowDoyouKnowEgiveButtonArray.count; i ++) {
            [muStr appendString:_HowDoyouKnowEgiveButtonArray[i]];
        }
        
        model.HowToKnoweGive = muStr;
        if (_HowDoyouKnowEgiveOtherButton.selected) {
            model.HowToKnoweGive_Other = _HowDoyouknowEgivePleasestate.text;
        }else{
            model.HowToKnoweGive_Other = @" ";
            _HowDoyouknowEgivePleasestate.text = @"";
        }
        model.AppToken = @" ";
        [self SaveMemberInfo:model];
    
}


- (void)SaveMemberInfo:(MemberModel *)model{
    long lang = [EGUtility getAppLang];
    [self showLoadingAlert];
    MyLog(@"%@",model.MemberID);
    MyLog(@"VolunteerInterest --------------- %@",model.EngLastName);
    MyLog(@"AvailableTime --------------- %@",model.EngFirstName);
    MyLog(@"ProfilePicBase64String----- %@",_base64Avatar);
    MyLog(@"BelongTo----- %@",model.BelongTo);
    if (_base64Avatar == nil){
        _base64Avatar = @"";
        NSString *urlmString = [NSString stringWithFormat:@"%@%@",SITE_URL,@"/Images/default_m.jpg"];
        NSString *urlFString = [NSString stringWithFormat:@"%@%@",SITE_URL,@"/Images/default_f.jpg"];
        if (_IconImage != nil  && ![[NSString stringWithFormat:@"%@" ,PICurl]  isEqualToString: urlmString] && ![[NSString stringWithFormat:@"%@" ,PICurl]  isEqualToString: urlFString]){
            
            _base64Avatar = [UIImagePNGRepresentation([self imageWithImage:[_IconImage image] convertToSize:CGSizeMake(128, 128)]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            MyLog(@"ProfilePicBase64String----- %@",_base64Avatar);
        }
        
    }
    MyLog(@"ProfilePicBase64String************** %@",_base64Avatar);
    NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <SaveMemberInfo xmlns=\"egive.appservices\"><MemberID>%@</MemberID><MemberType>%@</MemberType><CorporationType>%@</CorporationType><CorporationType_Other>%@</CorporationType_Other><LoginName></LoginName><Password></Password><ConfirmPassword></ConfirmPassword><ProfilePicBase64String>%@</ProfilePicBase64String><CorporationChiName>%@</CorporationChiName><CorporationEngName>%@</CorporationEngName><BusinessRegistrationType>%@</BusinessRegistrationType><BusinessRegistrationNo>%@</BusinessRegistrationNo><ChiNameTitle>%@</ChiNameTitle><ChiLastName>%@</ChiLastName><ChiFirstName>%@</ChiFirstName><EngNameTitle>%@</EngNameTitle><EngLastName>%@</EngLastName><EngFirstName>%@</EngFirstName><Sex>%@</Sex><AgeGroup>%@</AgeGroup><Email>%@</Email><TelCountryCode>%@</TelCountryCode><TelNo>%@</TelNo><AddressRoom>%@</AddressRoom><AddressBldg>%@</AddressBldg><AddressEstate>%@</AddressEstate><AddressStreet>%@</AddressStreet><AddressDistrict>%@</AddressDistrict><AddressCountry>%@</AddressCountry><EducationLevel>%@</EducationLevel><Position>%@</Position><BelongTo>%@</BelongTo><HowToKnoweGive>%@</HowToKnoweGive><HowToKnoweGive_Other>%@</HowToKnoweGive_Other><AcceptEDM>%d</AcceptEDM><DonationInterest>%@</DonationInterest><JoinVolunteer>%d</JoinVolunteer><VolunteerType>%@</VolunteerType><VolunteerStartDate>%@</VolunteerStartDate><VolunteerEndDate>%@</VolunteerEndDate><VolunteerInterest>%@</VolunteerInterest><VolunteerInterest_Other>%@</VolunteerInterest_Other><AvailableTime>%@</AvailableTime><AvailableTime_Other>%@</AvailableTime_Other><AppToken>%@</AppToken><FaceBookID>%@</FaceBookID><WeiboID>%@</WeiboID><Lang>%ld</Lang></SaveMemberInfo></soap:Body></soap:Envelope>",_item.MemberID,model.MemberType,model.CorporationType,model.CorporationType_Other,_base64Avatar,model.CorporationChiName,model.CorporationEngName,model.BusinessRegistrationType,model.BusinessRegistrationNo,model.ChiNameTitle,model.ChiLastName,model.ChiFirstName,model.EngNameTitle,model.EngLastName,model.EngFirstName,model.Sex,model.AgeGroup,model.Email,model.TelCountryCode,model.TelNo,model.AddressRoom,model.AddressBldg,model.AddressEstate,model.AddressStreet,model.AddressDistrict,model.AddressCountry,model.EducationLevel,model.Position,model.BelongTo,model.HowToKnoweGive,model.HowToKnoweGive_Other,model.AcceptEDM,model.DonationInterest,model.JoinVolunteer,model.VolunteerType,model.VolunteerStartDate,model.VolunteerEndDate,model.VolunteerInterest,model.VolunteerInterest_Other,model.AvailableTime,model.AvailableTime_Other,model.AppToken,model.faceBookID,model.weiboID,lang];
    
    MyLog(@"soapMessage ======= %@",soapMessage);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self removeLoadingAlert];
        //[self completeUserInfo];
        NSString * dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary * dict = [NSString parseJSONStringToNSDictionary:dataString];
        NSUInteger l = [[NSString captureData:dataString] length];
        NSRange range = {1,l-2};
        NSString * str = [NSString stringWithFormat:@"%@",[NSString captureData:dataString]];
        NSString * registerResult = [str substringWithRange:range];
        MyLog(@"-----------------%@",registerResult);
        
        if (dict != nil) {
            if (_selectedIndex == 0){
                if ([_item.BelongTo isEqualToString:@""]){
                    self.BelongTotextField.text = @"";
                }else{
                    self.BelongTotextField.text = _belongDesp[0];
                }
            }else{
                self.BelongTotextField.text = _belongDesp[_selectedIndex];
            }
            registerResult = dict[@"MemberID"];
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.delegate = self;
            alertView.message = EGLocalizedString(@"修改成功!", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            [self GetMemberInfo:_item.MemberID];
            
        }else{
            
            if ([registerResult isEqualToString:@"Error(5005)"]){
                
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message =EGLocalizedString(@"电邮已被注册", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
                
            }else if ([registerResult isEqualToString:@"\"Error(9999)\""]||[registerResult isEqualToString:@"Error(9999)"]){
                UIAlertView *alertView = [[UIAlertView alloc] init];
                alertView.message = EGLocalizedString(@"系统错误", nil);
                [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                [alertView show];
                
            }else{
            
                UIAlertView *alertView = [[UIAlertView alloc] init];
                alertView.message =registerResult;
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
        
        [self removeLoadingAlert];
    }];
    
    [operation start];
    
}
- (void)GetMemberInfo:(NSString *)memberId {
    
    MyLog(@"<<<<<<<<<<<<<<<<<<<%@",memberId);
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetMemberInfo xmlns=\"egive.appservices\"><MemberID>%@</MemberID></GetMemberInfo></soap:Body></soap:Envelope>",memberId];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self completeUserInfo];
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSArray * arr = [NSString parseJSONStringToNSArray:dataString];
        MyLog(@"arr=%@",arr);
        for (NSDictionary * dict in arr) {
            
            MemberModel * model = [[MemberModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
            [standardUserDefaults setObject:dict forKey:@"EGIVE_MEMBER_MODEL"];
            [standardUserDefaults synchronize];
            
            if ([model.ProfilePicURL isEqualToString:@""] || model.ProfilePicURL == nil){
                
                _IconImage.image = [UIImage imageNamed:@"menu_profile_pic_empty@2x.png"];
                
                if ([model.Sex isEqualToString:@"M"] || [model.ChiNameTitle isEqualToString:@"R"]){
                    
                    //_IconImage.image = [UIImage imageNamed:@"donor_detail_male@2x.png"];
                NSString *urlString = [NSString stringWithFormat:@"%@%@",SITE_URL,@"/Images/default_m.jpg"];
                    PICurl = [NSURL URLWithString:urlString];
                    [_IconImage sd_setImageWithURL:PICurl placeholderImage:nil];
                    
                }else{
                    //_IconImage.image = [UIImage imageNamed:@"donor_detail_female@2x.png"];
                NSString *urlString = [NSString stringWithFormat:@"%@%@",SITE_URL,@"/Images/default_f.jpg"];
                    PICurl = [NSURL URLWithString:urlString];
                    [_IconImage sd_setImageWithURL:PICurl placeholderImage:nil];
                    
                }
            }else{
                
                PICurl = [NSURL URLWithString:SITE_URL];
                PICurl = [PICurl URLByAppendingPathComponent:model.ProfilePicURL];
                [_IconImage sd_setImageWithURL:PICurl placeholderImage:_IconImage.image];
            }
            [_shareDict setObject:model forKey:@"LoginName"];
            [ShowMenuView sharedInstance].member = model;
            [self updateIcon];
            
        }
        [self requestMemberFormData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        
    }];
    
    [operation start];
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
