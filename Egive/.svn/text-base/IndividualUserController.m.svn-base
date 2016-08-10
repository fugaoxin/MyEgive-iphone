//
//  IndividualUserController.m
//  Egive
//
//  Created by sino on 15/7/30.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "Constants.h"
#import "IndividualUserController.h"
#import "UIView+ZJQuickControl.h"
#import "HomeViewController.h"
#import "ShowMenuView.h"
#import "MemberModel.h"
#import "EGDropDownMenu.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "EGUtility.h"
#import "UpdatePwsViewController.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface IndividualUserController ()<UITextViewDelegate,EGDropDownMenuDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIImageView * _iconImage;
    NSString * _ageGroup;
    BOOL _isSelAge;
    BOOL _isSelBelongDown;
    BOOL _isSexBelongDown;
    NSArray * _belongCdArray;
    NSArray * _belongDespArray;
    NSInteger _selectedIndex;
    NSInteger _sexIndex; //性别标记 0－男，1-女。
    NSArray * _ageGroupArray;
    
    NSMutableArray * _belongCd;
    NSMutableArray * _belongDesp;
    
    NSMutableArray * _ageCd;
    NSMutableArray * _ageDesp;
    
    UIView * _volunteerView; //成为义工View
    //NSMutableArray * _arr;
    UITextField * _dateStart;
    UITextField * _dateEnd;
    UIButton * _helpTypeButton;
    NSString * _base64Avatar;
    NSMutableDictionary *Belongdict;
    
    int IndividualViewHeight;
    int scrollHeight;
    int scrollShowHeight;
    int addHeight;
    
    UIView *DeatielAddressView;
    UILabel * addressLabel;
    
    NSArray * ageArr;
    NSArray * sexArr;
    NSArray *regionArray;
    
}
@property (strong, nonatomic) TPKeyboardAvoidingScrollView * scroll;
@property (strong, nonatomic) MemberModel * item;
@property (copy, nonatomic) NSMutableDictionary * shareDict;
@property (strong, nonatomic) UIButton * updateButton;
@property (strong, nonatomic) UIButton * outButton;
@property (strong, nonatomic) UIButton * completeButton;
@property (strong, nonatomic) UIView * bgView;
@property (strong, nonatomic) EGDropDownMenu * downMenu;
@property (strong, nonatomic) EGDropDownMenu * downMenu1;
@property (strong, nonatomic) EGDropDownMenu * sexDownMenu;
@property (strong, nonatomic) UIButton * isEmailButton;
@property (strong, nonatomic) UIButton * noEmailButton;
@property (strong, nonatomic) UIView * emailView;
@property (strong, nonatomic) UIButton * typeButton;
@property (copy, nonatomic) NSMutableArray * arr;
@property (nonatomic) BOOL isEdit;

@property (strong, nonatomic) UIView * view2; //成为义工view
@property (strong, nonatomic) UIButton * shortVolunteer;
@property (strong, nonatomic) UIButton * longVolunteer;
@property (strong, nonatomic) UIButton * orgShortVolunteer;
@property (strong, nonatomic) UIButton * orgLongVolunteer;
@property (strong, nonatomic) UITextField * noteText;
@property (strong, nonatomic) UITextField * noteTimeText;
@property (strong, nonatomic) UIButton * timesButton;
@property (copy, nonatomic) NSMutableArray * volunteerInterestArr;
@property (copy, nonatomic) NSMutableArray * availableTimeArr;
@property (strong, nonatomic) UIButton * yButton; //愿意
@property (strong, nonatomic) UIButton * nButton; //暂不考虑
@property (strong, nonatomic) MemberFormModel * FormModel;
@property (strong, nonatomic) NSMutableDictionary * cdDict;
@property (strong, nonatomic) NSMutableDictionary * ageCdDict; //年龄数据
@property(retain,nonatomic)UIPickerView *regionPickerView;

@end

@implementation IndividualUserController

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    IndividualViewHeight=60;
    scrollHeight=0;
    scrollShowHeight=100;
    addHeight=0;
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
    
   
//    _shareDict = [ShowMenuView getUserInfo];
//    _item = _shareDict[@"LoginName"];
    
    _isEdit = NO;
    _isSelAge = NO;
    _isSelBelongDown = NO;
    _isSexBelongDown = NO;
    _selectedIndex = 0;
    _belongCdArray = @[@"D9558D1C-A134-4959-85AE-0BE067932BA1",
                       @"04841030-EA82-47EC-9CB5-0CE5A52DDF17",
                       @"9AD203B8-5F3D-4712-92EE-3E436CE3E666",
                       @"CB280CFE-8F19-4F4F-AB4D-44AA81FCE0C5",
                       @"7CCFF3FA-B46C-4EF4-887A-54A69EAD9DDC",
                       @"EE55A2D5-F540-4EAF-A906-63ADDE76ED10",
                       @"EAEEB955-B294-4C95-8AC9-79F7661C114D",
                       @"16D9ED76-AE36-4273-BE00-8C24CB72B8E8",
                       @"07B6729B-9685-4EA4-8440-9C6704E3463D",
                       @"989D6361-7997-4051-84BB-C12ABE17D1BC",
                       @"5CD32AA0-E433-4BC9-8854-CB5AD8133DFA",
                       @"7DF9E29A-C14D-4834-A13D-D856A1F5081C",
                       @"Other"];
    _belongDespArray  = @[@"",@"蝦片基金會",@"abcde Limited",@"李意贈基金",@"佛教黃允畋中學",@"紅福涼茶集團",@"saib limited",@"紫色公司",@"炭寶慈善基金",@"corp_eptest",@"其他"];
    [self requestMemberFormData];
    _arr = [[NSMutableArray alloc] init];
    _volunteerInterestArr = [[NSMutableArray alloc] init]; //有关协助之项目数组
    
    regionArray = @[EGLocalizedString(@"Central and Western", nil),EGLocalizedString(@"Eastern", nil),EGLocalizedString(@"Southern", nil),EGLocalizedString(@"Wan Chai", nil),EGLocalizedString(@"Sham Shui Po", nil),EGLocalizedString(@"Kowloon City", nil),EGLocalizedString(@"Kwun Tong", nil),EGLocalizedString(@"Wong Tai Sin", nil),EGLocalizedString(@"Yau Tsim Mong", nil),EGLocalizedString(@"Islands", nil),EGLocalizedString(@"Kwai Tsing", nil),EGLocalizedString(@"North", nil),EGLocalizedString(@"Sai Kung", nil),EGLocalizedString(@"Sha Tin", nil),EGLocalizedString(@"Tai Po", nil),EGLocalizedString(@"Tsuen Wan", nil),EGLocalizedString(@"Tuen Mun", nil),EGLocalizedString(@"Yuen Long", nil)];
    
    [self createFooterButton];
    [self createUI];
    [self createMenuUI];
    
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HiddenregionPickerViewTap)];
     tap.cancelsTouchesInView = NO;
   [self.view addGestureRecognizer:tap];
    
    
}
-(void)HiddenregionPickerViewTap{
  
    _regionPickerView.hidden=YES;
}
-(void)regionPickerViewTap{

  _regionPickerView.hidden = NO;

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
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults objectForKey:@"EGIVE_MEMBER_MODEL"]) {
        NSMutableDictionary *m = [[standardUserDefaults objectForKey:@"EGIVE_MEMBER_MODEL"] mutableCopy];
        
        MemberModel *model = [[MemberModel alloc] init];
        [model setValuesForKeysWithDictionary:m];
        [ShowMenuView sharedInstance].member = model;
        
        NSLog(@"%@",m);
        //        NSMutableDictionary * _dict = [ShowMenuView getUserInfo];
        //        [_dict setObject:model forKey:@"LoginName"];
        _shareDict = m;
        //        _item = _shareDict[@"LoginName"];
        _item = model;
        NSLog(@"%@",_item.ProfilePicURL);
    }
    for (UIView *view in self.view.subviews){
        [view removeFromSuperview];
    }
    _scroll = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0,scrollHeight, ScreenSize.width, ScreenSize.height-scrollShowHeight)];
    _scroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scroll];
    _scroll.tag = 10000;
    _scroll.contentSize = CGSizeMake(0, 670+scrollHeight+addHeight+50);
    UIView * imageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 120)];
    imageView.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1];
    imageView.userInteractionEnabled = YES;
    [_scroll addSubview:imageView];
    
    _iconImage = [imageView addImageViewWithFrame:CGRectMake(20, 20, 90, 90) image:nil];
    _iconImage.layer.cornerRadius = 45;
    _iconImage.layer.masksToBounds = YES;
    _iconImage.userInteractionEnabled = YES;
    
    //判断Documents 中是否存在该图片
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@", [self documentFolderPath],@"test.jpg"]]) {
        ;
      [_iconImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [self documentFolderPath],@"test.jpg"]]];
        _base64Avatar = [UIImagePNGRepresentation([self imageWithImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [self documentFolderPath],@"test.jpg"]] convertToSize:CGSizeMake(128, 128)]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    //判断用户是否存在该头像
    if ([_item.ProfilePicURL isEqualToString:@""] || _item.ProfilePicURL == nil) {
        _iconImage.contentMode = UIViewContentModeScaleAspectFit;
        if ([_item.Sex isEqualToString:@"M"] || [_item.ChiNameTitle isEqualToString:@"R"]) {
            _iconImage.image = [UIImage imageNamed:@"donor_detail_male@2x.png"];
        }else{
            _iconImage.image = [UIImage imageNamed:@"donor_detail_female@2x.png"];
        }
    }else{
        
        NSURL *url = [NSURL URLWithString:SITE_URL];
        url = [url URLByAppendingPathComponent:_item.ProfilePicURL];
       [_iconImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"menu_profile_pic_empty@2x.png"]];
     [_iconImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
        _iconImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    UITapGestureRecognizer * imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageTapAction)];
    [_iconImage addGestureRecognizer:imageTap];
    
    UILabel * donations = [imageView addLabelWithFrame:CGRectMake(ScreenSize.width/2-40, 20, 150, 25) text:EGLocalizedString(@"个人累积捐款", nil)];
    donations.font = [UIFont systemFontOfSize:13];
    donations.textColor = [UIColor grayColor];
    _money = [imageView addLabelWithFrame:CGRectMake(ScreenSize.width/2-40, 45, 150, 25) text:_memberTotalDonationAmount];
    _money.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    _money.font = [UIFont boldSystemFontOfSize:16];
    float width = (ScreenSize.width/2+40)/2-5;
    UIButton * rankingButton = [imageView addImageButtonWithFrame:CGRectMake(ScreenSize.width/2-50, 85, width+20, 35) title:EGLocalizedString(@"查看排名", nil)  backgroud:nil action:^(UIButton *button) {
        
        RankListViewController * vc = [[RankListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    [rankingButton setImage:[UIImage imageNamed:@"account_ranking@2x.png"] forState:UIControlStateNormal];
    [rankingButton setTitleColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1] forState:UIControlStateNormal];
    rankingButton.titleLabel.font = [UIFont systemFontOfSize:12];
    UIButton * recordButton = [imageView addImageButtonWithFrame:CGRectMake(ScreenSize.width/2-30+width, 85, width, 35) title:EGLocalizedString(@"捐款记录", nil)  backgroud:nil action:^(UIButton *button) {
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
    
    UILabel * loginNameLabel = [_scroll addLabelWithFrame:CGRectMake(20, 130,120, 25) text:EGLocalizedString(@"登入名称", nil)];
    loginNameLabel.font = [UIFont systemFontOfSize:13];
    loginNameLabel.textColor = [UIColor grayColor];
    
    UILabel * loginPwsLabel = [_scroll addLabelWithFrame:CGRectMake(ScreenSize.width/2, 130, 120, 25) text:EGLocalizedString(@"登入密码", nil)];
    loginPwsLabel.font = [UIFont systemFontOfSize:13];
    loginPwsLabel.textColor = [UIColor grayColor];
    
    _loginName = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, 120, 25)];
    _loginName.text = _item.LoginName;
    _loginName.delegate = self;
    _loginName.font = [UIFont systemFontOfSize:13];
     [_scroll addSubview:_loginName];

    
    _pws = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2, 152, 120, 25)];
    _pws.text = @"******";
    _pws.delegate = self;
    _pws.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_pws];
    

    __weak typeof(self) weakSelf = self;
    UIButton * updatePwsButton = [_scroll addSystemButtonWithFrame:CGRectMake(ScreenSize.width-100, 150, 80, 20) title:EGLocalizedString(@"修改密码", nil) action:^(UIButton *button) {
        
        
        UpdatePwsViewController * vc = [[UpdatePwsViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    }];
    [updatePwsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [updatePwsButton setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
    
    
//UILabel * pws = [_scroll addLabelWithFrame:CGRectMake(ScreenSize.width/2, 152, 120, 25) text:@"******"];
//pws.font = [UIFont systemFontOfSize:14];
    
    UILabel * chName = [_scroll addLabelWithFrame:CGRectMake(20, 180, 120, 25) text:EGLocalizedString(@"姓名(中)", nil)];
    chName.font = [UIFont systemFontOfSize:13];
    chName.textColor = [UIColor grayColor];
    
    UILabel * enName = [_scroll addLabelWithFrame:CGRectMake(ScreenSize.width/2, 180, 120, 25) text:EGLocalizedString(@"姓名(英)", nil)];
    enName.font = [UIFont systemFontOfSize:13];
    enName.textColor = [UIColor grayColor];

    _chName = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, 120, 25)];
    _chName.delegate = self;
    _chName.text = [NSString stringWithFormat:@"%@%@",_item.ChiLastName,_item.ChiFirstName];
//    _chName.text =[NSString stringWithFormat:@"%@%@",[item.ChiLastName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[item.ChiFirstName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    _chName.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_chName];
    
    _chLastName = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, (ScreenSize.width/2-20)/2-10, 25)];
    _chLastName.delegate = self;
    _chLastName.borderStyle = UITextBorderStyleRoundedRect;
    _chLastName.hidden = YES;
    _chLastName.placeholder = @"姓";
    if ([_item.ChiLastName isEqualToString:@"(null)"]) {
         _chLastName.text = @"";
    }else{
        _chLastName.text = _item.ChiLastName;
    }
    _chLastName.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_chLastName];
    
    
    _chfirstName = [[UITextField alloc] initWithFrame:CGRectMake((ScreenSize.width/2-20)/2+10, 200, (ScreenSize.width/2-20)/2+5, 25)];
    _chfirstName.delegate = self;
    _chfirstName.borderStyle = UITextBorderStyleRoundedRect;
    _chfirstName.hidden = YES;
    _chfirstName.placeholder = @"名";
    if ([_item.ChiFirstName isEqualToString:@"(null)"]){
        _chfirstName.text = @"";
    }else{
        _chfirstName.text = _item.ChiFirstName;
    }
    _chfirstName.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_chfirstName];
    
    _enName = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2, 200, 120, 25)];
    _enName.text = [NSString stringWithFormat:@"%@ %@",_item.EngFirstName,_item.EngLastName];
    _enName.font = [UIFont systemFontOfSize:13];
    _enName.delegate = self;
    [_scroll addSubview:_enName];

    _enLastName = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2, 200, (ScreenSize.width/2-20)/2-10, 25)];
    _enLastName.font = [UIFont systemFontOfSize:13];
    _enLastName.placeholder = @"姓(英)";
    _enLastName.delegate = self;
    if ([_item.EngLastName isEqualToString:@"(null)"]) {
        _enLastName.text = @"";
    }else{
        _enLastName.text = _item.EngLastName;
    }
    _enLastName.borderStyle = UITextBorderStyleRoundedRect;
    _enLastName.hidden = YES;
    [_scroll addSubview:_enLastName];
    
    
    _enfirstName = [[UITextField alloc] initWithFrame:CGRectMake(ScreenSize.width/2+(ScreenSize.width/2-20)/2-10, 200, (ScreenSize.width/2-20)/2+10, 25)];
    _enfirstName.font = [UIFont systemFontOfSize:13];
    _enfirstName.placeholder = @"名(英)";
    if ([_item.EngFirstName isEqualToString:@"(null)"]) {
        _enfirstName.text = @"";
    }else{
        _enfirstName.text = _item.EngFirstName;
    }
    _enfirstName.delegate = self;
    _enfirstName.borderStyle = UITextBorderStyleRoundedRect;
    _enfirstName.hidden = YES;
    [_scroll addSubview:_enfirstName];
    
    UILabel * email = [_scroll addLabelWithFrame:CGRectMake(20, 230,300, 25) text:EGLocalizedString(@"Register_email", nil)];
    email.font = [UIFont systemFontOfSize:13];
    email.textColor = [UIColor grayColor];
    
    _email = [[UITextField alloc] initWithFrame:CGRectMake(20, 250, ScreenSize.width-40, 25)];
    _email.text = _item.Email;
    _email.delegate = self;
    _email.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_email];

    
    UILabel * organizationLabel = [_scroll addLabelWithFrame:CGRectMake(20, 275, 80, 25) text:EGLocalizedString(@"Register_belongto", nil)];
    organizationLabel.font = [UIFont systemFontOfSize:13];
    organizationLabel.textColor = [UIColor grayColor];
    
    _organization = [[UITextField alloc] initWithFrame:CGRectMake(20, 300, ScreenSize.width-40, 25)];
    _organization.delegate = self;
    _organization.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_organization];
    

    [_scroll addImageViewWithFrame:CGRectMake(15, 330, ScreenSize.width-30, 2) image:@"Line@2x.png"];
    
    UILabel * sexLabel = [_scroll addLabelWithFrame:CGRectMake(20, 340, 60, 25) text:EGLocalizedString(@"性别", nil) ];
    sexLabel.font = [UIFont systemFontOfSize:13];
    sexLabel.textColor = [UIColor grayColor];

    _sex = [[UITextField alloc] initWithFrame:CGRectMake(20, 365, 80, 25)];
    _sex.delegate = self;
    if ([_item.Sex isEqualToString:@"M"] || [_item.ChiNameTitle isEqualToString:@"R"]) {
//        if ([EGUtility getAppLang]==3) {
//            _sex.text = @"Mr";
//        }else
//         _sex.text = @"男";
        _sex.text = EGLocalizedString(@"男", nil);
    }else{
//        if ([EGUtility getAppLang]==3) {
//            _sex.text = @"Miss";
//        }else
//         _sex.text = @"女";
        _sex.text = EGLocalizedString(@"女", nil);
    }
    _sex.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_sex];
    
    
    sexArr = @[@[EGLocalizedString(@"男", nil),EGLocalizedString(@"女", nil)]];
    //创建性别下拉列表
    _sexDownMenu = [[EGDropDownMenu alloc] initWithFrame:CGRectMake(21, 366, 78, 23) Array:sexArr selectedColor:[UIColor grayColor]];
    _sexDownMenu.hidden = YES;
    _sexDownMenu.delegate = self;
    [_scroll addSubview:_sexDownMenu];
    
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
    
    UILabel * ageLabel = [_scroll addLabelWithFrame:CGRectMake(20, 395, 100, 25) text:EGLocalizedString(@"年龄组别", nil)];
    ageLabel.font = [UIFont systemFontOfSize:13];
    ageLabel.textColor = [UIColor grayColor];
    
    _ageGroupArray = @[EGLocalizedString(@"Please_Select", nil),@"0 - 10",@"11 - 20",@"21 - 30",@"31 - 40",@"41 - 50",@"51 - 60",@"61 - 70",@"71 - 80",@"81 - 90",@"90+"];
    
    _age = [[UITextField alloc] initWithFrame:CGRectMake(20, 420,120, 25)];
//    if ([_item.AgeGroup isEqualToString:@"(null)"]) {
//        _age.text = @"----";
//    }else{
//        int num = [_item.AgeGroup intValue];
//         _age.text = _ageGroupArray[num+1];
//    }
    _age.delegate = self;
    _age.backgroundColor=[UIColor whiteColor];
    _age.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_age];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(20, 419, 122, 28)];
    _bgView.hidden = YES;
    _bgView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [_scroll addSubview:_bgView];
    ageArr = @[@[EGLocalizedString(@"Please_Select", nil),@"0 - 10",@"11 - 20",@"21 - 30",@"31 - 40",@"41 - 50",@"51 - 60",@"61 - 70",@"71 - 80",@"81 - 90",@"90+"]];
    _downMenu = [[EGDropDownMenu alloc] initWithFrame:CGRectMake(21, 420, 120, 25) Array:ageArr selectedColor:[UIColor grayColor]];
    _downMenu.hidden = YES;
    _downMenu.delegate = self;
    [_scroll addSubview:_downMenu];
    
    UILabel * phoneNumLabel = [_scroll addLabelWithFrame:CGRectMake(20, 455, 100, 25) text:EGLocalizedString(@"Register_org_number", nil)];
    phoneNumLabel.font = [UIFont systemFontOfSize:13];
    phoneNumLabel.textColor = [UIColor grayColor];
    
    _phoneNum = [[UITextField alloc] initWithFrame:CGRectMake(20, 480, 120, 25)];
    _phoneNum.delegate = self;
    _phoneNum.text = [NSString stringWithFormat:@"%@%@",_item.TelCountryCode,_item.TelNo];
    _phoneNum.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_phoneNum];
    

     addressLabel = [_scroll addLabelWithFrame:CGRectMake(20,505, 60, 25) text:EGLocalizedString(@"通讯地址", nil) ];
     addressLabel.font = [UIFont systemFontOfSize:13];
     addressLabel.textColor = [UIColor grayColor];
    
    _address = [[UILabel alloc] initWithFrame:CGRectMake(20, 525, ScreenSize.width-40, 60)];
    _address.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",_item.AddressDistrict,_item.AddressStreet,_item.AddressEstate,_item.AddressBldg,_item.AddressRoom];
    _address.numberOfLines=0;
    _address.userInteractionEnabled = NO;
    _address.font = [UIFont systemFontOfSize:13];
    [_scroll addSubview:_address];

    UILabel * label6 = [_scroll addLabelWithFrame:CGRectMake(20, 510+IndividualViewHeight+15, ScreenSize.width/2+5, 40) text:EGLocalizedString(@"Register_IsEmailNote", nil)];
    label6.numberOfLines = 0;
    label6.font = [UIFont systemFontOfSize:12];

    //是否允许收到电邮资讯按钮 － 是
    int width3 = (ScreenSize.width/2-70)/2;
    _isEmailButton =[_scroll addImageButtonWithFrame:CGRectMake(ScreenSize.width/2+50, 515+IndividualViewHeight+20, width3, 25) title:EGLocalizedString(@"Register_isEmailButton_title", nil) backgroud:@"comment_segment_middle_nor.png" action:^(UIButton *button){
        if (weakSelf.isEdit){
            weakSelf.noEmailButton.selected = NO;
            button.selected = YES;
            weakSelf.emailView.hidden = NO;
            weakSelf.view2.frame = CGRectMake(20, 560+IndividualViewHeight*2+45, ScreenSize.width-40, 880);//义工view位置下移
            //是否也成为义工
            if (weakSelf.yButton.selected){
                
                weakSelf.scroll.contentSize = CGSizeMake(0, 670+IndividualViewHeight+900+addHeight+180);//如果接收电邮，改变scroll高度
            }else{
                weakSelf.scroll.contentSize = CGSizeMake(0, 670+IndividualViewHeight+addHeight+280); //如果接收电邮，改变scroll高度
            }
        }
        
        
    }];
    _isEmailButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_isEmailButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_middle_sel.png"] forState:UIControlStateSelected];
    [_isEmailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_isEmailButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    
    //是否允许收到电邮资讯按钮 － 否
    _noEmailButton = [_scroll addImageButtonWithFrame:CGRectMake(ScreenSize.width/2+50+width3, 515+IndividualViewHeight+20, width3, 25) title:EGLocalizedString(@"Register_noEmailButton_title", nil) backgroud:@"comment_segment_middle_nor.png" action:^(UIButton *button) {
        if (weakSelf.isEdit) {
            weakSelf.isEmailButton.selected = NO;
            button.selected = YES;
            weakSelf.emailView.hidden = YES;
            
            if (weakSelf.yButton.selected){
                
                weakSelf.scroll.contentSize = CGSizeMake(0, 670+900+addHeight+180); //如果不接收电邮，但选择成为义工，改变scroll高度
            }else{
                
                weakSelf.scroll.contentSize = CGSizeMake(0, 670+addHeight+250); //如果不接收电邮，改变scroll高度
                
            }
            weakSelf.view2.frame = CGRectMake(20, 560+IndividualViewHeight, ScreenSize.width-40, 880);//还原义工view位置
        }
        
    }];
    _noEmailButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_noEmailButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_middle_sel.png"] forState:UIControlStateSelected];
    [_noEmailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_noEmailButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    
    [self createEmailView];//创建电邮资讯view

    _view2 = [[UIView alloc] initWithFrame:CGRectMake(20, 560+IndividualViewHeight, ScreenSize.width-40, 880)];
    _view2.backgroundColor = [UIColor whiteColor];
    [_scroll addSubview:_view2];
    
     UILabel * note = [_view2 addLabelWithFrame:CGRectMake(0, 0, ScreenSize.width-35, 40) text:EGLocalizedString(@"Register_noteLabel3_title", nil)];
    note.numberOfLines = 0;
    note.font = [UIFont systemFontOfSize:13];
    
    
    // “愿意”按钮
    _yButton = [_view2 addImageButtonWithFrame:CGRectMake(0, 45, ScreenSize.width/2-20, 20) title:EGLocalizedString(@"Register_yButton_title", nil) backgroud:@"comment_segment_left_nor.png" action:^(UIButton *button){
        if (weakSelf.isEdit) {
            _nButton.selected = NO;
            button.selected = YES;
            _volunteerView.hidden = NO; //显示义工view
            if (weakSelf.isEmailButton.selected) {
                 _scroll.contentSize = CGSizeMake(0, 670+880+IndividualViewHeight+scrollHeight+addHeight+200); //增加scroll高度
            }else{
                _scroll.contentSize = CGSizeMake(0, 670+800+scrollHeight+addHeight+200); //增加scroll高度
            }
            
        }
        
    } ];
    _yButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _yButton.layer.cornerRadius = 4;
    [_yButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_left_sel.png"] forState:UIControlStateSelected];
    [_yButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_yButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    
    //”暂不考虑“按钮
    _nButton = [_view2 addImageButtonWithFrame:CGRectMake(ScreenSize.width/2-20, 45, ScreenSize.width/2-20, 20) title:EGLocalizedString(@"Register_nButton_title", nil) backgroud:@"comment_segment_right_nor.png" action:^(UIButton *button) {
     
        if (weakSelf.isEdit) {
            _yButton.selected = NO;
            button.selected = YES;
             _volunteerView.hidden = YES; //隐藏义工view
            if (weakSelf.isEmailButton.selected) {
                _scroll.contentSize = CGSizeMake(0, 670+IndividualViewHeight+scrollHeight+addHeight+200); //还原scroll高度
            }else{
                _scroll.contentSize = CGSizeMake(0, 670+scrollHeight+addHeight+20+200); //还原scroll高度
            }
            
        }

    }];
    _nButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _nButton.layer.cornerRadius = 4;
    [_nButton setBackgroundImage:[UIImage imageNamed:@"comment_segment_right_sel.png"] forState:UIControlStateSelected];
    [_nButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_nButton setTitleColor:[UIColor colorWithRed:110/255.0 green:185/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    
    [self createVoView]; //创建义工view

    //判断用户之前是否接收电邮
    if (_item.AcceptEDM){
        _isEmailButton.selected = YES;
        weakSelf.emailView.hidden = NO;
         weakSelf.view2.frame = CGRectMake(20, 560+IndividualViewHeight*2+150, ScreenSize.width-40, 880);//义工view位置下调
        _scroll.contentSize =  CGSizeMake(0, 670+IndividualViewHeight+1000+addHeight); //增加scroll高度
        
    }else{
        _noEmailButton.selected = YES;
    }
    
      //判断用户之前是否成为义工
    if (_item.JoinVolunteer) {
        _yButton.selected = YES;
        _volunteerView.hidden = NO; //显示义工view
        //如果也接收电邮
        if (_item.AcceptEDM) {
            _scroll.contentSize = CGSizeMake(0, 670+IndividualViewHeight+1000+scrollHeight+addHeight); //增加scroll高度
            weakSelf.view2.frame = CGRectMake(20, 560+IndividualViewHeight*2+150+addHeight, ScreenSize.width-40, 880);
        }else{
            
            _scroll.contentSize = CGSizeMake(0, 670+800+scrollHeight+addHeight+160); //增加scroll高度
            
        }
    }else{
        _nButton.selected = YES;
    }
    
    
    _updateButton = [self.view addSystemButtonWithFrame:CGRectMake(20, ScreenSize.height-80, ScreenSize.width/2-22, 25) title:EGLocalizedString(@"修改", nil) action:^(UIButton *button) {
        
    
        [weakSelf updateUserInfo];
        
    }];
    [_updateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_updateButton setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];

    _outButton = [self.view addSystemButtonWithFrame:CGRectMake(ScreenSize.width/2+2, ScreenSize.height-80, ScreenSize.width/2-20, 25) title:EGLocalizedString(@"登出", nil)  action:^(UIButton *button) {
        
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
    }];
    [_outButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_outButton setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
    
    _completeButton = [self.view addSystemButtonWithFrame:CGRectMake(20, ScreenSize.height-80, ScreenSize.width-40, 25) title:EGLocalizedString(@"完成", nil) action:^(UIButton *button) {
         if (weakSelf.isEmailButton.selected) {
             if (_arr.count > 0 || _item.DonationInterest != nil){
                [weakSelf PostIndividualUserInfo];
             }else{
                 UIAlertView *alertView = [[UIAlertView alloc] init];
                 alertView.message = EGLocalizedString(@"請選取專案類別", nil);
                 [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                 [alertView show];
             }
         }else{
             if (true) {
                 [weakSelf PostIndividualUserInfo];
             }else{
                 UIAlertView *alertView = [[UIAlertView alloc] init];
                 alertView.message = EGLocalizedString(@"性别错误", nil);
                 [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                 [alertView show];
             }

          
         }
        
    }];
    _completeButton.hidden = YES;
    [_completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_completeButton setBackgroundColor:[UIColor colorWithRed:98/255.0 green:185/255.0 blue:63/255.0 alpha:1]];
    
    
}
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
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
                NSLog(@"Album is not available.");
            }
        }
        @catch (NSException *exception) {
            //Error
            NSLog(@"Album is not available.");
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
                NSLog(@"Camera is not available.");
            }
        }
        @catch (NSException *exception) {
            NSLog(@"Camera is not available.");
        }
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"Image Picker Controller canceled.");
    //Cancel以后将ImagePicker删除
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"Image Picker Controller did finish picking media.");
    //TODO:选择照片或者照相完成以后的处理

    /*
     NSLog(@"info = %@",info);
     info = {
     UIImagePickerControllerMediaType = "public.image";
     UIImagePickerControllerOriginalImage = "<UIImage: 0x8f95470>";
     UIImagePickerControllerReferenceURL = "assets-library://asset/asset.PNG?id=9126D6F5-CC10-49DA-B7C9-E4553924FA71&ext=PNG";
     }
     */
    _iconImage.image = info[UIImagePickerControllerOriginalImage];
   
    NSLog(@"UIImagePickerControllerMediaURL-------------%@",info[UIImagePickerControllerReferenceURL]);
    _base64Avatar = [UIImagePNGRepresentation([self imageWithImage:_iconImage.image convertToSize:CGSizeMake(128, 128)]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    UIImage *image = [self fixOrientation:info[UIImagePickerControllerOriginalImage]];
    [self saveImage:image WithName:@"test.jpg"];
    [self updateIcon];
    [self dismissViewControllerAnimated:NO completion:nil];
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

#pragma mark 从文档目录下获取Documents路径
- (NSString *)documentFolderPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}
#pragma mark - 电邮资讯View
- (void)createEmailView{
    //创建点击“是”按钮弹出的视图
    _emailView = [[UIView alloc] initWithFrame:CGRectMake(20, 545+IndividualViewHeight+20, ScreenSize.width-40, 200)];
    _emailView.backgroundColor = [UIColor whiteColor];
    _emailView.hidden = YES;
    [_scroll addSubview:_emailView];
    
    UILabel * emailViewTitle = [_emailView addLabelWithFrame:CGRectMake(0, 0, 300, 40) text:EGLocalizedString(@"请选取你喜欢的专案类别(可选择多项):", nil)];
    emailViewTitle.numberOfLines=0;
    emailViewTitle.font = [UIFont systemFontOfSize:12];
    emailViewTitle.textColor = [UIColor grayColor];
    
    __weak typeof(self) weakSelf = self;
 
    NSArray * emailViewTitleArray = @[EGLocalizedString(@"助学", nil),EGLocalizedString(@"安老", nil),EGLocalizedString(@"助医", nil),EGLocalizedString(@"扶贫", nil),EGLocalizedString(@"紧急援助", nil),EGLocalizedString(@"其他", nil),EGLocalizedString(@"意赠行动", nil),EGLocalizedString(@"全部", nil)];
    
    NSArray * DonationInterestArr = @[@"S",@"E",@"M",@"P",@"U",@"O",@"A",@"L"];
    
    for (int i = 0; i < 8; i ++) {
        _typeButton = [_emailView addImageButtonWithFrame:CGRectMake(i%2*(ScreenSize.width/2), i/2*45+40, 20, 20) title:nil backgroud:@"cart_checkbox_nor.png" action:^(UIButton *button) {
            
            if (weakSelf.isEdit) {
                if (button.tag == 110) {
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr removeObject:@"S,"];
                        
                    }else{
                        button.selected = YES;
                        [weakSelf.arr addObject:@"S,"];
                    }
                }else if (button.tag == 111){
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr removeObject:@"E,"];
                    }else{
                        button.selected = YES;
                        [weakSelf.arr addObject:@"E,"];
                    }
                    
                }else if (button.tag == 112){
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr removeObject:@"M,"];
                    }else{
                        button.selected = YES;
                        [weakSelf.arr addObject:@"M,"];
                    }
                    
                }else if (button.tag == 113){
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr removeObject:@"P,"];
                    }else{
                        button.selected = YES;
                        [weakSelf.arr addObject:@"P,"];
                    }
                    
                }else if (button.tag == 114){
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr removeObject:@"U,"];
                    }else{
                        button.selected = YES;
                        [weakSelf.arr addObject:@"U,"];
                    }
                    
                }else if (button.tag == 115){
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr removeObject:@"O,"];
                    }else{
                        
                        button.selected = YES;
                        [weakSelf.arr addObject:@"O,"];
                    }
                    
                    
                }else if (button.tag == 116){
                    if (button.selected) {
                        button.selected = NO;
                        [weakSelf.arr removeObject:@"A,"];
                    }else{
                        button.selected = YES;
                        [weakSelf.arr addObject:@"A,"];
                    }
                    
                }else if (button.tag == 117){
                    
                    if (button.selected) {
                        for (int i = 0; i < 8; i ++) {
                            UIButton * button = (UIButton *)[weakSelf.view viewWithTag:110+i];
                            button.selected = NO;
                        }
                        [weakSelf.arr removeObject:@"L,"];
                    }else{
                        for (int i = 0; i < 8; i ++) {
                            UIButton * button = (UIButton *)[weakSelf.view viewWithTag:110+i];
                            button.selected = YES;
                        }
                        [weakSelf.arr addObject:@"L,"];
                    }
                }
            }
        }];
        _typeButton.tag = 110+i;
        [_typeButton setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
        
        UILabel * label = [_emailView addLabelWithFrame:CGRectMake(i%2*(ScreenSize.width/2)+25, i/2*45+40, 100, 20) text:emailViewTitleArray[i]];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:12];
        //判断是否包含全部，如果包含全部则全部选中
        if ([_item.DonationInterest rangeOfString:@"L"].location !=NSNotFound) {
            for (int i = 0; i < 8; i ++) {
                UIButton * button = (UIButton *)[weakSelf.view viewWithTag:110+i];
                button.selected = YES;
            }
        }else{
            if([_item.DonationInterest rangeOfString:DonationInterestArr[i]].location !=NSNotFound)
            {
                _typeButton.selected = YES;
            }
        }
    }
}

#pragma mark - 个人登记的义工选项视图
- (void)createVoView{
    _volunteerView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, ScreenSize.width-40, 800)];
    _volunteerView.hidden = YES;
    [_view2 addSubview:_volunteerView];
    
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
        if([_item.VolunteerInterest rangeOfString:VolunteerInterestArr[i]].location !=NSNotFound)
        {
            _helpTypeButton.selected = YES;
        }
        if (i==8 && _item.VolunteerInterest_Other != NULL && ![_item.VolunteerInterest_Other isEqualToString:@""]) {
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
        if (_item.VolunteerInterest_Other != NULL && ![_item.VolunteerInterest_Other isEqualToString:@""]) {
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
        if (i==12 && (![_item.AvailableTime_Other isEqualToString:@""] && _item.AvailableTime_Other != NULL)) {
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
        if (_item.AvailableTime_Other != NULL && ![_item.AvailableTime_Other isEqualToString:@""]) {
            _noteTimeText.text = _item.AvailableTime_Other;
        }
    }
}

- (void)updateUserInfo{
    IndividualViewHeight=160;
    scrollHeight=64;
    scrollShowHeight=170;
    addHeight=0;
    [self createUI];
    addressLabel.hidden=YES;
    DeatielAddressView = [[[NSBundle mainBundle] loadNibNamed:@"IndividualView" owner:self options:nil] objectAtIndex:0];
    DeatielAddressView.userInteractionEnabled=YES;
    DeatielAddressView.frame = CGRectMake(0, 515, ScreenSize.width, IndividualViewHeight);
    [self.scroll addSubview:DeatielAddressView];
    //初始化_regionPickerView
    _regionPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, ScreenSize.height - 200 + ((IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) ? 20 : 0), ScreenSize.width , 200)];
    _regionPickerView.delegate = self;
    _regionPickerView.showsSelectionIndicator = YES;
    _regionPickerView.hidden = YES;
    _regionPickerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_regionPickerView];
    NSArray *array = [_belongDesp copy];
    NSLog(@"array=%@",array);
    NSLog(@"%ld",array.count);
    NSArray * orgArr = @[array];
    _downMenu1 = [[EGDropDownMenu alloc] initWithFrame:CGRectMake(21, 301, ScreenSize.width-42, 23) Array:orgArr selectedColor:[UIColor grayColor]];
    _downMenu1.hidden = YES;
    _downMenu1.delegate = self;
    [_scroll addSubview:_downMenu1];
    //语言设置
    self.addressDistrict.placeholder = EGLocalizedString(@"Register_org_region1", nil);
    self.addressBldg.placeholder = EGLocalizedString(@"Register_org_region2", nil);
    self.addressEstate.placeholder = EGLocalizedString(@"Register_org_region3", nil);
    self.addressStreet.placeholder = EGLocalizedString(@"Register_org_region4", nil);
    self.RegionTitleTextfield.placeholder = EGLocalizedString(@"Register_org_selRegion", nil);
    self.addressTitleLabel.text = EGLocalizedString(@"通讯地址", nil);
    //显示详细地址
    _region.enabled=NO;
    _addressDistrict.text = _item.AddressRoom;
    _addressBldg.text = _item.AddressBldg;
    _addressEstate.text = _item.AddressEstate;
    _addressStreet.text = _item.AddressStreet;
    _region.text = _item.AddressDistrict;
     self.RegionTitleTextfield.enabled=NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(regionPickerViewTap)];
    self.RegionLabel.userInteractionEnabled = YES;
    [self.RegionLabel addGestureRecognizer:tap];

    _isEdit = YES;
    _chName.hidden = YES;
    _chLastName.hidden = NO;
    _chfirstName.hidden = NO;
    _enName.hidden = YES;
    _enLastName.hidden = NO;
    _enfirstName.hidden = NO;
//    _pws.borderStyle = UITextBorderStyleRoundedRect;
    _email.borderStyle = UITextBorderStyleRoundedRect;
    _organization.borderStyle = UITextBorderStyleRoundedRect;
    _age.borderStyle = UITextBorderStyleRoundedRect;
    _sex.borderStyle = UITextBorderStyleRoundedRect;
//    _age.hidden = YES;
    _address.userInteractionEnabled = YES;
    _address.layer.borderWidth = 0.5;
    _address.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _address.layer.cornerRadius = 3;
    _bgView.hidden = NO;
   // _address.borderStyle = UITextBorderStyleRoundedRect;
    _phoneNum.borderStyle = UITextBorderStyleRoundedRect;
    _completeButton.hidden = NO;
    _updateButton.hidden = YES;
    _outButton.hidden = YES;
    _downMenu.hidden = NO;
    _downMenu1.hidden = NO;
    _sexDownMenu.hidden = NO;
//    _organization.text = _item.BelongTo;
//    [_downMenu setItemName:_age AtIndex:0];
    //[_downMenu1 setItemName: _organization.text AtIndex:0];
      //[_downMenu setItemName:_age.text AtIndex:0];
    
    
    NSArray *sexArr = @[EGLocalizedString(@"男", nil),EGLocalizedString(@"女", nil)];
    NSInteger *sexNumber = [sexArr indexOfObject:_sex.text];
    [_sexDownMenu setSelectedRow:sexNumber];
    
    //NSInteger *AgeNumber = [_ageDesp indexOfObject:_age.text];
    int num = ([_item.AgeGroup intValue] +1);
    [_downMenu setSelectedRow:num];
    
   NSInteger *number = [_belongCd indexOfObject:[_item.BelongTo uppercaseString]];
    NSLog(@"%@",_belongDesp);
    NSLog(@"number=%ld",number);
    _selectedIndex = number;
    [_downMenu1 setSelectedRow:number];
    
}
- (void)completeUserInfo {
    
    IndividualViewHeight=60;
    addHeight=0;
    _isEdit = NO;
    _chName.hidden = NO;
    _chLastName.hidden = YES;
    _chfirstName.hidden = YES;
    _enName.hidden = NO;
    _enLastName.hidden = YES;
    _enfirstName.hidden = YES;
    _pws.borderStyle = UITextBorderStyleNone;
    _email.borderStyle = UITextBorderStyleNone;
    _organization.borderStyle = UITextBorderStyleNone;
    _age.borderStyle = UITextBorderStyleNone;
    _downMenu1.hidden = YES;
    _sex.borderStyle = UITextBorderStyleNone;
//    _age.hidden = NO;
    _address.userInteractionEnabled = NO;
    _address.layer.borderWidth = 0;
    _address.layer.borderColor = [UIColor whiteColor].CGColor;
    _address.layer.cornerRadius = 0;
    _bgView.hidden = YES;
    _downMenu.hidden = YES;
    _sexDownMenu.hidden = YES;
    //_address.borderStyle = UITextBorderStyleNone;
    _phoneNum.borderStyle = UITextBorderStyleNone;
    _completeButton.hidden = YES;
    _updateButton.hidden = NO;
    _outButton.hidden = NO;
}

#pragma mark filter - 下拉列表代理方法
- (void)dropDownMenu:(EGDropDownMenu *)dropDownMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dropDownMenu == _downMenu) {
        
        _isSelAge = YES;
        if (indexPath.row != 0) {
            
            _ageGroup = [NSString stringWithFormat:@"%d",indexPath.row-1];
            
        }else{
            
            _ageGroup = _item.AgeGroup;
            
          }
    
    }else if (dropDownMenu == _sexDownMenu){
    
        _isSexBelongDown = YES;
        _sexIndex = indexPath.row;
        
    }else{
        _isSelBelongDown = YES;
        
        _selectedIndex = indexPath.row;
       
        _organization.text = _belongDesp[_selectedIndex];

    }
  
    
}

#pragma mark - UITextView Delegate Methods

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {//控制键盘，不给回车，回车当确定
        
        [textView resignFirstResponder];
        
        return NO; 
        
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (_isEdit == NO) {
        return NO;
    }else{
        if (textField == _loginName || textField == _pws ||textField == _organization) {
            return NO;
        }
       return YES;
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _pws) {
        if ([textField.text isEqualToString:@""]) {
            textField.text = @"******";
        }else
        textField.text = _pws.text;
    }
}

#pragma mark - 修改用户信息请求
- (void)PostIndividualUserInfo {
    
    _organization.text = [_belongDesp[_selectedIndex] lowercaseString];
    if ([NSString isEmail:_email.text] && ![NSString isEmpty:_organization.text andNote:@"请输入所属机构"]) {
            MemberModel * model = [[MemberModel alloc] init];
            model.MemberType = @"P";
            model.Position = @"";
            model.TelNo = _phoneNum.text;
            model.TelCountryCode = @"";
            model.password = _pws.text;
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

    
            if (_isSexBelongDown) {
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
            
            model.Email = _email.text;
        
            if (_isSelAge == NO){
                
                model.AgeGroup = _item.AgeGroup;
                
            }else{
                
                model.AgeGroup = _ageGroup;
                
            }
            
            if (_isSelBelongDown == NO) {
                NSLog(@"BelongTo-------%@",_cdDict[_item.BelongTo]);
                model.BelongTo = [_item.BelongTo lowercaseString];
                
            }else{
                
                  model.BelongTo = [_belongCd[_selectedIndex] lowercaseString];
                  NSLog(@"model.BelongTo----->%@",model.BelongTo);
            }
            //是否收到电邮资讯
            if (_isEmailButton.selected == YES) {
                model.AcceptEDM = YES;
            }else{
                model.AcceptEDM = NO;
            }
            //是否成为义工
            if (_yButton.selected == YES) {
                model.JoinVolunteer = YES;
                if (_shortVolunteer.selected) {
                    model.VolunteerType = @"L";
                }else{
                    model.VolunteerType = @"S";
                    model.VolunteerStartDate = _dateStart.text;
                    model.VolunteerEndDate = _dateEnd.text;
                }
                NSMutableString * muStr = [[NSMutableString alloc] init];
                for (int i = 0; i < _volunteerInterestArr.count; i ++) {
                    [muStr appendString:_volunteerInterestArr[i]];
                }
                if (_volunteerInterestArr.count > 0){
                    model.VolunteerInterest = muStr;
                    NSLog(@"model.VolunteerInterest==%@",model.VolunteerInterest);
                }else{
                    model.VolunteerInterest = _item.VolunteerInterest;
                }
                
                NSMutableString * muStr1 = [[NSMutableString alloc] init];
                for (int i = 0; i < _availableTimeArr.count; i ++) {
                    [muStr1 appendString:_availableTimeArr[i]];
                }
                if (_availableTimeArr.count > 0) {
                    model.AvailableTime = muStr1;
                    NSLog(@"model.AvailableTi===%@",model.AvailableTime);
                }else{
                    model.AvailableTime = _item.AvailableTime;
                }
                
            }else{
                model.JoinVolunteer = NO;
                model.VolunteerType = @" ";
            }
        
            //电邮资讯
            NSMutableString * muStr = [[NSMutableString alloc] init];
            for (int i = 0; i < _arr.count; i ++) {
                [muStr appendString:_arr[i]];
            }
            if (_arr.count > 0) {
                model.DonationInterest = muStr;
            }else{
                model.DonationInterest = _item.DonationInterest;
            }
            UIButton * volunteerButton = (UIButton *)[self.view viewWithTag:128];
            if (volunteerButton.selected) {
                   model.VolunteerInterest_Other = _noteText.text;
            }else{
                   model.VolunteerInterest_Other = @" ";
            }
        
            UIButton * availableTimeButton = (UIButton *)[self.view viewWithTag:142];
            if (availableTimeButton.selected) {
                model.AvailableTime_Other = _noteTimeText.text;
            }else{
                model.AvailableTime_Other = @" ";
            }
            model.AppToken = @" ";
            [self SaveMemberInfo:model];
    }
}

- (void)SaveMemberInfo:(MemberModel *)model{
    [self showLoadingAlert];
    
    NSLog(@"%@",model.MemberID);
    NSLog(@"VolunteerInterest --------------- %@",model.EngLastName);
    NSLog(@"AvailableTime --------------- %@",model.EngFirstName);
    NSLog(@"ProfilePicBase64String----- %@",_base64Avatar);
    NSLog(@"BelongTo----- %@",model.BelongTo);
    if (_base64Avatar == nil) {
        _base64Avatar = @"";
        if (_iconImage != nil) {
            _base64Avatar = [UIImagePNGRepresentation([self imageWithImage:[_iconImage image] convertToSize:CGSizeMake(128, 128)]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            NSLog(@"ProfilePicBase64String----- %@",_base64Avatar);
        }
    }
    NSLog(@"ProfilePicBase64String************** %@",_base64Avatar);
    NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <SaveMemberInfo xmlns=\"egive.appservices\"><MemberID>%@</MemberID><MemberType>%@</MemberType><CorporationType>%@</CorporationType><CorporationType_Other>%@</CorporationType_Other><LoginName></LoginName><Password></Password><ConfirmPassword></ConfirmPassword><ProfilePicBase64String>%@</ProfilePicBase64String><CorporationChiName>%@</CorporationChiName><CorporationEngName>%@</CorporationEngName><BusinessRegistrationType>%@</BusinessRegistrationType><BusinessRegistrationNo>%@</BusinessRegistrationNo><ChiNameTitle>%@</ChiNameTitle><ChiLastName>%@</ChiLastName><ChiFirstName>%@</ChiFirstName><EngNameTitle>%@</EngNameTitle><EngLastName>%@</EngLastName><EngFirstName>%@</EngFirstName><Sex>%@</Sex><AgeGroup>%@</AgeGroup><Email>%@</Email><TelCountryCode>%@</TelCountryCode><TelNo>%@</TelNo><AddressRoom>%@</AddressRoom><AddressBldg>%@</AddressBldg><AddressEstate>%@</AddressEstate><AddressStreet>%@</AddressStreet><AddressDistrict>%@</AddressDistrict><AddressCountry>%@</AddressCountry><EducationLevel></EducationLevel><Position>%@</Position><BelongTo>%@</BelongTo><HowToKnoweGive></HowToKnoweGive><HowToKnoweGive_Other></HowToKnoweGive_Other><AcceptEDM>%d</AcceptEDM><DonationInterest>%@</DonationInterest><JoinVolunteer>%d</JoinVolunteer><VolunteerType>%@</VolunteerType><VolunteerStartDate>%@</VolunteerStartDate><VolunteerEndDate>%@</VolunteerEndDate><VolunteerInterest>%@</VolunteerInterest><VolunteerInterest_Other>%@</VolunteerInterest_Other><AvailableTime>%@</AvailableTime><AvailableTime_Other>%@</AvailableTime_Other><AppToken>%@</AppToken><FaceBookID>%@</FaceBookID><WeiboID>%@</WeiboID></SaveMemberInfo></soap:Body></soap:Envelope>",_item.MemberID,model.MemberType,model.CorporationType,model.CorporationType_Other,_base64Avatar,model.CorporationChiName,model.CorporationEngName,model.BusinessRegistrationType,model.BusinessRegistrationNo,model.ChiNameTitle,model.ChiLastName,model.ChiFirstName,model.EngNameTitle,model.EngLastName,model.EngFirstName,model.Sex,model.AgeGroup,model.Email,model.TelCountryCode,model.TelNo,model.AddressRoom,model.AddressBldg,model.AddressEstate,model.AddressStreet,model.AddressDistrict,_item.AddressCountry,model.Position,model.BelongTo,model.AcceptEDM,model.DonationInterest,model.JoinVolunteer,model.VolunteerType,model.VolunteerStartDate,model.VolunteerEndDate,model.VolunteerInterest,model.VolunteerInterest_Other,model.AvailableTime,model.AvailableTime_Other,model.AppToken,model.faceBookID,model.weiboID];
    
    NSLog(@"soapMessage ======= %@",soapMessage);
    
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
        //        NSLog(@"%@", operation.request.allHTTPHeaderFields);
        //
        //        // 服务器给我们返回的包得头部信息
        //        NSLog(@"%@", operation.response);
        [self removeLoadingAlert];
        [self completeUserInfo];
        [DeatielAddressView removeFromSuperview];
        NSString * dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary * dict = [NSString parseJSONStringToNSDictionary:dataString];
        NSUInteger l = [[NSString captureData:dataString] length];
        NSRange range = {1,l-2};
        NSString * str = [NSString stringWithFormat:@"%@",[NSString captureData:dataString]];
        NSString * registerResult = [str substringWithRange:range];
        NSLog(@"-----------------%@",registerResult);
        
        if (dict != nil) {

//            if ([_ageGroup isEqualToString:@"未选择"]) {
//                if ([model.AgeGroup isEqualToString:@"(null)"]) {
//                    _age.text = @"----";
//                }
//            }else{
//                int num = [model.AgeGroup intValue];
//                _age.text = _ageGroupArray[num];
//            }
//            int num = [model.AgeGroup intValue];
//              NSLog(@"%D",num);
////            NSString * num1=0;
////           num1 = [NSString stringWithFormat:@"%d",num];
//            NSArray *ageArr2 = @[EGLocalizedString(@"Please_Select", nil),@"0 - 10",@"11 - 20",@"21 - 30",@"31 - 40",@"41 - 50",@"51 - 60",@"61 - 70",@"71 - 80",@"81 - 90",@"90+"];
//            _age.text = ageArr2[num];
            
            
            
            if (_selectedIndex == 0){
                if ([_item.BelongTo isEqualToString:@"(null)"]){
                    _organization.text = @"";
                }else{
                
                    _organization.text = _belongDesp[0];
                
                }
                
            }else{
                
                 _organization.text = _belongDesp[_selectedIndex];
                
              }
            _chName.text = [NSString stringWithFormat:@"%@%@",model.ChiLastName,model.ChiFirstName];
            _phoneNum.text = [NSString stringWithFormat:@"%@%@",model.TelCountryCode,model.TelNo];
//            //判断Documents 中是否存在该图片
//            if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@", [self documentFolderPath],@"test.jpg"]]) {
//                ;
//                [_iconImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [self documentFolderPath],@"test.jpg"]]];
//                _base64Avatar = [UIImagePNGRepresentation([self imageWithImage:_iconImage.image convertToSize:CGSizeMake(128, 128)]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//                //         [_iconImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [self documentFolderPath],@"test.jpg"]]];
//            }else{
//                
//                if ([model.Sex isEqualToString:@"M"] || [model.ChiNameTitle isEqualToString:@"R"]) {
//                    _iconImage.image = [UIImage imageNamed:@"donor_detail_male@2x.png"];
//                }else{
//                    _iconImage.image = [UIImage imageNamed:@"donor_detail_female@2x.png"];
//                }
//            }

            registerResult = dict[@"MemberID"];
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.delegate = self;
            alertView.message = EGLocalizedString(@"修改成功!", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            [self GetMemberInfo:_item.MemberID];
            
        }else{
            
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"TelePhoneNumber", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        NSLog(@"%@", operation.request.allHTTPHeaderFields);
        // 服务器给我们返回的包得头部信息
        NSLog(@"%@", operation.response);
        // 返回的数据
        NSLog(@"success = %@", error);
        
        [self removeLoadingAlert];
    }];
    
        [operation start];
    
}


- (void)GetMemberInfo:(NSString *)memberId {
    
    NSLog(@"<<<<<<<<<<<<<<<<<<<%@",memberId);
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
  
        
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSArray * arr = [NSString parseJSONStringToNSArray:dataString];
        NSLog(@"arr=%@",arr);
        for (NSDictionary * dict in arr) {

            MemberModel * model = [[MemberModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
            [standardUserDefaults setObject:dict forKey:@"EGIVE_MEMBER_MODEL"];
            [standardUserDefaults synchronize];
            
            if ([model.ProfilePicURL isEqualToString:@""] || model.ProfilePicURL == nil) {
                     _iconImage.image = [UIImage imageNamed:@"menu_profile_pic_empty@2x.png"];
                if ([model.Sex isEqualToString:@"M"] || [model.ChiNameTitle isEqualToString:@"R"]) {
                    _iconImage.image = [UIImage imageNamed:@"donor_detail_male@2x.png"];
            
                }else{
                    _iconImage.image = [UIImage imageNamed:@"donor_detail_female@2x.png"];
                    _iconImage.contentMode = UIViewContentModeScaleAspectFit;
                }
            }else{
                
                NSURL *url = [NSURL URLWithString:@"http://www.egiveforyou.com"];
                url = [url URLByAppendingPathComponent:model.ProfilePicURL];
                [_iconImage sd_setImageWithURL:url placeholderImage:_iconImage.image];
            }
            [_shareDict setObject:model forKey:@"LoginName"];
            [ShowMenuView sharedInstance].member = model;
            [self updateIcon];

        }
        [self requestMemberFormData];
        [self createUI];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _pws) {
        textField.text = @"";
    }
    
//    CGRect frame = textField.frame;
//    //    NSLog(@"frame.origin.y = %f [_serverArr count] = %lu", frame.origin.y, (unsigned long)[_serverArr count]);
//    //int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
//    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216;
//    
//    NSTimeInterval animationDuration = 0.30f;
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

#pragma mark - 请求表格数据
-(void)requestMemberFormData{
    
    NSInteger lang = [EGUtility getAppLang];
    
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
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //                // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        //                NSLog(@"%@", operation.request.allHTTPHeaderFields);
        //                // 服务器给我们返回的包得头部信息
        //                        NSLog(@"%@", operation.response);
        //               // 返回的数据
        //                NSLog(@"success = %@",responseObject);
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary * dict = [NSString parseJSONStringToNSDictionary:dataString];
                NSLog(@"%@",dataString);
        
//        NSUserDefaults *standardUserDefaults1 = [NSUserDefaults standardUserDefaults];
//        if ([standardUserDefaults1 objectForKey:@"MemberForm"]) {
//            NSLog(@"%@",[standardUserDefaults1 objectForKey:@"MemberForm"]);
//            _FormModel = [[MemberFormModel alloc] init];
//            [_FormModel setValuesForKeysWithDictionary:[standardUserDefaults1 objectForKey:@"MemberForm"]];
//        }
        
        _FormModel = [[MemberFormModel alloc] init];
        [_FormModel setValuesForKeysWithDictionary:dict];
        
        NSArray * options = _FormModel.BelongToOptions[@"options"];
        NSArray * ageOptions = _FormModel.AgeGroupOptions[@"options"];
        
        NSLog(@"optionsoptionsoptions = %@", options);
        
        _belongDesp = [[NSMutableArray alloc] init];
        _belongCd = [[NSMutableArray alloc] init];
        
        _ageCd = [[NSMutableArray alloc] init];
        _ageDesp = [[NSMutableArray alloc] init];
        
        //获取年龄组数据
        _ageCdDict = [[NSMutableDictionary alloc] init];
        for (NSDictionary * opDict in ageOptions) {
            [_ageDesp addObject:opDict[@"Desp"]];
            [_ageCd addObject:opDict[@"Cd"]];
                
            [_ageCdDict setObject:opDict[@"Desp"] forKey:opDict[@"Cd"]];
            
        }
        
        NSLog(@"%@",_ageDesp);
        
        if ([_item.AgeGroup isEqualToString:@""]) {
            _age.text = @"----";
        }else{
//            int num = [_item.AgeGroup intValue];
//            NSLog(@"%@",_item.AgeGroup);
//            _age.text = [NSString stringWithFormat:@"%@",_ageCdDict[_item.AgeGroup]];
            
           NSArray *ageArr3 = @[EGLocalizedString(@"Please_Select", nil),@"0 - 10",@"11 - 20",@"21 - 30",@"31 - 40",@"41 - 50",@"51 - 60",@"61 - 70",@"71 - 80",@"81 - 90",@"90+"];
            int num = [_item.AgeGroup intValue];
            _age.text = ageArr3[num+1];
       
        }
        
//        //年龄下拉列表
//        NSArray *ageArray = [_ageDesp copy];
//       NSArray * ageArr = @[ageArray];
//        _downMenu = [[EGDropDownMenu alloc] initWithFrame:CGRectMake(21, 420, 120, 26) Array:ageArr selectedColor:[UIColor grayColor]];
//        _downMenu.hidden = YES;
//        _downMenu.delegate = self;
//        [_scroll addSubview:_downMenu];
        
        //获取所属机构数据
        _cdDict = [[NSMutableDictionary alloc] init];
        Belongdict =[[NSMutableDictionary alloc] init];
        for (NSDictionary * opDict in options) {
            
            [_belongDesp addObject:opDict[@"Desp"]];
            [_belongCd addObject:opDict[@"Cd"]];
            [_cdDict setObject:opDict[@"Cd"] forKey:opDict[@"Desp"]];
            [Belongdict setObject:opDict[@"Desp"] forKey:opDict[@"Cd"]];
        }
        //初始化BelongTo
        NSString *BelongString = [Belongdict objectForKey:_item.BelongTo];
        NSLog(@"BelongString=%@",BelongString);
        _organization.text = BelongString;
        
        NSArray *array = [_belongDesp copy];
        NSLog(@"array=%@",array);
        NSLog(@"%ld",array.count);
        NSArray * orgArr = @[array];
        //创建所属机构下拉列表
        _downMenu1 = [[EGDropDownMenu alloc] initWithFrame:CGRectMake(21, 301, ScreenSize.width-42, 23) Array:orgArr selectedColor:[UIColor grayColor]];
        _downMenu1.hidden = YES;
        _downMenu1.delegate = self;
        [_scroll addSubview:_downMenu1];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        NSLog(@"%@", operation.request.allHTTPHeaderFields);
        // 服务器给我们返回的包得头部信息
        NSLog(@"%@", operation.response);
        // 返回的数据
        NSLog(@"success = %@", error);
    }];
    [operation start];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
