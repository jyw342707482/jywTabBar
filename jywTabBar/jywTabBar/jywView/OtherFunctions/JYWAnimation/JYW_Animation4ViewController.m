//
//  JYW_Animation4ViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/7.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_Animation4ViewController.h"

@interface JYW_Animation4ViewController ()
{
    CALayer *animationLayer;
}
@end

@implementation JYW_Animation4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCALayer];
}

-(void)initCALayer{
    animationLayer=[CALayer layer];
    animationLayer.frame=CGRectMake(100, 100, 100, 100);
    animationLayer.backgroundColor=[UIColor redColor].CGColor;
    animationLayer.masksToBounds=YES;
    animationLayer.cornerRadius=50;
    [self.view.layer addSublayer:animationLayer];
    [self addAnimation];
}
-(void)addAnimation{
    
    CASpringAnimation *sAnimation=[CASpringAnimation animationWithKeyPath:@"position"];
    sAnimation.fromValue=@(animationLayer.position);
    sAnimation.toValue=@(CGPointMake(150, 500));
    sAnimation.duration=5.0f;
    sAnimation.removedOnCompletion=NO;
    sAnimation.repeatCount=INT_MAX;
    sAnimation.damping=4;
    sAnimation.initialVelocity=4;
    sAnimation.mass=2;
    sAnimation.stiffness=60;
    [animationLayer addAnimation:sAnimation forKey:@"position"];
    
    CASpringAnimation *sAnimation1=[CASpringAnimation animationWithKeyPath:@"bounds.size.height"];
    sAnimation1.fromValue=@(animationLayer.bounds.size.height);
    sAnimation1.toValue=@(animationLayer.bounds.size.height-10);
    sAnimation1.duration=5.0f;
    sAnimation1.beginTime=1.0f;
    sAnimation1.removedOnCompletion=YES;
    sAnimation1.repeatCount=INT_MAX;
    sAnimation1.damping=4;
    sAnimation1.initialVelocity=4;
    sAnimation1.mass=2;
    sAnimation1.stiffness=60;
    [animationLayer addAnimation:sAnimation1 forKey:@"bsHeight"];
}

@end
