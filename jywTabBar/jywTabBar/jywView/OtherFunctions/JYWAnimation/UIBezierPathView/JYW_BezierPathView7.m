//
//  JYW_BezierPathView7.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/7.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_BezierPathView7.h"

@implementation JYW_BezierPathView7

- (void)drawRect:(CGRect)rect{
    //创建，用路径
    CGMutablePathRef mPath=CGPathCreateMutable();
    CGPathMoveToPoint(mPath, nil, 10, 10);
    CGPathAddLineToPoint(mPath, nil, 90, 30);
    CGPathAddLineToPoint(mPath, nil, 90, 70);
    CGPathAddLineToPoint(mPath, nil, 70, 90);
    CGPathAddLineToPoint(mPath, nil, 30, 70);
    CGPathCloseSubpath(mPath);
    UIBezierPath *bPath7=[UIBezierPath bezierPathWithCGPath:mPath];
    [[UIColor blueColor] setFill];
    [bPath7 fill];
}

@end
