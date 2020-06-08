//
//  JYW_TabBarViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/27.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_TabBarViewController.h"
#import "JYW_TableViewController.h"
#import "JYW_OtherFunctionsViewController.h"
#import "JYW_CollectionViewController.h"
#import "JYW_NavigationViewController.h"
@interface JYW_TabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation JYW_TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate=self;
    self.tabBar.translucent=NO;
    [self addChildVC:[JYW_TableViewController new] Title:@"UITableView"];
    [self addChildVC:[JYW_OtherFunctionsViewController new] Title:@"OtherFunctions"];
    [self addChildVC:[JYW_CollectionViewController new] Title:@"UICollectionView"];
    
}

-(void)addChildVC:(UIViewController *)childVC Title:(NSString *)title{
    //UIViewController *vc=[[childVC alloc] init];
    JYW_NavigationViewController *nvc=[[JYW_NavigationViewController alloc] initWithRootViewController:childVC];
    nvc.title=title;
    nvc.navigationBar.hidden=NO;
    nvc.navigationBar.translucent=NO;
    [self addChildViewController:nvc];
}
# pragma Mark -锁定屏幕方向
/*此方法只能在rootViewController下设置可用，其它位置设置无效**/
- (BOOL)shouldAutorotate{
    return YES;
}
//返回视图控制器支持的所有界面方向。
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
//返回呈现视图控制器时要使用的界面方向。
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}
@end
