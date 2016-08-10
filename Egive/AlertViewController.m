//
//  AlertViewController.m
//  Egive
//
//  Created by sino on 15/7/31.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "AlertViewController.h"
#import "NSString+RegexKitLite.h"
#import "EGUtility.h"
#import "AppDelegate.h"
@interface AlertViewController (){


    NSMutableArray * contentArray;

}
@property (strong, nonatomic) IBOutlet UIView *bgView;

- (IBAction)agree:(MyRegisterButton *)sender;

@property (strong, nonatomic) IBOutlet UIView *alertView;
- (IBAction)disagree:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *checkButton;
- (IBAction)checkAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *AlertLabel;
@property (strong, nonatomic) IBOutlet UILabel *LabelDescription;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *ContentView;
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *Canacle;

@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];

    self.TitleLabel.text = EGLocalizedString(@"TitleLabel", nil);
    [self.Canacle setTitle:EGLocalizedString(@"取消", nil) forState:UIControlStateNormal];
    //[self.MyregisterAgreeButton setTitle:EGLocalizedString(@"Common_button_confirm", nil) forState:UIControlStateNormal];
    self.MyRegisterAgreeTitleLabel.text= EGLocalizedString(@"Common_button_confirm", nil);
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
    
    _isCheck = NO;
    _isWBLogin = NO;
    [self.checkButton setBackgroundImage:[UIImage imageNamed:@"cart_checkbox_sel.png"] forState:UIControlStateSelected];
    
    contentArray = [[NSMutableArray alloc] init];
    NSArray * arr = _model.ContentText;
    for (NSDictionary * donorsDict in arr) {
        NSDictionary * dict = [[NSDictionary alloc]initWithObjectsAndKeys:donorsDict[@"LabelName"],@"LabelName",donorsDict[@"LabelDescription"],@"LabelDescription", nil];
        [contentArray addObject:dict];
        
        
    }
    if (contentArray.count != 0) {
    
    NSDictionary * dict1 = contentArray[0];
    
    NSDictionary * dict2 = contentArray[1];
    
    self.AlertLabel.text = [[dict1[@"LabelDescription"] stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"] stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
    self.AlertLabel.text = [self.AlertLabel.text stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    self.AlertLabel.text = [self.AlertLabel.text stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@" \" "];
    self.AlertLabel.text =[self.AlertLabel.text stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@" \" "];
    
    self.AlertLabel.text = [NSString captureData:self.AlertLabel.text];
    self.AlertLabel.numberOfLines=0;
    CGSize requiredSize = [self.AlertLabel.text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(320, 10000) lineBreakMode:NSLineBreakByWordWrapping];
    self.AlertLabel.frame = CGRectMake(0, 0, requiredSize.width, requiredSize.height);
    
    
    
    self.LabelDescription.text = [NSString captureData:[dict2[@"LabelDescription"]stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@" \" "]];
    self.LabelDescription.text=[self.LabelDescription.text stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@" \" "];
    self.LabelDescription.numberOfLines=0;
    CGSize requiredSize2 = [self.LabelDescription.text sizeWithFont:[UIFont systemFontOfSize:16
                                                                     ] constrainedToSize:CGSizeMake(320, 10000) lineBreakMode:NSLineBreakByWordWrapping];
    self.LabelDescription.frame = CGRectMake(0, 0, requiredSize2.width, requiredSize2.height);
    
    CGRect rect = self.ContentView.frame;
    rect.size.height = requiredSize.height + requiredSize2.height;
    rect.size.width=SCREEN_WIDTH-20;
    self.ContentView.frame = rect;
    [self.scrollView addSubview:self.ContentView];
    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width,self.ContentView.frame.size.height+20)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeView) name:@"removeView" object:nil];
    
    }
    
    
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
- (IBAction)agree:(MyRegisterButton *)sender {
    if (_isCheck){
        if(self.action){
            _action(self);
        }
        self.checkButton.selected = NO;
        _isCheck = NO;
        if (!_isWBLogin){
            
            [self.view.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
            
        }else{
           
        }
//[self.view.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
    }else{
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.delegate = self;
        alertView.message = EGLocalizedString(@"请选择并同意上述声明", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
    }

}

- (void)removeView{
    
    [self.view.window.rootViewController dismissViewControllerAnimated:NO completion:nil];

}

- (IBAction)disagree:(UIButton *)sender {


    [self.view.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)checkAction:(UIButton *)sender {
    
    if (sender.selected) {
        _isCheck = NO;
        sender.selected = NO;
    }else{
        _isCheck = YES;
        sender.selected = YES;
    }
    
}
- (IBAction)selectButton:(id)sender {
}
@end
