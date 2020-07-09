//
//  JYW_GradientLayer.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/8.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_GradientLayer.h"

@implementation JYW_GradientLayer

- (void)drawRect:(CGRect)rect{
    
    CAGradientLayer *gLayer=[CAGradientLayer layer];
    gLayer.frame=CGRectMake(10, 10, 90, 90);
    gLayer.colors=@[(id)[UIColor redColor].CGColor,
                    (id)[UIColor yellowColor].CGColor,
                    (id)[UIColor blueColor].CGColor,
                    (id)[UIColor greenColor].CGColor
    ];
    gLayer.locations=@[@(0.01),@(0.3),@(0.7),@(1)];
    gLayer.startPoint=CGPointMake(0, 0);
    gLayer.endPoint=CGPointMake(1, 1);
    gLayer.type=kCAGradientLayerAxial;
    [self.layer addSublayer:gLayer];
    
    CABasicAnimation *bAnimation=[CABasicAnimation animationWithKeyPath:@"endPoint"];
    bAnimation.fromValue=@(CGPointMake(0, 0));
    bAnimation.toValue=@(CGPointMake(1, 1));
    bAnimation.duration=5.0f;
    bAnimation.repeatCount=INT_MAX;
    [gLayer addAnimation:bAnimation forKey:@"endPoint"];
}
/*
 Gradient Style Properties 渐变样式属性
 colors颜色
 一组CGColorRef对象，用于定义每个渐变色的颜色。 可动画的。
 locations
 可选的NSNumber对象数组，用于定义每个渐变色标的位置。 可动画的。
 endPoint 端点
 在图层的坐标空间中绘制时，渐变的终点。 可动画的。
 startPoint起点
 在图层的坐标空间中绘制时，渐变的起点。 可动画的。
 type 类型
 图层绘制的渐变样式。
 */
@end
