//
//  JYW_CALayerViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/8.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_CALayerViewController.h"
#import "JYW_TextLayer.h"
#import "JYW_ShapeLayer.h"
#import "JYW_GradientLayer.h"
#import "JYW_ShapeAndGradientFusion.h"
#import "JYW_EmitterLayer.h"
#import "JYW_ReplicatorLayer.h"
@interface JYW_CALayerViewController ()

@end

@implementation JYW_CALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTextLayer];
    [self initShapeLayer];
    [self initGradientLayer];
    [self initShapeAndGradientFusion];
    [self initEmitterLayer];
    [self initReplicatorLayer];
}
-(void)initTextLayer{
    JYW_TextLayer *tLayer=[[JYW_TextLayer alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [self.view addSubview:tLayer];
}
-(void)initShapeLayer{
    JYW_ShapeLayer *sLayer=[[JYW_ShapeLayer alloc] initWithFrame:CGRectMake(0, 110, 100, 100)];
    [self.view addSubview:sLayer];
}
-(void)initGradientLayer{
    JYW_GradientLayer *gLayer=[[JYW_GradientLayer alloc] initWithFrame:CGRectMake(120, 110, 100, 100)];
    [self.view addSubview:gLayer];
}
-(void)initShapeAndGradientFusion{
    JYW_ShapeAndGradientFusion *sagf=[[JYW_ShapeAndGradientFusion alloc] initWithFrame:CGRectMake(230, 110, 100, 100)];
    [self.view addSubview:sagf];
}
-(void)initEmitterLayer{
    JYW_EmitterLayer *eLayer=[[JYW_EmitterLayer alloc] initWithFrame:CGRectMake(0, 220, 200, 200)];
    [self.view addSubview:eLayer];
}
-(void)initReplicatorLayer{
    JYW_ReplicatorLayer *rLayer=[[JYW_ReplicatorLayer alloc] initWithFrame:CGRectMake(230, 220, 200, 100)];
    [self.view addSubview:rLayer];
}
@end
