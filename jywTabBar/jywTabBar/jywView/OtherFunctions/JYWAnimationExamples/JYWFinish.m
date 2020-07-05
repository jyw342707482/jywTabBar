//
//  JYWFinish.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/18.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYWFinish.h"

@implementation JYWFinish
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //[self caAnimation];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    //自定义图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();//创建图形上下文对象
    CGContextAddArc(context, self.frame.size.width/2, self.frame.size.height/2, self.frame.size.width/2, 0, M_PI*2, 1);
    //设置黑色描边参数
    [[UIColor blackColor] setStroke];
    //设置蓝色填充参数
    [[UIColor whiteColor] setFill];
    //绘制路径
    CGContextDrawPath(context,kCGPathFillStroke);
}
-(void)play{
    UIBezierPath *bezierPath=[UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(self.frame.size.width/4, self.frame.size.height/2)];
    [bezierPath addLineToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/4*3)];
    [bezierPath addLineToPoint:CGPointMake(self.frame.size.width/4*3, self.frame.size.height/3)];
    shape=[CAShapeLayer layer];
    shape.lineWidth=3;
    shape.fillColor=[UIColor clearColor].CGColor;
    shape.strokeColor=[UIColor colorWithRed:0.76f green:0.89f blue:0.89f alpha:1.00f].CGColor;
    /*
     kCALineCapButt: 默认格式，不附加任何形状;
     kCALineCapRound: 在线段头尾添加半径为线段 lineWidth 一半的半圆；
     kCALineCapSquare: 在线段头尾添加半径为线段 lineWidth 一半的矩形”
     */
    shape.lineCap = kCALineCapRound;
    shape.lineJoin = kCALineJoinRound;

    shape.path=bezierPath.CGPath;
    [self.layer addSublayer:shape];
    
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = 1;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    //checkAnimation.delegate = self;
    
    //组动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[checkAnimation];
    group.duration = 1;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    //动画重复次数
    group.repeatCount = INTMAX_MAX;
    [shape addAnimation:group forKey:@"checkAnimation"];
}
-(void)stop{
    [shape removeFromSuperlayer];
}
@end
