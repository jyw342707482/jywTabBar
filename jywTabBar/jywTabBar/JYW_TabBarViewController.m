//
//  JYW_TabBarViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/27.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_TabBarViewController.h"
#import "JYW_TableViewController.h"
#import "JYW_PictureViewController.h"
#import "JYW_CollectionViewController.h"
@interface JYW_TabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation JYW_TabBarViewController
/*
-(instancetype)init{
    self=[super init];
    if(self){
        CGRect tbFrame=self.view.frame;
        tbFrame.size.height+=0;
        self.view.frame=tbFrame;
    }
    return self;
}*/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBarItem];
}
/*
//修改tbbar的高度
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGRect tbFrame=self.tabBar.frame;
    tbFrame.size.height+=10;
    tbFrame.origin.y=self.view.frame.size.height-tbFrame.size.height;
    self.tabBar.frame=tbFrame;
    
}
 */
//设置items
-(void)setTabBarItem{
    self.delegate=self;
    self.tabBar.translucent=NO;
    JYW_TableViewController *jywTV=[[JYW_TableViewController alloc] init];
    UINavigationController *nc1=[[UINavigationController alloc] initWithRootViewController:jywTV];
    nc1.title=@"tableView";
    nc1.navigationBar.hidden=NO;
    nc1.navigationBar.translucent=NO;
    
    JYW_PictureViewController *jywPV=[[JYW_PictureViewController alloc] init];
    UINavigationController *nc2=[[UINavigationController alloc] initWithRootViewController:jywPV];
    nc2.title=@"pictureView";
    nc2.navigationBar.hidden=NO;
    nc2.navigationBar.translucent=NO;
    
    JYW_CollectionViewController *jywCV=[[JYW_CollectionViewController alloc] init];
    UINavigationController *nc3=[[UINavigationController alloc] initWithRootViewController:jywCV];
    nc3.title=@"collectionView";
    nc3.navigationBar.hidden=NO;
    nc3.navigationBar.translucent=NO;
    
    self.viewControllers=@[nc1,nc2,nc3];
}

@end
