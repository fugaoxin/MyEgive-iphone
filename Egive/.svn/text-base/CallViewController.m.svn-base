//
//  CallViewController.m
//  Egive
//
//  Created by sino on 15/9/12.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "CallViewController.h"
#import "UIView+ZJQuickControl.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "EGUtility.h"

#define ScreenSize [UIScreen mainScreen].bounds.size
@interface CallViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation CallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = EGLocalizedString(@"联络我们", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    if (ScreenSize.height==480) {
        
        self.view.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
    }
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self createUI];
}

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createUI {
    
    if (ScreenSize.height==480) {
        
        UIImageView * img = [self.view addImageViewWithFrame:CGRectMake(ScreenSize.width/2-50, 90, ScreenSize.width/2-20, 110) image:@"contact_mail_bg@2x.png"];
        img.contentMode = UIViewContentModeScaleAspectFit;
        
    }else{
    UIImageView * img = [self.view addImageViewWithFrame:CGRectMake(ScreenSize.width/2-70, 90, ScreenSize.width/2-20, 110) image:@"contact_mail_bg@2x.png"];
        img.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    UILabel * label = [self.view addLabelWithFrame:CGRectMake(20, 220, ScreenSize.width, 35) text:EGLocalizedString(@"意赠慈善基金", nil)];
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor colorWithRed:70.0/255.0 green:180.0/255.0 blue:4.0/255.0 alpha:1];
    
    [self.view addImageViewWithFrame:CGRectMake(10, 265, ScreenSize.width-20, 2) image:@"Line@2x.png"];

    
    UILabel * phoneLabel = [self.view addLabelWithFrame:CGRectMake(20, 270, 140, 25) text:EGLocalizedString(@"电话", nil)];
    phoneLabel.font = [UIFont systemFontOfSize:16];
    phoneLabel.textColor = [UIColor grayColor];

    UILabel * phone = [self.view addLabelWithFrame:CGRectMake(20, 290, 120, 25) text:@"(852) 2210 2600"];
    phone.font = [UIFont systemFontOfSize:13];
    phone.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
       __weak typeof(self)weakSelf = self;
    //☎️按钮
   [self.view addImageButtonWithFrame:CGRectMake(135, 290, 23, 23) title:nil backgroud:@"setting_phone@2x.png" action:^(UIButton *button) {

       NSString *allString = [NSString stringWithFormat:@"tel:85222102600"];
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
       
    }];

    UILabel * faxLabel = [self.view addLabelWithFrame:CGRectMake(ScreenSize.width/2+10, 270, 140, 25) text:EGLocalizedString(@"传真:", nil)];
    faxLabel.font = [UIFont systemFontOfSize:16];
    faxLabel.textColor = [UIColor grayColor];

    UILabel * fax = [self.view addLabelWithFrame:CGRectMake(ScreenSize.width/2+10, 290, 200, 25) text:@"(852) 2210 2676"];
    fax.font = [UIFont systemFontOfSize:13];

    UILabel * emailLabel = [self.view addLabelWithFrame:CGRectMake(20, 320, 140, 25) text:EGLocalizedString(@"电邮", nil)];
    emailLabel.font = [UIFont systemFontOfSize:16];
    emailLabel.textColor = [UIColor grayColor];

    UILabel * email = [self.view addLabelWithFrame:CGRectMake(20, 340, 200, 25) text:@"info@egive4u.org"];
    email.font = [UIFont systemFontOfSize:15];
    email.userInteractionEnabled = YES;
    email.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [email addGestureRecognizer:tap];
    
    //📧按钮
    [self.view addImageButtonWithFrame:CGRectMake(150, 340, 23, 23) title:nil backgroud:@"setting_mail@2x.png" action:^(UIButton *button) {

        [weakSelf displayMailPicker];

    }];

    UILabel * timeLabel = [self.view addLabelWithFrame:CGRectMake(20, 370, 140, 25) text:EGLocalizedString(@"办公时间", nil)];
    timeLabel.font = [UIFont systemFontOfSize:15];
    timeLabel.textColor = [UIColor grayColor];

    UILabel * timeLabel1 = [self.view addLabelWithFrame:CGRectMake(20, 400, 300, 30) text:EGLocalizedString(@"星期一至五", nil)];
    timeLabel1.font = [UIFont systemFontOfSize:15];

    UILabel * timeLabel2 = [self.view addLabelWithFrame:CGRectMake(20, 430, 300, 30) text:EGLocalizedString(@"上午9时至下午1时/下午2时至6时", nil)];
    timeLabel2.font = [UIFont systemFontOfSize:15];

    UILabel * timeLabel3 = [self.view addLabelWithFrame:CGRectMake(20, 460, 300, 50) text:EGLocalizedString(@"星期六丶日及公共假期休息", nil)];
    timeLabel3.numberOfLines = 2;
    timeLabel3.font = [UIFont systemFontOfSize:15];
    
    

}

- (void)tapAction{
    [self displayMailPicker];
    
}

- (void)displaySystemEmail{
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
    if (!mailViewController) {
        // 在设备还没有添加邮件账户的时候mailViewController为空，下面的present view controller会导致程序崩溃，这里要作出判断
        
        MyLog(@"设备还没有添加邮件账户");
        return;
    }
    mailViewController.mailComposeDelegate = self;
    NSArray *toRecipients = [NSArray arrayWithObject: @"info@egive4u.org"];
    [mailViewController setToRecipients: toRecipients];
    
    // 2.设置邮件主题
    [mailViewController setSubject:@"测试邮件"];
    
    // 3.设置邮件主体内容
    [mailViewController setMessageBody:@"邮件内容：" isHTML:NO];
    
    // 4.添加附件
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Icon@2x.png" ofType:@"jpg"];
//    NSData *attachmentData = [NSData dataWithContentsOfFile:imagePath];
//    [mailViewController addAttachmentData:attachmentData mimeType:@"image/jpeg" fileName:@"天堂之珠：仙本那"];
//
    // 添加一张图片
    UIImage *addPic = [UIImage imageNamed: @"Icon@2x.png"];
    NSData *imageData = UIImagePNGRepresentation(addPic);
    [mailViewController addAttachmentData: imageData mimeType: @"" fileName: @"Icon.png"];
    // 5.呼出发送视图
    [self presentViewController:mailViewController animated:YES completion:nil];
    
}


//调出邮件发送窗口
- (void)displayMailPicker
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    
    if (!mailPicker) {
        // 在设备还没有添加邮件账户的时候mailViewController为空，下面的present view controller会导致程序崩溃，这里要作出判断
        
        MyLog(@"设备还没有添加邮件账户");
        return;
    }

    mailPicker.mailComposeDelegate = self;
//    MyLog(EGLocalizedString(@"email_heading", nil));
    //设置主题
    [mailPicker setSubject: EGLocalizedString(@"email_heading", nil)];// EGLocalizedString(@"email_heading", nil)];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject:@"info@egive4u.org"];

    [mailPicker setToRecipients: toRecipients];
//    //添加抄送
//    NSArray *ccRecipients = [NSArray arrayWithObjects:nil];
//    [mailPicker setCcRecipients:ccRecipients];
//    //添加密送
//    NSArray *bccRecipients = [NSArray arrayWithObjects:@"fourth@example.com", nil];
//    [mailPicker setBccRecipients:bccRecipients];
    
    // 添加一张图片
    UIImage *addPic = [UIImage imageNamed: @"Icon@2x.png"];
    NSData *imageData = UIImagePNGRepresentation(addPic);            // png
    //关于mimeType：http://www.iana.org/assignments/media-types/index.html
    [mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"Icon.png"];
   
    NSString * emailBody = @"";
    if ([EGUtility getAppLang]==1) {
        NSString * str =@"姓名:\n電話:\n查詢內容:\n\n\n我們將盡快處理閣下的查詢！\n\n意贈慈善基金\nEgive For You Charity Foundation\n電話: (852) 2210 2600\n電郵: info@egive4u.org";
        emailBody = str;
        
    }else if ([EGUtility getAppLang]==2){
        NSString *str = @"姓名:\n电话:\n查询内容:\n\n\n我们将尽快处理阁下的查询！\n\n意赠慈善基金\nEgive For You Charity Foundation\n电話: (852) 2210 2600\n电邮: info@egive4u.org";
        emailBody = str;
    }else{
        
        NSString * str = [NSString stringWithFormat:@"Name:\nDaytime Contact No.:\nThe Enquiry:\n\nThank you for your enquiry and we will get back to you soonest!\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org"];
        emailBody = str;
    }
//    NSString *emailBody =  [NSString stringWithFormat:@"電話:  \n查詢內容: \n\n\n\n我們將盡快處理閣下的查詢！\n\n意贈慈善基金\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org"];
    [mailPicker setMessageBody:emailBody isHTML:NO];
//    [self presentModalViewController: mailPicker animated:YES];
    [self presentViewController:mailPicker animated:YES completion:nil];
  
}

//#pragma mark - 在应用内发送邮件
////激活邮件功能
//- (void)sendMailInApp
//{
//    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
//    if (!mailClass) {
////        [self alertWithMessage:@"当前系统版本不支持应用内发送邮件功能，您可以使用mailto方法代替"];
//        return;
//    }
//    if (![mailClass canSendMail]) {
////        [self alertWithMessage:@"用户没有设置邮件账户"];
//        return;
//    }
//    [self displayMailPicker];
//}

#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
//    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = EGLocalizedString(@"用户取消编辑邮件", nil);
            break;
        case MFMailComposeResultSaved:
            msg = EGLocalizedString(@"用户成功保存邮件", nil);
            break;
        case MFMailComposeResultSent:
            msg = EGLocalizedString(@"用户点击发送，将邮件放到队列中，还没发送", nil);
            break;
        case MFMailComposeResultFailed:
            msg = EGLocalizedString(@"用户试图保存或者发送邮件失败", nil);
            break;
        default:
            msg = @"";
            break;
    }
//    [self alertWithMessage:msg];

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
