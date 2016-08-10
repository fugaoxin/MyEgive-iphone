//
//  CommonProblemsViewController.m
//  Egive
//
//  Created by sino on 15/9/12.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "CommonProblemsViewController.h"
#import "baseController.h"
#import "EGUtility.h"
#import "EGGeneralRequestAdapter.h"
#import "MyDonationViewController.h"
#import "AnyWebViewController.h"
@interface CommonProblemsViewController ()<MDHTMLLabelDelegate,UIWebViewDelegate>

@property (nonatomic, strong)MDHTMLLabel *htmlLabel;
@property (nonatomic, copy)NSString *htmlString;

@end

@implementation CommonProblemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = EGLocalizedString(@"常见问题", nil);
  
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 33, 33);
    [rightButton addTarget:self action:@selector(chairmanButton) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_share@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.rightBarButtonItem = nil;
//    [self getStaticPageContentWithFormID:@"Public_FAQ"];
    __weak typeof(self) weakSelf = self;
    [EGStaticPageRequestAdapter GetStaticPageContentWithFormID:@"Public_FAQ" success:^(EGGetStaticPageContentResult *result) {
        if (result.ContentText) {
            MyLog(@"text:%@",result.ContentText);
            //
            UIWebView *webView = [[UIWebView alloc] initWithFrame:(CGRect){0,64,self.view.frame.size.width,self.view.frame.size.height-64}];
            [self.view addSubview:webView];
            webView.delegate = weakSelf;
            webView.dataDetectorTypes = UIDataDetectorTypeLink;
            [result.ContentText stringByReplacingOccurrencesOfString:@"DonateNow()" withString:@"ios:DonateNow"];
            [webView loadHTMLString:result.ContentText baseURL:nil];
//            [webView stringByEvaluatingJavaScriptFromString:@"DonateNow()"];
        }
        
    } failure:^(NSError *error) {
        MyLog(@"error:%@",error);
    }];
    
    currentY = 200;
    
    mScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    mScrollView.backgroundColor = [UIColor clearColor];
    mScrollView.delegate = self;
    [self.view addSubview:mScrollView];
    [self addMySlider];
    
    
//    [self parseHTML:nil];
}


- (void)chairmanButton{
    
    [self shareSystem:self];
}
-(void)shareSystem:(UIViewController *)viewController{
    
    NSString * string = @"";
    NSString * subject = @"";
    if ([EGUtility getAppLang]==1) {
        NSString *str = @"Egive 常見問題\nEgive - 常見問題  http://www.egive4u.org/FAQ.aspx\n\n請瀏覽: http://www.egive4u.org/\n\n意贈慈善基金\nEgive For You Charity Foundation\n\n電話: (852) 2210 2600\n電郵: info@egive4u.org";
        string = str;
        subject = @"Egive - 常見問題";
       
        
    }else if ([EGUtility getAppLang]==2){
        NSString *str = @"Egive 常见问题\nEgive - 常见问题  http://www.egive4u.org/FAQ.aspx\n\n请浏览: http://www.egive4u.org/\n\n意赠慈善基金\nEgive For You Charity Foundation\n电话: (852) 2210 2600\n电邮: info@egive4u.org";
        string = str;
        subject = @"Egive - 常见问题";
    }else{
        
        NSString * str = [NSString stringWithFormat:@"Egive - FAQ www.egive4u.org/FAQ.aspx\n\nVisit us at www.egive4u.org\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org"];
        string = str;
         subject = @"Egive - FAQ";
    }

    
    [MenuViewController shareToSocialNetworkWithSubject:subject content:string url:nil image:nil];
//    
//    UIActivityViewController *activityViewController =
//    [[UIActivityViewController alloc] initWithActivityItems:@[string]
//                                      applicationActivities:nil];
//    [self.navigationController presentViewController:activityViewController
//                                            animated:YES
//                                          completion:^{
//                                              // ...
//                                          }];
//    activityViewController.excludedActivityTypes = @[UIActivityTypePrint];
//    [activityViewController setValue:subject forKey:@"subject"];
    
}

- (void)parseHTML:(NSString*)htmlString
{
//    NSString *html = @"<ul id='ContentList' class='ContentList2'><li><div class=\"IndexedContentList_ContentBlock\"><div class=\"IndexedContentList_ContentBlock_Index\">1.</div><div class=\"IndexedContentList_ContentBlock_Content\">有甚麼捐款方法?<br />善長可選擇「劃線支票」、「銀行轉帳」及「PayPal」方式捐款。<br />請下載並填妥<a href=\"DownloadForm.aspx?type=D\">捐款表格</a>，連同劃線支票或銀行入數紙正本，寄回「意贈慈善基金」。<br /><br /><span class=\"UnderlineText\">劃線支票</span><br />支票抬頭：「意贈慈善基金有限公司」<br />郵寄地址：新界沙田小瀝源源順圍 10 – 12 號康健科技中心 6 樓，「意贈慈善基金」收。<br /><br /><span class=\"UnderlineText\">銀行轉帳</span><br />帳戶名稱：「意贈慈善基金有限公司」<br />銀行戶口號碼<br />大新銀行 74-373-01263 或 <br />恒生銀行 789-670775-001<br /><br /><span class=\"UnderlineText\">PayPal</span><br />請到以下網址進行網上捐款。我們接受PAYPAL進行捐款。<br /><a onclick=\"DonateNow();\">按此捐款</a><br /><br />凡捐款港幣 $100 元或以上可獲發退稅收據。<br /></div></div><br /><div class=\"IndexedContentList_ContentBlock\"><div class=\"IndexedContentList_ContentBlock_Index\">2.</div><div class=\"IndexedContentList_ContentBlock_Content\">捐款會收取行政費嗎?<br />「意贈」絕不收取任何行政費，惟網上付款平台PayPal每宗交易均收取0.039%&nbsp;+&nbsp;HKD$2.35手續費（香港捐款）或0.044%&nbsp;+&nbsp;HKD$2.35手續費（非香港捐款）；有關費用將直接影響到受惠者實際收到的援助金額，故「意贈」鼓勵捐款者一併捐出手續費。<br /></div></div><br /><div class=\"IndexedContentList_ContentBlock\"><div class=\"IndexedContentList_ContentBlock_Index\">3.</div><div class=\"IndexedContentList_ContentBlock_Content\">「意贈」如何運用捐款？<br />「意贈」所得善款將按照捐款者的意願分配到指定的受惠者。若因任何原因以致專案必須終止，所籌得的善款將會分配到另一專案，有關安排「意贈」將擁有最終決定權。公眾亦可於網上直接捐款支持「意贈」籌劃及推行各項慈善工作的經費。<br /></div></div><br /><div class=\"IndexedContentList_ContentBlock\"><div class=\"IndexedContentList_ContentBlock_Index\">4.</div><div class=\"IndexedContentList_ContentBlock_Content\">「意贈」接受外幣作網上捐款？<br />所有捐款暫時以港幣為結算貨幣，網上捐款亦會以港幣計算。如欲以外幣捐款，請先自行參考最新的外幣兌換率。<br /></div></div><br /><div class=\"IndexedContentList_ContentBlock\"><div class=\"IndexedContentList_ContentBlock_Index\">5.</div><div class=\"IndexedContentList_ContentBlock_Content\">如何保障我的個人資料及私隱？<br />「意贈」根據個人資料（私隱）條例，謹慎管理及保護每位捐款者的個人資料，<a href=\"Privacy.aspx\">按此</a>細閱個人資料（私隱）條例內容。<br /></div></div><br /><div class=\"IndexedContentList_ContentBlock\"><div class=\"IndexedContentList_ContentBlock_Index\">6.</div><div class=\"IndexedContentList_ContentBlock_Content\">如在進行網上捐款時遇到問題，怎麼辦？<br />請致電(852) 2210 2600或電郵 info@egive4u.org 聯絡我們，以作跟進。<br />辦公時間：（香港時間）星期一至五（周六日及公眾假期休息）09:00 – 13:00及14:00 – 18:00<br /></div></div><br /><div class=\"IndexedContentList_ContentBlock\"><div class=\"IndexedContentList_ContentBlock_Index\">7.</div><div class=\"IndexedContentList_ContentBlock_Content\">在網上捐款後，可以索取正式捐款收據嗎？<br />「意贈」是獲稅務局豁免繳稅的慈善機構（檔案編號：91/13823）。登記成為「意贈之友」，並待核實捐款及專案結束後，捐款港幣$100元或以上之會員，將可透過電郵方式獲發捐款收據。<br /></div></div><br /><p>現時「意贈」仍是初起步階段，需要大家多加指導，如對本機構有任何意見，歡迎以電郵info@egive4u.org向我們提出，一同携手為世界發放更多正能量。</p></li></ul>";
    
    
    MDHTMLLabel *htmlLabel = [[MDHTMLLabel alloc] init];
    htmlLabel.delegate = self;
    htmlLabel.numberOfLines = 0;
    htmlLabel.font = [UIFont systemFontOfSize:15];
    //htmlLabel.shadowColor = [UIColor whiteColor];
    //htmlLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    //htmlLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _htmlLabel = htmlLabel;
    
    htmlLabel.linkAttributes = @{
                                 NSForegroundColorAttributeName: [UIColor blueColor],
                                 //NSFontAttributeName: [UIFont systemFontOfSize:15],
                                 NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    
    htmlLabel.activeLinkAttributes = @{
                                       NSForegroundColorAttributeName: [UIColor blackColor],
                                       //NSFontAttributeName: [UIFont systemFontOfSize:15],
                                       NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    _htmlString = htmlString;
    
    htmlLabel.htmlText = htmlString;
    
    [mScrollView addSubview:htmlLabel];
    
    CGRect rect = [UIScreen mainScreen].bounds;
    
    CGSize maxSize = CGSizeMake(rect.size.width - 20, CGFLOAT_MAX);
    
    CGSize size = [htmlLabel sizeThatFits:maxSize];
    
    htmlLabel.frame = CGRectMake(10, 10, size.width, size.height);
    mScrollView.contentSize = CGSizeMake(0, size.height + 20);
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString = [[request URL] absoluteString];
    
    long  langnumber = [EGUtility getAppLang];
    
    MyLog(@"shouldStartLoadWithRequest requestString=%@", requestString);
    
    if ([requestString rangeOfString:@"applewebdata"].length > 0) {
        
        if ([requestString rangeOfString:@"DownloadForm.aspx"].length > 0) {
        NSString *urlString = [NSString stringWithFormat:@"DownloadForm.aspx?type=D&lang=%ld",langnumber];
            
            AnyWebViewController * vc = [[AnyWebViewController alloc] init];
            [vc setURL:urlString];
            [self.navigationController pushViewController:vc animated:YES];
            return NO;
        }else  if ([requestString rangeOfString:@"Privacy.aspx"].length > 0){
            
            AnyWebViewController * vc = [[AnyWebViewController alloc] init];
            [vc setURL:@"Privacy.aspx"];
            [self.navigationController pushViewController:vc animated:YES];
            return NO;
            
        }else{
            
            MyDonationViewController *vc = [[MyDonationViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES ];
           
    
        }
        
        
    }
    
    if ([requestString rangeOfString:@"tel:(852)"].length > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:requestString]];
        return NO;
    }
    
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    

    

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
   
    [webView stringByEvaluatingJavaScriptFromString:@"function DonateNow() { self.location.href='donate' }"];
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

}


- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sliderDragUp{
    
    float value = self.slider.value;
    float change = 6*(value - 0.5);
    CGFloat fontSize = 15 + change;

    _htmlLabel.numberOfLines = 0;
    _htmlLabel.font = [UIFont systemFontOfSize:fontSize];
    _htmlLabel.htmlText = @"";
    _htmlLabel.htmlText = _htmlString;
    
    CGFloat height = [MDHTMLLabel sizeThatFitsHTMLString:_htmlLabel.htmlText withFont:[UIFont systemFontOfSize:fontSize] constraints:CGSizeMake(self.view.bounds.size.width - 20, CGFLOAT_MAX) limitedToNumberOfLines:0 autoDetectUrls:YES];
//    CGRect rect = [UIScreen mainScreen].bounds;
//    CGSize maxSize = CGSizeMake(rect.size.width - 20, CGFLOAT_MAX);
//    CGSize size = [_htmlLabel sizeThatFits:maxSize];
    
    _htmlLabel.frame = CGRectMake(10, 10, self.view.bounds.size.width - 20, height);
    
    mScrollView.contentSize = CGSizeMake(0, height + 20);
}

@end
