//
//  JYW_Animation3ViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/6.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_Animation3ViewController.h"

@interface JYW_Animation3ViewController ()
{
    CALayer *animationLayer;
    CALayer *animationLayer1;
}
@end

@implementation JYW_Animation3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCALayer];
    [self initCALayer1];
}

-(void)initCALayer{
    animationLayer=[CALayer layer];
    animationLayer.frame=CGRectMake(0, 0, 100, 100);
    animationLayer.backgroundColor=[UIColor redColor].CGColor;
    [self.view.layer addSublayer:animationLayer];
    [self initAnimation];
}
-(void)initAnimation{
    NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(50, 50)];
    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(50, 200)];
    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(200, 200)];
    CAKeyframeAnimation *kAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    kAnimation.values=@[value1,value2,value3];
    kAnimation.keyTimes=@[@0,@0.5,@1];
    kAnimation.duration=10;
    kAnimation.timingFunctions=@[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]
    ];
    kAnimation.repeatCount=INT_MAX;
    [animationLayer addAnimation:kAnimation forKey:@"position"];
}
-(void)initCALayer1{
    animationLayer1=[CALayer layer];
    animationLayer1.frame=CGRectMake(0, 300, 100, 100);
    animationLayer1.backgroundColor=[UIColor blueColor].CGColor;
    [self.view.layer addSublayer:animationLayer1];
    [self initAnimation1];
}
-(void)initAnimation1{
    CGMutablePathRef mPath=CGPathCreateMutable();
    CGPathMoveToPoint(mPath, nil, animationLayer1.position.x, animationLayer1.position.y);
    CGPathAddCurveToPoint(mPath, nil, 200, 200, 300, 300, 200, 500);
    CAKeyframeAnimation *kAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    kAnimation.path=mPath;
    kAnimation.keyTimes=@[@0,@1];
    kAnimation.duration=10;
    kAnimation.timingFunctions=@[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]
    ];
    kAnimation.repeatCount=INT_MAX;
    [animationLayer1 addAnimation:kAnimation forKey:@"position1"];
}
@end
