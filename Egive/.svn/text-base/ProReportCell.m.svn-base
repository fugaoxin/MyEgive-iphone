//
//  ProReportCell.m
//  Egive
//
//  Created by sino on 15/8/17.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ProReportCell.h"
#import "UIView+ZJQuickControl.h"

#import "ZJScreenAdaptation.h"
#import "ZJScreenAdaptationMacro.h"

#import "EGUtility.h"

@implementation ProReportCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    UILabel * dateLabel = [self.contentView addLabelWithFrame:CGRectMake(10, 0, 60, 25) text:EGLocalizedString(@"Date", nil)];
    dateLabel.font = [UIFont systemFontOfSize:15];
    dateLabel.textColor = [UIColor grayColor];
    
    _date = [self.contentView addLabelWithFrame:CGRectMake(60, 0, 150, 25) text:nil];
    _date.font = [UIFont boldSystemFontOfSize:15];
    
    UILabel * proLabel = [self.contentView addLabelWithFrame:CGRectMake(320-100, 0, 80, 25) text:[NSString stringWithFormat:@"%@:", EGLocalizedString(@"GirdView_report_label", nil)]];
    proLabel.textColor = [UIColor grayColor];
    proLabel.font = [UIFont systemFontOfSize:15];
    
    _proReport = [self.contentView addLabelWithFrame:CGRectMake(300, 0, 20, 25) text:nil];
    _proReport.font = [UIFont boldSystemFontOfSize:15];
    
    UILabel * contenLabel = [self.contentView addLabelWithFrame:CGRectMake(10, 25, 300, 25) text:EGLocalizedString(@"Content", nil)];
    contenLabel.font = [UIFont systemFontOfSize:15];
    contenLabel.textColor = [UIColor grayColor];
    
    _conten = [self.contentView addLabelWithFrame:CGRectMake(10, 60, 300, 200) text:nil];
    _conten.font = [UIFont systemFontOfSize:18];
    _conten.numberOfLines = 0;
    _conten.hidden = NO;
    
    _webview = [[UIWebView alloc] init];
    //_webview.backgroundColor=[UIColor redColor];
    _webview.backgroundColor = [UIColor clearColor];
    _webview.frame = CGRectMake(10, 50, 300, 250-80);
    _webview.layer.borderColor = [UIColor whiteColor].CGColor;
    _webview.layer.borderWidth = 2;
    _webview.opaque = NO;
    _webview.delegate=self;
    [self.contentView addSubview:_webview];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 禁用用户选择
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    // 禁用长按弹出框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
   [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '150%'"];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
