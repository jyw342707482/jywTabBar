//
//  JYW_ButtonDoubleClickViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/19.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_ButtonDoubleClickViewController.h"
#import "UIButton+JYW_UIButtonMultiClick.h"
@interface JYW_ButtonDoubleClickViewController ()

@end

@implementation JYW_ButtonDoubleClickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    btn.jyw_acceptEventInterval=3;
    [btn method_exchangeImplementations];
}

-(IBAction)btn_click:(UIButton *)sender{
    NSLog(@"谁点我了？");
}

@end
