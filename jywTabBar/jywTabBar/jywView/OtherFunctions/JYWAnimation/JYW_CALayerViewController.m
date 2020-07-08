//
//  JYW_CALayerViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/8.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_CALayerViewController.h"
#import "JYW_TextLayer.h"
@interface JYW_CALayerViewController ()

@end

@implementation JYW_CALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTextLayer];
}
-(void)initTextLayer{
    JYW_TextLayer *tLayer=[[JYW_TextLayer alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [self.view addSubview:tLayer];
}


@end
