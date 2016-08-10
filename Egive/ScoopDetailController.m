//
//  ScoopDetailController.m
//  Egive
//
//  Created by sinogz on 15/9/7.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ScoopDetailController.h"
#import "AppDelegate.h"
#import "baseController.h"
#import "EGUtility.h"
#import "UIView+ZJQuickControl.h"
#import "MJPhotoBrowser.h"
#import "BannerAdViewController.h"
#import "MenuViewController.h"
#import "AnyWebViewController.h"

#define ScreenSize [UIScreen mainScreen].bounds.size

@interface ScoopDetailController ()<UITableViewDataSource, UITableViewDelegate,MJPhotoBrowserDelegate,UIWebViewDelegate>
{
    BOOL hasMore;
}

@property (nonatomic, strong) EGEventDtl *eventDtl;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomPanel;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UIButton *hiddenBtn;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * descLabel;
@property (nonatomic, strong) UILabel * dateLabel;
@property (nonatomic, strong) UILabel * locationLabel;
@property (nonatomic, assign) CGSize  descLabelSize;
@property (nonatomic, strong) UIScrollView * desScrollView;
@property (nonatomic, strong)UIView *sliderView;
@property (nonatomic, assign) UISlider *slider;

@property (nonatomic) CGRect viewTemp;
@property (nonatomic) CGRect desScrollViewTemp;
@property (nonatomic) CGRect dateLabelTemp;
@property (nonatomic) CGRect webviewTemp;

@property (nonatomic, strong) UIWebView * webview;
@end

#define MaxHeight 30

@implementation ScoopDetailController

- (id)initWithEventDtl:(EGEventDtl *)eventDtl
{
    if (self = [super init]) {
        _eventDtl = eventDtl;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = EGLocalizedString(@"DonationInfo_scoopButton", nil);
    hasMore = NO;
    
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
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_share@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.view.backgroundColor = [UIColor clearColor];
    [self setupTableView];
    [self setupBottomPanel];
    [self addMySlider];
    
}

- (void)rightAction{
    NSString * string = @"";
    NSString * subject = @"";
    if ([EGUtility getAppLang]==1) {
        NSString *str = [NSString stringWithFormat:@"Egive - 活動花絮\n%@\n精彩活動花絮已上載，請瀏覽:http://www.egive4u.org/EventTitle.aspx\n\n意贈慈善基金\nEgive For You Charity Foundation\n電話: (852) 2210 2600\n電郵: info@egive4u.org",self.eventDtl.Title];
        string = str;
        subject = [NSString stringWithFormat:@"Egive活動花絮 - %@",self.eventDtl.Title];
    }else if ([EGUtility getAppLang]==2){
        NSString *str = [NSString stringWithFormat:@"Egive - 活动花絮\n%@\n精彩活动花絮已上载，请浏览:http://www.egive4u.org/EventTitle.aspx\n\n意赠慈善基金\nEgive For You Charity Foundation\n电話: (852) 2210 2600\n电邮: info@egive4u.org",self.eventDtl.Title];
        string = str;
        subject = [NSString stringWithFormat:@"Egive活动花絮 - %@",self.eventDtl.Title];
    }else{
        
        NSString * str = [NSString stringWithFormat:@"Egive - Event Highlights\n%@\nPlease visit http://www.egive4u.org/EventTitle.aspx for more event highlights!\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org",self.eventDtl.Title];
        string = str;
        subject = [NSString stringWithFormat:@"Egive - Event Highlights %@",self.eventDtl.Title];
    }
    
    [MenuViewController shareToSocialNetworkWithSubject:subject content:string url:nil image:nil];
    
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

- (void) viewWillAppear:(BOOL)animated
{
    if (_eventDtl.Img.count < 3) {
        [self moreAction:nil];
        float delta = 45 + (ScreenSize.width/2) - ((IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) ? 72 : 0);
//        _titleLabel.frame = CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y - delta, _titleLabel.frame.size.width, _titleLabel.frame.size.height);
//        _descLabel.frame = CGRectMake(_descLabel.frame.origin.x, _descLabel.frame.origin.y - delta, _descLabel.frame.size.width, _descLabel.frame.size.height);
//        _dateLabel.frame = CGRectMake(_dateLabel.frame.origin.x, _dateLabel.frame.origin.y - delta, _dateLabel.frame.size.width, _dateLabel.frame.size.height);
        _tableView.scrollEnabled = NO;
    } else if (_eventDtl.Img.count < 5) {
        [self moreAction:nil];
        float delta = 50 - ((IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) ? 50 : 0);
//        _titleLabel.frame = CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y - delta, _titleLabel.frame.size.width, _titleLabel.frame.size.height);
//        _descLabel.frame = CGRectMake(_descLabel.frame.origin.x, _descLabel.frame.origin.y - delta, _descLabel.frame.size.width, _descLabel.frame.size.height);
//        _dateLabel.frame = CGRectMake(_dateLabel.frame.origin.x, _dateLabel.frame.origin.y - delta, _dateLabel.frame.size.width, _dateLabel.frame.size.height);
        _tableView.scrollEnabled = NO;
    }
    
    if (_eventDtl.Img.count > 4) {
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, ScreenSize.width/2, 0);
    }
}

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

- (void)setupBottomPanel
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    view.userInteractionEnabled = YES;
    [self.view addSubview:view];
    self.bottomPanel = view;
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.0;
    [view addGestureRecognizer:longPressGr];
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDo:)];
    [view addGestureRecognizer:tapGr];
    
    NSString *title = self.eventDtl.Title;
    NSString *descText = self.eventDtl.Desp;
    NSString *date = [NSString stringWithDataString:self.eventDtl.EventStartDate];
    NSString *dateText = [NSString stringWithFormat:@"%@ %@",EGLocalizedString(@"Date", nil),date];
    NSString *Location = self.eventDtl.Location;
    
    CGFloat posX = kDefaultMargin;
    CGFloat posY = kDefaultMargin;
    
    CGSize maxSize = CGSizeMake(kScreenW - kDefaultMargin*2, MAXFLOAT);
    CGSize size = EG_MULTILINE_TEXTSIZE(title, kTitleTextFont, maxSize, NSLineBreakByWordWrapping);
    
    _titleLabel = [view addLabelWithFrame:CGRectMake(posX, posY, ScreenSize.width-60, size.height) text:title];
    //_titleLabel.backgroundColor = [UIColor redColor];
    _titleLabel.numberOfLines = 2;
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    
    _locationLabel = [view addLabelWithFrame:CGRectMake(posX, posY+25, ScreenSize.width-30, size.height) text:[NSString stringWithFormat:@"%@%@",EGLocalizedString(@"DonationInfo_foreshow_address", nil),Location]];
    _locationLabel.font = [UIFont systemFontOfSize:10];
    _locationLabel.numberOfLines = 2;
    
    
    CGFloat tempMargin = 15.0;
    _hiddenBtn = [view addImageButtonWithFrame:CGRectMake(ScreenSize.width-60, posY, 60, size.height) title:EGLocalizedString(@"隐藏", nil)  backgroud:nil action:^(UIButton *button) {
        
        _hiddenBtn.hidden = YES;
//        view.frame = CGRectMake(0, kScreenH - 100 , kScreenW, 100);
//        _dateLabel.frame = CGRectMake(5, 80, size.width, size.height);
//        _desScrollView.frame = CGRectMake(0, 55, ScreenSize.width, 30);
        _moreBtn.hidden = NO;
        hasMore = YES;
        view.frame = _viewTemp;
        _dateLabel.frame = _dateLabelTemp;
        _desScrollView.frame = _desScrollViewTemp;
        _webview.frame = _webviewTemp;
    }];
    _hiddenBtn.hidden = YES;
    _hiddenBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_hiddenBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    posY = CGRectGetMaxY(_titleLabel.frame) + kDefaultMargin;
    size = EG_MULTILINE_TEXTSIZE(descText, kDescTextFont, maxSize, NSLineBreakByWordWrapping);
    _descLabelSize = size;
    
    if (size.height > MaxHeight) {
        size.height = MaxHeight;
        hasMore = YES;
    }
    
    _desScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(posX, posY+_titleLabel.frame.size.height-10+10, ScreenSize.width, size.height+tempMargin)];
    _desScrollViewTemp = _desScrollView.frame;
    [view addSubview:_desScrollView];
    
    _desScrollView.hidden = YES;
    
    
    NSString *html = @"<html><body><div id='content' style='font-size:15'>%@</div></body></html>";
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(posX, posY+_titleLabel.frame.size.height-10+10, ScreenSize.width, size.height+tempMargin)];
    _webviewTemp = _webview.frame;
    _webview.delegate = self;
    [_webview loadHTMLString:[NSString stringWithFormat:html,descText] baseURL:nil];
    _webview.backgroundColor = [UIColor clearColor];
    _webview.opaque = NO;
    [view addSubview:_webview];
    
    UILabel * descLabel = [_desScrollView addLabelWithFrame:CGRectMake(0, 0, size.width, size.height+tempMargin) text:descText];
    descLabel.numberOfLines = 0;
    descLabel.font = kDescTextFont;
    _descLabel = descLabel;
    
    //
// posY = CGRectGetMaxY(descLabel.frame) + kDefaultMargin;
    posY = CGRectGetMaxY(_desScrollView.frame) + kDefaultMargin;
    size = EG_TEXTSIZE(dateText, kDescTextFont);
    UILabel * dateLabel = [view addLabelWithFrame:CGRectMake(posX, posY, size.width, size.height) text:dateText];
    dateLabel.font = kDescTextFont;
    _dateLabel = dateLabel;
    _dateLabelTemp = dateLabel.frame;
    
    
    if (hasMore) {
        UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
        more.frame = CGRectMake(kScreenW -kDefaultMargin - size.width/2, posY, size.width/2, size.height);
        [more addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
        [more setTitle:EGLocalizedString(@"More", nil) forState:UIControlStateNormal];
        [more setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        more.titleLabel.font = [UIFont systemFontOfSize:15];
        [view addSubview:more];
        _moreBtn = more;
    }
    
    posY = CGRectGetMaxY(dateLabel.frame) + kDefaultMargin;
    view.frame = CGRectMake(0, kScreenH - posY-tempMargin , kScreenW, posY+tempMargin);
    _viewTemp = view.frame;

}

- (void)moreAction:(UIButton *)button
{
    _moreBtn.hidden = YES;
    hasMore = NO;
    _hiddenBtn.hidden = NO;
    
    CGRect frame = _descLabel.frame;
    frame.size.height = _descLabelSize.height;
    _descLabel.frame = frame;
//    _desScrollView.frame = CGRectMake(frame.origin.x, _desScrollView.frame.origin.y, frame.size.width, frame.size.height-50);
    _desScrollView.frame = CGRectMake(frame.origin.x, _desScrollView.frame.origin.y, frame.size.width, SCREEN_HEIGHT*0.4);
    _desScrollView.contentSize = CGSizeMake(0, frame.size.height);
    
    
    //
    _webview.frame = CGRectMake(_webview.frame.origin.x, _webview.frame.origin.y, _webview.frame.size.width, SCREEN_HEIGHT*0.4);
    //MyLog(@"%@",[NSValue valueWithCGSize:_webview.scrollView.contentSize]);
    CGFloat documentWidth = [[_webview stringByEvaluatingJavaScriptFromString:@"document.getElementById('content').offsetWidth"] floatValue];
    CGFloat documentHeight = [[_webview stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"content\").offsetHeight;"] floatValue];
    MyLog(@"documentSize = {%f, %f}", documentWidth, documentHeight);
    
    
    //
    frame = _dateLabel.frame;
//    frame.origin.y = CGRectGetMaxY(_descLabel.frame) + kDefaultMargin;
    frame.origin.y = CGRectGetMaxY(_webview.frame) + 10;
    _dateLabel.frame = frame;
    if (documentHeight>0) {
        _dateLabel.frame = (CGRect){_dateLabel.frame.origin.x,_webview.frame.origin.y+documentHeight+15,_dateLabel.frame.size.width,15};
    }
    
    CGFloat posY = CGRectGetMaxY(_dateLabel.frame) + kDefaultMargin;

//    _bottomPanel.frame = CGRectMake(0, kScreenH - posY, kScreenW, posY);
    _bottomPanel.frame = CGRectMake(0, kScreenH*0.3, kScreenW, SCREEN_HEIGHT*0.7);
}


- (void)bottomPanelHide
{
    CGFloat offY1 = kScreenH - _tableView.contentSize.height;
    
    if (_bottomPanel.frame.size.height <= offY1) {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        //self.bottomPanel.transform=CGAffineTransformIdentity;
        self.bottomPanel.transform=CGAffineTransformMakeTranslation(0, self.bottomPanel.frame.size.height);
        self.bottomPanel.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)bottomPanelShow
{
    CGFloat offY1 = kScreenH - _tableView.contentSize.height;
    if (_bottomPanel.frame.size.height <= offY1) {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomPanel.alpha = 1.0f;
        self.bottomPanel.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        
    }];

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self bottomPanelHide];
    if (!_sliderView.hidden) {
        _sliderView.hidden = YES;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self bottomPanelShow];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //[self bottomPanelShow];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = _eventDtl.Img.count;
    if (count) {
        NSInteger width = (kScreenW - cellMargin)/columnMax;
        NSInteger rows = (count - 1)/columnMax + 1;
        MyLog(@"rows == %d", rows);
        return width * rows + cellMargin;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScoopDetailCell *cell = [ScoopDetailCell cellWithTableView:tableView eventDtl:_eventDtl];
    
    return cell;
}


//
//- (void)photoBrowser:(MJPhotoBrowser *)photoBrowser didChangedToPageAtIndex:(NSUInteger)index{
////    photoBrowser.leftDetail = _currentDict[@"ImgCaption"];
//    
//}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


#pragma mark - webview delegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSURL *url = request.URL;
    
    
    if (url && [url.absoluteString hasPrefix:@"http"]) {
        AnyWebViewController * vc = [[AnyWebViewController alloc] init];
        [vc setAbsoluteURL:url.absoluteString];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        return NO;
    }
    
   
    
    
    return YES;
}


#pragma mark - other

-(void)addMySlider{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 568 - 90, 320 - 20, 47)];
    view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    view.layer.cornerRadius = 3;
    view.layer.masksToBounds = YES;
    [self.view addSubview:view];
    _sliderView = view;
    _sliderView.hidden = YES;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 27, 27)];
    label1.font = [UIFont systemFontOfSize:15];
    label1.text = @"A";
    [view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake( view.frame.size.width - 30, 10, 27, 27)];
    label2.font = [UIFont systemFontOfSize:20];
    label2.text = @"A";
    [view addSubview:label2];
    
    UISlider *sliderA=[[UISlider alloc]initWithFrame:CGRectMake(25, 20, view.frame.size.width - 60, 7)];
    sliderA.backgroundColor = [UIColor clearColor];
    sliderA.value=0.5;
    sliderA.minimumValue=0.0;
    sliderA.maximumValue=1.0;
    _slider = sliderA;
    
    //滑块拖动时的事件
    //    [sliderA addTarget:self action:@selector(sliderValueChanged) forControlEvents:UIControlEventValueChanged];
    //滑动拖动后的事件
    [sliderA addTarget:self action:@selector(sliderDragUp) forControlEvents:UIControlEventTouchUpInside];
    
    [self.sliderView addSubview:sliderA];
    
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.0;
    [_tableView addGestureRecognizer:longPressGr];
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDo:)];
    [_tableView addGestureRecognizer:tapGr];
}



- (void)tapToDo:(UITapGestureRecognizer *)gr
{
    if (!_sliderView.hidden) {
        _sliderView.hidden = YES;
    }
}

-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        //add your code here
        if (_sliderView.hidden) {
            _sliderView.hidden = NO;
        }
    }
}

-(void)sliderDragUp{
    
    float value = _slider.value;
    float change = 6*(value - 0.5);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    //    ForeshowDetailCell * cell = (ForeshowDetailCell*)[_tableView cellForRowAtIndexPath:indexPath];
//    UITableViewCell * cell = (UITableViewCell*)[_tableView cellForRowAtIndexPath:indexPath];
    CGFloat fontSize = 15 + change;
//    _font =[UIFont systemFontOfSize:fontSize];
    _descLabel.font = [UIFont systemFontOfSize:fontSize];
    CGSize retSize = EG_MULTILINE_TEXTSIZE(_descLabel.text, _descLabel.font, CGSizeMake(300,CGFLOAT_MAX), NSLineBreakByWordWrapping);
    _descLabel.frame = CGRectMake(0, 0, _descLabel.frame.size.width, retSize.height);
    _desScrollView.contentSize = CGSizeMake(0, _descLabel.frame.size.height);
 
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
