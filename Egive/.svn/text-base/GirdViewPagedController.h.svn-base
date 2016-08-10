
#import <UIKit/UIKit.h>
#import "MenuViewController.h"
#import "EGDropDownMenu.h"
#import "MemberModel.h"

@interface GirdViewPagedController : MenuViewController <UIPageViewControllerDataSource, EGDropDownMenuDelegate> {
    UISearchBar *_searchBar;
    NSTimer * _timer;
    NSMutableArray * _dataArray;
    BOOL _isSwap;
    BOOL _isTouched;
    
    NSDictionary * _typeImageDict;
    NSDictionary * _typeImageDict1;
    NSDictionary * _categoryDict;
    NSString * _collectionFlag;
}
@property (strong, nonatomic) UIButton * navbutton;
@property (strong, nonatomic) UIPageViewController *pageController;
@property (copy, nonatomic) NSMutableArray * ShoppingCartArr;
@property (copy, nonatomic) NSMutableArray * caseIDarr;
@property (copy, nonatomic)NSString * CaseTitle; //搜索内容
@property (strong, nonatomic) MemberModel * item;
@property (strong, nonatomic) UILabel * collectionCount;
@property (strong, nonatomic) UILabel * cartLabel;
@end
