//
//  Launching.m
//  Egive
//
//  Created by Tree Yip on 2/10/15.
//  Copyright © 2015 sino. All rights reserved.
//

#import "Launching.h"

#import "DDMenuController.h"
#import "PopupAdController.h"
#import "MediaPlayer/MediaPlayer.h"
#import "LangViewController.h"
@interface Launching ()
@property (retain, nonatomic) MPMoviePlayerController *player;

@property (strong, nonatomic) DDMenuController * menuController;
@property (nonatomic) BOOL isFirstLuch;
@end

@implementation Launching

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *moviePath = [bundle pathForResource:@"splash_1" ofType:@"mp4"];
    NSURL *movieURL = [NSURL fileURLWithPath:moviePath];

    self.player = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    [self.player setContentURL:movieURL];
    [self.player setMovieSourceType:MPMovieSourceTypeFile];
    
    [[self.player view] setFrame:self.view.bounds];
    [self.player view].backgroundColor = [UIColor whiteColor];
    
    self.player.scalingMode = MPMovieScalingModeNone;
    self.player.controlStyle = MPMovieControlStyleNone;
    self.player.backgroundView.backgroundColor = [UIColor whiteColor];
//    self.player.repeatMode = MPMovieRepeatModeNone;

    
    [self.view addSubview: [self.player view]];
    [self.player play];
    
    _isFirstLuch = YES;
    BOOL isfirst = [[NSUserDefaults standardUserDefaults] floatForKey:@"AppFirstLuch"];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (!isfirst) {
            DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
            LangViewController * vc = [[LangViewController alloc] init];
            [menuController setRootController:vc animated:YES];
            
            _isFirstLuch = YES;
            [[NSUserDefaults standardUserDefaults] setFloat:_isFirstLuch forKey:@"AppFirstLuch"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            
            DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
            HomeViewController * vc = [[HomeViewController alloc] init];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
            [menuController setRootController:navController animated:YES];

       
            
            PopupAdController *pvc = [[PopupAdController alloc] init];
            pvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            pvc.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [vc presentViewController:pvc animated:YES completion:^{
                
            }];
            
//            if ([_push isEqualToString:@"1"]) {
//                
//                [vc pushPro];
//            }
        
        }

    });
    
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
