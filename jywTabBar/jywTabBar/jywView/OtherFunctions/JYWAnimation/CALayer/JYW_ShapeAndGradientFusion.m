//
//  JYW_ShapeAndGradientFusion.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/8.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_ShapeAndGradientFusion.h"

@implementation JYW_ShapeAndGradientFusion

- (void)drawRect:(CGRect)rect{
    UIBezierPath *bezierPath=[UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(10, 10)];
    [bezierPath addLineToPoint:CGPointMake(90, 10)];
    [bezierPath addLineToPoint:CGPointMake(90, 90)];
    [bezierPath addCurveToPoint:CGPointMake(10, 10) controlPoint1:CGPointMake(10, 50) controlPoint2:CGPointMake(50, 50)];
    [bezierPath closePath];
    
    CAShapeLayer *sLayer=[CAShapeLayer layer];
    sLayer.path=bezierPath.CGPath;
    sLayer.strokeColor=[UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:0.5].CGColor;
    sLayer.fillColor=[UIColor clearColor].CGColor;
    sLayer.lineWidth=5.0f;
    sLayer.strokeStart=0;
    sLayer.strokeEnd=1;
    sLayer.lineCap=kCALineCapRound;
    [self.layer addSublayer:sLayer];
    
    CAGradientLayer *gLayer=[CAGradientLayer layer];
    gLayer.frame=CGRectMake(0, 0, 100, 100);
    gLayer.colors=@[(id)[UIColor redColor].CGColor,
                    (id)[UIColor yellowColor].CGColor,
                    (id)[UIColor blueColor].CGColor,
                    (id)[UIColor greenColor].CGColor
    ];
    gLayer.locations=@[@(0.01),@(0.33),@(0.66),@(1)];
    gLayer.startPoint=CGPointMake(0, 0);
    gLayer.endPoint=CGPointMake(1, 1);
    gLayer.type=kCAGradientLayerAxial;
    [self.layer addSublayer:gLayer];
    
    
    CAShapeLayer *mainLayer=[CAShapeLayer layer];
    mainLayer.path=bezierPath.CGPath;
    mainLayer.lineWidth=5.0f;
    mainLayer.strokeStart=0;
    mainLayer.strokeEnd=1;
    mainLayer.strokeColor=[UIColor redColor].CGColor;
    mainLayer.fillColor=[UIColor clearColor].CGColor;
    mainLayer.lineCap=kCALineCapRound;
    gLayer.mask=mainLayer;
    
    CABasicAnimation *bAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bAnimation.duration=5.0f;
    bAnimation.fromValue=@(0);
    bAnimation.toValue=@(1);
    bAnimation.repeatCount=INT_MAX;
    [mainLayer addAnimation:bAnimation forKey:@"strokeEnd"];
    
}

@end
