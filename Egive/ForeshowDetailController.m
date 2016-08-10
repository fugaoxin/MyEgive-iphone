//
//  ForeshowDetailController.m
//  Egive
//
//  Created by sino on 15/8/19.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ForeshowDetailController.h"
#import "UIView+ZJQuickControl.h"
#import "ForeshowDetailCell.h"
#import "MenuViewController.h"
#import "ShowDetaileTableViewCell.h"
#import "Constants.h"
#import "GirdShowDetailePicViewController.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface ForeshowDetailController ()

@property (nonatomic, strong) EGEventDtl *eventDtl;
@property (nonatomic, strong)UIView *sliderView;
@property (nonatomic, assign) UISlider *slider;
@property(retain,nonatomic)NSMutableArray *picArray;

@end

@implementation ForeshowDetailController{

    NSString * str1;
    NSString * str2;
    UIFont *_font;

}

- (id)initWithEventDtl:(EGEventDtl *)eventDtl
{
    if (self = [super init]) {
        _eventDtl = eventDtl;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = EGLocalizedString(@"DonationInfo_foreshowButton2", nil);
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
     _font = [UIFont systemFontOfSize:16];
    [self createTabaleView];
    [self addMySlider];
}

- (void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightAction {
    
    NSString * string = @"";
    NSString * subject = @"";
    
    if ([EGUtility getAppLang]==1) {
        NSString *str = [NSString stringWithFormat:@"Egive -意贈活動\n%@\n活動詳情，請瀏覽:http://www.egive4u.org/EventPreview.aspx\n\n意贈慈善基金\nEgive For You Charity Foundation\n電話: (852) 2210 2600\n電郵: info@egive4u.org",self.eventDtl.Title];
        string = str;
         subject = [NSString stringWithFormat:@"Egive意贈活動 - %@",self.eventDtl.Title];
       
    }else if ([EGUtility getAppLang]==2){
        NSString *str = [NSString stringWithFormat:@"Egive -意赠活动\n%@\n活动详情，请浏览:http://www.egive4u.org/EventPreview.aspx\n\n意赠慈善基金\nEgive For You Charity Foundation\n电话: (852) 2210 2600\n电邮: info@egive4u.org",self.eventDtl.Title];
        string = str;
        subject = [NSString stringWithFormat:@"Egive意赠活动 - %@",self.eventDtl.Title];
    }else{
        
        NSString * str = [NSString stringWithFormat:@"Egive - Events\n%@\nPlease visit www.egive4u.org/EventPreview.aspx for event details.\n\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail: info@egive4u.org",self.eventDtl.Title];
        string = str;
         subject = [NSString stringWithFormat:@"Egive - Events - %@",self.eventDtl.Title];
    }

//    NSString *string = [NSString stringWithFormat:@"Egive -意贈活動\n%@\n活動詳情，請瀏覽:\n\n意贈慈善基金\nEgive For You Charity Foundation\nTel: (852) 2210 2600\nEmail:info@egive4u.org",self.eventDtl.Title]; // TODO
    
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

- (void)createTabaleView {
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 240)];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 200)];
    _scrollView.delegate = self;
    [topView addSubview:_scrollView];
    
    UIPageControl  * pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 180, ScreenSize.width, 20)];
    pageControl.numberOfPages = 1;
    [topView addSubview:pageControl];
    
    UIImageView * imageView = [_scrollView addImageViewWithFrame:CGRectMake(0, 0, ScreenSize.width, 200) image:@"dummy_case_related_default@2x.png"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    _picArray = [[NSMutableArray alloc] init];
    MyLog(@"%@",_eventDtl.Img);
    
    if (_eventDtl.Img.count){
        [_picArray addObject:_eventDtl.Img[0]];
        MyLog(@"%@",_picArray);
        NSString *ImgURL = _eventDtl.Img[0][@"ImgURL"];
        NSURL *url = [NSURL URLWithString:SITE_URL];
        url = [url URLByAppendingPathComponent:ImgURL];
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShowDetailePic)];
        
        [imageView addGestureRecognizer:tap];
    }
    
// [NSString stringWithFormat:@"%@(%@)",self.eventDtl.Title,self.eventDtl.Location]
  
    UILabel * titleLabel = [topView addLabelWithFrame:CGRectMake(5, 200, ScreenSize.width-10, 40) text:nil];
    titleLabel.numberOfLines=0;
    //titleLabel.backgroundColor=[UIColor redColor];
    if (![self.eventDtl.Location isEqualToString:@""]) {
        titleLabel.text =[NSString stringWithFormat:@"%@(%@)",self.eventDtl.Title,self.eventDtl.Location];
    }else{
        titleLabel.text = self.eventDtl.Title;
    }
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.numberOfLines = 2;
    titleLabel.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    
    [topView addImageViewWithFrame:CGRectMake(10, 240, ScreenSize.width-20, 2) image:@"Line@2x.png"];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableHeaderView = topView;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
}
-(void)ShowDetailePic{
    
    GirdShowDetailePicViewController *svc = [[GirdShowDetailePicViewController alloc] initWithNibName:@"GirdShowDetailePicViewController" bundle:nil];
    svc.PicArray  = _picArray;
    [self.navigationController pushViewController:svc animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"ShowDetaileTableViewCell";
    ShowDetaileTableViewCell *cell = (ShowDetaileTableViewCell *)[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if(cell == nil){
        cell = (ShowDetaileTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

     str1 = [self.eventDtl.EventStartDate substringToIndex:[self.eventDtl.EventStartDate length]/2+1];
    if (self.eventDtl.EventEndDate.length !=0) {
     str2 = [self.eventDtl.EventEndDate substringToIndex:[self.eventDtl.EventEndDate length]/2+1];

    
    }
    if ([str1 isEqualToString:str2]) {
        cell.DateContentLabel.text = [NSString stringWithDataString:self.eventDtl.EventStartDate];
    }else{
        
         if (self.eventDtl.EventEndDate.length !=0) {
             cell.DateContentLabel.text = [NSString stringWithFormat:@"%@ - %@",[NSString stringWithDataString:self.eventDtl.EventStartDate],[NSString stringWithDataString:self.eventDtl.EventEndDate]];
         }else{
         
          cell.DateContentLabel.text = [NSString stringWithFormat:@"%@",[NSString stringWithDataString:self.eventDtl.EventStartDate]];
         
         }
    }
   
    NSString *fontString = [NSString stringWithFormat:@"%f",_font.pointSize];
    CGFloat fontSize = 3.0+[fontString floatValue];
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    
    MyLog(@"%f",fontSize);
    
    cell.ContentLabel.font = _font;
    cell.ContentLabel.numberOfLines=0;
    cell.ContentLabel.text = self.eventDtl.Desp;
    CGSize requiredSize = [cell.ContentLabel.text sizeWithFont:font constrainedToSize:CGSizeMake(ScreenSize.width-100, 10000) lineBreakMode:NSLineBreakByWordWrapping];
    cell.ContentLabel.frame = CGRectMake(0, 0, requiredSize.width, requiredSize.height);
    CGRect rect = cell.frame;
    rect.size.height = requiredSize.height;
    cell.frame = rect;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addMySlider{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, kScreenH - 57, kScreenW - 20, 47)];
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
    [sliderA addTarget:self action:@selector(sliderValueChanged) forControlEvents:UIControlEventValueChanged];
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
    
    CGFloat fontSize = 16 + change;
    _font =[UIFont systemFontOfSize:fontSize];
    
    [_tableView reloadData];
}

-(void)sliderValueChanged{
    
}

@end
