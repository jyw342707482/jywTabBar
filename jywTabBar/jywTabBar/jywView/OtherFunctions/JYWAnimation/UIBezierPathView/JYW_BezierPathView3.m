//
//  JYW_BezierPathView3.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/7.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_BezierPathView3.h"

@implementation JYW_BezierPathView3

- (void)drawRect:(CGRect)rect{
    //创建矩形中的椭圆形
    UIBezierPath *bPath3=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 20, 80, 60)];
    [[UIColor blueColor] setFill];
    [bPath3 fill];
}

@end
