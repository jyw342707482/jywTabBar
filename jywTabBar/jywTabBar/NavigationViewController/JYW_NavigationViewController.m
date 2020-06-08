//
//  JYW_NavigationViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/8.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_NavigationViewController.h"

@interface JYW_NavigationViewController ()

@end

@implementation JYW_NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/*
// 重写自定义的UINavigationController中的push方法
// 处理tabbar的显示隐藏
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.childViewControllers.count==1){
        viewController.hidesBottomBarWhenPushed=YES;
        //viewController.tabBarController.tabBar.hidden=YES;
        //translucent
        //viewController.tabBarController.tabBar.translucent=YES;
        
    }
    [super pushViewController:viewController animated:animated];
}
*/
@end
