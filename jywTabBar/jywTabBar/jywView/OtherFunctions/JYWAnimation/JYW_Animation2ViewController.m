//
//  JYW_Animation2ViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/6.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_Animation2ViewController.h"

@interface JYW_Animation2ViewController ()
{
    CALayer *animationlayer;
}
@end

@implementation JYW_Animation2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    animationlayer=[CALayer layer];
    animationlayer.frame=CGRectMake(0, 0, 100, 100);
    animationlayer.backgroundColor=[UIColor redColor].CGColor;
    [self.view.layer addSublayer:animationlayer];
    [self addAnimation];
}

-(void)addAnimation{
    
    CABasicAnimation *bAnimation=[CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    bAnimation.fromValue=(id)[UIColor redColor].CGColor;
    //bAnimation.byValue=(id)[UIColor yellowColor].CGColor;
    bAnimation.toValue=(id)[UIColor blueColor].CGColor;
    bAnimation.duration=10;
    bAnimation.repeatCount=INT_MAX;
    [animationlayer addAnimation:bAnimation forKey:@"bgc"];
    
    CABasicAnimation *bAnimation1=[CABasicAnimation animationWithKeyPath:@"position"];
    bAnimation1.fromValue=@(animationlayer.position);
    bAnimation1.toValue=@(CGPointMake(200, 200));
    bAnimation1.duration=10;
    bAnimation1.repeatCount=INT_MAX;
    [animationlayer addAnimation:bAnimation1 forKey:@"p"];
    
    CABasicAnimation *bAnimation2=[CABasicAnimation animationWithKeyPath:@"opacity"];
    bAnimation2.fromValue=@(1.0f);
    bAnimation2.toValue=@(0.2f);
    bAnimation2.duration=10;
    bAnimation2.repeatCount=INT_MAX;
    [animationlayer addAnimation:bAnimation2 forKey:@"o"];
    
    CABasicAnimation *bAnimation3=[CABasicAnimation animationWithKeyPath:@"transform.scale"];//transform.scale.x,transform.scale.y
    bAnimation3.fromValue=@(1);
    bAnimation3.toValue=@(2);
    bAnimation3.duration=10;
    bAnimation3.repeatCount=INT_MAX;
    [animationlayer addAnimation:bAnimation3 forKey:@"ts"];
}

@end
