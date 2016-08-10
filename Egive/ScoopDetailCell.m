//
//  ScoopDetailCell.m
//  Egive
//
//  Created by sinogz on 15/9/7.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ScoopDetailCell.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "Constants.h"

@interface ScoopDetailCell ()<MJPhotoBrowserDelegate>

/**
 *  Title
 */
@property(nonatomic,weak)UILabel  *titleLabel;
/**
 *  Desc
 */
@property(nonatomic,weak)UILabel  *descLabel;
/**
 *  dateLabel
 */
@property(nonatomic,weak)UILabel  *dateLabel;

/**
 *  dateLabel
 */
@property(nonatomic,strong)NSMutableArray  *imageViews;

@end


@implementation ScoopDetailCell

- (NSMutableArray *)imageViews
{
    if (!_imageViews) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier eventDtl:(EGEventDtl *)eventDtl
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //初始化
        self.eventDtl = eventDtl;
        
        UILabel *titleLabel=[[UILabel alloc] init];
        [self addSubview:titleLabel];
        self.titleLabel=titleLabel;

        UILabel *descLabel=[[UILabel alloc] init];
        [self addSubview:descLabel];
        self.descLabel = descLabel;
        
        UILabel *dateLabel=[[UILabel alloc]init];
        [self addSubview:dateLabel];
        self.dateLabel=dateLabel;
        
        
        NSInteger count = eventDtl.Img.count;
        
        for (int i = 0; i < count; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;        // 设置图片正常填充
            imageView.clipsToBounds = YES;                                   // 裁剪边缘
            
            NSInteger width = (kScreenW - cellMargin)/columnMax;
            NSInteger row = i / columnMax;                                          // 计算行号0~n
            NSInteger column = i % columnMax;                                       // 计算列号0~n
            imageView.frame = CGRectMake(cellMargin + column * width, cellMargin + row * width, width - cellMargin, width - cellMargin);
            
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            
            NSString *ImgURL = eventDtl.Img[i][@"ImgURL"];
//            _currentDict = eventDtl.Img[i];
            NSURL *url = [NSURL URLWithString:SITE_URL];
            url = [url URLByAppendingPathComponent:ImgURL];
            [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
            [self addSubview:imageView];
            [self.imageViews addObject:imageView];

        }
        
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView eventDtl:(EGEventDtl *)eventDtl
{
    static NSString *ID = @"ScoopDetailCell";
    ScoopDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID eventDtl:eventDtl];
    }
    return cell;
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    NSInteger count = _imageViews.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        //
        NSString *ImgURL = _eventDtl.Img[i][@"ImgURL"];
        NSURL *url = [[NSURL URLWithString:SITE_URL] URLByAppendingPathComponent:ImgURL];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = url;                        // 图片路径
        photo.srcImageView = _imageViews[i];    // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    _browser = browser;
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    browser.delegate = self;
    [browser show];
    
}

-(void)photoBrowser:(MJPhotoBrowser *)photoBrowser didChangedToPageAtIndex:(NSUInteger)index{
    _currentDict = _eventDtl.Img[index];
    photoBrowser.leftDetail = _currentDict[@"ImgCaption"];
}


- (void)dealloc
{
    [self.imageViews removeAllObjects];
    self.imageViews = nil;
}
@end


@implementation ScoopDetailCellFrame

- (id)initWithEventDtl:(EGEventDtl *)eventDtl
{
    if (self = [super init]) {
        self.eventDtl = eventDtl;
    }
    return self;
}

- (void)setEventDtl:(EGEventDtl *)eventDtl
{
    
}

@end
