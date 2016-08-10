//
//  ChairmanPageController.m
//  Egive
//
//  Created by sinogz on 15/9/10.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ChairmanPageController.h"
#import "baseController.h"
#import "MenuViewController.h"
@interface ChairmanPageController (){
  
    UILabel *titleLabel;

}

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *imageScrollView;

@property (nonatomic, assign) NSInteger imageNum;

@end

@implementation ChairmanPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:15];  //设置文本字体与大小
    titleLabel.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]; //设置文本颜色
    titleLabel.textAlignment=NSTextAlignmentLeft;
    titleLabel.text = EGLocalizedString(@"AboutGird_label_title2", nil);  //设置标题
    self.navigationItem.titleView = titleLabel;
    
    //self.title = EGLocalizedString(@"AboutGird_label_title2", nil);
    
    
    
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    mScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    mScrollView.backgroundColor = [UIColor clearColor];
    mScrollView.delegate = self;
    [self.view addSubview:mScrollView];

    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 33, 33);
    [rightButton addTarget:self action:@selector(rightButton) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_share@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 220)];
    _imageScrollView.showsHorizontalScrollIndicator = NO;
    _imageScrollView.pagingEnabled = YES;
    _imageScrollView.delegate = self;
    [mScrollView addSubview:_imageScrollView];
    
//    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 200, kScreenW, 20)];
//    _pageControl.numberOfPages = 1;
//    [mScrollView addSubview:_pageControl];
//    [_pageControl addTarget:self action:@selector(pageControlAction) forControlEvents:UIControlEventValueChanged];

    
    currentY = CGRectGetMaxY(_imageScrollView.frame) + 10;
    _imageNum = 0;
    [self addMySlider];
    [self getStaticPageContentWithFormID:@"Chairman"];
}

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButton{
    
    NSString * string = @"";
    NSString * subject = @"";
    if ([EGUtility getAppLang]==1) {
        NSString *str = @"Egive 意贈慈善基金由一群熱心公益的社會賢達創辦，旨在團結個人力量，以生命影響生命的方法，透過互聯網募捐平台不分地域、文化、族裔和語言，將受惠者、捐款者及公眾緊密連繫起來，宣揚關懷互愛的訊息，共建關懷互助的社群，以達致「網絡相連．善心相傳」之效\n\n請瀏覽: http://www.egive4u.org/";
        string = str;
        subject = @"Egive 意贈慈善基金";
        
    }else if ([EGUtility getAppLang]==2){
        NSString *str = @"Egive 意赠慈善基金由一群热心公益的社会贤达创办，旨在团结个人力量，以生命影响生命的方法，透过互联网募捐平台不分地域、文化、族裔和语言，将受惠者、捐款者及公众紧密连系起来，宣扬关怀互爱的讯息，共建关怀互助的社群，以达致「网络相连．善心相传」之效。\n\n请浏览: http://www.egive4u.org/";
        string = str;
        subject = @"Egive 意赠慈善基金";
    }else{
        
        NSString * str = [NSString stringWithFormat:@"\"Egive\" was founded by a group of public-spirited community leaders who aim to gather everyone to touch the lives of each other. \n\n For more details, please visit us at www.egive4u.org\n\n"];
        string = str;
        
        subject = @"Egive For You Charity Foundation";
    }
    
    
    [MenuViewController shareToSocialNetworkWithSubject:subject content:string url:nil image:nil];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x / kScreenW;
}

-(void)pageControlAction
{
    [_imageScrollView setContentOffset:CGPointMake(_pageControl.currentPage*kScreenW, 0) animated:YES];
}

- (void)parseHTMLTest:(NSString*)htmlString
{    
    NSString *html = @"<ul id=\"ctl00_cnt_PageContent_ContentList\" class=\"ContentList\" style=\"padding-top:40px; text-align:justify;\"><li><p><img class=\"ChairmanPhoto\" src=\"images/chairman.jpg\" style=\"width:430px;\" alt=\"曹貴子醫生\" /></p><p class=\"chairmantitle\">「意贈慈善基金」董事會主席暨創辦人<br /><span class=\"signature\">曹貴子醫生</span></p><p>生命無常，每當我們面對死亡、疾病、貧窮、天災，總是<br />渴望出現守護者，在黑暗中找到方向。我們不能夠阻止<br />厄運，但人人都可以付出一點，為身邊人帶來希望。<br />「意贈慈善基金」（下稱「意贈」）相信，改變世界不是<br />靠少數人付出很多，而是每個人都可以付出一點，聚沙<br />成塔的力量，才真正為有需要人士帶來勇氣及正能量，<br />構建網絡互助的社會。</p><p>互聯網世界將全球人類聯繫在一起，不分年齡、地區、<br />種族、貧富。隨著社會發展，昔日因地域所限，社群間<br />依靠鄰里互助，今日地球另一端的需要，我們彈指之間<br />也可提供即時幫助。</p><p>「意贈」網站突破傳統捐款模式，更自主、直接捐助有<br />需要人士，利用互聯網可以不受時空、地域的限制，將<br />善款、關注及祝福直接送予受惠者。透過網上捐款，善長<br />可以選擇指定的受惠者，透過網站了解其需求，捐款後亦<br />可以跟進受惠者的現況。同時，「意贈」會透過更新網站<br />資訊，讓捐款者及公眾一起監察善款的運用，透明度高，<br />確保善款依據善長意願而分配，令大家捐款更放心。</p><p>這個點對點的全球性互聯網募捐平台，希望為公益事業<br />開拓一個新紀元，亦可補足政府或社福機構未能完全涵蓋<br />的服務範疇。捐款者不再單靠可信的機構分配善款，亦<br />可以自主地選擇受惠者，雙方更可以互動關懷，並發動<br />身邊人一起參與慈善工作，達到「網絡相連，善心相傳」<br />的效果。捐款者幫助受惠者，受惠者未來也可以通過<br />「意贈」回饋有需要的捐款者及其他人士，讓關愛得以<br />延續。</p><p>「意贈慈善基金」希望可以匯聚全球數以十億計的網民，<br />通過「意贈」發放的資訊，引發他們的關注和參與。我們<br />希望人人都可以按自己的能力參與其中，捐款多寡並不<br />重要，只要有「助人」之心才最值得重視。因為在受惠者<br />心中，每個人的支持都是如此寶貴，正所謂「一方有難，<br />八方支援」，我們希望匯集網民的愛心，令「意贈」的<br />參與者都可以感受到這份雪中送炭的溫暖。</p><p>所以，我鼓勵大家為「意贈」捐善款、捐時間、捐才能，<br />又或在網上擔任守護者，天天為有需要人士送上關懷與<br />祝福。大家一起邁出一小步，用愛改變世界。現時<br />「意贈」只是初起步，「意贈」需要大家群策群力，多加<br />指導，為世界發放更多正能量。</p></li></ul>";
    
    html = [html stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    
    NSData *dataTitle=[html dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
    
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//ul"];
    
    [self parseElements:elements];
}

- (void)addSubImageView:(NSURL *)imageURL
{
    if (_imageNum) {
        _pageControl.numberOfPages = _imageNum + 1;
    }
    UIImageView * imageView = [_imageScrollView addImageViewWithFrame:CGRectMake(kScreenW*_imageNum, 0, kScreenW, 220) image:nil];
    _imageScrollView.contentSize = CGSizeMake(kScreenW*(++_imageNum), 0);
    [imageView sd_setImageWithURL:imageURL];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
}

@end
