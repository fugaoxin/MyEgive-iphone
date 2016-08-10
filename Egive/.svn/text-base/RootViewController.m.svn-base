//
//  RootViewController.m
//  Egive
//
//  Created by sino on 15/8/4.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "RootViewController.h"
#import "HomeViewController.h"
#import "InformationController.h"
#import "AboutGridViewController.h"
#import "GirdViewController.h"
#import "GirdViewPagedController.h"

@interface RootViewController ()

@property (strong, nonatomic) HomeViewController * home;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _home = [[HomeViewController alloc] init];
    _nv = [[UINavigationController alloc] initWithRootViewController:_home];
    [self.view addSubview:_nv.view];
    
    
    
}

#pragma -mark MenuViewControllerDelegate
- (void)didSelectItem:(NSString *)title{
    
    if (self.nv.viewControllers.count > 1) {
        NSMutableArray *controllers = [NSMutableArray arrayWithArray:self.nv.viewControllers];
        [controllers removeLastObject];
        self.nv.viewControllers = [controllers copy];
    }
    
    if ([title isEqualToString:@"80"]) {
        AboutGridViewController * vc1 = [[AboutGridViewController alloc] init];
        UIButton * button = (UIButton *)[vc1.navigationController.navigationBar viewWithTag:95];
        button.hidden = YES;
        
        HomeViewController * vc = [[HomeViewController alloc] init];

        [self.nv pushViewController:vc animated:YES];

        
    }else if ([title isEqualToString:@"81"]){
        AboutGridViewController * vc = [[AboutGridViewController alloc] init];

        [self.nv pushViewController:vc animated:YES];
        
    }else if ([title isEqualToString:@"82"]){
        GirdViewController * vc = [[GirdViewController alloc] init];
      
        [self.nv pushViewController:vc animated:YES];
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

@end
