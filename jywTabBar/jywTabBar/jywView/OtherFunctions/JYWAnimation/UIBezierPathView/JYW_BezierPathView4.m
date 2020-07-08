//
//  JYW_BezierPathView4.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/7.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_BezierPathView4.h"

@implementation JYW_BezierPathView4

- (void)drawRect:(CGRect)rect{
    //创建圆角矩形
    UIBezierPath *bPath4=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, 80, 80) cornerRadius:10.0f];
    [[UIColor greenColor] setStroke];
    [bPath4 stroke];
}

@end
