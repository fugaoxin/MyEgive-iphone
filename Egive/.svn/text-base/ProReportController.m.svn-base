//
//  ProReportController.m
//  Egive
//
//  Created by sino on 15/7/28.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "Constants.h"
#import "ProReportController.h"
#import "UIView+ZJQuickControl.h"
#import "ProReportCell.h"
#import "EGDropDownMenu.h"
#import "baseController.h"
#import "EGUtility.h"
#import "AFHTTPRequestOperation.h"
#import "NSString+RegexKitLite.h"
#import "ModelTool.h"
#import "ProReportModel.h"
#import "MenuViewController.h"
#import "AppDelegate.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface ProReportController ()<EGDropDownMenuDelegate>
{
    UIView * _topTabaleView;
    UIFont *_font;
    UIView * topView;
    UILabel *noContentlabel;
    UIButton * rightButton;
    int selectindex;
    UIImageView * galleryImg;
}
@property (nonatomic, strong)UIView *sliderView;
@property (nonatomic, assign) UISlider *slider;
@property (nonatomic) CGSize retSize;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) UIScrollView * imageScrollView;
@property (strong, nonatomic) UIPageControl  * pageControl;
@property (nonatomic) int page;
@property(retain,nonatomic)NSMutableArray *reportArray;
@end

@implementation ProReportController

- (void)viewDidLoad {
    [super viewDidLoad];
     selectindex=0;
    // Do any additional setup after loading the view.
    noContentlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenSize.height/2+10, ScreenSize.width, 20)];
    noContentlabel.text = EGLocalizedString(@"NoContent", nil);
    noContentlabel.textAlignment  =NSTextAlignmentCenter;
    noContentlabel.textColor = [UIColor blackColor];
    [self.view addSubview:noContentlabel];
    self.title = EGLocalizedString(@"GirdView_report_label", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    self.reportArray = [[NSMutableArray alloc] init];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 33, 33);
        [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_share@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults objectForKey:@"caseId"]) {
        
        [self requestApiData:[standardUserDefaults objectForKey:@"caseId"]];
        [standardUserDefaults removeObjectForKey:@"caseId"];
        
    }else{
        [self requestApiData:_caseId];
    }
    //_dataArray = [[NSMutableArray alloc] init];
     _font = [UIFont systemFontOfSize:18];
    [self createTableView];
    [self createUI];
    [self addMySlider];
}

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightAction{
    
    MyLog(@"self.nameString=%@",self.nameString);
    NSString * string = @"";
    NSString * subject = @"";
    MyLog(@"self.nameString%@",self.nameString);
    if ([EGUtility getAppLang]==1) {
        NSString *str = [NSString stringWithFormat:@"Egive – 進度報告:%@ - %@/CaseUpdate.aspx?CaseID=%@\n\n請瀏覽: http://www.egive4u.org/\n\n意贈慈善基金\nEgive For You Charity Foundation\n電話: (852) 2210 2600\n電郵: info@egive4u.org",[self.nameString stringByReplacingOccurrencesOfString:@"(null)" withString:@""],SITE_URL,_caseId];
        string = str;
        subject = [NSString stringWithFormat:@"Egive專案"];
        
    }else if ([EGUtility getAppLang]==2){
        NSString *str = [NSString stringWithFormat:@"Egive – 进度报告:%@ - %@/CaseUpdate.aspx?CaseID=%@\n\n请浏览: http://www.egive4u.org/\n\n意赠慈善基金\nEgive For You Charity Foundation\n电话: (852) 2210 2600\n电邮: info@egive4u.org",[self.nameString stringByReplacingOccurrencesOfString:@"(null)" withString:@""],SITE_URL,_caseId];
        string = str;
        subject = [NSString stringWithFormat:@"Egive专案"];
    }else{
        
        NSString * str = [NSString stringWithFormat:@"Egive - Progress Report:%@ - %@/CaseUpdate.aspx?CaseID=%@\n\nVisit us at www.egive4u.org\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org",[self.nameString  stringByReplacingOccurrencesOfString:@"(null)" withString:@""],SITE_URL,_caseId];
        string = str;
        subject = [NSString stringWithFormat:@"Egive - Events"];
    }
    
    [MenuViewController shareToSocialNetworkWithSubject:subject content:string url:nil image:nil];

    //    NSString *string = [NSString stringWithFormat:@"Egive -意贈活動\n%@\n活動詳情，請瀏覽:\n\n意贈慈善基金\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail:info@egive4u.org",self.eventDtl.Title]; // TODO
    
    
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
- (void)createUI{
    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 65,ScreenSize.width,40)];
    topView.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    [self.view addSubview:topView];
    
//    UIView * downMenuView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, 300, 30)];
//    downMenuView.backgroundColor = [UIColor whiteColor];
//    [topView addSubview:downMenuView];
   
    
//    UILabel * proLabel = [downMenuView addLabelWithFrame:CGRectMake(5, 5, 200, 20) text:@"2015年5月22日"];
//    proLabel.font = [UIFont systemFontOfSize:12];
//    
//    UILabel * reportLabel = [downMenuView addLabelWithFrame:CGRectMake(220, 5, 60, 20) text:@"(报告4)"];
//    reportLabel.font = [UIFont systemFontOfSize:12];
//    
//    [downMenuView addImageViewWithFrame:CGRectMake(270, 10, 15, 10) image:@"downMune.png"];

}
#pragma mark - 请求Cell数据
-(void)requestApiData:(NSString *)caseID{
//    [self showLoadingAlert];
    long lang = [EGUtility getAppLang];
    _dataArray = [[NSMutableArray alloc] init];
    NSString * soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCaseDtl xmlns=\"egive.appservices\"><Lang>%ld</Lang><CaseID>%@</CaseID><MemberID></MemberID></GetCaseDtl></soap:Body></soap:Envelope>",lang,caseID];
    
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
        //        MyLog(@"%@", operation.request.allHTTPHeaderFields);
        //        // 服务器给我们返回的包得头部信息
        //                MyLog(@"%@", operation.response);
        //        返回的数据
        //        MyLog(@"success = %@",responseObject);
//        [self removeLoadingAlert];
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary * dataDict = [NSString parseJSONStringToNSDictionary:dataString];
        
        MyLog(@"dataDict=%@",dataDict);
        
        if (![dataDict[@"UpdatesDetail"] isEqual:[NSNull null]]){
            
        NSArray * arr = dataDict[@"UpdatesDetail"];
        if (arr.count > 0) {
            for (NSDictionary * dict in arr) {
                ProReportModel * model = [[ProReportModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [_dataArray addObject:model];
            }
        }
        
        for ( ProReportModel * model in _dataArray){
     NSString *report = [NSString stringWithFormat:@"(%@ %@)",EGLocalizedString(@"GirdView_report_label", nil),model.CaseUpdateIndex];
            
            if (IS_IPHONE_6) {
                
                report = [NSString stringWithFormat:@"%@%@%@",model.UpdateDate,
                          @"                            ",report];
                
            }else if (IS_IPHONE_6P){
            
                report = [NSString stringWithFormat:@"%@%@%@",model.UpdateDate,
                          @"                                    ",report];
            
            }else if (IS_IPHONE_5){
            
                report = [NSString stringWithFormat:@"%@%@%@",model.UpdateDate,
                          @"         ",report];
            
            }else{
            
                report = [NSString stringWithFormat:@"%@%@%@",model.UpdateDate,
                          @"           ",report];
            }
   
            [self.reportArray addObject:report];
            
            //NSArray * arr = @[@[report1,report2]];

            
        }
       
       
        if (self.reportArray.count > 0){
//          NSArray * arr1 = @[@[[self.reportArray objectAtIndex:0]]];
//            NSArray *array = [[NSArray alloc] arrayByAddingObjectsFromArray:self.reportArray];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            [array addObject:self.reportArray];
            EGDropDownMenu *menu = [[EGDropDownMenu alloc] initWithFrame:CGRectMake(10, 72, ScreenSize.width-20, 25) Array:array selectedColor:[UIColor grayColor]];
             menu.delegate = self;
            [self.view addSubview:menu];
        }
    
        
        }
        
        [self ChangePic:0];
        [_tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        MyLog(@"%@", operation.request.allHTTPHeaderFields);
        // 服务器给我们返回的包得头部信息
        MyLog(@"%@", operation.response);
        // 返回的数据
        MyLog(@"success = %@", error);
//        [self removeLoadingAlert];
    }];
    
    [operation start];
    
}



-(void)ChangePic:(int)index{
    
    if (_dataArray.count > 0){
        
        for (UIView *views in _imageScrollView.subviews) {
            
           
                
                [views removeFromSuperview];
            
            
        }
        
        self.tableView.hidden=NO;
        rightButton.enabled=YES;
        ProReportModel * model = _dataArray[index];
        _pageControl.numberOfPages = model.GalleryImg.count;
        _imageScrollView.contentSize = CGSizeMake(ScreenSize.width*model.GalleryImg.count, 0);
        if (model.GalleryImg.count == 0) {
            [_imageScrollView addImageViewWithFrame:CGRectMake(0, 0, ScreenSize.width, 200) image:@"dummy_case_related_default@2x.png"];
            _imageScrollView.contentMode = UIViewContentModeScaleAspectFit;
        }
        
        for (int i = 0; i < model.GalleryImg.count; i++){
            NSDictionary * dict = model.GalleryImg[i];
            NSURL *url = [NSURL URLWithString:SITE_URL];
            url = [url URLByAppendingPathComponent:dict[@"ImgURL"]];
             galleryImg = [_imageScrollView addImageViewWithFrame:CGRectMake(ScreenSize.width*i, 0, ScreenSize.width, 220) image:nil];
            
            if (![dict[@"ImgURL"] isEqualToString:@""]){
                [galleryImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
                galleryImg.contentMode = UIViewContentModeScaleAspectFit;
            }else{
                [galleryImg setImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"]];
                galleryImg.contentMode = UIViewContentModeScaleAspectFit;
            }
            
        }
        
       
    }else{
        
        galleryImg = [_imageScrollView addImageViewWithFrame:CGRectMake(0, 0, ScreenSize.width, 220) image:nil];
        galleryImg.contentMode = UIViewContentModeScaleAspectFit;
        topView.backgroundColor = [UIColor whiteColor];
        self.tableView.hidden=YES;
        rightButton.enabled=NO;
        [_topTabaleView addImageViewWithFrame:CGRectMake(0, 220, ScreenSize.width, 2) image:nil];
    }

}

//过滤数据
- (void)dropDownMenu:(EGDropDownMenu *)dropDownMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectindex = indexPath.row;
    [self ChangePic:selectindex];
    [self.tableView reloadData];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    _page = point.x/ScreenSize.width;
    _pageControl.currentPage = _page;
    
}

-(void)pageControlAction{
    int page = (int)_pageControl.currentPage;
    [_imageScrollView setContentOffset:CGPointMake(ScreenSize.width*page, 0) animated:YES];
    
}

- (void)createTableView{
    _topTabaleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 250)];
    [self.view addSubview:_topTabaleView];
   
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 180, ScreenSize.width, 20)];
    _pageControl.currentPage = _page;
    [_topTabaleView addSubview:_pageControl];
    [_pageControl addTarget:self action:@selector(pageControlAction) forControlEvents:UIControlEventValueChanged];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 105,ScreenSize.width, ScreenSize.height-105) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = _topTabaleView;
    
//    _showImage = [_topTabaleView addImageViewWithFrame:CGRectMake(0, 0,ScreenSize.width, 200) image:nil];
//    _showImage.contentMode = UIViewContentModeScaleAspectFit;
    
    _imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 200)];
    _imageScrollView.showsHorizontalScrollIndicator = NO;
    _imageScrollView.pagingEnabled = YES;
    _imageScrollView.delegate = self;
    [_topTabaleView insertSubview:_imageScrollView belowSubview:_pageControl];
    if (_dataArray.count !=  0){
        
        self.tableView.hidden=NO;
        ProReportModel * model = _dataArray[0];
        
        _imageScrollView.contentSize = CGSizeMake(ScreenSize.width*model.GalleryImg.count, 0);
        if (model.GalleryImg.count == 0){
            [_imageScrollView addImageViewWithFrame:CGRectMake(0, 0, ScreenSize.width, 200) image:@"dummy_case_related_default@2x.png"];
            _imageScrollView.contentMode = UIViewContentModeScaleAspectFit;
        }
        
        for (int i = 0; i < model.GalleryImg.count; i ++){
            NSDictionary * dict = model.GalleryImg[i];
            NSURL *url = [NSURL URLWithString:SITE_URL];
            url = [url URLByAppendingPathComponent:dict[@"ImgURL"]];
            UIImageView * galleryImg = [_imageScrollView addImageViewWithFrame:CGRectMake(ScreenSize.width*i, 0, ScreenSize.width, 220) image:nil];
            
            if (![dict[@"ImgURL"] isEqualToString:@""]) {
                [galleryImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
                 galleryImg.contentMode = UIViewContentModeScaleAspectFit;
            }else{
                [galleryImg setImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"]];
                 galleryImg.contentMode = UIViewContentModeScaleAspectFit;
            }
            
        }
        
         [_topTabaleView addImageViewWithFrame:CGRectMake(0, 220, ScreenSize.width, 2) image:@"Line@2x.png"];
    }else{
        UIImageView * galleryImg = [_imageScrollView addImageViewWithFrame:CGRectMake(0, 0, ScreenSize.width, 220) image:nil];
        galleryImg.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    
   

    _titleLabel = [_topTabaleView addLabelWithFrame:CGRectMake(10, 205, 200, 25) text:nil];
    _titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _titleLabel.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    
   

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

     //return _retSize.height + 100;
       return 250;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    ProReportCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[ProReportCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (_dataArray.count > 0){
        
        ProReportModel * model = _dataArray[selectindex];
        cell.proReport.text = [NSString stringWithFormat:@"%@",model.CaseUpdateIndex];
        NSArray *array = [model.Content componentsSeparatedByString:@"<br>"];
        //cell.conten.text = [array objectAtIndex:0];
    
       [cell.webview loadHTMLString: [array objectAtIndex:0] baseURL:nil];
        cell.date.text = model.UpdateDate;
//        cell.conten.font = _font;
//        _retSize = EG_MULTILINE_TEXTSIZE(cell.conten.text, cell.conten.font, CGSizeMake(ScreenSize.width-20,CGFLOAT_MAX), NSLineBreakByWordWrapping);
//        
//        cell.conten.frame = CGRectMake(10, 60, ScreenSize.width-20, _retSize.height);
        
    }

    return cell;
 
}

-(void)addMySlider{
    UIDevice *device_=[[UIDevice alloc] init];
    int height=0;
    if (ScreenSize.height==480 || [device_.model isEqualToString:@"iPad"]) {
        
        height=380;
    }else{
        
        height=568 - 90;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, height, 320 - 20, 47)];
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
    //[sliderA addTarget:self action:@selector(sliderValueChanged) forControlEvents:UIControlEventValueChanged];
    //滑动拖动后的事件
    [sliderA addTarget:self action:@selector(sliderDragUp) forControlEvents:UIControlEventTouchUpInside];
    
    [self.sliderView addSubview:sliderA];
    
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.0;
    [_tableView addGestureRecognizer:longPressGr];
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDo:)];
    [_tableView addGestureRecognizer:tapGr];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (!_sliderView.hidden) {
        _sliderView.hidden = YES;
    }
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
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //ForeshowDetailCell * cell = (ForeshowDetailCell*)[_tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell * cell = (UITableViewCell*)[_tableView cellForRowAtIndexPath:indexPath];
    CGFloat fontSize = 18 + change;
    cell.textLabel.font = [UIFont systemFontOfSize:fontSize];
    _font =[UIFont systemFontOfSize:fontSize];
    [_tableView reloadData];
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
