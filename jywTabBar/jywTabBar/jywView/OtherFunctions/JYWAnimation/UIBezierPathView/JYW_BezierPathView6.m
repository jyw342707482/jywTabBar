//
//  JYW_BezierPathView6.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/7.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_BezierPathView6.h"

@implementation JYW_BezierPathView6

- (void)drawRect:(CGRect)rect{
    //创建圆弧
    /*
     center:中心点
     radius:半径
     startAngle:圆弧开始位置
     endAngle:圆弧结束位置
     clockwise:圆弧方向
     */
    UIBezierPath *bPath6=[UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:40.0f startAngle:M_PI endAngle:M_PI_4 clockwise:YES];
    [[UIColor redColor] setStroke];
    [bPath6 stroke];
}

@end
