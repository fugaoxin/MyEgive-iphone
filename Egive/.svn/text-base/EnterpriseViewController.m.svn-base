//
//  EnterpriseViewController.m
//  Egive
//
//  Created by sino on 15/7/31.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "Constants.h"
#import "EnterpriseViewController.h"
#import "UIView+ZJQuickControl.h"
#import "HomeViewController.h"
#import "ShowMenuView.h"
#import "EGDropDownMenu.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "EGUtility.h"
#import "UpdatePwsViewController.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface EnterpriseViewController ()<UITextFieldDelegate,UITextViewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIPickerViewDelegate>{
    UIImageView * _iconImage;
     NSInteger selectedDistrict;
    UITextField * _editing;
    NSString * _base64Avatar;
    
    UIView * _volunteerView; //成为义工选项View
    UITextField * _dateStart;
    UITextField * _dateEnd;
    UIButton * _helpTypeButton;
    UILabel * label5;
    UILabel * labelAddressCountry;
    NSURL *PicUrl;
    UIButton * updatePwsButton;
    UILabel * loginNumber;
}
@property (strong, nonatomic) TPKeyboardAvoidingScrollView * scroll;
@property (strong, nonatomic) MemberModel * item;
@property (copy, nonatomic) NSMutableDictionary * shareDict;
@property (strong, nonatomic) UITextField * numbeField;
@property (strong, nonatomic) UIButton * updateButton;
@property (strong, nonatomic) UIButton * outButton;
@property (strong, nonatomic) UIButton * completeButton;
@property (strong, nonatomic) UIView * view1;
@property (strong, nonatomic) UIView * view2;
@property (strong, nonatomic) UIView * view3;   //电邮 && 义工 UI
@property (strong, nonatomic) UIView * view4;   //成为义工View
@property (strong, nonatomic) UITextField * addressBldg;
@property (strong, nonatomic) UITextField * addressEstate;
@property (strong, nonatomic) UITextField * addressStreet;
@property (strong, nonatomic) UITextField * addressDistrict;
@property (strong, nonatomic) UITextField * hkOrOtherPleaseState;
@property (strong, nonatomic) UITextField * RegionTextField;
@property (strong, nonatomic) EGDropDownMenu * downMenu;
@property (strong, nonatomic) UIButton * selRegionButton;
@property (strong, nonatomic) UITextField * instructions;
@property (strong, nonatomic) UIPickerView *pickerViewPopup;
@property (strong, nonatomic) NSMutableArray * arr; //从何处了解意赠
@property (strong, nonatomic) NSMutableArray * arr1; //电邮资讯
@property (copy, nonatomic) NSString * HowToKnoweGive_Other;
@property (strong, nonatomic) UIButton * regionButton;
@property (nonatomic) BOOL isEdit;

@property (strong, nonatomic) UIButton * isEmailButton;
@property (strong, nonatomic) UIButton * noEmailButton;
@property (strong, nonatomic) UIView * emailView;
@property (strong, nonatomic) UIButton * typeButton;
@property (strong, nonatomic) UIButton * yButton; //愿意
@property (strong, nonatomic) UIButton * nButton; //暂不考虑
@property (strong, nonatomic) UIButton * shortVolunteer;
@property (strong, nonatomic) UIButton * longVolunteer;
@property (copy, nonatomic) NSMutableArray * volunteerInterestArr;
@property (copy, nonatomic) NSMutableArray * availableTimeArr;
@property (strong, nonatomic) UITextField * noteText;
@property (strong, nonatomic) UITextField * noteTimeText;
@property (strong, nonatomic) UIButton * timesButton;
@property(retain,nonatomic)UILabel *totalPhoneNumber;
@end

@implementation EnterpriseViewController

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _scroll = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height-100)];
    _scroll.userInteractionEnabled = YES;
    [self.view addSubview:_scroll];
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.contentSize = CGSizeMake(0, 870+80+100);
    self.title = EGLocalizedString(@"会员专区", nil);
    self.view.backgroundColor = [UIColor whiteColor];
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

    _isEdit = NO;

      _volunteerInterestArr = [[NSMutableArray alloc] init]; //有关协助之项目数组
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults objectForKey:@"EGIVE_MEMBER_MODEL"]) {
        NSMutableDictionary *m = [[standardUserDefaults objectForKey:@"EGIVE_MEMBER_MODEL"] mutableCopy];
        
        MemberModel * model = [[MemberModel alloc] init];
        [model setValuesForKeysWithDictionary:m];
        [ShowMenuView sharedInstance].member = model;
        
        MyLog(@"%@",m);
        _shareDict = m;
   
        _item = model;
        MyLog(@"%@",_item.ProfilePicURL);
        MyLog(@"%@",_item.VolunteerInterest);
    }
//    _shareDict = [ShowMenuView getUserInfo];
//    _item = _shareDict[@"LoginName"];
    
    [self createUI];
    [self createFooterButton];
    [self createMenuUI];
    
    _pickerViewPopup = [[UIPickerView alloc] initWithFrame:CGRectMake(0, ScreenSize.height - 200 + ((IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) ? 20 : 0), ScreenSize.width , 200)];
    _pickerViewPopup.delegate = self;
    _pickerViewPopup.showsSelectionIndicator = YES;
    _pickerViewPopup.hidden = YES;
    _pickerViewPopup.backgroundColor = [UIColor whiteColor];
    [_pickerViewPopup selectRow:selectedDistrict inComponent:0 animated:YES];
    [self.view addSubview:_pickerViewPopup];
}

- (void)rightAction{
    MyDonationViewController *vc = [[MyDonationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}
- (void)createUI{

    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(dismissKeyboard)];
    [_scroll addGestureRecognizer:tap0];
    UIView * imageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 130)];
    imageView.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1];
    [_scroll addSubview:imageView];
    
    _iconImage = [imageView addImageViewWithFrame:CGRectMake(20, 20, 90, 90) image:nil];
    _iconImage.layer.cornerRadius = 45;
    _iconImage.layer.masksToBounds = YES;

    UITapGestureRecognizer * imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageTapAction)];
    [_iconImage addGestureRecognizer:imageTap];
    
//    //判断Documents 中是否存在该图片
//    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@", [self documentFolderPath],@"test1.jpg"]]) {
//        
////        [_iconImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [self documentFolderPath],@"test.jpg"]]];
//        
//        _base64Avatar = [UIImagePNGRepresentation([self imageWithImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [self documentFolderPath],@"test1.jpg"]] convertToSize:CGSizeMake(128, 128)]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//        
//    }
    
    if ([_item.ProfilePicURL isEqualToString:@""] || _item.ProfilePicURL == nil){
        
        NSString *urlString = [NSString stringWithFormat:@"%@%@",SITE_URL,@"/Images/default_c.png"];
        PicUrl = [NSURL URLWithString:urlString];
        [_iconImage sd_setImageWithURL:PicUrl placeholderImage:nil];
        
    }else{
        PicUrl = [NSURL URLWithString:SITE_URL];
        PicUrl = [PicUrl URLByAppendingPathComponent:_item.ProfilePicURL];
        [_iconImage sd_setImageWithURL:PicUrl placeholderImage:nil];
    }
    
    UILabel * donations = [imageView addLabelWithFrame:CGRectMake(ScreenSize.width/2-40, 20, 150, 25) text:EGLocalizedString(@"企业累积捐款", nil)];
    donations.font = [UIFont systemFontOfSize:13];
    donations.textColor = [UIColor grayColor];
    
    _money = [imageView addLabelWithFrame:CGRectMake(ScreenSize.width/2-40, 45, 150, 25) text:_memberTotalDonationAmount];
    _money.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    _money.font = [UIFont boldSystemFontOfSize:16];
    
    
    float width = (ScreenSize.width/2+40)/2-5;
    UIButton * rankingButton = [imageView addImageButtonWithFrame:CGRectMake(ScreenSize.width/2-50, 85, width+20, 30) title:EGLocalizedString(@"查看排名", nil)  backgroud:nil action:^(UIButton *button) {
        
        RankListViewController * vc = [[RankListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [rankingButton setImage:[UIImage imageNamed:@"account_ranking@2x.png"] forState:UIControlStateNormal];
    [rankingButton setTitleColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1] forState:UIControlStateNormal];
    rankingButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    UIButton * recordButton = [imageView addImageButtonWithFrame:CGRectMake(ScreenSize.width/2-30+width, 85, width, 30) title:EGLocalizedString(@"捐款记录", nil)  backgroud:nil action:^(UIButton *button) {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        [standardUserDefaults setObject:@"1" forKey:@"EGIVE_AFTER_DONATE"];
        [standardUserDefaults synchronize];
        MyDonationViewController * vc = [[MyDonationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    recordButton.titleLabel.numberOfLines = 2;
    [recordButton setImage:[UIImage imageNamed:@"account_history@2x.png"] forState:UIControlStateNormal];
    [recordButton setTitleColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1] forState:UIControlStateNormal];
    recordButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    
    //获取用户信息
// NSMutableDictionary * dict = [ShowMenuView getUserInfo];
//  MemberModel * item = dict[@"LoginName"];
    
    UILabel * loginName = [_scroll addLabelWithFrame:CGRectMake(20, 150, 120, 25) text:EGLocalizedString(@"Register_userNameTextfile", nil)];
    loginName.font = [UIFont systemFontOfSize:13];
    loginName.textColor = [UIColor grayColor];
    
    UILabel * loginPws = [_scroll addLabelWithFrame:CGRectMake(ScreenSize.width/2-30, 150, 120, 25) text:EGLocalizedString(@"Register_mpwsTextfile", nil)];
    loginPws.font = [UIFont systemFontOfSize:13];
    loginPws.textColor = [UIColor grayColor];
    
    _loginName = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 120, 25)];
    _loginName.text = _item.LoginName;
    _loginName.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_loginName];
    
    
    _pws = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2-30, 172, 120, 25)];
    _pws.text = @"******";
    _pws.delegate= self;
    _pws.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_pws];
    
    
    __weak typeof(self) weakSelf = self;
   updatePwsButton = [_scroll addSystemButtonWithFrame:CGRectMake(ScreenSize.width-140, 170, 130, 20) title:EGLocalizedString(@"修改密码", nil) action:^(UIButton *button) {
        
        
        UpdatePwsViewController * vc = [[UpdatePwsViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    }];
    [updatePwsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [updatePwsButton setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (([standardUserDefaults objectForKey:@"FACEBOOK_REG_REQ"] != nil && [[standardUserDefaults objectForKey:@"FACEBOOK_REG_REQ"] isEqualToString:@"1"]) || ([standardUserDefaults objectForKey:@"WEIBO_REG_REQ"] != nil && [[standardUserDefaults objectForKey:@"WEIBO_REG_REQ"] isEqualToString:@"1"]) ){
        
        updatePwsButton.hidden=YES;
    
    }else{
        updatePwsButton.hidden=NO;
        updatePwsButton.enabled=NO;
    }
    UILabel * orgChName = [_scroll addLabelWithFrame:CGRectMake(20, 200,300, 25) text:EGLocalizedString(@"Register_org_orgNameCh_textFile", nil)];
    orgChName.font = [UIFont systemFontOfSize:13];
    orgChName.textColor = [UIColor grayColor];
    
    _orgChName = [[UITextField alloc] initWithFrame:CGRectMake(20, 225, ScreenSize.width-40, 25)];
    _orgChName.text = _item.CorporationChiName;
    _orgChName.delegate = self;
    _orgChName.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_orgChName];
    
    UILabel * orgEnName = [_scroll addLabelWithFrame:CGRectMake(20, 245, 300, 25) text:EGLocalizedString(@"Register_org_orgNameEn_textFile", nil)];
    orgEnName.font = [UIFont systemFontOfSize:13];
    orgEnName.textColor = [UIColor grayColor];
    
    _orgEnName = [[UITextField alloc] initWithFrame:CGRectMake(20, 270, ScreenSize.width-40, 25)];
    _orgEnName.text =  _item.CorporationEngName;
     _orgEnName.borderStyle = UITextBorderStyleNone;
    //_orgEnName.delegate= self;
    //_orgEnName.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    //_orgEnName.layer.borderWidth = 0.0;
   // _orgEnName.layer.cornerRadius = 5.0f;
    //[_orgEnName.layer setMasksToBounds:YES];
    _orgEnName.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_orgEnName];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:EGLocalizedString(@"税局档号", nil) forKey:@"T"];
    [dict setObject:EGLocalizedString(@"香港社团注册证明书编号", nil) forKey:@"C"];
    [dict setObject:EGLocalizedString(@"不适用", nil) forKey:@" "];
    [dict setObject:EGLocalizedString(@"商业登记编号", nil) forKey:@"B"];
    
    loginNumber = [_scroll addLabelWithFrame:CGRectMake(20, 295,300, 25) text:[dict objectForKey:  _item.BusinessRegistrationType ]];
    loginNumber.font = [UIFont systemFontOfSize:13];
    loginNumber.textColor = [UIColor grayColor];
    
    _numbeField = [[UITextField alloc] initWithFrame:CGRectMake(20, 320, ScreenSize.width-40, 25)];
    _numbeField.text = _item.BusinessRegistrationNo;
    _numbeField.delegate = self;
    _numbeField.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_numbeField];

    UILabel * chName = [_scroll addLabelWithFrame:CGRectMake(20, 345, 200, 25) text:EGLocalizedString(@"联络人姓名(中)", nil)];
    chName.font = [UIFont systemFontOfSize:13];
    chName.textColor = [UIColor grayColor];
    
    UILabel * enName = [_scroll addLabelWithFrame:CGRectMake(ScreenSize.width/2, 345,200, 25) text:EGLocalizedString(@"联络人姓名(英)", nil)];
    enName.font = [UIFont systemFontOfSize:13];
    enName.textColor = [UIColor grayColor];
    
    _chName = [[UITextField alloc] initWithFrame:CGRectMake(20, 365, 120, 25)];
    _chName.delegate = self;
    MyLog(@"ming == %@ xing == %@",_item.ChiFirstName,_item.ChiFirstName);
//    _chName.text =[NSString stringWithFormat:@"%@%@",[item.ChiLastName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[item.ChiFirstName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    _chName.text = [NSString stringWithFormat:@"%@%@",_item.ChiLastName ,_item.ChiFirstName];
    _chName.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_chName];
    _chLastName = [[UITextField alloc] initWithFrame:CGRectMake(20, 365, (ScreenSize.width/2-20)/2-10, 25)];
    _chLastName.delegate = self;
    _chLastName.borderStyle = UITextBorderStyleRoundedRect;
    _chLastName.hidden = YES;
    //_chLastName.placeholder = @"姓";
    if ([_item.ChiLastName isEqualToString:@"(null)"]) {
        _chLastName.text = @"";
    }else{
        _chLastName.text = _item.ChiLastName;
    }
    _chLastName.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_chLastName];
    _chfirstName = [[UITextField alloc] initWithFrame:CGRectMake((ScreenSize.width/2-20)/2+10, 365, (ScreenSize.width/2-20)/2+5, 25)];
    _chfirstName.delegate = self;
    _chfirstName.borderStyle = UITextBorderStyleRoundedRect;
    _chfirstName.hidden = YES;
    //_chfirstName.placeholder = @"名";
    if ([_item.ChiFirstName isEqualToString:@"(null)"]) {
        _chfirstName.text = @"";
    }else{
        _chfirstName.text = _item.ChiFirstName;
    }
    _chfirstName.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_chfirstName];
    
    
    _enName = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2, 365, 120, 25)];
    _enName.text = [NSString stringWithFormat:@"%@ %@",_item.EngFirstName,_item.EngLastName];
    _enName.font = [UIFont systemFontOfSize:13];
    _enName.delegate = self;
    [_scroll addSubview:_enName];

    _enLastName = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2, 365, (ScreenSize.width/2-20)/2-10, 25)];
    _enLastName.font = [UIFont systemFontOfSize:13];
    //_enLastName.placeholder = @"姓(英)";
    _enLastName.delegate = self;
    if ([_item.EngLastName isEqualToString:@"(null)"]){
        _enLastName.text = @"";
    }else{
        _enLastName.text = _item.EngLastName;
    }
    _enLastName.borderStyle = UITextBorderStyleRoundedRect;
    _enLastName.hidden = YES;
    [_scroll addSubview:_enLastName];
    
    
    _enfirstName = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2+(ScreenSize.width/2-20)/2-10, 365, (ScreenSize.width/2-20)/2+10, 25)];
    _enfirstName.font = [UIFont systemFontOfSize:13];
   //_enfirstName.placeholder = @"名(英)";
    if ([_item.EngFirstName isEqualToString:@"(null)"]) {
        _enfirstName.text = @"";
    }else{
        _enfirstName.text = _item.EngFirstName;
    }
    _enfirstName.delegate = self;
    _enfirstName.borderStyle = UITextBorderStyleRoundedRect;
    _enfirstName.hidden = YES;
    [_scroll addSubview:_enfirstName];
    //职位
    UILabel * Position = [_scroll addLabelWithFrame:CGRectMake(20, 385, 300, 25) text:EGLocalizedString(@"職位", nil)];
    Position.font = [UIFont systemFontOfSize:13];
    Position.textColor = [UIColor grayColor];
    
    _positionTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 410, ScreenSize.width-40, 25)];
    _positionTextField.text = _item.Position;
    _positionTextField.delegate = self;
    _positionTextField.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_positionTextField];
    //电邮地址
    UILabel * email = [_scroll addLabelWithFrame:CGRectMake(20, 430, 300, 25) text:EGLocalizedString(@"Register_email", nil)];
    email.font = [UIFont systemFontOfSize:13];
    email.textColor = [UIColor grayColor];
    
    _email = [[UITextField alloc] initWithFrame:CGRectMake(20, 450, ScreenSize.width-40, 25)];
    _email.text = _item.Email;
    _email.delegate = self;
    _email.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_email];

    UILabel * phone = [_scroll addLabelWithFrame:CGRectMake(20, 475, 300, 25) text:EGLocalizedString(@"Register_org_number", nil)];
    phone.font = [UIFont systemFontOfSize:13];
    phone.textColor = [UIColor grayColor];
    _CountyCodephoneNum = [[UITextField alloc] initWithFrame:CGRectMake(20, 495, 80, 25)];
    _CountyCodephoneNum.text = [NSString stringWithFormat:@"%@",_item.TelCountryCode];
    _CountyCodephoneNum.font = [UIFont systemFontOfSize:13];
    _CountyCodephoneNum.delegate= self;
    _CountyCodephoneNum.hidden=YES;
    _CountyCodephoneNum.keyboardType=UIKeyboardTypeNumberPad;
    [_scroll addSubview:_CountyCodephoneNum];

    _phoneNum = [[UITextField alloc] initWithFrame:CGRectMake(120, 495, ScreenSize.width-140, 25)];
    _phoneNum.text = [NSString stringWithFormat:@"%@",_item.TelNo];
    _phoneNum.font = [UIFont systemFontOfSize:13];
    _phoneNum.hidden=YES;
    _phoneNum.delegate= self;
     _phoneNum.keyboardType = UIKeyboardTypeNumberPad;

    [_scroll addSubview:_phoneNum];
    
    if (![_item.TelCountryCode isEqualToString:@""] && ![_item.TelNo isEqualToString:@""]){
    _totalPhoneNumber=[[UILabel alloc] initWithFrame:CGRectMake(20, 495, ScreenSize.width-40, 25)];
    _totalPhoneNumber.text = [NSString stringWithFormat:@"(%@)%@",_item.TelCountryCode,_item.TelNo];
    _totalPhoneNumber.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_totalPhoneNumber];
    }
    
    
    UILabel * addressLabel = [_scroll addLabelWithFrame:CGRectMake(20, 520, 300, 25) text:EGLocalizedString(@"Register_org_address", nil)];
    addressLabel.font = [UIFont systemFontOfSize:13];
    addressLabel.textColor = [UIColor grayColor];
    
    _address = [[UILabel alloc] initWithFrame:CGRectMake(20, 540, ScreenSize.width-40, 1)];
    MyLog(@"item.AddressBldg = %@", _item.AddressBldg);
    _address.font = [UIFont systemFontOfSize:13];
    if (![_item.AddressBldg isEqualToString:@"(null)"] && ![_item.AddressDistrict isEqualToString:@"(null)"]&&![_item.AddressStreet isEqualToString:@"(null)"]&&![_item.AddressRoom isEqualToString:@"(null)"]&&![_item.AddressEstate isEqualToString:@"(null)"]){
        
          _address.text = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",_item.AddressDistrict,@" ",_item.AddressStreet,@" ",_item.AddressEstate,@" ",_item.AddressBldg,@" ",_item.AddressRoom];
        
    }
    _address.numberOfLines=0;
     CGSize requiredSize = [[_address.text stringByReplacingOccurrencesOfString:@" " withString:@""]sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(ScreenSize.width-40, 10000) lineBreakMode:NSLineBreakByWordWrapping];
     _address.frame = CGRectMake(20, 540, ScreenSize.width-40, requiredSize.height);
   // _address.backgroundColor = [UIColor redColor];
    [_scroll addSubview:_address];
    
    
    
    if ([_item.AddressBldg isEqualToString:@"(null)"]){
        _item.AddressBldg = @"";
    }
    if ([_item.AddressDistrict isEqualToString:@"(null)"]){
        _item.AddressDistrict = @"";
    }
    if ([_item.AddressStreet isEqualToString:@"(null)"]){
        _item.AddressStreet = @"";
    }
    if ([_item.AddressRoom isEqualToString:@"(null)"]){
        _item.AddressRoom = @"";
    }
    if ([_item.AddressEstate isEqualToString:@"(null)"]){
        _item.AddressEstate = @"";
    }
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 545, ScreenSize.width, 120)];
    _view1.hidden = YES;
    //_view1.backgroundColor=[UIColor redColor];
    [_scroll addSubview:_view1];
    
    _addressDistrict = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, 85, 25)];
    _addressDistrict.delegate = self;
    _addressDistrict.placeholder = EGLocalizedString(@"Register_org_region1", nil);
    _addressDistrict.text = [NSString stringWithFormat:@"%@",_item.AddressRoom];
    _addressDistrict.font = [UIFont systemFontOfSize:13];
    _addressDistrict.borderStyle = UITextBorderStyleRoundedRect;
    [_view1 addSubview:_addressDistrict];
    
    _addressBldg = [[UITextField alloc] initWithFrame:CGRectMake(120, 5, ScreenSize.width-140, 25)];
    _addressBldg.text = [NSString stringWithFormat:@"%@",_item.AddressBldg];
    _addressBldg.font = [UIFont systemFontOfSize:13];
    _addressBldg.delegate= self;
    _addressBldg.placeholder = EGLocalizedString(@"Register_org_region2", nil);
    _addressBldg.borderStyle = UITextBorderStyleRoundedRect;
    [_view1 addSubview:_addressBldg];
    
    _addressEstate = [[UITextField alloc] initWithFrame:CGRectMake(20, 35, ScreenSize.width-40, 25)];
    _addressEstate.text = [NSString stringWithFormat:@"%@",_item.AddressEstate];
    _addressEstate.font = [UIFont systemFontOfSize:13];
    _addressEstate.delegate= self;
    _addressEstate.placeholder = EGLocalizedString(@"Register_org_region3", nil);
    _addressEstate.borderStyle = UITextBorderStyleRoundedRect;
    [_view1 addSubview:_addressEstate];
    
    _addressStreet = [[UITextField alloc] initWithFrame:CGRectMake(20, 65, ScreenSize.width-40, 25)];
    _addressStreet.text = [NSString stringWithFormat:@"%@",_item.AddressStreet];
    _addressStreet.font = [UIFont systemFontOfSize:13];
    _addressStreet.delegate= self;
    _addressStreet.placeholder = EGLocalizedString(@"Register_org_region4", nil);
    _addressStreet.borderStyle = UITextBorderStyleRoundedRect;
    [_view1 addSubview:_addressStreet];
    
    UITextField * textfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 95, 80, 25)];
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    textfield.enabled=NO;
    textfield.font = [UIFont systemFontOfSize:13];
    textfield.placeholder=EGLocalizedString(@"Register_org_selRegion", nil);
    [_view1 addSubview:textfield];
    
    _RegionTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, 95, ScreenSize.width-140, 25)];
    _RegionTextField.text = [NSString stringWithFormat:@"%@",_item.AddressDistrict];
    _RegionTextField.font = [UIFont systemFontOfSize:13];
    _RegionTextField.borderStyle = UITextBorderStyleRoundedRect;
    _RegionTextField.delegate= self;
    [_view1 addSubview:_RegionTextField];
    
//    _regionButton = [_view1 addImageButtonWithFrame:CGRectMake(20, 95, 80, 25) title:nil backgroud:@"" action:^(UIButton *button) {
//        //_pickerViewPopup.hidden = NO;
//    }];
//    _regionButton.titleLabel.font = [UIFont systemFontOfSize:12];
//    _regionButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
//    if ([_item.AddressDistrict isEqualToString:@""]) {
//        [_regionButton setTitle:EGLocalizedString(@"Register_org_selRegion", nil) forState:UIControlStateNormal];
//    }else{
//        [_regionButton setTitle:_item.AddressDistrict forState:UIControlStateNormal];
//    }
    
    //何处认识意赠view
    _view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 545+_address.frame.size.height, ScreenSize.width, 300)];
    [_scroll addSubview:_view2];
    //_view2.backgroundColor = [UIColor blackColor];
    [_view2 addImageViewWithFrame:CGRectMake(10, 0, ScreenSize.width-20, 2) image:@"Line@2x.png"];
    _view2.userInteractionEnabled=NO;
     label5 = [_view2 addLabelWithFrame:CGRectMake(20, 40, ScreenSize.width-40, 60) text:EGLocalizedString(@"Register_org_noteLabel2_title", nil)];
    label5.textColor = [UIColor grayColor];
    label5.numberOfLines = 0;
    label5.font = [UIFont systemFontOfSize:13];
    
    labelAddressCountry = [_view2 addLabelWithFrame:CGRectMake(20, 40, ScreenSize.width-160, 60) text:EGLocalizedString(@"Register_org_noteLabel2_title", nil)];
    labelAddressCountry.textColor = [UIColor grayColor];
    labelAddressCountry.numberOfLines = 0;
    labelAddressCountry.font = [UIFont systemFontOfSize:13];
    
    _hkOrOtherPleaseState = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width-140, 40, 120, 50)];
    _hkOrOtherPleaseState.font = [UIFont systemFontOfSize:13];
    _hkOrOtherPleaseState.delegate= self;
    _hkOrOtherPleaseState.placeholder = EGLocalizedString(@"请说明", nil);
    _hkOrOtherPleaseState.text = _item.AddressCountry;
    _hkOrOtherPleaseState.borderStyle = UITextBorderStyleRoundedRect;
    [_view2 addSubview:_hkOrOtherPleaseState];
       NSArray * region = @[EGLocalizedString(@"Register_org_regionButton", nil),EGLocalizedString(@"Register_org_otherButton", nil)];
    NSArray * regNorBg = @[@"comment_segment_left_nor.png",@"comment_segment_right_nor.png"];
    NSArray * regSelBg = @[@"comment_segment_left_sel.png",@"comment_segment_right_sel.png",];
    int width2 = (ScreenSize.width-40)/2;
    for (int i = 0; i < 2; i ++) {
        _selRegionButton = [_view2 addImageButtonWithFrame:CGRectMake(i*width2+20, 10, width2, 25) title:region[i] backgroud:regNorBg[i] action:^(UIButton *button) {
            
            for (int i = 0; i < 2; i ++) {
                UIButton * button = (UIButton *)[weakSelf.view viewWithTag:45+i];
                button.selected = NO;
            }
            if (button.tag == 45) {
                button.selected = YES;
               weakSelf.hkOrOtherPleaseState.hidden=YES;
                weakSelf.hkOrOtherPleaseState.text=@"";
                labelAddressCountry.hidden=YES;
                label5.hidden=NO;
            }else{
                button.selected = YES;
                label5.hidden=YES;
                weakSelf.hkOrOtherPleaseState.hidden=NO;
                labelAddressCountry.hidden=NO;
            }
        }];
        
        _selRegionButton.tag = 45 +i;
        _selRegionButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_selRegionButton setBackgroundImage:[UIImage imageNamed:regSelBg[i]] forState:UIControlStateSelected];
        [_selRegionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_selRegionButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
        
        if (i == 0) {
            _selRegionButton.selected = YES;
        }
        
    }
    
    if ([_item.AddressCountry isEqualToString:@"香港"]) {
        UIButton *hkbtn = (UIButton*)[_view2 viewWithTag:45];
        UIButton *otherbtn = (UIButton*)[_view2 viewWithTag:46];
        hkbtn.selected=YES;
        otherbtn.selected=NO;
        label5.hidden=NO;
        labelAddressCountry.hidden=YES;
        _hkOrOtherPleaseState.hidden=YES;
        _hkOrOtherPleaseState.text=@"";
        
    }else{
        UIButton *hkbtn = (UIButton*)[_view2 viewWithTag:45];
        UIButton *otherbtn = (UIButton*)[_view2 viewWithTag:46];
        hkbtn.selected=NO;
        otherbtn.selected=YES;
        label5.hidden=YES;
        labelAddressCountry.hidden=NO;
        _hkOrOtherPleaseState.hidden=NO;
        
    }

    UILabel * noteLabel = [_view2 addLabelWithFrame:CGRectMake(20, 105, ScreenSize.width-40, 25) text:EGLocalizedString(@"你從何處認識「意贈慈善基金」(可選擇多項)", nil)];
    noteLabel.font = [UIFont systemFontOfSize:13];
    noteLabel.textColor = [UIColor grayColor];

    _arr = [[NSMutableArray alloc] init];
    NSArray * timeTitleArray = @[EGLocalizedString(@"「意贈」網頁", nil),EGLocalizedString(@"「意贈」活動/刊物", nil),EGLocalizedString(@"朋友", nil),EGLocalizedString(@"報章", nil),EGLocalizedString(@"社交媒體(Facebook、新浪微博等)", nil),EGLocalizedString(@"為「意贈」的捐款者", nil),EGLocalizedString(@"其他", nil)];
    NSArray * titleArr = @[@"Web",@"Event",@"Friend",@"News",@"Social",@"Donor",@"other"];
    for (int i = 0; i < 7; i ++) {
        UIButton * opButton = [_view2 addImageButtonWithFrame:CGRectMake(i%2*(ScreenSize.width/2)+20, i/2*45+130, 20, 20) title:nil backgroud:@"cart_checkbox_nor.png" action:^(UIButton *button) {
            if (_isEdit) {
            if (button.tag == 130) {
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.arr removeObject:@"Web,"];
                    MyLog(@"%@",weakSelf.arr);
                }else{
                    button.selected = YES;
                    [weakSelf.arr addObject:@"Web,"];
                }
                
            }else if (button.tag == 131){
                if (button.selected) {
                    button.selected = NO;
                [weakSelf.arr removeObject:@"Event,"];
                       MyLog(@"%@",weakSelf.arr);
                }else{
                    button.selected = YES;
                  [weakSelf.arr addObject:@"Event,"];
                    
                }
                
            }else if (button.tag == 132){
                if (button.selected) {
                    button.selected = NO;
                 [weakSelf.arr removeObject:@"Friend,"];
                       MyLog(@"%@",weakSelf.arr);
                }else{
                    button.selected = YES;
                    [weakSelf.arr addObject:@"Friend,"];
                }
                
                
            }else if (button.tag == 133){
                if (button.selected) {
                    button.selected = NO;
                [weakSelf.arr removeObject:@"News,"];
                }else{
                    button.selected = YES;
                    [weakSelf.arr addObject:@"News,"];
                }
                
                
            }else if (button.tag == 134){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.arr removeObject:@"Social,"];
                }else{
                    button.selected = YES;
                   [weakSelf.arr addObject:@"Social,"];
                }
                
                
            }else if (button.tag == 135){
                if (button.selected) {
                    button.selected = NO;
                    [weakSelf.arr removeObject:@"Donor,"];
                }else{
                    button.selected = YES;
                    [weakSelf.arr addObject:@"Donor,"];
                }    
            }else{
                if (button.selected) {
                    button.selected = NO;
                    
                }else
                    button.selected = YES;
            }
        }
        }];
        opButton.tag = 130+i;
        [opButton setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
        
        UILabel * label = [_view2 addLabelWithFrame:CGRectMake(i%2*(ScreenSize.width/2)+45, i/2*45+123, ScreenSize.width/2-40, 35) text:timeTitleArray[i]];
        label.numberOfLines = 2;
        label.font = [UIFont systemFontOfSize:12];
        if([_item.HowToKnoweGive rangeOfString:titleArr[i]].location !=NSNotFound)
        {
            opButton.selected = YES;
        }
        if (i==6 && ![_item.HowToKnoweGive_Other isEqualToString:@""]) {
            opButton.selected = YES;
        }
    }
    _instructions = [[UITextField alloc] initWithFrame:CGRectMake(100, 265, ScreenSize.width-120, 25)];
    _instructions.font = [UIFont systemFontOfSize:13];
    _instructions.delegate= self;
    _instructions.placeholder = EGLocalizedString(@"请说明", nil);
    _instructions.borderStyle = UITextBorderStyleRoundedRect;
    [_view2 addSubview:_instructions];

    if (_item.VolunteerInterest_Other != NULL){
        _instructions.text = _item.HowToKnoweGive_Other;
    }
    _view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 840+_address.frame.size.height, ScreenSize.width, 120)];
   // _view3.backgroundColor = [UIColor greenColor];
    [_scroll addSubview:_view3];
    
    UILabel * label6 = [_view3 addLabelWithFrame:CGRectMake(20, 0, ScreenSize.width/2+10, 40) text:EGLocalizedString(@"Register_IsEmailNote", nil)];
    label6.numberOfLines = 2;
    label6.font = [UIFont systemFontOfSize:12];
    //是否允许收到电邮资讯按钮 － 是
    int width3 = (ScreenSize.width/2-70)/2;
    _isEmailButton =[_view3 addImageButtonWithFrame:CGRectMake(ScreenSize.width/2+50, 5, width3, 25) title:EGLocalizedString(@"Register_isEmailButton_title", nil) backgroud:@"comment_segment_middle_nor.png" action:^(UIButton *button) {
        if (weakSelf.isEdit) {
            weakSelf.noEmailButton.selected = NO;
            button.selected = YES;
            weakSelf.emailView.hidden = NO;
            
            weakSelf.view4.frame = CGRectMake(20, 50+200, ScreenSize.width-40, 880);//义工view位置下移
            //是否也成为义工
            if (weakSelf.yButton.selected) {
                _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 120+200);
                weakSelf.scroll.contentSize = CGSizeMake(0, 870+140+80+200); //如果接收电邮，改变scroll高度
            }else{
                _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 120+200);
                weakSelf.scroll.contentSize = CGSizeMake(0, 870+140+80+200); //如果不接收电邮，改变scroll高度
            }
        }
        
    }];
    _isEmailButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_isEmailButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_middle_sel.png"] forState:UIControlStateSelected];
    [_isEmailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_isEmailButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    
    //是否允许收到电邮资讯按钮 － 否
    _noEmailButton = [_view3 addImageButtonWithFrame:CGRectMake(ScreenSize.width/2+50+width3, 5, width3, 25) title:EGLocalizedString(@"Register_noEmailButton_title", nil) backgroud:@"comment_segment_middle_nor.png" action:^(UIButton *button) {
        if (weakSelf.isEdit) {
            weakSelf.isEmailButton.selected = NO;
            button.selected = YES;
            weakSelf.emailView.hidden = YES;
            
            if (weakSelf.yButton.selected) {
                _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 120);
                weakSelf.scroll.contentSize = CGSizeMake(0, 870+140+80); //如果不接收电邮，但选择成为义工，改变scroll高度
            }else{
                _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 120);
                weakSelf.scroll.contentSize = CGSizeMake(0, 870+140+80); //如果不接收电邮，改变scroll高度
            }
            weakSelf.view4.frame = CGRectMake(20, 50, ScreenSize.width-40, 880);//还原义工view位置
        }
        
    }];
    _noEmailButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_noEmailButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_middle_sel.png"] forState:UIControlStateSelected];
    [_noEmailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_noEmailButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];

    [self createEmailView];
    
     NSArray * DonationInterestArr = @[@"S",@"E",@"M",@"P",@"U",@"O",@"A",@"L"];
    //判断是否包含全部，如果包含全部则全部选中
    if ([_item.DonationInterest rangeOfString:@"L"].location !=NSNotFound){
        //[weakSelf.arr1 removeAllObjects];
        for (int i = 0; i < 8; i ++){
            UIButton * button = (UIButton *)[weakSelf.view viewWithTag:110+i];
            button.selected = YES;
            NSString *str = [NSString stringWithFormat:@"%@,",DonationInterestArr[i]];
            [weakSelf.arr1 addObject:str];
        }
        
        MyLog(@"%@",weakSelf.arr1);
        
    }else{
        //[weakSelf.arr1 removeAllObjects];
        for (int i = 0; i < 8; i ++){
            if([_item.DonationInterest rangeOfString:DonationInterestArr[i]].location !=NSNotFound)
            {
                UIButton * button = (UIButton *)[weakSelf.view viewWithTag:110+i];
                button.selected = YES;
                NSString *str = [NSString stringWithFormat:@"%@,",DonationInterestArr[i]];
                [weakSelf.arr1 addObject:str];
            }
        }
    }
    _view4 = [[UIView alloc] initWithFrame:CGRectMake(20, 50, ScreenSize.width-40, 880)];
    [_view3 addSubview:_view4];

    UILabel * note = [_view4 addLabelWithFrame:CGRectMake(0, 0, ScreenSize.width-20, 35) text:EGLocalizedString(@"Register_noteLabel3_title", nil)];
    note.numberOfLines = 2;
    note.font = [UIFont systemFontOfSize:14];
    
    // “愿意”按钮
    _yButton = [_view4 addImageButtonWithFrame:CGRectMake(0, 45, ScreenSize.width/2-20, 25) title:EGLocalizedString(@"Register_yButton_title", nil) backgroud:@"comment_segment_left_nor.png" action:^(UIButton *button) {
        if (weakSelf.isEdit) {
            _nButton.selected = NO;
            button.selected = YES;
            _volunteerView.hidden = YES; //显示义工view
            if (weakSelf.isEmailButton.selected) {
                _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 120+200);
                _scroll.contentSize = CGSizeMake(0, 870+140+80+200); //增加scroll高度
            }else{
                 _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 120);
                weakSelf.scroll.contentSize = CGSizeMake(0, 870+140+80);  //增加scroll高度
            }
            
        }
        
    } ];
    _yButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _yButton.layer.cornerRadius = 4;
    [_yButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_left_sel.png"] forState:UIControlStateSelected];
    [_yButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_yButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    
    //”暂不考虑“按钮
    _nButton = [_view4 addImageButtonWithFrame:CGRectMake(ScreenSize.width/2-20, 45, ScreenSize.width/2-20, 25) title:EGLocalizedString(@"Register_nButton_title", nil) backgroud:@"comment_segment_right_nor.png" action:^(UIButton *button) {
        
        if (weakSelf.isEdit) {
            
            _yButton.selected = NO;
            button.selected = YES;
            _volunteerView.hidden = YES; //隐藏义工view
            if (weakSelf.isEmailButton.selected) {

                _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 120+200);
                _scroll.contentSize = CGSizeMake(0, 870+140+80+200); //还原scroll高度
            }else{
                
                _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 120);
                weakSelf.scroll.contentSize = CGSizeMake(0, 870+140+80); //还原scroll高度
            }
            
        }
        
    }];
    _nButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _nButton.layer.cornerRadius = 4;
    [_nButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_right_sel.png"] forState:UIControlStateSelected];
    [_nButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_nButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    
    [self createVoView];    //创建义工view
    
    //判断用户之前是否接收电邮
    if (_item.AcceptEDM) {
        _isEmailButton.selected = YES;
        _emailView.hidden = NO;
//        _view2.frame = CGRectMake(0, 560, ScreenSize.width, 200); //义工view位置下调
        
        _view3.frame = CGRectMake(0, 840+_address.frame.size.height, ScreenSize.width, 150+200);
        _view4.frame = CGRectMake(20, 50+200, ScreenSize.width-40, 880);
        _scroll.contentSize = CGSizeMake(0, 920+200+100+_address.frame.size.height);
        if (_item.JoinVolunteer) {
            
            _yButton.selected = YES;
            _volunteerView.hidden = YES; //显示义工view
            _view3.frame = CGRectMake(0, 840+_address.frame.size.height, ScreenSize.width, 150);
            _view4.frame = CGRectMake(20, 50+200, ScreenSize.width-40, 880);
            _scroll.contentSize = CGSizeMake(0, 920+200+100+_address.frame.size.height);

        }else{
            _nButton.selected = YES;
        }

    }else{
        _noEmailButton.selected = YES;
        if (_item.JoinVolunteer){
            _yButton.selected = YES;
            _volunteerView.hidden = YES; //显示义工view
            _view3.frame = CGRectMake(0, 840+_address.frame.size.height, ScreenSize.width, 150);
            _view4.frame = CGRectMake(20, 50, ScreenSize.width-40, 880);
            _scroll.contentSize = CGSizeMake(0, 920+50+_address.frame.size.height);
            
        }else{
            
            _nButton.selected = YES;
             _scroll.contentSize = CGSizeMake(0, 920+50+_address.frame.size.height);
            
        }
    }
    
//    //判断用户之前是否成为义工
//    if (_item.JoinVolunteer) {
//        _yButton.selected = YES;
//        _volunteerView.hidden = NO; //显示义工view
//        //如果也接收电邮
//        if (_item.AcceptEDM) {
//            _scroll.contentSize = CGSizeMake(0, 650+200+800); //增加scroll高度
//        }else{
//            _scroll.contentSize = CGSizeMake(0, 650+800); //增加scroll高度
//        }
//    }else{
//        _nButton.selected = YES;
//    }
    _updateButton = [self.view addSystemButtonWithFrame:CGRectMake(20, ScreenSize.height-80, ScreenSize.width/2-22, 25) title:EGLocalizedString(@"修改", nil) action:^(UIButton *button) {
        [weakSelf updateUserInfo];
        //[weakSelf PostIndividualUserInfo];
        
    }];
    
    [_updateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_updateButton setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
    
    _outButton = [self.view addSystemButtonWithFrame:CGRectMake(ScreenSize.width/2+2, ScreenSize.height-80, ScreenSize.width/2-20, 25) title:EGLocalizedString(@"登出", nil) action:^(UIButton *button) {
        
        NSMutableDictionary * dict = [ShowMenuView getUserInfo];
        [dict removeAllObjects];
        [ShowMenuView sharedInstance].member = nil;
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        [standardUserDefaults removeObjectForKey:@"EGIVE_MEMBER_MODEL"];
        [standardUserDefaults synchronize];
        
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        HomeViewController * vc = [[HomeViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
        [menuController setRootController:navController animated:YES];
    }];
    [_outButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_outButton setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
    
    _completeButton = [self.view addSystemButtonWithFrame:CGRectMake(20, ScreenSize.height-80, ScreenSize.width-40, 25) title:EGLocalizedString(@"完成", nil) action:^(UIButton *button) {
        
        
        [weakSelf checkErrorMessage:weakSelf.numbeField.text];
       
        
    }];
    _completeButton.hidden = YES;
    [_completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_completeButton setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
    
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

//判断是否选择了香港或者其他
-(BOOL)HkorOther{
    
    UIButton *btn = (UIButton*)[self.view viewWithTag:46];
    if (btn.selected && [self isEmpty:self.hkOrOtherPleaseState.text]){
        
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


-(BOOL)selectzhuana:(NSArray*)array{
    if (array.count==0 && _isEmailButton.selected){
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"请选取您喜欢的专案类别",nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
        
    }else{
        
        return true;
        
    }
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


-(BOOL)isBusinessRegistrationNUmber:(NSString*)bussessNumber{
    
    for (int j=0; j<bussessNumber.length; j++){
        
        unichar ch = [bussessNumber characterAtIndex:j];
        if (0x4e00 < ch  && ch < 0x9fff)
        {
            return true;
        }
        
        
    }
    return false;
    
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
//其他验证BusinessRegistrationNo
-(BOOL)BusinessRegistrationNooter:(NSString*)BusinessRegistrationNo{
    
    MyLog(@"%@",BusinessRegistrationNo);
    
    
    if ([self isBusinessRegistrationNUmber:BusinessRegistrationNo]){
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"商业登记号码/香港社团注册证明书编号/税局档号", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
        
    }else{
        return true;
    }
}

//验证BusinessRegistrationNo
-(BOOL)BusinessRegistrationNo:(NSString*)BusinessRegistrationNo{
    
    MyLog(@"%@",BusinessRegistrationNo);
    if ([self isBusinessRegistrationNUmber:BusinessRegistrationNo] || [BusinessRegistrationNo isEqualToString:@""]){
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"商业登记号码/香港社团注册证明书编号/税局档号", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
        
    }else{
        return true;
    }
}


//是否是纯数字
-(BOOL)isNumText:(NSString *)str{
    NSString * regex = @"^[0-9]*$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
    
}


-(void)UpdateInformation{
    for (UIView *view in _scroll.subviews) {
        [view removeFromSuperview];
    }
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(dismissKeyboard)];
    [_scroll addGestureRecognizer:tap0];
    UIView * imageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 130)];
    imageView.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1];
    [_scroll addSubview:imageView];
    
    _iconImage = [imageView addImageViewWithFrame:CGRectMake(20, 20, 90, 90) image:@"donor_list_company@2x.png"];
    _iconImage.layer.cornerRadius = 45;
    _iconImage.layer.masksToBounds = YES;
    
    
    UITapGestureRecognizer * imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageTapAction)];
    [_iconImage addGestureRecognizer:imageTap];
    
    //    //判断Documents 中是否存在该图片
    //    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@", [self documentFolderPath],@"test1.jpg"]]) {
    //
    ////        [_iconImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [self documentFolderPath],@"test.jpg"]]];
    //
    //        _base64Avatar = [UIImagePNGRepresentation([self imageWithImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [self documentFolderPath],@"test1.jpg"]] convertToSize:CGSizeMake(128, 128)]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //
    //    }
    
    if ([_item.ProfilePicURL isEqualToString:@""] || _item.ProfilePicURL == nil){
        
        NSString *urlString = [NSString stringWithFormat:@"%@%@",SITE_URL,@"/Images/default_c.png"];
        PicUrl = [NSURL URLWithString:urlString];
        [_iconImage sd_setImageWithURL:PicUrl placeholderImage:nil];
        
    }else{
        
        PicUrl = [NSURL URLWithString:SITE_URL];
        PicUrl = [PicUrl URLByAppendingPathComponent:_item.ProfilePicURL];
        [_iconImage sd_setImageWithURL:PicUrl placeholderImage:nil];
    }
    
    UILabel * donations = [imageView addLabelWithFrame:CGRectMake(ScreenSize.width/2-40, 20, 150, 25) text:EGLocalizedString(@"企业累积捐款", nil)];
    donations.font = [UIFont systemFontOfSize:13];
    donations.textColor = [UIColor grayColor];
    
    _money = [imageView addLabelWithFrame:CGRectMake(ScreenSize.width/2-40, 45, 150, 25) text:_memberTotalDonationAmount];
    _money.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    _money.font = [UIFont boldSystemFontOfSize:16];
    
    
    float width = (ScreenSize.width/2+40)/2-5;
    UIButton * rankingButton = [imageView addImageButtonWithFrame:CGRectMake(ScreenSize.width/2-50, 85, width+20, 30) title:EGLocalizedString(@"查看排名", nil)  backgroud:nil action:^(UIButton *button) {
        
        RankListViewController * vc = [[RankListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [rankingButton setImage:[UIImage imageNamed:@"account_ranking@2x.png"] forState:UIControlStateNormal];
    [rankingButton setTitleColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1] forState:UIControlStateNormal];
    rankingButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    UIButton * recordButton = [imageView addImageButtonWithFrame:CGRectMake(ScreenSize.width/2-30+width, 85, width, 30) title:EGLocalizedString(@"捐款记录", nil)  backgroud:nil action:^(UIButton *button) {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        [standardUserDefaults setObject:@"1" forKey:@"EGIVE_AFTER_DONATE"];
        [standardUserDefaults synchronize];
        MyDonationViewController * vc = [[MyDonationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    recordButton.titleLabel.numberOfLines = 2;
    [recordButton setImage:[UIImage imageNamed:@"account_history@2x.png"] forState:UIControlStateNormal];
    [recordButton setTitleColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1] forState:UIControlStateNormal];
    recordButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    
    //获取用户信息
    // NSMutableDictionary * dict = [ShowMenuView getUserInfo];
    //  MemberModel * item = dict[@"LoginName"];
    
    UILabel * loginName = [_scroll addLabelWithFrame:CGRectMake(20, 150, 120, 25) text:EGLocalizedString(@"登入名称", nil)];
    loginName.font = [UIFont systemFontOfSize:13];
    loginName.textColor = [UIColor grayColor];
    
    UILabel * loginPws = [_scroll addLabelWithFrame:CGRectMake(ScreenSize.width/2-30, 150, 120, 25) text:EGLocalizedString(@"Register_mpwsTextfile", nil)];
    loginPws.font = [UIFont systemFontOfSize:13];
    loginPws.textColor = [UIColor grayColor];
    
    _loginName = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 120, 25)];
    _loginName.text = _item.LoginName;
    _loginName.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_loginName];
    
    
    _pws = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2-30, 172, 120, 25)];
    _pws.text = @"******";
    _pws.delegate= self;
    _pws.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_pws];
    
    
    __weak typeof(self) weakSelf = self;
     updatePwsButton = [_scroll addSystemButtonWithFrame:CGRectMake(ScreenSize.width-140, 170, 130, 20) title:EGLocalizedString(@"修改密码", nil) action:^(UIButton *button) {
        
        
        UpdatePwsViewController * vc = [[UpdatePwsViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    }];
    [updatePwsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [updatePwsButton setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
    updatePwsButton.enabled=NO;
    
    UILabel * orgChName = [_scroll addLabelWithFrame:CGRectMake(20, 200,300, 25) text:EGLocalizedString(@"Register_org_orgNameCh_textFile", nil)];
    orgChName.font = [UIFont systemFontOfSize:13];
    orgChName.textColor = [UIColor grayColor];
    
    _orgChName = [[UITextField alloc] initWithFrame:CGRectMake(20, 225, ScreenSize.width-40, 25)];
    _orgChName.text = _item.CorporationChiName;
    _orgChName.delegate = self;
    _orgChName.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_orgChName];
    
    UILabel * orgEnName = [_scroll addLabelWithFrame:CGRectMake(20, 245, 300, 25) text:EGLocalizedString(@"Register_org_orgNameEn_textFile", nil)];
    orgEnName.font = [UIFont systemFontOfSize:13];
    orgEnName.textColor = [UIColor grayColor];
    
    _orgEnName = [[UITextField alloc] initWithFrame:CGRectMake(20, 270, ScreenSize.width-40, 25)];
    _orgEnName.text =  _item.CorporationEngName;
    _orgEnName.delegate= self;
    
    _orgEnName.borderStyle = UITextBorderStyleNone;
//    _orgEnName.layer.borderColor = [[UIColor grayColor]CGColor];
//    _orgEnName.layer.borderWidth = 0.0;
//    _orgEnName.layer.cornerRadius = 5.0f;
//    [_orgEnName.layer setMasksToBounds:YES];
    
    _orgEnName.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_orgEnName];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:EGLocalizedString(@"税局档号", nil) forKey:@"T"];
    [dict setObject:EGLocalizedString(@"香港社团注册证明书编号", nil) forKey:@"C"];
    [dict setObject:EGLocalizedString(@"不适用", nil) forKey:@" "];
    [dict setObject:EGLocalizedString(@"商业登记编号", nil) forKey:@"B"];
    
    loginNumber = [_scroll addLabelWithFrame:CGRectMake(20, 295,300, 25) text:[dict objectForKey:  _item.BusinessRegistrationType ]];
    loginNumber.font = [UIFont systemFontOfSize:13];
    loginNumber.textColor = [UIColor grayColor];
    
    _numbeField = [[UITextField alloc] initWithFrame:CGRectMake(20, 320, ScreenSize.width-40, 25)];
    _numbeField.text = _item.BusinessRegistrationNo;
    _numbeField.delegate = self;
    _numbeField.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_numbeField];
    
    UILabel * chName = [_scroll addLabelWithFrame:CGRectMake(20, 345, 200, 25) text:EGLocalizedString(@"联络人姓名(中)", nil)];
    chName.font = [UIFont systemFontOfSize:13];
    chName.textColor = [UIColor grayColor];
    
    UILabel * enName = [_scroll addLabelWithFrame:CGRectMake(ScreenSize.width/2, 345,200, 25) text:EGLocalizedString(@"联络人姓名(英)", nil)];
    enName.font = [UIFont systemFontOfSize:13];
    enName.textColor = [UIColor grayColor];
    
    _chName = [[UITextField alloc] initWithFrame:CGRectMake(20, 365, 120, 25)];
    _chName.delegate = self;
    MyLog(@"ming == %@ xing == %@",_item.ChiFirstName,_item.ChiFirstName);
    //    _chName.text =[NSString stringWithFormat:@"%@%@",[item.ChiLastName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[item.ChiFirstName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    _chName.text = [NSString stringWithFormat:@"%@%@",_item.ChiLastName ,_item.ChiFirstName];
    _chName.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_chName];
    
    _chLastName = [[UITextField alloc] initWithFrame:CGRectMake(20, 365, (ScreenSize.width/2-20)/2-10, 25)];
    _chLastName.delegate = self;
    _chLastName.borderStyle = UITextBorderStyleRoundedRect;
    _chLastName.hidden = YES;
    //_chLastName.placeholder = @"姓";
    if ([_item.ChiLastName isEqualToString:@"(null)"]) {
        _chLastName.text = @"";
    }else{
        _chLastName.text = _item.ChiLastName;
    }
    _chLastName.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_chLastName];
    _chfirstName = [[UITextField alloc] initWithFrame:CGRectMake((ScreenSize.width/2-20)/2+10, 365, (ScreenSize.width/2-20)/2+5, 25)];
    _chfirstName.delegate = self;
    _chfirstName.borderStyle = UITextBorderStyleRoundedRect;
    _chfirstName.hidden = YES;
    //_chfirstName.placeholder = @"名";
    if ([_item.ChiFirstName isEqualToString:@"(null)"]) {
        _chfirstName.text = @"";
    }else{
        _chfirstName.text = _item.ChiFirstName;
    }
    _chfirstName.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_chfirstName];
    
    
    _enName = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2, 365, 120, 25)];
    _enName.text = [NSString stringWithFormat:@"%@ %@",_item.EngFirstName,_item.EngLastName];
    _enName.font = [UIFont systemFontOfSize:13];
    _enName.delegate = self;
    [_scroll addSubview:_enName];
    
    _enLastName = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2, 365, (ScreenSize.width/2-20)/2-10, 25)];
    _enLastName.font = [UIFont systemFontOfSize:13];
    //_enLastName.placeholder = @"姓(英)";
    _enLastName.delegate = self;
    if ([_item.EngLastName isEqualToString:@"(null)"]){
        _enLastName.text = @"";
    }else{
        _enLastName.text = _item.EngLastName;
    }
    _enLastName.borderStyle = UITextBorderStyleRoundedRect;
    _enLastName.hidden = YES;
    [_scroll addSubview:_enLastName];
    
    
    _enfirstName = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2+(ScreenSize.width/2-20)/2-10, 365, (ScreenSize.width/2-20)/2+10, 25)];
    _enfirstName.font = [UIFont systemFontOfSize:13];
    //_enfirstName.placeholder = @"名(英)";
    if ([_item.EngFirstName isEqualToString:@"(null)"]) {
        _enfirstName.text = @"";
    }else{
        _enfirstName.text = _item.EngFirstName;
    }
    _enfirstName.delegate = self;
    _enfirstName.borderStyle = UITextBorderStyleRoundedRect;
    _enfirstName.hidden = YES;
    [_scroll addSubview:_enfirstName];
    //职位
    UILabel * Position = [_scroll addLabelWithFrame:CGRectMake(20, 385, 300, 25) text:EGLocalizedString(@"職位", nil)];
    Position.font = [UIFont systemFontOfSize:13];
    Position.textColor = [UIColor grayColor];
    
    _positionTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 410, ScreenSize.width-40, 25)];
    _positionTextField.text = _item.Position;
    _positionTextField.delegate = self;
    _positionTextField.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_positionTextField];
    //电邮地址
    UILabel * email = [_scroll addLabelWithFrame:CGRectMake(20, 430, 300, 25) text:EGLocalizedString(@"Register_email", nil)];
    email.font = [UIFont systemFontOfSize:13];
    email.textColor = [UIColor grayColor];
    
    _email = [[UITextField alloc] initWithFrame:CGRectMake(20, 450, ScreenSize.width-40, 25)];
    _email.text = _item.Email;
    _email.delegate = self;
    _email.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_email];
    
    UILabel * phone = [_scroll addLabelWithFrame:CGRectMake(20, 475, 300, 25) text:EGLocalizedString(@"Register_org_number", nil)];
    phone.font = [UIFont systemFontOfSize:13];
    phone.textColor = [UIColor grayColor];
    _CountyCodephoneNum = [[UITextField alloc] initWithFrame:CGRectMake(20, 495, 80, 25)];
    _CountyCodephoneNum.text = [NSString stringWithFormat:@"%@",_item.TelCountryCode];
    _CountyCodephoneNum.font = [UIFont systemFontOfSize:13];
    _CountyCodephoneNum.delegate= self;
    _CountyCodephoneNum.hidden=YES;
    [_scroll addSubview:_CountyCodephoneNum];
    
    _phoneNum = [[UITextField alloc] initWithFrame:CGRectMake(120, 495, ScreenSize.width-140, 25)];
    _phoneNum.text = [NSString stringWithFormat:@"%@",_item.TelNo];
    _phoneNum.font = [UIFont systemFontOfSize:13];
    _phoneNum.hidden=YES;
    _phoneNum.delegate= self;
    [_scroll addSubview:_phoneNum];
    
    if (![_item.TelCountryCode isEqualToString:@""] && ![_item.TelNo isEqualToString:@""]){
        _totalPhoneNumber=[[UILabel alloc] initWithFrame:CGRectMake(20, 495, ScreenSize.width-40, 25)];
        _totalPhoneNumber.text = [NSString stringWithFormat:@"(%@)%@",_item.TelCountryCode,_item.TelNo];
        _totalPhoneNumber.font = [UIFont systemFontOfSize:13];
        [_scroll addSubview:_totalPhoneNumber];
    }
    
    
    UILabel * addressLabel = [_scroll addLabelWithFrame:CGRectMake(20, 520, 300, 25) text:EGLocalizedString(@"Register_org_address", nil)];
    addressLabel.font = [UIFont systemFontOfSize:13];
    addressLabel.textColor = [UIColor grayColor];
    
    _address = [[UILabel alloc] initWithFrame:CGRectMake(20, 540, ScreenSize.width-40, 1)];
    MyLog(@"item.AddressBldg = %@", _item.AddressBldg);
    _address.font = [UIFont systemFontOfSize:13];
    if (![_item.AddressBldg isEqualToString:@"(null)"] && ![_item.AddressDistrict isEqualToString:@"(null)"]&&![_item.AddressStreet isEqualToString:@"(null)"]&&![_item.AddressRoom isEqualToString:@"(null)"]&&![_item.AddressEstate isEqualToString:@"(null)"]){
        
        _address.text = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",_item.AddressDistrict,@" ",_item.AddressStreet,@" ",_item.AddressEstate,@" ",_item.AddressBldg,@" ",_item.AddressRoom];
        
    }
    _address.numberOfLines=0;
    CGSize requiredSize = [[_address.text stringByReplacingOccurrencesOfString:@" " withString:@""] sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(ScreenSize.width-40, 10000) lineBreakMode:NSLineBreakByWordWrapping];
    _address.frame = CGRectMake(20, 540, ScreenSize.width-40, requiredSize.height);
    //_address.backgroundColor = [UIColor redColor];
    [_scroll addSubview:_address];
    
    
    
    if ([_item.AddressBldg isEqualToString:@"(null)"]){
        _item.AddressBldg = @"";
    }
    if ([_item.AddressDistrict isEqualToString:@"(null)"]){
        _item.AddressDistrict = @"";
    }
    if ([_item.AddressStreet isEqualToString:@"(null)"]){
        _item.AddressStreet = @"";
    }
    if ([_item.AddressRoom isEqualToString:@"(null)"]){
        _item.AddressRoom = @"";
    }
    if ([_item.AddressEstate isEqualToString:@"(null)"]){
        _item.AddressEstate = @"";
    }
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 545, ScreenSize.width, 120)];
    _view1.hidden = YES;
    //_view1.backgroundColor=[UIColor redColor];
    [_scroll addSubview:_view1];
    
    _addressDistrict = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, 85, 25)];
    _addressDistrict.delegate = self;
    _addressDistrict.placeholder = EGLocalizedString(@"Register_org_region1", nil);
    _addressDistrict.text = [NSString stringWithFormat:@"%@",_item.AddressRoom];
    _addressDistrict.font = [UIFont systemFontOfSize:13];
    _addressDistrict.borderStyle = UITextBorderStyleRoundedRect;
    [_view1 addSubview:_addressDistrict];
    
    _addressBldg = [[UITextField alloc] initWithFrame:CGRectMake(120, 5, ScreenSize.width-140, 25)];
    _addressBldg.text = [NSString stringWithFormat:@"%@",_item.AddressBldg];
    _addressBldg.font = [UIFont systemFontOfSize:13];
    _addressBldg.delegate= self;
    _addressBldg.placeholder = EGLocalizedString(@"Register_org_region2", nil);
    _addressBldg.borderStyle = UITextBorderStyleRoundedRect;
    [_view1 addSubview:_addressBldg];
    
    _addressEstate = [[UITextField alloc] initWithFrame:CGRectMake(20, 35, ScreenSize.width-40, 25)];
    _addressEstate.text = [NSString stringWithFormat:@"%@",_item.AddressEstate];
    _addressEstate.font = [UIFont systemFontOfSize:13];
    _addressEstate.delegate= self;
    _addressEstate.placeholder = EGLocalizedString(@"Register_org_region3", nil);
    _addressEstate.borderStyle = UITextBorderStyleRoundedRect;
    [_view1 addSubview:_addressEstate];
    
    _addressStreet = [[UITextField alloc] initWithFrame:CGRectMake(20, 65, ScreenSize.width-40, 25)];
    _addressStreet.text = [NSString stringWithFormat:@"%@",_item.AddressStreet];
    _addressStreet.font = [UIFont systemFontOfSize:13];
    _addressStreet.delegate= self;
    _addressStreet.placeholder = EGLocalizedString(@"Register_org_region4", nil);
    _addressStreet.borderStyle = UITextBorderStyleRoundedRect;
    [_view1 addSubview:_addressStreet];
    
    UITextField * textfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 95, 80, 25)];
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    textfield.enabled=NO;
    textfield.font = [UIFont systemFontOfSize:13];
    textfield.placeholder=EGLocalizedString(@"Register_org_selRegion", nil);
    [_view1 addSubview:textfield];
    
    _RegionTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, 95, ScreenSize.width-140, 25)];
    _RegionTextField.text = [NSString stringWithFormat:@"%@",_item.AddressDistrict];
    _RegionTextField.font = [UIFont systemFontOfSize:13];
    _RegionTextField.borderStyle = UITextBorderStyleRoundedRect;
    _RegionTextField.delegate= self;
    [_view1 addSubview:_RegionTextField];
    
    //    _regionButton = [_view1 addImageButtonWithFrame:CGRectMake(20, 95, 80, 25) title:nil backgroud:@"" action:^(UIButton *button) {
    //        //_pickerViewPopup.hidden = NO;
    //    }];
    //    _regionButton.titleLabel.font = [UIFont systemFontOfSize:12];
    //    _regionButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
    //    if ([_item.AddressDistrict isEqualToString:@""]) {
    //        [_regionButton setTitle:EGLocalizedString(@"Register_org_selRegion", nil) forState:UIControlStateNormal];
    //    }else{
    //        [_regionButton setTitle:_item.AddressDistrict forState:UIControlStateNormal];
    //    }
    
    //何处认识意赠view
    _view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 545+_address.frame.size.height, ScreenSize.width, 300)];
    [_scroll addSubview:_view2];
    //_view2.backgroundColor = [UIColor blackColor];
    [_view2 addImageViewWithFrame:CGRectMake(10, 0, ScreenSize.width-20, 2) image:@"Line@2x.png"];
    _view2.userInteractionEnabled=NO;
    label5 = [_view2 addLabelWithFrame:CGRectMake(20, 40, ScreenSize.width-40, 60) text:EGLocalizedString(@"Register_org_noteLabel2_title", nil)];
    label5.textColor = [UIColor grayColor];
    label5.numberOfLines = 0;
    label5.font = [UIFont systemFontOfSize:13];
    
    labelAddressCountry = [_view2 addLabelWithFrame:CGRectMake(20, 40, ScreenSize.width-160, 60) text:EGLocalizedString(@"Register_org_noteLabel2_title", nil)];
    labelAddressCountry.textColor = [UIColor grayColor];
    labelAddressCountry.numberOfLines = 0;
    labelAddressCountry.font = [UIFont systemFontOfSize:13];
    
    _hkOrOtherPleaseState = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width-140, 40, 120, 50)];
    _hkOrOtherPleaseState.font = [UIFont systemFontOfSize:13];
    _hkOrOtherPleaseState.delegate= self;
    _hkOrOtherPleaseState.placeholder = EGLocalizedString(@"请说明", nil);
    _hkOrOtherPleaseState.text = _item.AddressCountry;
    _hkOrOtherPleaseState.borderStyle = UITextBorderStyleRoundedRect;
    [_view2 addSubview:_hkOrOtherPleaseState];
    
    NSArray * region = @[EGLocalizedString(@"Register_org_regionButton", nil),EGLocalizedString(@"Register_org_otherButton", nil)];
    NSArray * regNorBg = @[@"comment_segment_left_nor.png",@"comment_segment_right_nor.png"];
    NSArray * regSelBg = @[@"comment_segment_left_sel.png",@"comment_segment_right_sel.png",];
    int width2 = (ScreenSize.width-40)/2;
    for (int i = 0; i < 2; i ++) {
        _selRegionButton = [_view2 addImageButtonWithFrame:CGRectMake(i*width2+20, 10, width2, 25) title:region[i] backgroud:regNorBg[i] action:^(UIButton *button) {
            
            for (int i = 0; i < 2; i ++) {
                UIButton * button = (UIButton *)[weakSelf.view viewWithTag:45+i];
                button.selected = NO;
            }
            if (button.tag == 45) {
                button.selected = YES;
                weakSelf.hkOrOtherPleaseState.hidden=YES;
                labelAddressCountry.hidden=YES;
                label5.hidden=NO;
            }else{
                button.selected = YES;
                label5.hidden=YES;
                weakSelf.hkOrOtherPleaseState.hidden=NO;
                labelAddressCountry.hidden=NO;
            }
        }];
        _selRegionButton.tag = 45 +i;
        _selRegionButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_selRegionButton setBackgroundImage:[UIImage imageNamed:regSelBg[i]] forState:UIControlStateSelected];
        [_selRegionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_selRegionButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
        
        if (i == 0) {
            _selRegionButton.selected = YES;
        }
        
        
    }
    
    if ([_item.AddressCountry isEqualToString:@"香港"]) {
        UIButton *hkbtn = (UIButton*)[_view2 viewWithTag:45];
        UIButton *otherbtn = (UIButton*)[_view2 viewWithTag:46];
        hkbtn.selected=YES;
        otherbtn.selected=NO;
        label5.hidden=NO;
        labelAddressCountry.hidden=YES;
        _hkOrOtherPleaseState.hidden=YES;
        _hkOrOtherPleaseState.text=@"";
        
    }else{
        UIButton *hkbtn = (UIButton*)[_view2 viewWithTag:45];
        UIButton *otherbtn = (UIButton*)[_view2 viewWithTag:46];
        hkbtn.selected=NO;
        otherbtn.selected=YES;
        label5.hidden=YES;
        labelAddressCountry.hidden=NO;
        _hkOrOtherPleaseState.hidden=NO;
        
    }
    

    
    UILabel * noteLabel = [_view2 addLabelWithFrame:CGRectMake(20, 105, ScreenSize.width-40, 25) text:EGLocalizedString(@"你從何處認識「意贈慈善基金」(可選擇多項)", nil)];
    noteLabel.font = [UIFont systemFontOfSize:13];
    noteLabel.textColor = [UIColor grayColor];
    
    _arr = [[NSMutableArray alloc] init];
    NSArray * timeTitleArray = @[EGLocalizedString(@"「意贈」網頁", nil),EGLocalizedString(@"「意贈」活動/刊物", nil),EGLocalizedString(@"朋友", nil),EGLocalizedString(@"報章", nil),EGLocalizedString(@"社交媒體(Facebook、新浪微博等)", nil),EGLocalizedString(@"為「意贈」的捐款者", nil),EGLocalizedString(@"其他", nil)];
    NSArray * titleArr = @[@"Web",@"Event",@"Friend",@"News",@"Social",@"Donor",@"other"];
    for (int i = 0; i < 7; i ++) {
        UIButton * opButton = [_view2 addImageButtonWithFrame:CGRectMake(i%2*(ScreenSize.width/2)+20, i/2*45+130, 20, 20) title:nil backgroud:@"cart_checkbox_nor.png" action:^(UIButton *button) {
            if (_isEdit) {
                if (button.tag == 130) {
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr removeObject:@"Web,"];
                        MyLog(@"%@",weakSelf.arr);
                    }else{
                        button.selected = YES;
                        [weakSelf.arr addObject:@"Web,"];
                    }
                    
                }else if (button.tag == 131){
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr removeObject:@"Event,"];
                        MyLog(@"%@",weakSelf.arr);
                    }else{
                        button.selected = YES;
                        [weakSelf.arr addObject:@"Event,"];
                        
                    }
                    
                }else if (button.tag == 132){
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr removeObject:@"Friend,"];
                        MyLog(@"%@",weakSelf.arr);
                    }else{
                        button.selected = YES;
                        [weakSelf.arr addObject:@"Friend,"];
                    }
                    
                    
                }else if (button.tag == 133){
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr removeObject:@"News,"];
                    }else{
                        button.selected = YES;
                        [weakSelf.arr addObject:@"News,"];
                    }
                    
                    
                }else if (button.tag == 134){
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr removeObject:@"Social,"];
                    }else{
                        button.selected = YES;
                        [weakSelf.arr addObject:@"Social,"];
                    }
                    
                }else if (button.tag == 135){
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr removeObject:@"Donor,"];
                    }else{
                        button.selected = YES;
                        [weakSelf.arr addObject:@"Donor,"];
                    }
                }else{
                    if (button.selected) {
                        button.selected = NO;
                        
                    }else
                        button.selected = YES;
                }
            }
        }];
        opButton.tag = 130+i;
        [opButton setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
        
        UILabel * label = [_view2 addLabelWithFrame:CGRectMake(i%2*(ScreenSize.width/2)+45, i/2*45+123, ScreenSize.width/2-40, 35) text:timeTitleArray[i]];
        label.numberOfLines = 2;
        label.font = [UIFont systemFontOfSize:12];
        if([_item.HowToKnoweGive rangeOfString:titleArr[i]].location !=NSNotFound)
        {
            opButton.selected = YES;
        }
        if (i==6 && ![_item.HowToKnoweGive_Other isEqualToString:@""]) {
            opButton.selected = YES;
        }
    }
    _instructions = [[UITextField alloc] initWithFrame:CGRectMake(100, 265, ScreenSize.width-120, 25)];
    _instructions.font = [UIFont systemFontOfSize:13];
    _instructions.delegate= self;
    _instructions.placeholder = EGLocalizedString(@"请说明", nil);
    _instructions.borderStyle = UITextBorderStyleRoundedRect;
    [_view2 addSubview:_instructions];
    
    if (_item.VolunteerInterest_Other != NULL){
        _instructions.text = _item.HowToKnoweGive_Other;
    }
    _view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 840+_address.frame.size.height, ScreenSize.width, 120)];
    // _view3.backgroundColor = [UIColor greenColor];
    [_scroll addSubview:_view3];
    
    UILabel * label6 = [_view3 addLabelWithFrame:CGRectMake(20, 0, ScreenSize.width/2+10, 40) text:EGLocalizedString(@"Register_IsEmailNote", nil)];
    label6.numberOfLines = 2;
    label6.font = [UIFont systemFontOfSize:12];
    //是否允许收到电邮资讯按钮 － 是
    int width3 = (ScreenSize.width/2-70)/2;
    _isEmailButton =[_view3 addImageButtonWithFrame:CGRectMake(ScreenSize.width/2+50, 5, width3, 25) title:EGLocalizedString(@"Register_isEmailButton_title", nil) backgroud:@"comment_segment_middle_nor.png" action:^(UIButton *button) {
        if (weakSelf.isEdit) {
            weakSelf.noEmailButton.selected = NO;
            button.selected = YES;
            weakSelf.emailView.hidden = NO;
            
            weakSelf.view4.frame = CGRectMake(20, 50+200, ScreenSize.width-40, 880);//义工view位置下移
            //是否也成为义工
            if (weakSelf.yButton.selected) {
                _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 120+200);
                weakSelf.scroll.contentSize = CGSizeMake(0, 870+140+80+200); //如果接收电邮，改变scroll高度
            }else{
                _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 120+200);
                weakSelf.scroll.contentSize = CGSizeMake(0, 870+140+80+200); //如果不接收电邮，改变scroll高度
            }
        }
        
    }];
    _isEmailButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_isEmailButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_middle_sel.png"] forState:UIControlStateSelected];
    [_isEmailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_isEmailButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    
    //是否允许收到电邮资讯按钮 － 否
    _noEmailButton = [_view3 addImageButtonWithFrame:CGRectMake(ScreenSize.width/2+50+width3, 5, width3, 25) title:EGLocalizedString(@"Register_noEmailButton_title", nil) backgroud:@"comment_segment_middle_nor.png" action:^(UIButton *button) {
        if (weakSelf.isEdit) {
            weakSelf.isEmailButton.selected = NO;
            button.selected = YES;
            weakSelf.emailView.hidden = YES;
            
            if (weakSelf.yButton.selected) {
                _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 120);
                weakSelf.scroll.contentSize = CGSizeMake(0, 870+140+80); //如果不接收电邮，但选择成为义工，改变scroll高度
            }else{
                _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 120);
                weakSelf.scroll.contentSize = CGSizeMake(0, 870+140+80); //如果不接收电邮，改变scroll高度
            }
            weakSelf.view4.frame = CGRectMake(20, 50, ScreenSize.width-40, 880);//还原义工view位置
        }
        
    }];
    _noEmailButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_noEmailButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_middle_sel.png"] forState:UIControlStateSelected];
    [_noEmailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_noEmailButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    
    [self createEmailView];
    
    NSArray * DonationInterestArr = @[@"S",@"E",@"M",@"P",@"U",@"O",@"A",@"L"];
    //判断是否包含全部，如果包含全部则全部选中
    if ([_item.DonationInterest rangeOfString:@"L"].location !=NSNotFound){
        //[weakSelf.arr1 removeAllObjects];
        for (int i = 0; i < 8; i ++){
            UIButton * button = (UIButton *)[weakSelf.view viewWithTag:110+i];
            button.selected = YES;
            NSString *str = [NSString stringWithFormat:@"%@,",DonationInterestArr[i]];
            [weakSelf.arr1 addObject:str];
        }
        
        MyLog(@"%@",weakSelf.arr1);
        
    }else{
        //[weakSelf.arr1 removeAllObjects];
        for (int i = 0; i < 8; i ++){
            if([_item.DonationInterest rangeOfString:DonationInterestArr[i]].location !=NSNotFound)
            {
                UIButton * button = (UIButton *)[weakSelf.view viewWithTag:110+i];
                button.selected = YES;
                NSString *str = [NSString stringWithFormat:@"%@,",DonationInterestArr[i]];
                [weakSelf.arr1 addObject:str];
            }
        }
    }
    
    
    _view4 = [[UIView alloc] initWithFrame:CGRectMake(20, 50, ScreenSize.width-40, 880)];
    [_view3 addSubview:_view4];
    
    
    UILabel * note = [_view4 addLabelWithFrame:CGRectMake(0, 0, ScreenSize.width-20, 35) text:EGLocalizedString(@"Register_noteLabel3_title", nil)];
    note.numberOfLines = 2;
    note.font = [UIFont systemFontOfSize:14];
    
    
    // “愿意”按钮
    _yButton = [_view4 addImageButtonWithFrame:CGRectMake(0, 45, ScreenSize.width/2-20, 25) title:EGLocalizedString(@"Register_yButton_title", nil) backgroud:@"comment_segment_left_nor.png" action:^(UIButton *button) {
        if (weakSelf.isEdit) {
            _nButton.selected = NO;
            button.selected = YES;
            _volunteerView.hidden = YES; //显示义工view
            if (weakSelf.isEmailButton.selected) {
                _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 120+200);
                _scroll.contentSize = CGSizeMake(0, 870+140+80+200); //增加scroll高度
            }else{
                _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 120);
                weakSelf.scroll.contentSize = CGSizeMake(0, 870+140+80);  //增加scroll高度
            }
            
        }
        
    } ];
    _yButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _yButton.layer.cornerRadius = 4;
    [_yButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_left_sel.png"] forState:UIControlStateSelected];
    [_yButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_yButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    
    //”暂不考虑“按钮
    _nButton = [_view4 addImageButtonWithFrame:CGRectMake(ScreenSize.width/2-20, 45, ScreenSize.width/2-20, 25) title:EGLocalizedString(@"Register_nButton_title", nil) backgroud:@"comment_segment_right_nor.png" action:^(UIButton *button) {
        
        if (weakSelf.isEdit) {
            
            _yButton.selected = NO;
            button.selected = YES;
            _volunteerView.hidden = YES; //隐藏义工view
            if (weakSelf.isEmailButton.selected) {
                
                _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 120+200);
                _scroll.contentSize = CGSizeMake(0, 870+140+80+200); //还原scroll高度
            }else{
                
                _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 120);
                weakSelf.scroll.contentSize = CGSizeMake(0, 870+140+80); //还原scroll高度
            }
            
        }
        
    }];
    _nButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _nButton.layer.cornerRadius = 4;
    [_nButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_right_sel.png"] forState:UIControlStateSelected];
    [_nButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_nButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    
    [self createVoView];    //创建义工view
    
    //判断用户之前是否接收电邮
    if (_item.AcceptEDM) {
        _isEmailButton.selected = YES;
        _emailView.hidden = NO;
        //        _view2.frame = CGRectMake(0, 560, ScreenSize.width, 200); //义工view位置下调
        
        _view3.frame = CGRectMake(0, 840+_address.frame.size.height, ScreenSize.width, 150+200);
        _view4.frame = CGRectMake(20, 50+200, ScreenSize.width-40, 880);
        _scroll.contentSize = CGSizeMake(0, 920+200+100+_address.frame.size.height);
        if (_item.JoinVolunteer) {
            
            _yButton.selected = YES;
            _volunteerView.hidden = YES; //显示义工view
            _view3.frame = CGRectMake(0, 840+_address.frame.size.height, ScreenSize.width, 150);
            _view4.frame = CGRectMake(20, 50+200, ScreenSize.width-40, 880);
            _scroll.contentSize = CGSizeMake(0, 920+200+100+_address.frame.size.height);
            
        }else{
            _nButton.selected = YES;
        }
        
    }else{
        _noEmailButton.selected = YES;
        if (_item.JoinVolunteer){
            _yButton.selected = YES;
            _volunteerView.hidden = YES; //显示义工view
            _view3.frame = CGRectMake(0, 840+_address.frame.size.height, ScreenSize.width, 150);
            _view4.frame = CGRectMake(20, 50, ScreenSize.width-40, 880);
            _scroll.contentSize = CGSizeMake(0, 920+50+_address.frame.size.height);
            
        }else{
            
            _nButton.selected = YES;
            _scroll.contentSize = CGSizeMake(0, 920+50+_address.frame.size.height);
            
        }
    }
    
   
  }

#pragma mark - 电邮资讯View
- (void)createEmailView{
    
    //创建点击“是”按钮弹出的视图
    _emailView = [[UIView alloc] initWithFrame:CGRectMake(20, 40, ScreenSize.width-40, 200)];
    _emailView.backgroundColor = [UIColor whiteColor];
    _emailView.hidden = YES;
    [_view3 addSubview:_emailView];
    UILabel * emailViewTitle = [_emailView addLabelWithFrame:CGRectMake(0, 0, 300, 40) text:EGLocalizedString(@"请选取你喜欢的专案类别(可选择多项):", nil)];
    emailViewTitle.numberOfLines=0;
    emailViewTitle.font = [UIFont systemFontOfSize:12];
    emailViewTitle.textColor = [UIColor grayColor];
    
    __weak typeof(self) weakSelf = self;
    
    _arr1 = [[NSMutableArray alloc] init];
    
    NSArray * emailViewTitleArray = @[EGLocalizedString(@"助学", nil),EGLocalizedString(@"安老", nil),EGLocalizedString(@"助医", nil),EGLocalizedString(@"扶贫", nil),EGLocalizedString(@"紧急援助", nil),EGLocalizedString(@"其他", nil),EGLocalizedString(@"意赠行动", nil),EGLocalizedString(@"全部", nil)];
    NSArray * DonationInterestArr = @[@"S",@"E",@"M",@"P",@"U",@"O",@"A",@"L"];
    for (int i = 0; i < 8; i ++){
        _typeButton = [_emailView addImageButtonWithFrame:CGRectMake(i%2*(ScreenSize.width/2), i/2*45+40, 20, 20) title:nil backgroud:@"cart_checkbox_nor.png" action:^(UIButton *button) {
            if (weakSelf.isEdit) {
                if (button.tag == 110){
                    
                    UIButton *btn = [weakSelf.emailView viewWithTag:117];
                    btn.selected=NO;
                    [weakSelf.arr1 removeObject:@"L,"];
                    
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr1 removeObject:@"S,"];
                        
                    }else{
                        button.selected = YES;
                        [weakSelf.arr1 addObject:@"S,"];
                    }
                }else if (button.tag == 111){
                   
                    UIButton *btn = [weakSelf.emailView viewWithTag:117];
                    btn.selected=NO;
                    [weakSelf.arr1 removeObject:@"L,"];
                    
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr1 removeObject:@"E,"];
                    }else{
                        
                        button.selected = YES;
                        [weakSelf.arr1 addObject:@"E,"];
                    }
                    
                }else if (button.tag == 112){
                    UIButton *btn = [weakSelf.emailView viewWithTag:117];
                    btn.selected=NO;
                    [weakSelf.arr1 removeObject:@"L,"];
                    
                    if (button.selected){
                        button.selected = NO;
                        [weakSelf.arr1 removeObject:@"M,"];
                    }else{
                        
                        button.selected = YES;
                        [weakSelf.arr1 addObject:@"M,"];
                    }
                    
                }else if (button.tag == 113){
                    UIButton *btn = [weakSelf.emailView viewWithTag:117];
                    btn.selected=NO;
                    [weakSelf.arr1 removeObject:@"L,"];
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr1 removeObject:@"P,"];
                    }else{
                        button.selected = YES;
                        [weakSelf.arr1 addObject:@"P,"];
                    }
                    
                }else if (button.tag == 114){
                    UIButton *btn = [weakSelf.emailView viewWithTag:117];
                    btn.selected=NO;
                    [weakSelf.arr1 removeObject:@"L,"];
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr1 removeObject:@"U,"];
                    }else{
                        button.selected = YES;
                        [weakSelf.arr1 addObject:@"U,"];
                    }
                    
                }else if (button.tag == 115){
                    
                    UIButton *btn = [weakSelf.emailView viewWithTag:117];
                    btn.selected=NO;
                    [weakSelf.arr1 removeObject:@"L,"];
                    
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr1 removeObject:@"O,"];
                    }else{
                        
                        button.selected = YES;
                        [weakSelf.arr1 addObject:@"O,"];
                    }
                    
                    
                }else if (button.tag == 116){
                    UIButton *btn = [weakSelf.emailView viewWithTag:117];
                    btn.selected=NO;
                    [weakSelf.arr1 removeObject:@"L,"];
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr1 removeObject:@"A,"];
                    }else{
                        button.selected = YES;
                        [weakSelf.arr1 addObject:@"A,"];
                    }
                    
                }else if (button.tag == 117){
                    
                    if (button.selected){
                        
                        for (int i = 0; i < 8; i ++) {
                            UIButton * button = (UIButton *)[weakSelf.view viewWithTag:110+i];
                            button.selected = NO;
                        }
                        
                        [weakSelf.arr1 removeAllObjects];
                        
                    }else{
                        for (int i = 0; i < 8; i ++){
                            UIButton * button = (UIButton *)[weakSelf.view viewWithTag:110+i];
                            button.selected = YES;
                        }
                        [weakSelf.arr1 removeAllObjects];
                        NSArray * DonationInterest = @[@"S",@"E",@"M",@"P",@"U",@"O",@"A",@"L"];
                        for (int j=0; j<DonationInterestArr.count; j++) {
                            NSString *str = [NSString stringWithFormat:@"%@,",DonationInterest[j]];
                            [weakSelf.arr1 addObject:str];
                            
                        }
                        

                    }
                }
            }
        }];
        
        _typeButton.tag = 110+i;
        [_typeButton setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
        
        UILabel * label = [_emailView addLabelWithFrame:CGRectMake(i%2*(ScreenSize.width/2)+25, i/2*45+40, 100, 20) text:emailViewTitleArray[i]];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:12];
        
        
    }
    
}
#pragma mark - 个人登记的义工选项视图
- (void)createVoView{
    _volunteerView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, ScreenSize.width-40, 800)];
    _volunteerView.hidden = YES;
    [_view4 addSubview:_volunteerView];
    
    __weak typeof(self) weakSelf = self;
    
    UILabel * label1 = [_volunteerView addLabelWithFrame:CGRectMake(0, 0, ScreenSize.width-20, 40) text:EGLocalizedString(@"义工服务意向", nil)];
    label1.font = [UIFont systemFontOfSize:12];
    label1.numberOfLines = 2;
    
    UILabel * label2 = [_volunteerView addLabelWithFrame:CGRectMake(0, 35, ScreenSize.width, 25) text:EGLocalizedString(@"我愿意成为意赠慈善基金的:", nil)];
    label2.font = [UIFont systemFontOfSize:12];
    
    _shortVolunteer = [_volunteerView addImageButtonWithFrame:CGRectMake(0, 70, ScreenSize.width/2 -20, 25) title:EGLocalizedString(@"长期义工", nil)  backgroud:@"comment_segment_left_nor.png" action:^(UIButton *button) {
        if (weakSelf.isEdit) {
            weakSelf.longVolunteer.selected = NO;
            button.selected = YES;
        }
        
    }];
    [_shortVolunteer setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    [_shortVolunteer setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _shortVolunteer.titleLabel.font = [UIFont systemFontOfSize:14];
    [_shortVolunteer setBackgroundImage:[UIImage imageNamed:@"comment_segment_left_sel.png"] forState:UIControlStateSelected];
    
    _longVolunteer = [_volunteerView addImageButtonWithFrame:CGRectMake(ScreenSize.width/2 -20, 70, ScreenSize.width/2-20, 25) title:EGLocalizedString(@"短期义工", nil) backgroud:@"comment_segment_right_nor.png" action:^(UIButton *button) {
        if (weakSelf.isEdit) {
            weakSelf.shortVolunteer.selected = NO;
            button.selected = YES;
        }
    }];
    _longVolunteer.titleLabel.font = [UIFont systemFontOfSize:14];
    [_longVolunteer setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    [_longVolunteer setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_longVolunteer setBackgroundImage:[UIImage imageNamed:@"comment_segment_right_sel.png"] forState:UIControlStateSelected];
    //    _longVolunteer.selected = YES;
    if (_item.JoinVolunteer) {
        if ([_item.VolunteerType isEqualToString:@"L"]) {
            _shortVolunteer.selected = YES;
        }else
            _longVolunteer.selected = YES;
    }else{
        _longVolunteer.selected = YES;
    }
    _dateStart = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, ScreenSize.width/2-21, 30)];
    _dateStart.placeholder = @"由(YYYY/MM/DD)";
    _dateStart.delegate = self;
    _dateStart.font = [UIFont systemFontOfSize:12];
    _dateStart.borderStyle = UITextBorderStyleRoundedRect;
    [_volunteerView addSubview:_dateStart];
    if (_item.JoinVolunteer) {
        _dateStart.text = _item.VolunteerStartDate;
    }
    
    _dateEnd = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2-19, 100, ScreenSize.width/2-21, 30)];
    _dateEnd.placeholder = @"至(YYYY/MM/DD)";
    _dateEnd.delegate = self;
    _dateEnd.font = [UIFont systemFontOfSize:12];
    _dateEnd.borderStyle = UITextBorderStyleRoundedRect;
    [_volunteerView addSubview:_dateEnd];
    if (_item.JoinVolunteer) {
        _dateEnd.text = _item.VolunteerEndDate;
    }
    
    UILabel * noteLabel = [_volunteerView addLabelWithFrame:CGRectMake(0, 135, ScreenSize.width, 25) text:EGLocalizedString(@"有关协助之项目:(可选择多项)", nil)];
    noteLabel.textColor = [UIColor grayColor];
    noteLabel.font = [UIFont boldSystemFontOfSize:12];
    
    
    UIButton * firstButton = [_volunteerView addImageButtonWithFrame:CGRectMake(0, 170, 20, 20) title:nil backgroud:@"cart_checkbox_nor.png" action:^(UIButton *button) {
        if (weakSelf.isEdit) {
            if (button.selected) {
                button.selected = NO;
                [weakSelf.volunteerInterestArr removeObject:@"Admin,"];
            }else{
                button.selected = YES;
                [weakSelf.volunteerInterestArr addObject:@"Admin,"];
            }
            
        }
    }];
    [firstButton setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
    if([_item.VolunteerInterest rangeOfString:@"Admin"].location !=NSNotFound)
    {
        firstButton.selected = YES;
    }
    
    UILabel * firstLabel = [_volunteerView addLabelWithFrame:CGRectMake(30, 160, ScreenSize.width-70, 40) text:EGLocalizedString(@"办事处行政服务:(资料输入,信件处理,一般行政工作等)", nil)];
    firstLabel.numberOfLines = 2;
    firstLabel.font = [UIFont boldSystemFontOfSize:12];
    NSArray * emailViewTitleArray = @[EGLocalizedString(@"印刷品设计", nil),EGLocalizedString(@"活动联络", nil),EGLocalizedString(@"编辑", nil),EGLocalizedString(@"翻译(中英/英中)", nil),EGLocalizedString(@"文稿撰写", nil),EGLocalizedString(@"摄影", nil),EGLocalizedString(@"協辦籌款活動(不定期舉辦)", nil),EGLocalizedString(@"探访", nil),EGLocalizedString(@"Register_org_otherButton", nil)];
    NSArray * VolunteerInterestArr = @[@"Print",@"Contact",@"Editing",@"Translate",@"Write",@"Photo",@"Event",@"Visit",@"otherVolunteer"];
    for (int i = 0; i < 9; i ++) {
        _helpTypeButton = [_volunteerView addImageButtonWithFrame:CGRectMake(i%2*(ScreenSize.width/2), i/2*45+210, 20, 20) title:nil backgroud:@"cart_checkbox_nor.png" action:^(UIButton *button) {
            if (weakSelf.isEdit) {
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
                        [weakSelf.volunteerInterestArr removeObject:@"otherVolunteer,"];
                    }else
                        button.selected = YES;
                    [weakSelf.volunteerInterestArr addObject:@"otherVolunteer,"];
                }
            }
        }];
        _helpTypeButton.tag = 120+i;
        [_helpTypeButton setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
        
        UILabel * label = [_volunteerView addLabelWithFrame:CGRectMake(i%2*(ScreenSize.width/2)+30, i/2*45+202, ScreenSize.width/2-35, 40) text:emailViewTitleArray[i]];
        label.numberOfLines = 2;
        label.font = [UIFont boldSystemFontOfSize:12];
        
        MyLog(@"%@",_item.VolunteerInterest);
        if([_item.VolunteerInterest rangeOfString:VolunteerInterestArr[i]].location !=NSNotFound)
        {
            _helpTypeButton.selected = YES;
        }
        if (i==8 && ![_item.VolunteerInterest_Other isEqualToString:@""]) {
            MyLog(@"%@",_item.VolunteerInterest_Other);
            _helpTypeButton.selected = YES;
        }
    }
    
    _noteText = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2-80,388 , ScreenSize.width/2+30, 25)];
    _noteText.placeholder =EGLocalizedString(@"请说明", nil);
    _noteText.delegate = self;
    _noteText.font = [UIFont systemFontOfSize:12];
    _noteText.borderStyle = UITextBorderStyleRoundedRect;
    [_volunteerView addSubview:_noteText];
    if (_item.JoinVolunteer) {
        if (_item.VolunteerInterest_Other != NULL) {
            _noteText.text = _item.VolunteerInterest_Other;
        }
    }
    
    
    UILabel * timeLabel = [_volunteerView addLabelWithFrame:CGRectMake(0, 425, ScreenSize.width-20, 35) text:EGLocalizedString(@"可服务的时间(可选择多项)", nil)];
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.numberOfLines= 2;
    timeLabel.font = [UIFont boldSystemFontOfSize:12];
    
    _availableTimeArr = [[NSMutableArray alloc] init];
    NSArray * timeTitleArray = @[EGLocalizedString(@"星期一",nil),EGLocalizedString(@"星期二",nil),EGLocalizedString(@"星期三",nil),EGLocalizedString(@"星期四",nil),EGLocalizedString(@"星期五",nil),EGLocalizedString(@"星期六",nil),EGLocalizedString(@"星期日",nil),EGLocalizedString(@"任何时间",nil),EGLocalizedString(@"上午10时至下午1时",nil),EGLocalizedString(@"下午2時至下午5時",nil),EGLocalizedString(@"上午10時至下午5時",nil),EGLocalizedString(@"晚上7時至9時",nil),EGLocalizedString(@"其他",nil)];
    
    NSArray * availabelArr = @[@"Mon",@"Tues",@"Wed",@"Thurs",@"Fri",@"Sat",@"Sun",@"All",@"Morning",@"Afternoon",@"Evening",@"WholeDay",@"timeOther"];
    
    for (int i = 0; i < 13; i ++) {
        _timesButton = [_volunteerView addImageButtonWithFrame:CGRectMake(i%2*(ScreenSize.width/2), i/2*45+460, 20, 20) title:nil backgroud:@"cart_checkbox_nor.png" action:^(UIButton *button) {
            if (weakSelf.isEdit) {
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
            }
            
        }];
        _timesButton.tag = 130+i;
        [_timesButton setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
        
        UILabel * label = [_volunteerView addLabelWithFrame:CGRectMake(i%2*(ScreenSize.width/2)+30, i/2*45+460, ScreenSize.width/2-35, 20) text:timeTitleArray[i]];
        label.numberOfLines = 2;
        label.font = [UIFont boldSystemFontOfSize:12];
        if([_item.AvailableTime rangeOfString:availabelArr[i]].location !=NSNotFound)
        {
            _timesButton.selected = YES;
        }
        if (i==12 && ![_item.AvailableTime_Other isEqualToString:@""]) {
            _timesButton.selected = YES;
        }
    }
    
    _noteTimeText = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2-80,728 , ScreenSize.width/2+30, 25)];
    _noteTimeText.placeholder =EGLocalizedString(@"请说明",nil) ;
    _noteTimeText.delegate = self;
    _noteTimeText.font = [UIFont systemFontOfSize:12];
    _noteTimeText.borderStyle = UITextBorderStyleRoundedRect;
    [_volunteerView addSubview:_noteTimeText];
    if (_item.JoinVolunteer) {
        if (_item.AvailableTime_Other != NULL) {
            _noteTimeText.text = _item.AvailableTime_Other;
        }
    }
}


- (void)dismissKeyboard{
    _pickerViewPopup.hidden = YES;
     [_editing resignFirstResponder];
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
        //        [pickerView removeFromSuperview];
        [_regionButton setTitle:[districtArr objectAtIndex:row] forState:UIControlStateNormal];
        _pickerViewPopup.hidden = YES;
    } else {
        //        [pickerView removeFromSuperview];

        _pickerViewPopup.hidden = YES;
        
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
   
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
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
   
    return 19;
    
}
#pragma mark - 点击更换头像
-(void)iconImageTapAction{
    
    if (_isEdit) {
        UIActionSheet *photoBtnActionSheet =
        [[UIActionSheet alloc] initWithTitle:nil
                                    delegate:self
                           cancelButtonTitle:EGLocalizedString(@"取消", nil)
                      destructiveButtonTitle:nil
                           otherButtonTitles:EGLocalizedString(@"从照片库选取", nil) ,EGLocalizedString(@"拍摄新照片", nil), nil];
        [photoBtnActionSheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
        [photoBtnActionSheet showInView:[self.view window]];
    }

}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
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
    //TODO:选择照片或者照相完成以后的处理
    
    /*
     MyLog(@"info = %@",info);
     info = {
     UIImagePickerControllerMediaType = "public.image";
     UIImagePickerControllerOriginalImage = "<UIImage: 0x8f95470>";
     UIImagePickerControllerReferenceURL = "assets-library://asset/asset.PNG?id=9126D6F5-CC10-49DA-B7C9-E4553924FA71&ext=PNG";
     }
     */
    _iconImage.image = info[UIImagePickerControllerOriginalImage];
    MyLog(@"UIImagePickerControllerMediaURL-------------%@",info[UIImagePickerControllerReferenceURL]);
     _base64Avatar = [UIImagePNGRepresentation([self imageWithImage:_iconImage.image convertToSize:CGSizeMake(128, 128)]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    UIImage *image = [self fixOrientation:info[UIImagePickerControllerOriginalImage]];
    [self saveImage:image WithName:@"test1.jpg"];
    [self updateIcon];
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (UIImage *)fixOrientation:(UIImage *)aImage{
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation){
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
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
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
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma mark 保存图片到document
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
}

//压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

#pragma mark 从文档目录下获取Documents路径
- (NSString *)documentFolderPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}
- (void)updateUserInfo{
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (([standardUserDefaults objectForKey:@"FACEBOOK_REG_REQ"] != nil && [[standardUserDefaults objectForKey:@"FACEBOOK_REG_REQ"] isEqualToString:@"1"]) || ([standardUserDefaults objectForKey:@"WEIBO_REG_REQ"] != nil && [[standardUserDefaults objectForKey:@"WEIBO_REG_REQ"] isEqualToString:@"1"]) ){
        
     updatePwsButton.enabled=NO;
    
    }else{
    
    updatePwsButton.enabled=YES;
    }
    
    _CountyCodephoneNum.hidden=NO;
    _phoneNum.hidden=NO;
    _totalPhoneNumber.hidden=YES;
    _isEdit = YES;
    _chName.hidden = YES;
    _chLastName.hidden = NO;
    _chfirstName.hidden = NO;
    _enName.hidden = YES;
    _enLastName.hidden = NO;
    _enfirstName.hidden = NO;
    //_pws.borderStyle = UITextBorderStyleRoundedRect;
    _orgChName.borderStyle = UITextBorderStyleRoundedRect;
    //_orgEnName.layer.borderWidth = 0.3;
    _orgEnName.borderStyle = UITextBorderStyleRoundedRect;
    _numbeField.borderStyle = UITextBorderStyleRoundedRect;
    _enName.borderStyle = UITextBorderStyleRoundedRect;
    _email.borderStyle = UITextBorderStyleRoundedRect;
    _phoneNum.borderStyle = UITextBorderStyleRoundedRect;
    _CountyCodephoneNum.borderStyle = UITextBorderStyleRoundedRect;
    _positionTextField.borderStyle = UITextBorderStyleRoundedRect;
    _completeButton.hidden = NO;
    _updateButton.hidden = YES;
    _outButton.hidden = YES;
    _address.hidden = YES;
    _view1.hidden = NO;
    _view2.userInteractionEnabled=YES;
    _view2.frame = CGRectMake(0, 580+87, ScreenSize.width, 300);
    
    if (_isEmailButton.selected) {
        _view3.frame = CGRectMake(0, 840+120+_address.frame.size.height, ScreenSize.width, 150+200);
        _scroll.contentSize = CGSizeMake(0, 920+150+200+100);
        
        if (_yButton.selected) {
            _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 150+200);
            _scroll.contentSize = CGSizeMake(0, 920+150+200+_address.frame.size.height);
        }
    }else{
        _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 120);
        _scroll.contentSize = CGSizeMake(0, 920+130+30);
        
        if (_yButton.selected) {
            _view3.frame = CGRectMake(0, 880+80, ScreenSize.width, 150);
            _scroll.contentSize = CGSizeMake(0, 870+200+30);
        }
    }

    
//    _view3.frame = CGRectMake(0, 780+140, ScreenSize.width, 120);
//    _scroll.contentSize = CGSizeMake(0, 920+130);
//    for (int i = 0; i < 7; i ++) {
//        UIButton * button = (UIButton *)[_scroll viewWithTag:130+i];
//        button.selected = NO;
//    }
    
}

- (void)completeUserInfo {
    updatePwsButton.enabled=NO;
    _CountyCodephoneNum.hidden=YES;
    _phoneNum.hidden=YES;
    _totalPhoneNumber.hidden=NO;
    _isEdit = NO;
    _chName.hidden = NO;
    _chLastName.hidden = YES;
    _chfirstName.hidden = YES;
    _enName.hidden = NO;
    _enLastName.hidden = YES;
    _enfirstName.hidden = YES;
    _orgChName.borderStyle = UITextBorderStyleNone;
    _pws.borderStyle = UITextBorderStyleNone;
    _email.borderStyle = UITextBorderStyleNone;
    //_orgEnName.layer.borderWidth = 0.0;
    _orgEnName.borderStyle=UITextBorderStyleNone;
    _enName.borderStyle = UITextBorderStyleNone;
    _numbeField.borderStyle = UITextBorderStyleNone;
    _phoneNum.borderStyle = UITextBorderStyleNone;
    _CountyCodephoneNum.borderStyle = UITextBorderStyleNone;
    _positionTextField.borderStyle = UITextBorderStyleNone;
    _completeButton.hidden = YES;
    _updateButton.hidden = NO;
    _outButton.hidden = NO;
    _address.hidden = NO;
    _view1.hidden = YES;
    _view2.userInteractionEnabled=NO;
    _view2.frame = CGRectMake(0, 580, ScreenSize.width, 300);
    
    if (_isEmailButton.selected) {
        _view3.frame = CGRectMake(0, 840, ScreenSize.width, 150+200);
        _scroll.contentSize = CGSizeMake(0, 920+200+100);
        if (_yButton.selected) {
            _view3.frame = CGRectMake(0, 840, ScreenSize.width, 150+200);
            _scroll.contentSize = CGSizeMake(0, 920+200+100);
        }
    }else{
        _view3.frame = CGRectMake(0, 840, ScreenSize.width, 150);
        _scroll.contentSize = CGSizeMake(0, 920+100);

    }
    
//    _view3.frame = CGRectMake(0, 780, ScreenSize.width, 150);
//    _scroll.contentSize = CGSizeMake(0, 870+130);
//    for (int i = 0; i < 7; i ++) {
//        UIButton * button = (UIButton *)[_scroll viewWithTag:130+i];
//        button.selected = NO;
//    }
   
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (_isEdit == NO) {
        return NO;
    }else{
        if (textField == _pws) {
            return NO;
        }
        return YES;
    }
    
}

- (void)PostEnterpriseUserInfo {

                    MemberModel * model = [[MemberModel alloc] init];
                    model.MemberType = @"C";
                    model.CorporationType = _item.CorporationType;
                    model.CorporationType_Other = @"O";
                    model.CorporationChiName = _orgChName.text;
                    model.CorporationEngName = _orgEnName.text;
                    model.BusinessRegistrationType = _item.BusinessRegistrationType;
                    model.BusinessRegistrationNo = _numbeField.text;
                    model.Position = _item.Position;
                    model.TelNo = _phoneNum.text;
                    model.TelCountryCode = self.CountyCodephoneNum.text;
                    model.ChiNameTitle = _item.ChiNameTitle;
                    model.EngNameTitle = _item.EngNameTitle;
                    model.Sex = _item.Sex;
                    model.ChiLastName = _chLastName.text;
                    model.ChiFirstName = _chfirstName.text;
                    model.EngLastName = _enLastName.text;
                    model.EngFirstName = _enfirstName.text;
                    model.Email = [_email.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                    model.AddressRoom = _addressDistrict.text;
                    model.AddressBldg = _addressBldg.text;
                    model.AddressEstate = _addressEstate.text;
                    model.AddressStreet = _addressStreet.text;
                    UIButton *btn = (UIButton*)[_view2 viewWithTag:45];
                    if (btn.selected) {
                         model.AddressCountry = @"香港";
                    }else{
                    
                        model.AddressCountry = self.hkOrOtherPleaseState.text;

                    }
                    model.BelongTo = @"Other";
                    model.Position = _positionTextField.text;
                    model.AddressDistrict = self.RegionTextField.text;//_address.text;
                    //是否收到电邮资讯
                    if (_isEmailButton.selected == YES) {
                        model.AcceptEDM = YES;
                    }else{
                        model.AcceptEDM = NO;
                    }
                    NSMutableString * muStr1 = [[NSMutableString alloc] init];
                    for (int i = 0; i < _arr1.count; i ++) {
                        [muStr1 appendString:_arr1[i]];
                    }
                    
                    model.DonationInterest = muStr1;
                   
          
                    //是否成为义工
                    if (_yButton.selected == YES) {
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
                            MyLog(@"model.VolunteerInterest==%@",model.VolunteerInterest);
                        }else{
                            model.VolunteerInterest = _item.VolunteerInterest;
                        }
                        
                        NSMutableString * muStr1 = [[NSMutableString alloc] init];
                        for (int i = 0; i < _availableTimeArr.count; i ++) {
                            [muStr1 appendString:_availableTimeArr[i]];
                        }
                        if (_availableTimeArr.count > 0) {
                            model.AvailableTime = muStr1;
                            MyLog(@"model.AvailableTi===%@",model.AvailableTime);
                        }else{
                            model.AvailableTime = @" ";
                        }
                        
                    }else{
                        model.JoinVolunteer = NO;
                        model.VolunteerType = @" ";
                    }
 
                    NSMutableString * muStr = [[NSMutableString alloc] init];
                    for (int i = 0; i < _arr.count; i ++) {
                        [muStr appendString:_arr[i]];
                    }
                    
                    if (_arr.count > 0) {

                        model.HowToKnoweGive = muStr;
                    }else{
                        model.HowToKnoweGive = _item.HowToKnoweGive;
                    }
                    UIButton * htgiveButton = (UIButton *)[self.view viewWithTag:136];
                    if (htgiveButton.selected) {
                        model.HowToKnoweGive_Other = _instructions.text;
                    }else{
                        model.HowToKnoweGive_Other = @" ";
                        _instructions.text = @"";
                    }

                    
//                    model.VolunteerType = @"";
//                    model.VolunteerStartDate = @"";
//                    model.VolunteerEndDate = @"";
//                    model.VolunteerInterest = @"";
//                    model.VolunteerInterest_Other = @"";
//                    model.AvailableTime = @"";
//                    model.AvailableTime_Other = @"";
                    model.AppToken = @"";
                    [self SaveMemberInfo:model];
                    

}

- (void)SaveMemberInfo:(MemberModel *)model{
    [self showLoadingAlert];
    
     long lang = [EGUtility getAppLang];
    MyLog(@"%@",model.MemberID);
    MyLog(@"VolunteerInterest --------------- %@",model.EngLastName);
    MyLog(@"AvailableTime --------------- %@",model.EngFirstName);
    MyLog(@"VolunteerInterest --------------- %@",model.VolunteerInterest);
    if (_base64Avatar == nil) {
        _base64Avatar = @"";
        NSString *urlString = [NSString stringWithFormat:@"%@%@",SITE_URL,@"/Images/default_c.png"];
        if (_iconImage != nil && ![[NSString stringWithFormat:@"%@",PicUrl] isEqualToString:urlString]){
            _base64Avatar = [UIImagePNGRepresentation([self imageWithImage:[_iconImage image] convertToSize:CGSizeMake(128, 128)]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            MyLog(@"ProfilePicBase64String----- %@",_base64Avatar);
        
        }
    }
    NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <SaveMemberInfo xmlns=\"egive.appservices\"><MemberID>%@</MemberID><MemberType>%@</MemberType><CorporationType>%@</CorporationType><CorporationType_Other>%@</CorporationType_Other><LoginName></LoginName><Password></Password><ConfirmPassword></ConfirmPassword><ProfilePicBase64String>%@</ProfilePicBase64String><CorporationChiName>%@</CorporationChiName><CorporationEngName>%@</CorporationEngName><BusinessRegistrationType>%@</BusinessRegistrationType><BusinessRegistrationNo>%@</BusinessRegistrationNo><ChiNameTitle>%@</ChiNameTitle><ChiLastName>%@</ChiLastName><ChiFirstName>%@</ChiFirstName><EngNameTitle>%@</EngNameTitle><EngLastName>%@</EngLastName><EngFirstName>%@</EngFirstName><Sex>%@</Sex><AgeGroup>%@</AgeGroup><Email>%@</Email><TelCountryCode>%@</TelCountryCode><TelNo>%@</TelNo><AddressRoom>%@</AddressRoom><AddressBldg>%@</AddressBldg><AddressEstate>%@</AddressEstate><AddressStreet>%@</AddressStreet><AddressDistrict>%@</AddressDistrict><AddressCountry>%@</AddressCountry><EducationLevel></EducationLevel><Position>%@</Position><BelongTo>%@</BelongTo><HowToKnoweGive>%@</HowToKnoweGive><HowToKnoweGive_Other>%@</HowToKnoweGive_Other><AcceptEDM>%d</AcceptEDM><DonationInterest>%@</DonationInterest><JoinVolunteer>%d</JoinVolunteer><VolunteerType>%@</VolunteerType><VolunteerStartDate>%@</VolunteerStartDate><VolunteerEndDate>%@</VolunteerEndDate><VolunteerInterest>%@</VolunteerInterest><VolunteerInterest_Other>%@</VolunteerInterest_Other><AvailableTime>%@</AvailableTime><AvailableTime_Other>%@</AvailableTime_Other><AppToken>%@</AppToken><FaceBookID></FaceBookID><WeiboID></WeiboID><Lang>%ld</Lang></SaveMemberInfo></soap:Body></soap:Envelope>",_item.MemberID,model.MemberType,model.CorporationType,model.CorporationType_Other,_base64Avatar,model.CorporationChiName,model.CorporationEngName,model.BusinessRegistrationType,model.BusinessRegistrationNo,model.ChiNameTitle,model.ChiLastName,model.ChiFirstName,model.EngNameTitle,model.EngLastName,model.EngFirstName,model.Sex,model.AgeGroup,model.Email,model.TelCountryCode,model.TelNo,model.AddressRoom,model.AddressBldg,model.AddressEstate,model.AddressStreet,model.AddressDistrict,model.AddressCountry,model.Position,model.BelongTo,model.HowToKnoweGive,model.HowToKnoweGive_Other,model.AcceptEDM,model.DonationInterest,model.JoinVolunteer,model.VolunteerType,model.VolunteerStartDate,model.VolunteerEndDate,model.VolunteerInterest,model.VolunteerInterest_Other,model.AvailableTime,model.AvailableTime_Other,model.AppToken,lang];
    
    MyLog(@"soapMessage ======= %@",soapMessage);
//return;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsd", SITE_URL]];
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
        NSString * registerResult = [str substringWithRange:range];
        MyLog(@"-----------------%@",registerResult);
        
        if (dict != nil) {
      
            registerResult = dict[@"MemberID"];
            
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.delegate = self;
            alertView.message = EGLocalizedString(@"修改成功!", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            [self completeUserInfo];
            [self GetMemberInfo:_item.MemberID];
        }else{
            
            if ([registerResult isEqualToString:@"\"Error(5005)\""]||[registerResult isEqualToString:@"Error(5005)"]) {
                
                UIAlertView *alertView = [[UIAlertView alloc] init];
                alertView.message = EGLocalizedString(@"电邮已被注册", nil);
                [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                [alertView show];
                
            }else if ([registerResult isEqualToString:@"\"Error(9999)\""]||[registerResult isEqualToString:@"Error(9999)"]){
                UIAlertView *alertView = [[UIAlertView alloc] init];
                alertView.message = EGLocalizedString(@"系统错误", nil);
                [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                [alertView show];
            
            }else{
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = registerResult;
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
    [self showLoadingAlert];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self removeLoadingAlert];
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSArray * arr = [NSString parseJSONStringToNSArray:dataString];
        MyLog(@"%ld",arr.count);
        for (NSDictionary * dict in arr) {
            MyLog(@"dict------------------------------%@",dict);
             _item = [[MemberModel alloc] init];
            [_item setValuesForKeysWithDictionary:dict];
            
            NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
            [standardUserDefaults setObject:dict forKey:@"EGIVE_MEMBER_MODEL"];
            [standardUserDefaults synchronize];
            
            [_shareDict setObject:_item forKey:@"LoginName"];
           
            [self updateIcon];
            //[ShowMenuView sharedInstance].member = model;
        }
        //获取用户信息
        NSMutableDictionary * dict = [ShowMenuView getUserInfo];
          MemberModel * item = dict[@"LoginName"];
//        if ([item.AddressBldg isEqualToString:@""]) {
//            item.AddressBldg = @"";
//        }
//        if ([item.AddressDistrict isEqualToString:@""]) {
//            item.AddressDistrict = @"";
//        }
//        if ([item.AddressStreet isEqualToString:@""]) {
//            item.AddressStreet = @"";
//        }
//        if ([item.AddressRoom isEqualToString:@""]) {
//            item.AddressRoom = @"";
//        }
//        if ([item.AddressEstate isEqualToString:@""]) {
//            item.AddressEstate = @"";
//        }
//        _address.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",item.AddressDistrict,item.AddressStreet,item.AddressEstate,item.AddressBldg,item.AddressRoom];
//        _chName.text = [NSString stringWithFormat:@"%@%@",item.ChiLastName ,item.ChiFirstName];
        
            [self UpdateInformation];
        
       

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self removeLoadingAlert];
    }];
    
    [operation start];
}


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

#pragma mark - UITextFieldDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text{

    if ([text isEqualToString:@"\n"]) {
        
        NSTimeInterval animationDuration = 0.20f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame = rect;
        [UIView commitAnimations];
        [textView resignFirstResponder];
      
        
        return NO;
    }

    return YES;
}

-(void)checkErrorMessage:(NSString*)bussnessNumber{
    
    MyLog(@"%@",loginNumber.text);
    
    
    if ([loginNumber.text isEqualToString:EGLocalizedString(@"不适用", nil)]) {
        if (![NSString isEmpty:self.orgChName.text andNote:EGLocalizedString(@"机构名称不能为空", nil)])
        {
            if ([self enterprise:self.orgEnName.text]) {
                
               if ([self BusinessRegistrationNooter:bussnessNumber]){
                   
                        if (([self.chLastName.text isEqualToString:@""]&&[self.chfirstName.text isEqualToString:@""]&&[self.enLastName.text isEqualToString:@""]&&[self.enfirstName.text isEqualToString:@""])){
                            
                            UIAlertView *alertView = [[UIAlertView alloc] init];
                            alertView.message = EGLocalizedString(@"请输入[联络人姓名(中)(姓)]", nil);
                            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                            [alertView show];
                            
                            
                        }else if (((![self.chLastName.text isEqualToString:@""] && [self.chfirstName.text isEqualToString:@""]) || ([self.chLastName.text isEqualToString:@""] && ![self.chfirstName.text isEqualToString:@""]))){
                            
                            if ([self.chLastName.text isEqualToString:@""]){
                                
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
                            
                            //weakSelf.lastNameEn.text=@"";
                            //weakSelf.nameEn.text=@"";
                            
                        }else if (((![self.enLastName.text isEqualToString:@""]&&[self.enfirstName.text isEqualToString:@""]) || ([self.enLastName.text isEqualToString:@""]&&![self.enfirstName.text isEqualToString:@""])) ){
                            
                            if ([self.enLastName.text isEqualToString:@""]){
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
                            
                            
                        }else if ((![self isZhongWenFirst:self.chLastName.text]&&![self.chfirstName.text isEqualToString:@""]) || (![self isZhongWenFirst:self.chfirstName.text]&&![self.chfirstName.text isEqualToString:@""])){
                            
                            UIAlertView *alertView = [[UIAlertView alloc] init];
                            alertView.message = EGLocalizedString(@"联络人姓名(中)内请输入中文",nil);
                            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                            [alertView show];
                        }else if (![self pipeizimu:self.enLastName.text] || ![self pipeizimu:self.enfirstName.text]){
                            
                            UIAlertView *alertView = [[UIAlertView alloc] init];
                            alertView.message = EGLocalizedString(@"联络人姓名(英)内请输入英文",nil);
                            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                            [alertView show];
                            
                        }else{
                            if (![NSString isEmpty:self.positionTextField.text andNote:EGLocalizedString(@"职位不能为空", nil)]) {
                                if (![NSString isEmpty:self.email.text andNote:EGLocalizedString(@"邮箱不能为空", nil)]) {
                                    if ([NSString isEmail:self.email.text]){
                                        if (![NSString isEmpty:self.phoneNum.text andNote:EGLocalizedString(@"联络电话不能为空", nil)]){
                                            if ([self address:self.addressBldg.text andRegister_org_region2:self.addressEstate.text andRegister_org_region3:self.addressDistrict.text andRegister_org_region4:self.addressStreet.text andRegister_org_region5:self.RegionTextField.text]){
                                                if([self HkorOther]){
                                                
                                                if ([self selectzhuana:self.arr1]){
                                                    
                                                    [self PostEnterpriseUserInfo];
                                                    
                                                }
                                            }
                                        }
                                        
                                    }
                                    
                                    
                                }
                                }}}}}}
        
        
    }else{
    
    if (![NSString isEmpty:self.orgChName.text andNote:EGLocalizedString(@"机构名称不能为空", nil)])
    {
        if ([self enterprise:self.orgEnName.text]) {
            
            if (![NSString isEmpty:self.numbeField.text andNote:EGLocalizedString(@"请输入[商业登记号码/香港社团注册证明书编号/税局档号]", nil)]){
                
                if ([self BusinessRegistrationNo:bussnessNumber]){
                    
                    
                    if (([self.chLastName.text isEqualToString:@""]&&[self.chfirstName.text isEqualToString:@""]&&[self.enLastName.text isEqualToString:@""]&&[self.enfirstName.text isEqualToString:@""])){
                        
                        UIAlertView *alertView = [[UIAlertView alloc] init];
                        alertView.message = EGLocalizedString(@"请输入[联络人姓名(中)(姓)]", nil);
                        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                        [alertView show];
                        
                        
                    }else if (((![self.chLastName.text isEqualToString:@""] && [self.chfirstName.text isEqualToString:@""]) || ([self.chLastName.text isEqualToString:@""] && ![self.chfirstName.text isEqualToString:@""]))){
                        
                        if ([self.chLastName.text isEqualToString:@""]){
                            
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
                        
                        //weakSelf.lastNameEn.text=@"";
                        //weakSelf.nameEn.text=@"";
                        
                    }else if (((![self.enLastName.text isEqualToString:@""]&&[self.enfirstName.text isEqualToString:@""]) || ([self.enLastName.text isEqualToString:@""]&&![self.enfirstName.text isEqualToString:@""])) ){
                        
                        if ([self.enLastName.text isEqualToString:@""]){
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
                        
                        
                    }else if ((![self isZhongWenFirst:self.chLastName.text]&&![self.chfirstName.text isEqualToString:@""]) || (![self isZhongWenFirst:self.chfirstName.text]&&![self.chfirstName.text isEqualToString:@""])){
                        
                        UIAlertView *alertView = [[UIAlertView alloc] init];
                        alertView.message = EGLocalizedString(@"联络人姓名(中)内请输入中文",nil);
                        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                        [alertView show];
                    }else if (![self pipeizimu:self.enLastName.text] || ![self pipeizimu:self.enfirstName.text]){
                        
                        UIAlertView *alertView = [[UIAlertView alloc] init];
                        alertView.message = EGLocalizedString(@"联络人姓名(英)内请输入英文",nil);
                        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                        [alertView show];
                        
                    }else{
                        if (![NSString isEmpty:self.positionTextField.text andNote:EGLocalizedString(@"职位不能为空", nil)]) {
                            if (![NSString isEmpty:self.email.text andNote:EGLocalizedString(@"邮箱不能为空", nil)]) {
                                if ([NSString isEmail:self.email.text]){
                                    if (![NSString isEmpty:self.phoneNum.text andNote:EGLocalizedString(@"联络电话不能为空", nil)]){
                                        if ([self address:self.addressBldg.text andRegister_org_region2:self.addressEstate.text andRegister_org_region3:self.addressDistrict.text andRegister_org_region4:self.addressStreet.text andRegister_org_region5:self.RegionTextField.text]){
                                            if ([self HkorOther]) {
                                                
                                            if ([self selectzhuana:self.arr1]){
                                                
                                                [self PostEnterpriseUserInfo];
                                                
                                            }
                                        }
                                    }
                    
                               }
            
            
                          }
                            }}}}}}}}}
    
    
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length + string.length > 50) {
        return NO;
    }
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (_isEdit) {
        return YES;
    }else{
        return NO;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _editing = textField;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    
//    CGRect frame = textView.frame;
//    //    MyLog(@"frame.origin.y = %f [_serverArr count] = %lu", frame.origin.y, (unsigned long)[_serverArr count]);
//    //int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
//    int offset = frame.origin.y +150 - (self.view.frame.size.height - 216.0);//键盘高度216;
//    
//    NSTimeInterval animationDuration = 0.20f;
//    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    float width = self.view.frame.size.width;
//    float height = self.view.frame.size.height;
//    if(offset > 0)
//    {
//        CGRect rect = CGRectMake(0.0f, -offset,width,height);
//        self.view.frame = rect;
//    }
//    [UIView commitAnimations];
    
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
