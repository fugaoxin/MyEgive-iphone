//
//  baseController.m
//  Egive
//
//  Created by sino on 15/7/24.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "baseController.h"
#import "ShowMenuView.h"
#import "MemberModel.h"
#import "EGUtility.h"

@interface baseController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) MemberModel * item;
@property (copy, nonatomic) NSMutableDictionary * shareDict;

@end

@implementation baseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    tap.delegate = self;
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void)tapAction
{
    [self.view endEditing:YES];
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
//解决虚拟键盘挡住UITextField的方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    //    MyLog(@"frame.origin.y = %f [_serverArr count] = %lu", frame.origin.y, (unsigned long)[_serverArr count]);
    //int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    frame = [textField.superview convertRect:frame toView:self.view];
    
    int offset = frame.origin.y - (self.view.frame.size.height - 216.0 - 80);//键盘高度216;
    
    NSTimeInterval animationDuration = 0.30f;
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

- (void)setAlertView:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc] init];
    //alertView.title = @"标题";
    alertView.message = message;
    [alertView addButtonWithTitle:EGLocalizedString(@"Common_button_confirm", nil)];
    [alertView show];
}

-(void)shareSystem:(UIViewController *)viewController{

        NSString *string = @"分享内容"; // TODO
        
        UIActivityViewController *activityViewController =
        [[UIActivityViewController alloc] initWithActivityItems:@[string]
                                          applicationActivities:nil];
        [viewController.navigationController presentViewController:activityViewController
                                                animated:YES
                                              completion:^{
                                                  // ...
                                              }];
        activityViewController.excludedActivityTypes = @[UIActivityTypePrint];
    
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
