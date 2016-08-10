
#import "GirdViewPagedController.h"
#import "GirdViewController.h"
#import "MyDonationViewController.h"
#define ScreenSize [UIScreen mainScreen].bounds.size

@interface GirdViewPagedController ()

@end

@implementation GirdViewPagedController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    GirdViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"點擊行善";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]}];
    
    _caseIDarr = [[NSMutableArray alloc] init]; //购物车中的caseID
    
    _ShoppingCartArr = [[NSMutableArray alloc] init];
    NSArray * arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"isCartItem"];
    if (arr) {
        [_ShoppingCartArr addObjectsFromArray:arr];
    }
    
    __weak typeof(self) weakSelf = self;
    self.navbutton = [self.navigationController.navigationBar addImageButtonWithFrame:CGRectMake(ScreenSize.width-110, 5, 33, 33) title:nil backgroud:@"header_favourite@2x.png" action:^(UIButton *button) {
        if (weakSelf.item != nil){
            MyAttentionViewController * vc = [[MyAttentionViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            UIAlertView *alertView = [[UIAlertView alloc] init];
            //alertView.title = @"标题";
            alertView.message = @"请登录后再操作!";
            [alertView addButtonWithTitle:@"确定"];
            [alertView show];
        }
    }];
    
    _typeImageDict = @{@"S":@"comment_poster_type_education@2x.png",
                       @"E":@"comment_poster_type_elder@2x.png",
                       @"U":@"comment_poster_type_emergency@2x.png",
                       @"M":@"comment_poster_type_medical@2x.png",
                       @"P":@"comment_poster_type_poverty@2x.png",
                       @"A":@"comment_poster_type_case_list@2x.png"};
    
    _typeImageDict1 = @{@"S":@"comment_list_type_education@2x.png",
                        @"E":@"comment_list_type_elder@2x.png",
                        @"U":@"comment_list_type_emergency@2x.png",
                        @"M":@"comment_list_type_medical@2x.png",
                        @"P":@"comment_list_type_poverty@2x.png",
                        @"A":@"comment_list_type_case_list@2x.png"};
    _categoryDict   = @{@"0":@"", @"1":@"S",@"2":@"E",@"3":@"M",@"4":@"P",@"5":@"U",@"6":@"A",@"7":@"0",};
    
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 70,50);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"header_logo@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    [rightButton addTarget:self action:@selector(cartAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"header_cart@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //购物车右侧数量标示label
    NSMutableDictionary * shopCartDict = [ShowMenuView getIsSaveShoppingCart];
    EGGetAndSaveShoppingCartResult * item = shopCartDict[@"shopItem"];
    
    _cartLabel = [self.navigationController.navigationBar addLabelWithFrame:CGRectMake(ScreenSize.width-30, 18, 18, 18) text:[NSString stringWithFormat:@"%ld",item.NumberOfItems]];
    _cartLabel.layer.cornerRadius = 9;
    _cartLabel.layer.masksToBounds = YES;
    _cartLabel.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    _cartLabel.textAlignment = NSTextAlignmentCenter;
    _cartLabel.font = [UIFont systemFontOfSize:11];
    _cartLabel.textColor = [UIColor whiteColor];
    
    
    //收藏右侧数量标示label
    _collectionCount = [self.navigationController.navigationBar addLabelWithFrame:CGRectMake(ScreenSize.width-85, 18, 18, 18) text:@"1"];
    _collectionCount.layer.cornerRadius = 9;
    _collectionCount.layer.masksToBounds = YES;
    _collectionCount.backgroundColor = [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1];
    _collectionCount.textAlignment = NSTextAlignmentCenter;
    _collectionCount.font = [UIFont systemFontOfSize:11];
    _collectionCount.textColor = [UIColor whiteColor];
    
    
    //判断用户是否登入，如登入获取：MemberID
    NSMutableDictionary * dict = [ShowMenuView getUserInfo];
    _item = dict[@"LoginName"];
    
    _collectionFlag = @"N";
    
}

-(void)cartAction{
    MyDonationViewController * vc = [[MyDonationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (GirdViewController *)viewControllerAtIndex:(NSUInteger)index {
    int tag = 90 + (int)index;
    GirdViewController *childViewController = [[GirdViewController alloc] initWithTag:tag];
    childViewController.index = index;
    
    return childViewController;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(GirdViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(GirdViewController *)viewController index];
    
    index++;
    
    if (index == 4) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

@end
