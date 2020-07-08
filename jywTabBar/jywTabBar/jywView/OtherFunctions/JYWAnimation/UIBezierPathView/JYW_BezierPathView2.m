//
//  JYW_BezierPathView2.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/7.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_BezierPathView2.h"

@implementation JYW_BezierPathView2

- (void)drawRect:(CGRect)rect{
    //创建一个矩形
    UIBezierPath *bPath2=[UIBezierPath bezierPathWithRect:CGRectMake(10, 10, 80, 80)];
    [[UIColor redColor] setStroke];
    [bPath2 stroke];
}

@end
