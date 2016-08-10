//
//  SendBlessingsViewController.m
//  Egive
//
//  Created by sino on 15/9/13.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "Constants.h"
#import "SendBlessingsViewController.h"
#import "PreviewViewController.h"
#import "UIView+ZJQuickControl.h"
#import "UIKit+AFNetworking.h"
#import "AppDelegate.h"

#define ScreenSize [UIScreen mainScreen].bounds.size
@interface SendBlessingsViewController ()
{
    BOOL editingMode;
    BOOL couldHideKeyboard;
    BOOL showingEmojiKeyboard;
    CGRect keyboardFrameBeginRect;
    
    CGRect _tapFrame;
    
    CGRect _emojiFrame;
    
    UILabel *_countLabel;
    UIDevice *device_;
}
@property (strong, nonatomic) MemberModel * item;
@property (strong, nonatomic) UIScrollView * scroll;
@property (strong, nonatomic) UILabel * titleLabel;
@property (strong, nonatomic) UIWebView * wv;
@property (strong, nonatomic) UIButton * tapButton;
@property (strong, nonatomic) UIButton * emojiButton;
@property (strong, nonatomic) UIView *mask;
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *rightBtn;
@property (strong, nonatomic) UIView * leftBtnLine;
@property (strong, nonatomic) UIView * rightBtnLine;
@property (strong, nonatomic) UITextField * unreal;

@end

@interface UIWebView (HackishAccessoryHiding)
@property (nonatomic, assign) BOOL hackishlyHidesInputAccessoryView;
- (void) setHackishlyHidesInputAccessoryView:(BOOL)value;
@end

@implementation SendBlessingsViewController

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    MyLog(@"SendBlessingsViewController");
    [super viewDidLoad];
    
    editingMode = NO;
    couldHideKeyboard = NO;
    showingEmojiKeyboard = NO;
    
    // Do any additional setup after loading the view.
    self.title = EGLocalizedString(@"GirdView_blessings_button", nil);
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    
    
    //判断用户是否登入，如登入获取：MemberID
    NSMutableDictionary * dict = [ShowMenuView getUserInfo];
    _item = dict[@"LoginName"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 85,50);
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"ic_header_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
     device_=[[UIDevice alloc] init];
    
    _scroll = [[UIScrollView alloc] init];
    _scroll.frame = CGRectMake(0, 0, ScreenSize.width, 900);
    _scroll.contentSize = CGSizeMake(ScreenSize.width, IS_IPHONE_5?1050:640);
    if ([device_.model isEqualToString:@"iPad"]||IS_IPHONE_4_OR_LESS) {
        
        _scroll.contentSize = CGSizeMake(ScreenSize.width, 1300);
        
        
    }
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
    
    [self createUI];
    
    // Listen for keyboard appearances and disappearances
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageAction)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)keyboardDidShow: (NSNotification *) notif{
    
    if (IS_IPHONE_5|| [device_.model isEqualToString:@"iPad"]||IS_IPHONE_4_OR_LESS)
        
        return;
    
    editingMode = YES;
    
    NSDictionary* keyboardInfo = [notif userInfo];
    CGSize kbSize = [[keyboardInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    MyLog(@"UIKeyboardFrameEndUserInfoKey kbSize = %f", kbSize.height);
    
    if (_leftBtn != nil) {
        //        [self.view addSubview:_leftBtn]; // Temp Solution
    } else {
        _leftBtnLine = [[UIView alloc] init];
        _leftBtnLine.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
        _leftBtnLine.frame = CGRectMake(0, 36, ScreenSize.width/2, 4);
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setImage:[UIImage imageNamed:@"bless_text_sel"] forState:UIControlStateNormal];
        [_leftBtn setTitle:@"Keyboard" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1] forState:UIControlStateNormal];
        [_leftBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        _leftBtn.frame = CGRectMake(0, ScreenSize.height - kbSize.height - 40, ScreenSize.width/2, 40);
        _leftBtn.backgroundColor = [UIColor whiteColor];
        [_leftBtn addTarget:self action:@selector(toggleKeyboard:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn addSubview:_leftBtnLine];
        //        [self.view addSubview:_leftBtn]; // Temp Solution
    }
    
    if (_rightBtn != nil) {
        //        [self.view addSubview:_rightBtn]; // Temp Solution
    } else {
        _rightBtnLine = [[UIView alloc] init];
        _rightBtnLine.backgroundColor = [UIColor lightGrayColor];
        _rightBtnLine.frame = CGRectMake(0, 36, ScreenSize.width/2, 4); // Temp Solution
        _rightBtnLine.frame = CGRectMake(0, 36, ScreenSize.width, 4); // Temp Solution
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn setImage:[UIImage imageNamed:@"bless_icon_nor"] forState:UIControlStateNormal];
        [_rightBtn setTitle:@"Emoji" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_rightBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        _rightBtn.titleLabel.text = @"Emoji";
        _rightBtn.frame = CGRectMake(ScreenSize.width/2+1, ScreenSize.height - kbSize.height - 40, ScreenSize.width/2, 40); // Temp Solution
        _rightBtn.frame = CGRectMake(0, ScreenSize.height - kbSize.height - 40, ScreenSize.width, 40);
        _rightBtn.backgroundColor = [UIColor whiteColor];
        [_rightBtn addTarget:self action:@selector(toggleEmoji:) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn addSubview:_rightBtnLine];
        //        [self.view addSubview:_rightBtn]; // Temp Solution
    }
    
    //    if (showingEmojiKeyboard) {
    //        _leftBtnLine.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    //        [_leftBtn setImage:[UIImage imageNamed:@"bless_icon_sel"] forState:UIControlStateNormal];
    //        [_leftBtn setTitleColor:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1] forState:UIControlStateNormal];
    //        [_leftBtn setEnabled:YES];
    //
    //        _rightBtnLine.backgroundColor = [UIColor lightGrayColor];
    //        [_rightBtn setImage:[UIImage imageNamed:@"bless_icon_nor"] forState:UIControlStateNormal];
    //        [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //        [_rightBtn setEnabled:NO];
    //    } else {
    //        _leftBtnLine.backgroundColor = [UIColor lightGrayColor];
    //        [_leftBtn setImage:[UIImage imageNamed:@"bless_text_nor"] forState:UIControlStateNormal];
    //        [_leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //        [_leftBtn setEnabled:NO];
    //
    //        _rightBtnLine.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    //        [_rightBtn setImage:[UIImage imageNamed:@"bless_icon_sel"] forState:UIControlStateNormal];
    //        [_rightBtn setTitleColor:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1] forState:UIControlStateNormal];
    //        [_rightBtn setEnabled:YES];
    //    }
    
    showingEmojiKeyboard = NO;
    _leftBtnLine.backgroundColor = [UIColor lightGrayColor];
    [_leftBtn setImage:[UIImage imageNamed:@"bless_text_nor"] forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_leftBtn setEnabled:NO];
    
    _rightBtnLine.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    [_rightBtn setImage:[UIImage imageNamed:@"bless_icon_sel"] forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1] forState:UIControlStateNormal];
    [_rightBtn setEnabled:YES];
    
    if (!editingMode || !couldHideKeyboard) {
        [_scroll setContentSize:CGSizeMake(ScreenSize.width, (IS_IPHONE_6P?(editingMode?1070:900):(IS_IPHONE_5?1290:1090)))];
        CGPoint bottomOffset = CGPointMake(0, _scroll.contentSize.height - _scroll.bounds.size.height - 20);
        //        [_tapButton setFrame:CGRectMake(20, ScreenSize.height-170, ScreenSize.width-40, 35)]; // Temp Solution
//        [_tapButton setFrame:CGRectMake(20, ScreenSize.height-(IS_IPHONE_6P?210:150), ScreenSize.width-40 - 45 - 10, 35)]; // Temp Solution
//        [_emojiButton setFrame:CGRectMake(ScreenSize.width-45 - 20, ScreenSize.height-(IS_IPHONE_6P?210:150), 45, 35)];
        
        
        [_tapButton setFrame:_tapFrame]; // Temp Solution
        [_emojiButton setFrame:_emojiFrame];
        
       
        
        [_scroll setContentOffset:bottomOffset animated:(IS_IPHONE_5 || [device_.model isEqualToString:@"iPad"]||IS_IPHONE_4_OR_LESS)?NO:YES];
    }
    couldHideKeyboard = YES;
    _titleLabel.hidden = YES;
}

- (void)keyboardDidHide: (NSNotification *) notif{
    [_mask removeFromSuperview];
    
    
    NSString *val = [_wv stringByEvaluatingJavaScriptFromString: @"$('<div/>').text(document.getElementById('ctl00_cnt_PageContent_txt_Comment').value).html();"];
    _countLabel.text = [NSString stringWithFormat:@"%ld/500",val.length];
    //    showingEmojiKeyboard = NO;
}

- (void)keyboardWillShow: (NSNotification *) notif{
   // MyLog(@"keyboardWillShow");
    
}

- (void)toggleKeyboard:(id)target
{
    //MyLog(@"toggleKeyboard");
    if (!showingEmojiKeyboard) return;
    
    showingEmojiKeyboard = NO;
    _leftBtnLine.backgroundColor = [UIColor lightGrayColor];
    [_leftBtn setImage:[UIImage imageNamed:@"bless_text_nor"] forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_leftBtn setEnabled:NO];
    
    _rightBtnLine.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    [_rightBtn setImage:[UIImage imageNamed:@"bless_icon_sel"] forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1] forState:UIControlStateNormal];
    [_rightBtn setEnabled:YES];
    
    [_scroll addSubview:_mask];
    
    couldHideKeyboard = YES;
    [_wv becomeFirstResponder];
    [_wv endEditing:NO];
    [_wv stringByEvaluatingJavaScriptFromString:@"document.getElementById('emoji-wysiwyg-editor').focus()"];
}

-(void)tapImageAction{

    [_wv resignFirstResponder];
    [_wv endEditing:YES];


}

- (void)toggleEmoji:(id)target{
   // MyLog(@"toggleEmoji");
    if (IS_IPHONE_5 || [device_.model isEqualToString:@"iPad"]||IS_IPHONE_4_OR_LESS) {
        [_wv resignFirstResponder];
        [_wv endEditing:YES];
        return;
    }
    
    if (showingEmojiKeyboard) return;
    
    _leftBtnLine.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    [_leftBtn setImage:[UIImage imageNamed:@"bless_text_sel"] forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1] forState:UIControlStateNormal];
    [_leftBtn setEnabled:YES];
    
    _rightBtnLine.backgroundColor = [UIColor lightGrayColor];
    [_rightBtn setImage:[UIImage imageNamed:@"bless_icon_nor"] forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_rightBtn setEnabled:NO]; // Temp Solution
    [_rightBtn removeFromSuperview]; // Temp Solution
    
    showingEmojiKeyboard = YES;
    [_mask removeFromSuperview];
    
    [_scroll setContentSize:CGSizeMake(ScreenSize.width, 1090)];
    CGPoint bottomOffset = CGPointMake(0, _scroll.contentSize.height - _scroll.bounds.size.height);
    //    [_tapButton setFrame:CGRectMake(20, ScreenSize.height-150, ScreenSize.width-40, 35)]; // Temp Solution
//    [_tapButton setFrame:CGRectMake(20, ScreenSize.height-(IS_IPHONE_6P?210:150), ScreenSize.width-40 - 45 - 10, 35)]; // Temp Solution
//    [_emojiButton setFrame:CGRectMake(ScreenSize.width-45 - 20, ScreenSize.height-(IS_IPHONE_6P?210:150), 45, 35)];
    
    [_tapButton setFrame:_tapFrame]; // Temp Solution
    [_emojiButton setFrame:_emojiFrame];

    
    [_scroll setContentOffset:bottomOffset animated:YES];
    
    
    [_wv resignFirstResponder];
    [_wv endEditing:YES];
    _titleLabel.hidden = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (IS_IPHONE_5 || [device_.model isEqualToString:@"iPad"] || IS_IPHONE_4_OR_LESS) return;
    editingMode = NO;
    if (couldHideKeyboard || showingEmojiKeyboard) {
        couldHideKeyboard = NO;
        [self.view endEditing:YES];
        CGPoint bottomOffset = CGPointMake(0, 0);
        //        [_tapButton setFrame:CGRectMake(20, ScreenSize.height-150, ScreenSize.width-40, 35)]; // Temp Solution
//        [_tapButton setFrame:CGRectMake(20, ScreenSize.height-(IS_IPHONE_6P?210:150), ScreenSize.width-40 - 45 - 10, 35)]; // Temp Solution
//        [_emojiButton setFrame:CGRectMake(ScreenSize.width-45 - 20, ScreenSize.height-(IS_IPHONE_6P?210:150), 45, 35)];
        
        [_tapButton setFrame:_tapFrame]; // Temp Solution
        [_emojiButton setFrame:_emojiFrame];
        

        //[_scroll setContentOffset:bottomOffset animated:YES];
        [_scroll setContentSize:CGSizeMake(ScreenSize.width, 640)];
        [_scroll scrollsToTop];
        
        [_wv stringByEvaluatingJavaScriptFromString:@"document.activeElement.blur()"];
        [_wv endEditing:YES];
        [_wv resignFirstResponder];
        
        [_leftBtn removeFromSuperview];
        [_rightBtn removeFromSuperview];
        [_mask removeFromSuperview];
        _titleLabel.hidden = NO;
        
        NSString *val = [_wv stringByEvaluatingJavaScriptFromString: @"$('<div/>').text(document.getElementById('ctl00_cnt_PageContent_txt_Comment').value).html();"];
        MyLog(@"Emoji Keyboard = %@", val);
    }
   // MyLog(@"%@", couldHideKeyboard);
}

- (void)createUI {
    
    UIImageView * image = [_scroll addImageViewWithFrame:CGRectMake(60, 45, ScreenSize.width-120, 150) image:nil];
    //    [image setImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"]]; // for fast testing
    NSURL *url = [NSURL URLWithString:SITE_URL];
    url = [url URLByAppendingPathComponent:_model.ProfilePicURL];
    [image setImageWithURL:url placeholderImage:[UIImage imageNamed:@"dummy_case_related_default@2x.png"]];
    image.contentMode = UIViewContentModeScaleAspectFit;
    
    // UIImageView * commentInputBg = [self.view addImageViewWithFrame:CGRectMake(20, 300, ScreenSize.width-40, ScreenSize.height-360) image:@"comment_input@2x.png"];
    
    UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 300, ScreenSize.width-40, ScreenSize.height-360)];
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:15];
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    [_scroll addSubview:textView];
    
    
    //
    int height=0;
    if (IS_IPHONE_5) {
        
        height=345;
    }else if (IS_IPHONE_6){
    
        height=445;
    }else if (IS_IPHONE_6P){
    
         height=450;
    }else if([device_.model isEqualToString:@"iPad"] || IS_IPHONE_4_OR_LESS) {
        
       height=450;
    }
    
    UILabel *countLabel = [_scroll addLabelWithFrame:CGRectMake(ScreenSize.width-100-27, height, 100, 150) text:@""];
    _countLabel = countLabel;
    countLabel.layer.zPosition = 9999999;
    countLabel.text = @"0/500";
//    countLabel.backgroundColor = [UIColor blackColor];
    countLabel.textAlignment = NSTextAlignmentRight;
    countLabel.font = [UIFont systemFontOfSize:12];
    countLabel.textColor = [UIColor blackColor];
//    countLabel.frame = (CGRect){ScreenSize.width-45 - 20, ScreenSize.height-(IS_IPHONE_6P?210:150), 100, 15};
    [_scroll addSubview:countLabel];
    
    NSString *filePath=[[NSBundle mainBundle] pathForResource:IS_IPHONE_6P?@"emoji-iphone6p":(IS_IPHONE_5?@"emoji-iphone5s":@"emoji") ofType:@"html" inDirectory:@""];
    _wv = [[UIWebView alloc] init];
    _wv.frame = CGRectMake(5, 240, ScreenSize.width-10, 900);
    _wv.contentMode = UIViewContentModeScaleAspectFit;
    _wv.scrollView.scrollEnabled = NO;
    _wv.scrollView.bounces = NO;
    [_wv loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
    [_wv setHackishlyHidesInputAccessoryView:YES];
    _mask = [[UIView alloc] init];
    _mask.frame = CGRectMake(0, 500, ScreenSize.width, 900);
    _mask.backgroundColor = [UIColor clearColor];
    [_scroll addSubview:_wv];
    [_scroll addSubview:_mask];
    
    _tapButton = [[UIButton alloc] init];
    //    [_tapButton setFrame:CGRectMake(20, ScreenSize.height-150, ScreenSize.width-40, 35)]; // Temp Solution
    
    if ([device_.model isEqualToString:@"iPad"] || IS_IPHONE_4_OR_LESS) {
        
         _tapFrame = CGRectMake(20, ScreenSize.height+60, ScreenSize.width-40 - 45 - 10, 35);
    }else{
    
        _tapFrame = CGRectMake(20, ScreenSize.height-(IS_IPHONE_6P?210:150)+15, ScreenSize.width-40 - 45 - 10, 35);
    }
    [_tapButton setFrame:_tapFrame]; // Temp Solution
    
    [_tapButton setTitle:EGLocalizedString(@"Register_commitButton_title", nil) forState:UIControlStateNormal];
    [_tapButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [_tapButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _tapButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _tapButton.layer.cornerRadius = 4;
    _tapButton.backgroundColor = [UIColor colorWithRed:110/255.0 green:184/255.0 blue:43/255.0 alpha:1];
    [_scroll addSubview:_tapButton];
    
    _emojiButton = [[UIButton alloc] init];
    if ([device_.model isEqualToString:@"iPad"]||IS_IPHONE_4_OR_LESS) {
        
        _emojiFrame = CGRectMake(ScreenSize.width-45 - 20, ScreenSize.height+60, 45, 35);
    }else{
        _emojiFrame = CGRectMake(ScreenSize.width-45 - 20, ScreenSize.height-(IS_IPHONE_6P?210:150)+15, 45, 35);
    }
    [_emojiButton setFrame:_emojiFrame];
    [_emojiButton setImage:[UIImage imageNamed:@"bless_icon_sel"] forState:UIControlStateNormal];
    [_emojiButton addTarget:self action:@selector(toggleEmoji:) forControlEvents:UIControlEventTouchUpInside];
    _emojiButton.layer.cornerRadius = 4;
    _emojiButton.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    [_scroll addSubview:_emojiButton];
    
    _titleLabel = [_scroll addLabelWithFrame:CGRectMake(40, 280-84, ScreenSize.width-80, 40) text:_model.Title];
    _titleLabel.numberOfLines=0;
    //_titleLabel.backgroundColor=[UIColor redColor];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    if (IS_IPHONE_5) {
        CGPoint bottomOffset = CGPointMake(0, _scroll.contentSize.height - _scroll.bounds.size.height + 64);
        [_scroll setContentOffset:bottomOffset animated:YES];
    }
}

-(void) submit: (id)sender
{
    
    couldHideKeyboard = NO;
    _titleLabel.hidden = NO;
    [self.view endEditing:YES];
    if (!(IS_IPHONE_5 || [device_.model isEqualToString:@"iPad"]||IS_IPHONE_4_OR_LESS)) {
        CGPoint bottomOffset = CGPointMake(0, 0);
        //    [_tapButton setFrame:CGRectMake(20, ScreenSize.height-150, ScreenSize.width-40, 35)]; // Temp Solution
//        [_tapButton setFrame:CGRectMake(20, ScreenSize.height-(IS_IPHONE_6P?210:150), ScreenSize.width-40 - 45 - 10, 35)]; // Temp Solution
        [_tapButton setFrame:_tapFrame];
        
//        [_emojiButton setFrame:CGRectMake(ScreenSize.width-45 - 20, ScreenSize.height-(IS_IPHONE_6P?210:150), 45, 35)];
         [_emojiButton setFrame:_emojiFrame];
        //        [_scroll setContentOffset:bottomOffset animated:YES];
        [_scroll setContentSize:CGSizeMake(ScreenSize.width, 640)];
        [_scroll scrollsToTop];

        [_wv stringByEvaluatingJavaScriptFromString:@"document.activeElement.blur()"];
        [_wv endEditing:YES];
        [_wv resignFirstResponder];
        
        [_leftBtn removeFromSuperview];
        [_rightBtn removeFromSuperview];
        [_mask removeFromSuperview];
    }
    NSString *val = [_wv stringByEvaluatingJavaScriptFromString: @"$('<div/>').text(document.getElementById('ctl00_cnt_PageContent_txt_Comment').value).html();"];
   
    
   // MyLog(@"Emoji Keyboard = %@", val);
    

    _countLabel.text = [NSString stringWithFormat:@"%ld/500",val.length];
    
    if (![val isEqualToString:@""]){
       // MyLog(@"%ld",[val length]);
        if ([val length] > 500) {
            UIAlertView * alertView = [[UIAlertView alloc] init];
            alertView.message = EGLocalizedString(@"内容不能超过500个字符", nil) ;
            [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
            [alertView show];
            return;
        }
        
        PreviewViewController * vc = [[PreviewViewController alloc] init];
        [vc setAction:^(void) {
            [self.navigationController popViewControllerAnimated:YES];
            if(self.action)
            {
                self.action();
            }
        }];
        
        vc.caseId = self.model.CaseID;
       // MyLog(@"%@",val);
        vc.comments = val;
        vc.memberId = self.item.MemberID;
        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self.view.window.rootViewController presentViewController:vc animated:YES completion:nil];
        
    }else{
        
        UIAlertView * alertView = [[UIAlertView alloc] init];
        alertView.message = EGLocalizedString(@"请输入祝福内容!", nil);
        [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
        [alertView show];
    }
}

//计算字符长度
- (int)convertToInt:(NSString*)strtemp{
        int strlength = 0;
        char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
        for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
            if (*p) {
                p++;
                strlength++;
            }
            else {
                p++;
            }
        }
      //  MyLog(@"%d",strlength);
        return strlength;
    
}

#pragma mark - UITextFieldDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text{
    
    if ([text isEqualToString:@"\n"]) {
        
        NSTimeInterval animationDuration = 0.20f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame = rect;
        [UIView commitAnimations];
        [textView resignFirstResponder];
        return YES;
        
        return NO;
    }
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    CGRect frame = textView.frame;
    //    MyLog(@"frame.origin.y = %f [_serverArr count] = %lu", frame.origin.y, (unsigned long)[_serverArr count]);
    //int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    int offset = frame.origin.y + 270 - (self.view.frame.size.height - 310.0);//键盘高度216;
    _titleLabel.hidden = YES;
    NSTimeInterval animationDuration = 0.20f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
    
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
