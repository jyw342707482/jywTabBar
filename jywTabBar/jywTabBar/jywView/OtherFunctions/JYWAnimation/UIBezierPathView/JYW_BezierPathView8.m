//
//  JYW_BezierPathView8.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/7.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_BezierPathView8.h"

@implementation JYW_BezierPathView8

- (void)drawRect:(CGRect)rect{
    //bezierPathByReversingPath,反向绘制,并不会修改样子，而是把路径反过来
    //创建，用路径
    CGMutablePathRef mPath=CGPathCreateMutable();
    CGPathMoveToPoint(mPath, nil, 10, 10);
    CGPathAddLineToPoint(mPath, nil, 90, 10);
    CGPathAddLineToPoint(mPath, nil, 70, 90);
    CGPathAddLineToPoint(mPath, nil, 50, 50);
    CGPathCloseSubpath(mPath);
    UIBezierPath *bPath8=[[UIBezierPath bezierPathWithCGPath:mPath] bezierPathByReversingPath];
    [[UIColor greenColor] setFill];
    [bPath8 fill];
    
    
}

@end
