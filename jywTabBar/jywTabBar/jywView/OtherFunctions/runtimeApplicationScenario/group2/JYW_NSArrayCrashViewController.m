//
//  JYW_NSArrayCrashViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/20.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_NSArrayCrashViewController.h"
#import "NSArray+JYW_Crash.h"
@interface JYW_NSArrayCrashViewController ()
{
    NSArray *array;
}
@end

@implementation JYW_NSArrayCrashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    array=@[@"1"];
    [array method_exchangeImplementations];
}

-(IBAction)btn_click:(UIButton *)sender{
    NSString *arrayStr=array[1];
    NSLog(@"数组越界返回值%@",arrayStr);
}

@end
