//
//  UpdatePwsViewController.m
//  Egive
//
//  Created by sino on 15/10/21.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "UpdatePwsViewController.h"
#import "EGUtility.h"
#import "EGGeneralRequestAdapter.h"
#import "UIView+ZJQuickControl.h"
#import "MemberModel.h"
#import "ShowMenuView.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface UpdatePwsViewController ()<UITextFieldDelegate>



@property (strong, nonatomic) MemberModel * item;
@property (copy, nonatomic) NSMutableDictionary * shareDict;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@end

@implementation UpdatePwsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = EGLocalizedString(@"修改密码", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    
    
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIImageView * image = [self.view addImageViewWithFrame:CGRectMake(40, 160,ScreenSize.width-80 , 80) image:@"login_logo@2x.png"];
    image.contentMode = UIViewContentModeScaleAspectFit;
 
    
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults objectForKey:@"EGIVE_MEMBER_MODEL"]) {
        NSMutableDictionary *m = [[standardUserDefaults objectForKey:@"EGIVE_MEMBER_MODEL"] mutableCopy];
        
        MemberModel * model = [[MemberModel alloc] init];
        [model setValuesForKeysWithDictionary:m];
    
        _shareDict = [ShowMenuView getUserInfo];
        _item = _shareDict[@"LoginName"];
    }

    
    
    UITextField * oldPswField = [[UITextField alloc] initWithFrame:CGRectMake(40, 290, ScreenSize.width-80, 30)];
    oldPswField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [oldPswField setSecureTextEntry:YES];
    oldPswField.placeholder = EGLocalizedString(@"旧密码", nil);
    oldPswField.delegate = self;
    oldPswField.font = [UIFont systemFontOfSize:12];
    oldPswField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:oldPswField];
    
    
    UITextField * newPswField = [[UITextField alloc] initWithFrame:CGRectMake(40, 330, ScreenSize.width-80, 30)];
    newPswField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [newPswField setSecureTextEntry:YES];
    newPswField.placeholder = EGLocalizedString(@"新密码", nil);
    newPswField.delegate = self;
    newPswField.font = [UIFont systemFontOfSize:12];
    newPswField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:newPswField];
    
    
    UITextField * confirmPswField = [[UITextField alloc] initWithFrame:CGRectMake(40, 370, ScreenSize.width-80, 30)];
    [confirmPswField setSecureTextEntry:YES];
    confirmPswField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    confirmPswField.placeholder = EGLocalizedString(@"Register_comfirmpwsTextfile", nil);
    confirmPswField.delegate = self;
    confirmPswField.font = [UIFont systemFontOfSize:12];
    confirmPswField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:confirmPswField];
    
    UILabel * label = [self.view addLabelWithFrame:CGRectMake(40, 405, ScreenSize.width-80, 25) text:EGLocalizedString(@"Register_noteLabel_title", nil)];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:12];
    
    
    __weak typeof(self) weakSelf = self;
    UIButton * tapButton = [self.view addImageButtonWithFrame:CGRectMake(40, ScreenSize.height-40, ScreenSize.width-80, 30) title:EGLocalizedString(@"Register_commitButton_title", nil) backgroud:nil action:^(UIButton *button) {
        
        //MyLog(@"%@",newPswField.text);
        if (![NSString isEmpty:oldPswField.text andNote:EGLocalizedString(@"请输入旧密码", nil)]) {
            if ([weakSelf NewPass:newPswField]) {
                
                if ([weakSelf chicheckfirstName:newPswField.text]){
                    
             if (![NSString isEmpty:confirmPswField.text andNote:EGLocalizedString(@"请输入确认密码", nil)]) {
                if ([weakSelf newpass:newPswField.text andConfirm:confirmPswField.text]) {
                     
                 
            
            [weakSelf setNewPasswordAPI:oldPswField.text andNewPassword:newPswField.text];
                    
            
        }
        
        }
        }
            }
        }
        
    }];
    tapButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [tapButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tapButton.layer.cornerRadius = 4;
    tapButton.backgroundColor = [UIColor colorWithRed:110/255.0 green:184/255.0 blue:43/255.0 alpha:1];
}


-(BOOL)chicheckfirstName:(NSString*)firstName{
    
    // MyLog(@"%@",firstName);
    
    if ([self isZhongWenFirst:firstName] && ![firstName isEqualToString:@""]){
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"密码不接受中文输入", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        
        return false;
        
    }else{
        return true;
        
    }
    
    
}
-(BOOL)isZhongWenFirst:(NSString *)str{
    
    NSString *ZIMU = @"^[\u4e00-\u9fa5]*$";
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

-(BOOL)newpass: (NSString*)newpass andConfirm:(NSString*)confirmPass{

    if (![newpass isEqualToString:confirmPass]){
    
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"密码不一致", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        return false;
    
    }else{

        return true;
    
    }
}

-(BOOL)NewPass:(UITextField*)newPassTextField{

    if (([newPassTextField.text length]<5)){
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"新密码至少需要6个字元", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
        return false;
        
    }else{
        return true;
    }
 }

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 修改密码请求
- (void)setNewPasswordAPI:(NSString *)oldPassword andNewPassword:(NSString *)newPassword{
    [self showLoadingAlert];
    NSString * soapMessage = [NSString stringWithFormat:
                              @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SavePassword xmlns=\"egive.appservices\"><MemberID>%@</MemberID><OldPassword>%@</OldPassword><NewPassword>%@</NewPassword><ConfirmPassword>%@</ConfirmPassword></SavePassword></soap:Body></soap:Envelope>",_item.MemberID,oldPassword,newPassword,newPassword];
    
    [EGGeneralRequestAdapter postWithHttpsConnection:NO soapMsg:soapMessage success:^(id result) {
        [self removeLoadingAlert];
        NSString *dataString = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
        result = [NSString captureData:dataString];
        
        if ([[NSString captureData:dataString] isEqualToString:@"\"\""]) {
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.delegate = self;
            alertView.message = EGLocalizedString(@"修改成功!", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            
        }else{
            if ([[NSString captureData:dataString] isEqualToString:@"\"Wrong old password!\""] ||[[NSString captureData:dataString] isEqualToString:@"\"Error(5006)\""] ) {
                UIAlertView *alertView = [[UIAlertView alloc] init];
                alertView.message = EGLocalizedString(@"旧密码错误", nil) ;
                [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                [alertView show];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] init];
                alertView.message = result;
                [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                [alertView show];
                
            }
        }
    
    } failure:^(NSError * error) {
        [self removeLoadingAlert];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showLoadingAlert
{
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.progressHUD = [MBProgressHUD showHUDAddedTo:app.window animated:NO];
    [app.window addSubview:self.progressHUD];
    self.progressHUD.dimBackground = YES;
}

- (void)removeLoadingAlert
{
    
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
