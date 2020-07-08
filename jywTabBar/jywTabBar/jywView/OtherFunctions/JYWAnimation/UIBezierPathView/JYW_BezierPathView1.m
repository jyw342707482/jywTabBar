//
//  JYW_BezierPathView1.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/7.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_BezierPathView1.h"

@implementation JYW_BezierPathView1

- (void)drawRect:(CGRect)rect{
    //将后续笔划和填充操作的颜色设置为接收器代表的颜色。
    [[UIColor redColor] set];
    //将后续笔划操作的颜色设置为接收器代表的颜色。
    [[UIColor yellowColor] setStroke];
    
    //创建一个新的实例，并返回空
    UIBezierPath *bPath1=[UIBezierPath bezierPath];
    //添加起始点
    [bPath1 moveToPoint:CGPointMake(10, 10)];
    //添加线
    [bPath1 addLineToPoint:CGPointMake(90, 10)];
    //添加线
    [bPath1 addLineToPoint:CGPointMake(90, 90)];
    //添加线
    //[bPath1 addLineToPoint:CGPointMake(10, 90)];
    //添加贝塞尔曲线，
    //[bPath1 addQuadCurveToPoint:CGPointMake(10, 10) controlPoint:CGPointMake(10, 90)];
    [bPath1 addCurveToPoint:CGPointMake(10, 10) controlPoint1:CGPointMake(90, 50) controlPoint2:CGPointMake(10, 50)];
    //封闭路径
    [bPath1 closePath];
    bPath1.lineWidth=2.0f;
    
    [[UIColor yellowColor] set];
    //[bPath1 stroke];
    [bPath1 fill];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
