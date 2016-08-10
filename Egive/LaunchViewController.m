//
//  LaunchViewController.m
//  Egive
//
//  Created by sino on 15/9/24.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "LaunchViewController.h"

#import "SideMenuViewController.h"
#import "HomeViewController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化主页面
    HomeViewController * home = [[HomeViewController alloc] init];
    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:home];
    DDMenuController * rootController = [[DDMenuController alloc]initWithRootViewController:nvc];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = rootController;
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
