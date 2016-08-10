//
//  PreviewViewController.m
//  Egive
//
//  Created by sino on 15/9/13.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "PreviewViewController.h"
#import "UIView+ZJQuickControl.h"
#import "GirdDetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"
#import "Constants.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface PreviewViewController (){

    UIDevice *device_;

}
@property (strong, nonatomic) UIView * successfulView;
@property (strong, nonatomic) UIView * PreviewBgView;
@property (strong,nonatomic) MPMoviePlayerController *playerController;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@end

@implementation PreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.75];
    
    device_=[[UIDevice alloc] init];
    [self PreviewView];
    [self successfulView];
}

- (void)PreviewView{
    
    //预览view
    if ([device_.model isEqualToString:@"iPad"]||IS_IPHONE_4_OR_LESS ) {
        
         _PreviewBgView = [[UIView alloc] initWithFrame:CGRectMake(10, ScreenSize.height/2-160, ScreenSize.width-20, ScreenSize.height-230)];
        
    }else{
        
        _PreviewBgView = [[UIView alloc] initWithFrame:CGRectMake(10, ScreenSize.height/2-160, ScreenSize.width-20, ScreenSize.height-360)];
    }
    
    _PreviewBgView.backgroundColor = [UIColor whiteColor];
    _PreviewBgView.layer.cornerRadius = 8;
    _PreviewBgView.layer.masksToBounds = YES;
    [self.view addSubview:_PreviewBgView];
    
    UILabel * titleLabel = [_PreviewBgView addLabelWithFrame:CGRectMake(0, 0, ScreenSize.width-20, 45) text:EGLocalizedString(@"预览", nil)];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    
    
    //    UILabel * comment = [_PreviewBgView addLabelWithFrame:CGRectMake(10, 55, ScreenSize.width-40, 0) text:_comments];
    //    comment.font = [UIFont systemFontOfSize:14];
    //    comment.numberOfLines = 0;
    //    CGSize  size = EG_MULTILINE_TEXTSIZE(_comments, comment.font, CGSizeMake(ScreenSize.width-40,CGFLOAT_MAX), NSLineBreakByWordWrapping);
    //    comment.frame = CGRectMake(10, 55, ScreenSize.width-40, size.height);
    
    UIScrollView * contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 55, ScreenSize.width-20, _PreviewBgView.frame.size.height-55-40)];
    
    [_PreviewBgView addSubview:contentScrollView];
    
    
    NSString* content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"preview" ofType:@"html"] encoding:NSUTF8StringEncoding error:NULL];
    content = [content stringByReplacingOccurrencesOfString:@":content:" withString:_comments];
    
    MyLog(@"%@", content);
    
    UIWebView *_wv = [[UIWebView alloc] init];
    CGSize requiredSize = [[content stringByReplacingOccurrencesOfString:@" " withString:@""] sizeWithFont:[UIFont systemFontOfSize:7] constrainedToSize:CGSizeMake(ScreenSize.width-20, 10000) lineBreakMode:NSLineBreakByWordWrapping];
    _wv.frame = CGRectMake(-20, 10, ScreenSize.width + 30, requiredSize.height);//550
    contentScrollView.contentSize = CGSizeMake(ScreenSize.width-20, requiredSize.height);
    _wv.contentMode = UIViewContentModeScaleAspectFit;
    _wv.scrollView.scrollEnabled = NO;
    _wv.scrollView.bounces = NO;
    _wv.userInteractionEnabled = NO;
    [_wv loadHTMLString:content baseURL:[[NSBundle mainBundle] bundleURL]];
    [contentScrollView addSubview:_wv];
    [_wv.superview sendSubviewToBack:_wv];
    
    
    __weak typeof(self) weakSelf = self;
    UIButton * cancelButton = [_PreviewBgView addImageButtonWithFrame:CGRectMake(0, _PreviewBgView.frame.size.height-35, _PreviewBgView.frame.size.width/2-1, 35) title:EGLocalizedString(@"取消", nil) backgroud:nil action:^(UIButton *button) {
        
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        
    }];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    
    UIButton * determineButton = [_PreviewBgView addImageButtonWithFrame:CGRectMake(_PreviewBgView.frame.size.width/2+1, _PreviewBgView.frame.size.height-35, _PreviewBgView.frame.size.width/2-1, 35) title:EGLocalizedString(@"Common_button_confirm", nil) backgroud:nil action:^(UIButton *button) {
        
        [weakSelf SaveCaseComment:weakSelf.caseId andMemberID:weakSelf.memberId];
        
        
    }];
    determineButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [determineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    determineButton.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    
    
    //成功传送的view
    _successfulView = [[UIView alloc] initWithFrame:CGRectMake(10, ScreenSize.height/2-180, ScreenSize.width-20, ScreenSize.height-300)];
    _successfulView.hidden = YES;
    _successfulView.backgroundColor = [UIColor whiteColor];
    _successfulView.layer.cornerRadius = 8;
    _successfulView.layer.masksToBounds = YES;
    [self.view addSubview:_successfulView];
    
    UILabel * titleLabel1 = [_successfulView addLabelWithFrame:CGRectMake(0, 0, ScreenSize.width-20, 45) text:EGLocalizedString(@"成功传送", nil)];
    titleLabel1.font = [UIFont systemFontOfSize:17];
    titleLabel1.textAlignment = NSTextAlignmentCenter;
    titleLabel1.textColor = [UIColor whiteColor];
    titleLabel1.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    
    //创建视频controller
    NSString *path = [[NSBundle mainBundle] pathForResource:@"envelope1" ofType:@"mp4"];
    _playerController = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:path]];
    _playerController.view.backgroundColor = [UIColor whiteColor];
    _playerController.controlStyle = MPMovieControlStyleNone;   //视频无框
    _playerController.scalingMode = MPMovieScalingModeAspectFill;  //设置视频全屏
    _playerController.view.frame = CGRectMake(0, 45,ScreenSize.width-20, _successfulView.frame.size.height-80);
    _playerController.repeatMode = MPMovieRepeatModeOne;    //设置视频循环播放
    
    [_successfulView addSubview:_playerController.view];
    
    UILabel * thxLabel = [_successfulView addLabelWithFrame:CGRectMake(0, _successfulView.frame.size.height-70, ScreenSize.width-20, 30) text:EGLocalizedString(@"感谢您的祝福", nil)];
    thxLabel.font = [UIFont systemFontOfSize:16];
    thxLabel.textAlignment = NSTextAlignmentCenter;
    
    if (ScreenSize.height == 667) {
        thxLabel.frame = CGRectMake(0, _successfulView.frame.size.height-90, ScreenSize.width-20, 30);
    }else if (ScreenSize.height == 736)
        thxLabel.frame = CGRectMake(0, _successfulView.frame.size.height-110, ScreenSize.width-20, 30);
    else{
        thxLabel.frame = CGRectMake(0, _successfulView.frame.size.height-70, ScreenSize.width-20, 30);
    }
    
    //关闭按钮
    UIButton * offButton = [_successfulView addImageButtonWithFrame:CGRectMake(0, _successfulView.frame.size.height-35, _successfulView.frame.size.width, 35) title:EGLocalizedString(@"关闭", nil) backgroud:nil action:^(UIButton *button){
        
        if(weakSelf.action)
        {
            weakSelf.action();
        }
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        
    }];
    offButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [offButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    offButton.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    
}

- (void)SaveCaseComment:(NSString *)caseID andMemberID:(NSString *)memberID{
    [self showLoadingAlert];
    NSString * soapMessage = [NSString stringWithFormat:
                              @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <SaveCaseComment xmlns=\"egive.appservices\"><CaseCommentID></CaseCommentID><CaseID>%@</CaseID><MemberID>%@</MemberID><Comment>%@</Comment></SaveCaseComment></soap:Body></soap:Envelope>",caseID,memberID,_comments];
    
    MyLog(@"%@",soapMessage );
    
    [EGGeneralRequestAdapter postWithHttpsConnection:YES soapMsg:soapMessage success:^(id result) {
        [self removeLoadingAlert];
        NSString *dataString = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
        result = [NSString captureData:dataString];
        
        if ([[NSString captureData:dataString] isEqualToString:@"\"\""]) {
            
            self.PreviewBgView.hidden = YES;
            self.successfulView.hidden = NO;
            [self.playerController play];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.message = result;
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
        }
        
        
    } failure:^(NSError * error) {
        [self removeLoadingAlert];
    }];
    
}
//显示加载图标
- (void)showLoadingAlert
{
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.progressHUD = [MBProgressHUD showHUDAddedTo:app.window animated:NO];
    [app.window addSubview:self.progressHUD];
    self.progressHUD.dimBackground = YES;
}
//移除加载图标
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
