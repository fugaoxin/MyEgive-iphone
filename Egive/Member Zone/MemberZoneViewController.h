//
//  MemberZoneViewController.h
//  Egive
//
//  Created by zxj on 15/11/12.
//  Copyright © 2015年 sino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "ViewController.h"
#import "MenuViewController.h"
#import "RankListViewController.h"
#import "MyDonationViewController.h"
#import "EGGeneralRequestAdapter.h"
#import "MemberFormModel.h"
#import "NSString+RegexKitLite.h"
@interface MemberZoneViewController : MenuViewController
@property (strong, nonatomic) MemberFormModel * model;
@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *ScrollView;
@property (strong, nonatomic) IBOutlet UIView *UserInfoWithIconView;
@property (strong, nonatomic) IBOutlet UIView *UserInfoLoadView;
@property (strong, nonatomic) IBOutlet UIView *UserInfoDetaileView;
@property (strong, nonatomic) IBOutlet UIView *IconView;
@property (strong, nonatomic) IBOutlet UIView *UserInforDetaileLoadEmaileView;
@property (strong, nonatomic) IBOutlet UIView *EmaileViewButtonSeclect;
@property (strong, nonatomic) IBOutlet UIView *volunteersView;
@property (strong, nonatomic) IBOutlet UIView *volunteersButtonSelectView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *RegionandStreetConstraintHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *EmaileConstraintHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *volunteersConstraintHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *UserInfoWithViewIconConstraintHeight;
//请选取你喜欢的专案类别
@property (strong, nonatomic) IBOutlet UIButton *EducationButton;
@property (strong, nonatomic) IBOutlet UIButton *ElderlyButton;
@property (strong, nonatomic) IBOutlet UIButton *MedicalButton;
@property (strong, nonatomic) IBOutlet UIButton *CommunityButton;
@property (strong, nonatomic) IBOutlet UIButton *ReliefButton;
@property (strong, nonatomic) IBOutlet UIButton *EgiveActionButton;
@property (strong, nonatomic) IBOutlet UIButton *ALLButton;
@property (strong, nonatomic) IBOutlet UIButton *otherButton;
@property (strong, nonatomic) IBOutlet UIButton *YesButton;
@property (strong, nonatomic) IBOutlet UIButton *NoButton;
@property (strong, nonatomic) IBOutlet UISegmentedControl *IdoSegmentControl;
@property (strong, nonatomic) IBOutlet UIView *RegionDetaileView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *RegionConstraintHeight;
@property (strong, nonatomic) IBOutlet UIView *RegionDetaileAddressView;
//义工Button
@property (strong, nonatomic) IBOutlet UIButton *officeAdminButton;
@property (strong, nonatomic) IBOutlet UIButton *PrintDesign;
@property (strong, nonatomic) IBOutlet UIButton *EventButton;
@property (strong, nonatomic) IBOutlet UIButton *Edition;
@property (strong, nonatomic) IBOutlet UIButton *TransiationButton;
@property (strong, nonatomic) IBOutlet UIButton *CopywritingButton;
@property (strong, nonatomic) IBOutlet UIButton *photographyButton;
@property (strong, nonatomic) IBOutlet UIButton *FundraisingButton;
@property (strong, nonatomic) IBOutlet UIButton *VisitButton;
@property (strong, nonatomic) IBOutlet UIButton *volunteersotherButton;
@property (strong, nonatomic) IBOutlet UITextField *volunteerstextField;
//时间Button
@property (strong, nonatomic) IBOutlet UIButton *MondayButton;
@property (strong, nonatomic) IBOutlet UIButton *TuesdayButton;
@property (strong, nonatomic) IBOutlet UIButton *WednesdayButton;
@property (strong, nonatomic) IBOutlet UIButton *ThuresdayButton;
@property (strong, nonatomic) IBOutlet UIButton *FridayButton;
@property (strong, nonatomic) IBOutlet UIButton *statudayButton;
@property (strong, nonatomic) IBOutlet UIButton *sundayButton;
@property (strong, nonatomic) IBOutlet UIButton *AnytimeButton;
@property (strong, nonatomic) IBOutlet UIButton *TimeOtheButton;
@property (strong, nonatomic) IBOutlet UIButton *sevenAMButton;
@property (strong, nonatomic) IBOutlet UIButton *FiveAMButton;
@property (strong, nonatomic) IBOutlet UIButton *twoAMButton;
@property (strong, nonatomic) IBOutlet UIButton *TenAMButton;
//头像
@property (strong, nonatomic) IBOutlet UIImageView *IconImage;
@property (strong, nonatomic) IBOutlet UIButton *CheckRankingButton;
@property (strong, nonatomic) IBOutlet UILabel *LoginName;
@property (strong, nonatomic) IBOutlet UILabel *LoginPassWord;
@property (strong, nonatomic) IBOutlet UITextField *EmaileAddress;
@property (strong, nonatomic) IBOutlet UITextField *Sex;
@property (strong, nonatomic) IBOutlet UITextField *PhoneNumber;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ValidEmaileTrallingConstraint;
@property (strong, nonatomic) IBOutlet UIButton *LoginOutButton;
@property (strong, nonatomic) IBOutlet UILabel *DonamtionAmount;
//捐款钱数
@property (copy, nonatomic) NSString * memberTotalDonationAmount;
@property (strong, nonatomic) IBOutlet UILabel *RegionLabel;
@property (strong, nonatomic) IBOutlet UITextField *region;
@property (strong, nonatomic) IBOutlet UIView *PleaseSpecifyView;

@property (strong, nonatomic) IBOutlet UIButton *ModifyButton;
@property (strong, nonatomic) IBOutlet UIButton *ConfirmButton;
@property (strong, nonatomic) IBOutlet UITextField *agetextField;
@property (strong, nonatomic) IBOutlet UITextField *BelongTotextField;

//室楼座
@property (strong, nonatomic) IBOutlet UITextField *addressDistrict;
//大楼/楼宇名称
@property (strong, nonatomic) IBOutlet UITextField *addressBldg;
//屋苑
@property (strong, nonatomic) IBOutlet UITextField *addressEstate;
//街道
@property (strong, nonatomic) IBOutlet UITextField *addressStreet;

@property (strong, nonatomic) IBOutlet UILabel *chNameLabel;
@property (strong, nonatomic) IBOutlet UITextField *chLastName;
@property (strong, nonatomic) IBOutlet UITextField *chfirstName;
@property (strong, nonatomic) IBOutlet UILabel *enName;
@property (strong, nonatomic) IBOutlet UITextField *enLastName;
@property (strong, nonatomic) IBOutlet UITextField *enfirstName;
@property (strong, nonatomic) IBOutlet UITextField *VolunteerPleasestateTexyField;
@property (strong, nonatomic) IBOutlet UITextField *TimePleaseState;
@property (strong, nonatomic) IBOutlet UIView *ButtonView;
@property (strong, nonatomic) IBOutlet UITextField *emaile;
@property (strong, nonatomic) IBOutlet UITextField *dateStart;
@property (strong, nonatomic) IBOutlet UITextField *dateEnd;
@property (strong, nonatomic) IBOutlet UISegmentedControl *LongOrShortSegment;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@property (strong, nonatomic) IBOutlet UITextField *HKorOtherTextField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *HKorOtherSegment;
@property (strong, nonatomic) IBOutlet UITextField *ConturyCodeNumberTextField;
@property (strong, nonatomic) IBOutlet UILabel *DetailePhoneNumber;

//How do you know about Egive?
@property (strong, nonatomic) IBOutlet UIButton *EgiveWebsiteButton;
@property (strong, nonatomic) IBOutlet UIButton *EgiveMagazineButton;
@property (strong, nonatomic) IBOutlet UIButton *FriendButton;
@property (strong, nonatomic) IBOutlet UIButton *NewspaperButton;
@property (strong, nonatomic) IBOutlet UIButton *SocialMediaButton;
@property (strong, nonatomic) IBOutlet UIButton *AsaEgiveButton;
@property (strong, nonatomic) IBOutlet UIButton *HowDoyouKnowEgiveOtherButton;
@property (strong, nonatomic) IBOutlet UITextField *HowDoyouknowEgivePleasestate;
@property (strong, nonatomic) IBOutlet UITextField *EducationTextField;
@property (strong, nonatomic) IBOutlet UITextField *WorkTextField;
@property (strong, nonatomic) IBOutlet UILabel *personalTitle;
@property (strong, nonatomic) IBOutlet UILabel *DonationRecordLabel;
@property (strong, nonatomic) IBOutlet UILabel *LoginNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *LoginPassLabel;
@property (strong, nonatomic) IBOutlet UIButton *ChangethepasswordButton;
@property (strong, nonatomic) IBOutlet UILabel *NameChLabel;
@property (strong, nonatomic) IBOutlet UILabel *NameEnLabel;
@property (strong, nonatomic) IBOutlet UILabel *EmaileAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *EducationLabel;

@property (strong, nonatomic) IBOutlet UILabel *WorkLabel;
@property (strong, nonatomic) IBOutlet UILabel *BelongLabel;
@property (strong, nonatomic) IBOutlet UILabel *GenderLabel;
@property (strong, nonatomic) IBOutlet UILabel *AgeGroupLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *ProvireReallyAddress;
@property (strong, nonatomic) IBOutlet UILabel *HowToKnowEgiveLabel;
@property (strong, nonatomic) IBOutlet UILabel *EgiveWebsiteLabel;

@property (strong, nonatomic) IBOutlet UILabel *MagszineLabel;
@property (strong, nonatomic) IBOutlet UILabel *FriendLabel;
@property (strong, nonatomic) IBOutlet UILabel *NewsPaperLabel;

@property (strong, nonatomic) IBOutlet UILabel *MedicalFacbookLabel;
@property (strong, nonatomic) IBOutlet UILabel *AsaegiveDonnerLabel;

@property (strong, nonatomic) IBOutlet UILabel *HowtoKnowEgiveLabel;
@property (strong, nonatomic) IBOutlet UILabel *DoyouWishLabel;
@property (strong, nonatomic) IBOutlet UILabel *PleaseSelectthemesLabel;

@property (strong, nonatomic) IBOutlet UILabel *EducationthemesLabel;

@property (strong, nonatomic) IBOutlet UILabel *EdlerlythemesLabel;

@property (strong, nonatomic) IBOutlet UILabel *Medicalthemeslabel;
@property (strong, nonatomic) IBOutlet UILabel *CommunitythemesLabel;
@property (strong, nonatomic) IBOutlet UILabel *ReliefthemesLabel;


@property (strong, nonatomic) IBOutlet UILabel *otherThemesLabel;
@property (strong, nonatomic) IBOutlet UILabel *EgiveActionthemesLabel;
@property (strong, nonatomic) IBOutlet UILabel *ALLthemesLabel;
@property (strong, nonatomic) IBOutlet UILabel *willYouConsidertobeLabel;

@property (strong, nonatomic) IBOutlet UILabel *WillyouConsiderBecomingLabel;
@property (strong, nonatomic) IBOutlet UILabel *IagreeToJoinLabel;
@property (strong, nonatomic) IBOutlet UILabel *MySpcialtyLabel;

@property (strong, nonatomic) IBOutlet UILabel *officeAdminiLabel;

@property (strong, nonatomic) IBOutlet UILabel *PrintDesignLabel;

@property (strong, nonatomic) IBOutlet UILabel *EventCoordnationLabel;

@property (strong, nonatomic) IBOutlet UILabel *EditionLabel;
@property (strong, nonatomic) IBOutlet UILabel *TranslationLabel;
@property (strong, nonatomic) IBOutlet UILabel *CopywritingLabel;
@property (strong, nonatomic) IBOutlet UILabel *PhotographyLabel;
@property (strong, nonatomic) IBOutlet UILabel *FundraisingLabel;
@property (strong, nonatomic) IBOutlet UILabel *VisitLabel;
@property (strong, nonatomic) IBOutlet UILabel *MyspecialtyotherLabel;
@property (strong, nonatomic) IBOutlet UILabel *AvailableDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *MondayLabel;

@property (strong, nonatomic) IBOutlet UILabel *TuesdayLabel;
@property (strong, nonatomic) IBOutlet UILabel *WendesdayLabel;
@property (strong, nonatomic) IBOutlet UILabel *ThuredayLabel;
@property (strong, nonatomic) IBOutlet UILabel *FridayLabel;

@property (strong, nonatomic) IBOutlet UILabel *StatudyLabel;
@property (strong, nonatomic) IBOutlet UILabel *SundayLabel;
@property (strong, nonatomic) IBOutlet UILabel *AnyTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *TenAMLabel;


@property (strong, nonatomic) IBOutlet UILabel *TwoAMLabel;
@property (strong, nonatomic) IBOutlet UILabel *FiveAMlabel;

@property (strong, nonatomic) IBOutlet UILabel *selvenAMLabel;

@property (strong, nonatomic) IBOutlet UILabel *AvailabelotherLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressTitleLabel;

@end
