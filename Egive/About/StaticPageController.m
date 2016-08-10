//
//  StaticPageController.m
//  Egive
//
//  Created by sinogz on 15/9/10.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "Constants.h"
#import "StaticPageController.h"
#import "baseController.h"

@interface StaticPageController ()

@property (nonatomic, strong)UIView *sliderView;
@property (nonatomic, assign) NSInteger titleSize;
@property (nonatomic, assign) NSInteger subTitleSize;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, strong)NSMutableArray *labelViews;
@end

@implementation StaticPageController

- (NSMutableArray *)labelViews
{
    if (!_labelViews) {
        _labelViews = [NSMutableArray array];
    }
    return _labelViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 80, 50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"header_back@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 33, 33);
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_share@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _titleSize = 18;
    _subTitleSize = 18;
}

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightAction{


}

- (void)getStaticPageContentWithFormID:(NSString*)formID{
    
    [EGStaticPageRequestAdapter GetStaticPageContentWithFormID:formID success:^(EGGetStaticPageContentResult *result) {
        if (result.ContentText) {
           // MyLog(@"ContentText:%@",result.ContentText);
            [self parseHTML:result.ContentText];
        }
        
    } failure:^(NSError *error) {
       // MyLog(@"error:%@",error);
    }];
}

- (void)parseHTML:(NSString*)htmlString{
    
   // MyLog(@"htmlString = %@", htmlString);
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<p>1." withString:@"<p>　1."];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br />2." withString:@"</p><p>　2."];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br />3." withString:@"</p><p>　3."];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br />4." withString:@"</p><p>　4."];
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    
    NSData *dataTitle=[htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
    
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//ul"];

    [self parseElements:elements];
}


-(void)parseElements:(NSArray *)elements
{
    for (TFHppleElement *element in elements) {
        NSArray *childs=[element children];
        if (childs.count) {

            if ([element.tagName isEqualToString:@"video"]) {
                NSString *videoSrc = [element objectForKey:@"src"];
                NSURL *imageURL = [NSURL URLWithString:SITE_URL];
                imageURL = [imageURL URLByAppendingPathComponent:videoSrc];
                [self addSubImageView:imageURL];
                MyLog(@"videoSrc:%@", videoSrc);
            }
            else if ([[element objectForKey:@"class"] isEqualToString:@"chairmantitle"]) {
                NSString *chairmantitle = [element content];
                TFHppleElement *signature = [element firstChild];
                //MyLog(@"tagName:%@, content:%@", element.tagName, element.content);
                chairmantitle = [NSString stringWithFormat:@"%@\n%@",chairmantitle,signature.content];
                [self addTitleText:chairmantitle font:[UIFont systemFontOfSize:18]];
            } else if ([element.tagName isEqualToString:@"table"]) {
                NSArray *trs=[element children];
                NSString *str_tr = @"";
                for (TFHppleElement *tr in trs) {
                    
                    NSArray *tds=[tr children];
                    for (TFHppleElement *td in tds) {
                        str_tr = [str_tr stringByAppendingString:@" "];
                        str_tr = [str_tr stringByAppendingString:[td content]];
                    }
                    str_tr = [str_tr stringByAppendingString:@"\n"];
                }
                //MyLog(@"str_tr:%@", str_tr);
                [self addSubText:str_tr];
            } else {
                [self parseElements:childs];
            }
        } else {
            //没有子节点
            if ([element.tagName isEqualToString:@"img"]) {
                NSString *imgSrc = [element objectForKey:@"src"];
                //MyLog(@"tagName:%@, src:%@", element.tagName, imgSrc);
                NSURL *imageURL = [NSURL URLWithString:SITE_URL];
                imageURL = [imageURL URLByAppendingPathComponent:imgSrc];
                [self addSubImageView:imageURL];
                
            } else if ([element.tagName isEqualToString:@"span"]) {
                //MyLog(@"tagName:%@, content:%@", element.tagName, element.content);
            } else if ([element.tagName isEqualToString:@"h2"]) {
                //MyLog(@"tagName:%@, content:%@", element.tagName, element.content);
                [self addTitleText:element.content font:[UIFont systemFontOfSize:18]];
            } else if ([element.tagName isEqualToString:@"p"]) {
                //MyLog(@"tagName:%@, content:%@", element.tagName, element.content);
                [self addSubText:element.content];
            }
            
        }
    }
}

- (void)addSubImageView:(NSURL *)imageURL {
    
    
    
}

//添加文章标题
- (void)addTitleText:(NSString *)content font:(UIFont*)font {
    
    FDLabelView *titleView = [[FDLabelView alloc] initWithFrame:CGRectMake(10, currentY, kScreenW - 20, 0)];
    //titleView.backgroundColor = [UIColor redColor];
    titleView.textColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    titleView.font = [UIFont systemFontOfSize:_titleSize];
    titleView.minimumScaleFactor = 0.50;
    titleView.numberOfLines = 0;
    titleView.text = content;
    titleView.tag = 1;
    titleView.lineHeightScale = 0.90;
    titleView.fixedLineHeight = 25;
    titleView.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
    titleView.fdTextAlignment = FDTextAlignmentLeft;
    titleView.fdAutoFitMode = FDAutoFitModeAutoHeight;
    titleView.fdLabelFitAlignment = FDLabelFitAlignmentCenter;
    titleView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    [mScrollView addSubview:titleView];
    currentY += titleView.visualTextHeight;
    [mScrollView setContentSize:CGSizeMake(self.view.frame.size.width, currentY)];
    [self.labelViews addObject:titleView];
}

//添加文章段落
- (void)addSubText:(NSString *)content {
    
//    FDLabelView *titleView = [[FDLabelView alloc] initWithFrame:CGRectMake(10, currentY, kScreenW - 20, 0)];
//    titleView.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.00];
//    titleView.textColor = [UIColor blackColor];
//    titleView.font = [UIFont systemFontOfSize:_subTitleSize];
//    titleView.minimumScaleFactor = 0.50;
//    titleView.numberOfLines = 0;
//    titleView.text = content;
//    titleView.tag = 0;
//    titleView.lineHeightScale = 0.80;
//    titleView.fixedLineHeight = 20;
//    titleView.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
//    titleView.fdTextAlignment = FDTextAlignmentLeft;
//    titleView.fdAutoFitMode = FDAutoFitModeAutoHeight;
//    titleView.fdLabelFitAlignment = FDLabelFitAlignmentCenter;
//    titleView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, currentY, kScreenW - 30, 0);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:_subTitleSize];
    label.minimumScaleFactor = 0.50;
    label.numberOfLines = 0;
    label.text = content;
    label.tag = 0;
    NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
    style.minimumLineHeight = 20.f;
    style.maximumLineHeight = 20.f;
    NSDictionary *attributtes = @{NSParagraphStyleAttributeName : style,};
    label.attributedText = [[NSAttributedString alloc] initWithString:content
                                                           attributes:attributtes];
    [label sizeToFit];
    
    [mScrollView addSubview:label];
    
    currentY += label.frame.size.height /* .visualTextHeight*/ + 20;
    [mScrollView setContentSize:CGSizeMake(self.view.frame.size.width, currentY)];
    
    [self.labelViews addObject:label];
//    titleView.debug = NO;
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
    [mScrollView addGestureRecognizer:longPressGr];
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDo:)];
    [mScrollView addGestureRecognizer:tapGr];
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
    for (FDLabelView *view in _labelViews) {
        
            CGFloat fontSize;
            if (view.tag) {
                fontSize = _titleSize + change;
            } else {
                fontSize = _subTitleSize +change;
            }
            view.font = [UIFont systemFontOfSize:fontSize];
        
        [view sizeToFit];
    }
   
    NSInteger count = _labelViews.count;
    if (count) {
        CGFloat offY = CGRectGetMaxY(((FDLabelView*)[_labelViews firstObject]).frame) + 10;
        for (int i = 1; i < count; i++) {
            FDLabelView *view = _labelViews[i];
            CGRect frame = view.frame;
            frame.size.width = kScreenW - 30;
            frame.origin.y = offY;
            view.frame = frame;
            offY = CGRectGetMaxY(view.frame) + 10;
        }
        [mScrollView setContentSize:CGSizeMake(0, offY)];

    }
}

-(void)sliderValueChanged{
    
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
