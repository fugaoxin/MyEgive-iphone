#import <UIKit/UIKit.h>
#import "MDHTMLLabel.h"

@interface GirdTableViewCell : UITableViewCell <MDHTMLLabelDelegate>

@property (strong, nonatomic) MDHTMLLabel *mainLabel;
@property (strong, nonatomic) UIWebView *web;
@property (strong, nonatomic) UIViewController *parent;

-(id) init:(UIViewController *)vc;
-(void) setLabelFont:(UIFont *)font;
-(void) setLabelText:(NSString *)text;

@end