#import "GirdTableViewCell.h"
#import "AnyWebViewController.h"

@implementation GirdTableViewCell

- (id)init:(UIViewController *)vc
{
   // NSLog(@"GirdTableViewCell");
    self = [super init]; //initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _parent = vc;
        _mainLabel = [[MDHTMLLabel alloc] init];//[[UILabel alloc] init];
        _mainLabel.frame = CGRectMake(15, 30, [UIScreen mainScreen].bounds.size.width - 30, 200);
        _mainLabel.numberOfLines = 0;
//        _mainLabel.userInteractionEnabled = YES;
        _mainLabel.delegate = self;
        
        [self addSubview:_mainLabel];
    }
    return self;
}

-(void) setLabelFont:(UIFont *)font
{
    _mainLabel.font = font;
}

-(void) setLabelText:(NSString *)text
{
    _mainLabel.htmlText = text;
   // NSLog(@"_mainLabel.text %@", _mainLabel.text);
    [_mainLabel sizeToFit];
    _mainLabel.frame = CGRectMake(15, 15, [UIScreen mainScreen].bounds.size.width - 30, _mainLabel.frame.size.height+20);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - MDHTMLLabelDelegate methods

- (void)HTMLLabel:(MDHTMLLabel *)label didSelectLinkWithURL:(NSURL *)URL
{
   // NSLog(@"Did select link with URL: %@", URL.absoluteString);
    
    AnyWebViewController * vc = [[AnyWebViewController alloc] init];
    [vc setAbsoluteURL:[URL absoluteString]];
    [_parent.navigationController pushViewController:vc animated:YES];
}

- (void)HTMLLabel:(MDHTMLLabel *)label didHoldLinkWithURL:(NSURL *)URL
{
   // NSLog(@"Did hold link with URL: %@", URL.absoluteString);
    
    AnyWebViewController * vc = [[AnyWebViewController alloc] init];
    [vc setAbsoluteURL:[URL absoluteString]];
    [_parent.navigationController pushViewController:vc animated:YES];
}

@end