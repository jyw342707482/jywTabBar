//
//  JYW_FireworksViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/19.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_FireworksViewController.h"
#import "JYWFireworks.h"
@interface JYW_FireworksViewController ()
{
    JYWFireworks *fireworks;
}
@end

@implementation JYW_FireworksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    float fireworksHeight=0;
    if (@available(iOS 11.0, *)) {
        fireworksHeight=168;
    }
    fireworks=[[JYWFireworks alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-fireworksHeight)];
    [self.view addSubview:fireworks];
    [fireworks play];
    
    //添加导航右侧按钮
    //添加导航右侧按钮，按钮类型为系统加号
    UIBarButtonItem *leftBarButton1=[[UIBarButtonItem alloc] initWithTitle:@"＜返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButton_Back:)];
    self.navigationItem.leftBarButtonItem=leftBarButton1;
}
-(IBAction)leftBarButton_Back:(id)sender{
    
    [fireworks stop];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
