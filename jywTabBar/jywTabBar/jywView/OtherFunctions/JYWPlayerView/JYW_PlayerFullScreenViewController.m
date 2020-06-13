//
//  JYW_PlayerFullScreenViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/11.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_PlayerFullScreenViewController.h"

@interface JYW_PlayerFullScreenViewController ()

@end

@implementation JYW_PlayerFullScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"aa");
    // Do any additional setup after loading the view.
}
/*
# pragma mark -禁止屏幕翻转动画
//ios8以后
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    NSLog(@"bb");
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
        [CATransaction commit];
    }];
}
//ios8以前
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    NSLog(@"bb1");
    [UIView setAnimationsEnabled:NO];
    return TRUE;
// Your original orientation booleans, in case you prevent one of the orientations
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"bb2");
    [[UIApplication sharedApplication] setStatusBarOrientation:toInterfaceOrientation animated:NO];
}
*/
# pragma Mark -锁定屏幕方向
/*此方法只能在rootViewController下设置可用，其它位置设置无效**/
- (BOOL)shouldAutorotate{
    return NO;
}
//返回视图控制器支持的所有界面方向。
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight;
}
/*
//返回呈现视图控制器时要使用的界面方向。
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}
*/
@end
