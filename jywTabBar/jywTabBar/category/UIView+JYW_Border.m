//
//  UIView+JYW_Border.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/29.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "UIView+JYW_Border.h"

@implementation UIView (JYW_Border)
//设置左侧边框
-(void)drawLeftBorderWithBorderWidth:(float)borderWidth borderColor:(UIColor *)borderColor{
    CGRect lineRect=CGRectMake(0, 0, borderWidth, self.frame.size.height);
    [self drawBorderWithLineRect:lineRect lineColor:borderColor];
}
//设置右侧边框
-(void)drawRightBorderWithBorderWidth:(float)borderWidth borderColor:(UIColor *)borderColor{
    CGRect lineRect=CGRectMake(self.frame.size.width, 0, borderWidth, self.frame.size.height);
    [self drawBorderWithLineRect:lineRect lineColor:borderColor];
}
//设置上边框
-(void)drawTopBorderWithBorderWidth:(float)borderWidth borderColor:(UIColor *)borderColor{
    CGRect lineRect=CGRectMake(0, 0, self.frame.size.width, borderWidth);
    [self drawBorderWithLineRect:lineRect lineColor:borderColor];
}
//设置下边框
-(void)drawBottomBorderWithBorderWidth:(float)borderWidth borderColor:(UIColor *)borderColor{
    CGRect lineRect=CGRectMake(0, self.frame.size.height, self.frame.size.width, borderWidth);
    [self drawBorderWithLineRect:lineRect lineColor:borderColor];
}
//画线
-(void)drawBorderWithLineRect:(CGRect)lineRect lineColor:(UIColor *)lineColor{
    //实例化一条宽度为1的直线
    UIBezierPath *bPath=[UIBezierPath bezierPathWithRect:lineRect];
    //设置路径的画布
    CAShapeLayer *caShape=[[CAShapeLayer alloc] init];
    //设置画布的路径为贝塞尔曲线的路径
    caShape.path=bPath.CGPath;
    //设置颜色
    caShape.fillColor=lineColor.CGColor;
    //添加到画布的 layer
    [self.layer addSublayer:caShape];
}
@end
