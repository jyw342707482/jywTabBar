//
//  JYW_BezierPathView5.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/7.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_BezierPathView5.h"

@implementation JYW_BezierPathView5

- (void)drawRect:(CGRect)rect{
    //创建圆角矩形
    UIBezierPath *bPath5=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, 80, 80) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(15, 15)];
    [[UIColor yellowColor] setFill];
    [bPath5 fill];
}

@end
