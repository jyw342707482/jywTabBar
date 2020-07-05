//
//  JYWProgressRing1.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/18.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYWProgressRing1.h"

@implementation JYWProgressRing1

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //[self addAnimation ];
    }
    return self;
}
-(void)play{
    if(layerArray!=nil){
        return;
    }
        
    float x=self.frame.size.width/2;
    layerArray=[[NSMutableArray alloc] init];
    for(int i=0;i<10;i++){
        CALayer *layer=[[CALayer alloc] init];
        layer.frame=CGRectMake(x-5, 0, 10, 10);
        layer.backgroundColor=[UIColor redColor].CGColor;
        layer.cornerRadius=5;
        //位置动画
        CAKeyframeAnimation *kFrameAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
        kFrameAnimation.path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(x, x) radius:x-5 startAngle:-M_PI_2 endAngle:30 clockwise:1].CGPath;
        kFrameAnimation.duration=15;
        kFrameAnimation.beginTime=i*0.3;
        
        kFrameAnimation.fillMode = kCAFillModeForwards;
        //确定在完成后是否从目标层的动画中删除动画。
        kFrameAnimation.removedOnCompletion=NO;
        kFrameAnimation.calculationMode = kCAAnimationPaced;
        kFrameAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        //改变透明度动画
        CABasicAnimation *bAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
        bAnimation.fromValue=[NSNumber numberWithFloat:1.0];
        bAnimation.toValue=[NSNumber numberWithFloat:0];
        bAnimation.duration=15;
        bAnimation.beginTime=i*0.3;
        //改变背景色动画
        CABasicAnimation *bAnimation1=[CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        bAnimation1.fromValue=(__bridge id _Nullable)([UIColor redColor].CGColor);
        bAnimation1.toValue=(__bridge id _Nullable)([UIColor blueColor].CGColor);
        bAnimation1.duration=15;
        bAnimation1.beginTime=i*0.3;
        
        //组动画
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[kFrameAnimation,bAnimation,bAnimation1];
        group.duration = 15;
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
        //动画重复次数
        group.repeatCount = INTMAX_MAX;
        [layer addAnimation:group forKey:nil];
        [self.layer addSublayer:layer];
        [layerArray addObject:layer];
        
    }
}
-(void)stop{
    for(CALayer *layer in layerArray){
        [layer removeFromSuperlayer];
    }
    layerArray=nil;
}

@end
