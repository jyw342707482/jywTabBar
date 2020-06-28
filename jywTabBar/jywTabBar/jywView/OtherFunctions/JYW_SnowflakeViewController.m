//
//  JYW_SnowflakeViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/19.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_SnowflakeViewController.h"
#import "JYW_Snowflake.h"
#import "JYWFireworks.h"
@interface JYW_SnowflakeViewController ()
{
    JYW_Snowflake *snowflake;
}
@end

@implementation JYW_SnowflakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    float snowflakeHeight=0;
    if (@available(iOS 11.0, *)) {
        snowflakeHeight=168;
    }
    snowflake=[[JYW_Snowflake alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-snowflakeHeight)];
    [self.view addSubview:snowflake];
    snowflake.birthRate=10;
    [snowflake play];
    //添加导航右侧按钮
    //添加导航右侧按钮，按钮类型为系统加号
    UIBarButtonItem *leftBarButton1=[[UIBarButtonItem alloc] initWithTitle:@"＜返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButton_Back:)];
    self.navigationItem.leftBarButtonItem=leftBarButton1;
}
#pragma mark -返回按钮
-(IBAction)leftBarButton_Back:(id)sender{
    
    [snowflake stop];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
