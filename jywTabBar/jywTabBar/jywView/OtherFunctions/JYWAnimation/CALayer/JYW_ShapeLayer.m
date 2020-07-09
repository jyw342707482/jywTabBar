//
//  JYW_ShapeLayer.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/8.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_ShapeLayer.h"

@implementation JYW_ShapeLayer

- (void)drawRect:(CGRect)rect{
    UIBezierPath *bezierPath=[UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(10, 10)];
    [bezierPath addLineToPoint:CGPointMake(90, 10)];
    [bezierPath addLineToPoint:CGPointMake(90, 90)];
    [bezierPath addCurveToPoint:CGPointMake(10, 10) controlPoint1:CGPointMake(10, 50) controlPoint2:CGPointMake(50, 50)];
    [bezierPath closePath];
    
    CAShapeLayer *sLayer=[CAShapeLayer layer];
    sLayer.path=bezierPath.CGPath;
    sLayer.lineWidth=5.0f;
    sLayer.lineCap=kCALineCapRound;
    sLayer.strokeColor=[UIColor redColor].CGColor;
    sLayer.fillColor=[UIColor clearColor].CGColor;
    sLayer.strokeStart=0.0f;
    sLayer.strokeEnd=1.0f;
    
    [self.layer addSublayer:sLayer];
    
    CABasicAnimation *bAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bAnimation.fromValue=@(0.0f);
    bAnimation.toValue=@(1.0f);
    bAnimation.duration=5;
    bAnimation.repeatCount=INT_MAX;
    [sLayer addAnimation:bAnimation forKey:@"stroke"];
    
}
/*
 Specifying the Shape Path 指定形状路径
 
 path 路径
 定义要渲染的形状的路径。 可动画的。
 
 Accessing Shape Style Properties 访问形状样式属性
 fillColor 填色
 用于填充形状路径的颜色。 可动画的。
 fillRule
 填充形状路径时使用的填充规则。
 lineCap
 指定形状路径的线帽样式。
 lineDashPattern
 划线时，虚线图案将应用于形状的路径。
 lineDashPhase
 划线时，破折号应用于图形的路径。 可动画的。
 lineJoin
 指定形状路径的线连接样式。
 lineWidth 行宽
 指定形状路径的线宽。 可动画的。
 miterLimit
 笔触形状路径时使用的斜接限制。 可动画的。
 strokeColor
 用于描画形状路径的颜色。 可动画的。
 strokeStart
 开始抚摸路径的相对位置。 可动画的。
 strokeEnd
 停止抚摸路径的相对位置。 可动画的。
 */
@end
