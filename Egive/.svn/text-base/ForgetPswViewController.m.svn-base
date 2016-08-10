//
//  ForgetPswViewController.m
//  Egive
//
//  Created by sino on 15/9/13.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ForgetPswViewController.h"
#import "UIView+ZJQuickControl.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface ForgetPswViewController ()<UITextFieldDelegate>

@end

@implementation ForgetPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = EGLocalizedString(@"找回密码", nil);
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
    
    UILabel * noteLabel = [self.view addLabelWithFrame:CGRectMake(40, 280, ScreenSize.width-80, 50) text:EGLocalizedString(@"请输入注册会员时所填的邮箱", nil)];
    noteLabel.numberOfLines=0;
    noteLabel.font = [UIFont systemFontOfSize:14];
    noteLabel.textColor = [UIColor redColor];
    
    UITextField * emailField = [[UITextField alloc] initWithFrame:CGRectMake(40, 330, ScreenSize.width-80, 30)];
    emailField.placeholder = EGLocalizedString(@"Register_email", nil);
    emailField.delegate = self;
    emailField.font = [UIFont systemFontOfSize:12];
    emailField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:emailField];
    
    __weak typeof(self) weakSelf = self;
    UIButton * tapButton = [self.view addImageButtonWithFrame:CGRectMake(40, ScreenSize.height-80, ScreenSize.width-80, 30) title:EGLocalizedString(@"Register_commitButton_title", nil) backgroud:nil action:^(UIButton *button) {
        
        if (![NSString isEmpty:emailField.text andNote:EGLocalizedString(@"邮箱不能为空", nil)]){
        if ([NSString isEmail:emailField.text]) {
            [weakSelf ForgetPasswordAPI:emailField.text];
        }
        }
    }];
    tapButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [tapButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tapButton.layer.cornerRadius = 4;
    tapButton.backgroundColor = [UIColor colorWithRed:110/255.0 green:184/255.0 blue:43/255.0 alpha:1];

    
}

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 发送找回密码请求
- (void)ForgetPasswordAPI:(NSString *)emailAddress{
    long lang = [EGUtility getAppLang];
    
    NSString * soapMessage = [NSString stringWithFormat:
                              @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <ForgetPassword xmlns=\"egive.appservices\"><Lang>%ld</Lang><Email>%@</Email></ForgetPassword></soap:Body></soap:Envelope>",lang,emailAddress];
    
    MyLog(@"%@",soapMessage);

    [EGGeneralRequestAdapter postWithHttpsConnection:NO soapMsg:soapMessage success:^(id result) {
        
        NSString *dataString = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
        result = [NSString captureData:dataString];
        
        if ([[NSString captureData:dataString] isEqualToString:@"\"\""]){
            
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.delegate = self;
            alertView.message = EGLocalizedString(@"密码重设成功,已发送至您的邮箱,请注意查收!", nil);
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            
        }else{
            
   if ([result isEqualToString:@"\"Error(1001)\""]||[result isEqualToString:@"\"Email address not registered!\""]) {
            
                UIAlertView *alertView = [[UIAlertView alloc] init];
                alertView.message = EGLocalizedString(@"邮箱地址没有注册", nil);
    
                [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
                [alertView show];
                
        }
            
    }

        
    } failure:^(NSError * error){
        
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self.navigationController popViewControllerAnimated:YES];
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
