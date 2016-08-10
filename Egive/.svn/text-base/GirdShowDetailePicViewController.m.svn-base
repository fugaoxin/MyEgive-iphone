//
//  GirdShowDetailePicViewController.m
//  Egive
//
//  Created by zxj on 15/11/11.
//  Copyright © 2015年 sino. All rights reserved.
//

#import "GirdShowDetailePicViewController.h"
#import "Constants.h"
#import "UIView+ZJQuickControl.h"
#import "UIImageView+WebCache.h"
#import "objc/runtime.h"
#import "UIView+WebCacheOperation.h"
//#import "ZJScreenAdaptation.h"
//#import "ZJScreenAdaptationMacro.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
#define cellMargin 2
#define columnMax  2
@interface GirdShowDetailePicViewController ()<UIScrollViewDelegate,MJPhotoBrowserDelegate>{

    UIImageView * galleryImg;
    long height;
}


@property(retain,nonatomic)NSMutableArray *picDetaileArray;
@property(nonatomic,strong)NSMutableArray  *imageViews;



@end

@implementation GirdShowDetailePicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //_picDetaileArray = [[NSMutableArray alloc] init];
    _imageViews = [[NSMutableArray alloc] init];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    leftButton.transform = CGAffineTransformScale(leftButton.transform, 0.85, 0.85);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height)];
    self.scrollView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.scrollView];
   
    for (int i = 0; i < self.PicArray.count; i++){
        
        NSDictionary * dict = self.PicArray[i];
        NSURL *url = [NSURL URLWithString:SITE_URL];
       // if ([[dict allKeys] containsObject:@"MediaURL"]){
//            url = [url URLByAppendingPathComponent:dict[@"MediaURL"]];
//            NSString *urlString = [NSString stringWithFormat:@"%@",url];
//            UIImage *image = [self getThumbnailImage:urlString];
//            UIImageView *imageView = [[UIImageView alloc] init];
//            imageView.tag = i;
//            imageView.userInteractionEnabled = YES;
//            imageView.contentMode = UIViewContentModeScaleAspectFill;        // 设置图片正常填充
//            imageView.clipsToBounds = YES;
//            
//            NSInteger width = (kScreenW - cellMargin)/columnMax;
//            NSInteger row = i / columnMax;                                          // 计算行号0~n
//            NSInteger column = i % columnMax;                                       // 计算列号0~n
//            imageView.frame = CGRectMake(cellMargin + column * width, cellMargin + row * width+64, width - cellMargin, width - cellMargin);
//            
//            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
//
//            imageView.image = image;
//            //galleryImg.contentMode = UIViewContentModeScaleAspectFit;
//            __weak typeof (self) ws = self;
//            UIButton * playButton = [imageView addImageButtonWithFrame:CGRectMake(20, 50, 50, 50) title:nil backgroud:nil action:^(UIButton *button){
//                
//                
//                MPMoviePlayerViewController *mpvc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
//                
//                [ws presentViewController:mpvc animated:YES completion:nil];
//                
//                
//            }];
            
           // [playButton setBackgroundImage:[UIImage imageNamed:@"comment_play.png"] forState:UIControlStateNormal];
       // }else{
            
            url = [url URLByAppendingPathComponent:dict[@"ImgURL"]];
            if (![dict[@"ImgURL"] isEqualToString:@""]){
//                [galleryImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
                //galleryImg.contentMode = UIViewContentModeScaleAspectFit;
                UIImageView *imageView = [[UIImageView alloc] init];
                imageView.tag = i;
                imageView.userInteractionEnabled = YES;
                imageView.contentMode = UIViewContentModeScaleAspectFill;        // 设置图片正常填充
                imageView.clipsToBounds = YES;
                
                NSInteger width = (kScreenW - cellMargin)/columnMax;
                NSInteger row = i / columnMax;                                          // 计算行号0~n
                NSInteger column = i % columnMax;                                       // 计算列号0~n
                imageView.frame = CGRectMake(cellMargin + column * width, cellMargin + row * width, width - cellMargin, width - cellMargin);
                
                height=width - cellMargin;
                [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
                
                [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
                [self.scrollView addSubview:imageView];
                [self.imageViews addObject:imageView];
                
               
            
            }else{
                [galleryImg setImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"]];
                 galleryImg.contentMode = UIViewContentModeScaleAspectFit;
            }
            
        }
    
    
    if (self.imageViews.count%2==0){
       self.scrollView.contentSize = CGSizeMake(0,(height+3)*(self.imageViews.count/2));
        
    }else{
        self.scrollView.contentSize = CGSizeMake(0,(height+3)*(self.imageViews.count/2+1));

    
    }
    
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    NSInteger count = _imageViews.count;
    // 1.封装图片数据
    NSMutableArray *photos = [[NSMutableArray alloc] init];
     NSURL *url = [NSURL URLWithString:SITE_URL];
    
    for (int i = 0; i<count; i++){
        
        NSDictionary * dict = self.PicArray[i];
        url = [url URLByAppendingPathComponent:dict[@"ImgURL"]];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = url;                        // 图片路径
        photo.srcImageView = _imageViews[i];    // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    browser.delegate = self;
    [browser show];
    
}

-(void)photoBrowser:(MJPhotoBrowser *)photoBrowser didChangedToPageAtIndex:(NSUInteger)index{
    
    
    NSDictionary * dict = self.PicArray[index];
    photoBrowser.leftDetail = dict[@"ImgCaption"];
    
    
}


-(UIImage *)getThumbnailImage:(NSString *)videoURL{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoURL] options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(10, 50);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    if (error) {
        MyLog(@"截取视频图片失败:%@",error.localizedDescription);
    }
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;
}
- (void)leftAction{
    
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
