//
//  JYWGradeRing.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/20.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYWGradeRing.h"

@implementation JYWGradeRing

-(instancetype)initWithFrame:(CGRect)frame colorArray:(NSArray*)colorArray locationArray:(NSArray*)locationArray{
    self=[super initWithFrame:frame];
    if(self){
        self.backgroundColor=[UIColor blackColor];
        self.locationArray=locationArray;
        self.colorArray=colorArray;
        [self addAnimation];
        [self addSubview:self.percentageLabel];
    }
    return self;
}
-(void)addAnimation{
    //背景灰色
    CAShapeLayer *shapeLayer=[CAShapeLayer layer];
    shapeLayer.frame=self.bounds;
    shapeLayer.lineWidth=self.bounds.size.width/2*0.15;
    shapeLayer.fillColor=[UIColor clearColor].CGColor;
    shapeLayer.strokeColor=[UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0].CGColor;
    UIBezierPath *bezierPath=[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:self.frame.size.width/2-shapeLayer.lineWidth startAngle:-0.5 *M_PI endAngle:1.5 *M_PI clockwise:YES];
    shapeLayer.path=bezierPath.CGPath;
    [self.layer addSublayer:shapeLayer];
    
    //渐变色，蒙版
    CAGradientLayer *gradientLayer=[CAGradientLayer layer];
    gradientLayer.frame=self.bounds;
    gradientLayer.colors=self.colorArray;
    gradientLayer.locations=self.locationArray;
    gradientLayer.startPoint=CGPointMake(1, 0.5);
    gradientLayer.endPoint=CGPointMake(0.5, 1);
    [self.layer addSublayer:gradientLayer];
    
    mainShapeLayer=[CAShapeLayer layer];
    mainShapeLayer.frame=self.bounds;
    mainShapeLayer.fillColor=[UIColor clearColor].CGColor;
    mainShapeLayer.lineWidth=self.bounds.size.width/2*0.15;
    mainShapeLayer.strokeColor=[UIColor greenColor].CGColor;
    mainShapeLayer.strokeEnd=self.progress;
    mainShapeLayer.lineCap=kCALineCapRound;
    mainShapeLayer.path=bezierPath.CGPath;
    gradientLayer.mask=mainShapeLayer;
}
/*
-(void)addAnimation{
    
    CALayer *layer = [CALayer layer];
    
    CAGradientLayer *gradientLayer=[CAGradientLayer layer];
    gradientLayer.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    //gradientLayer.position = self.center;
    //[self.layer addSublayer: gradientLayer];
    //渐变颜色组，一组CGColorRef对象
    gradientLayer.colors=self.colorArray;
    //NSNumber对象的可选数组，用于定义每个渐变色标的位置。 可以动画。
    gradientLayer.locations=self.locationArray;
    //在图层的坐标空间中绘制时渐变的终点。 可以动画。
    gradientLayer.endPoint=CGPointMake(1, 0);
    //在图层的坐标空间中绘制时渐变的起点。 可以动画。
    gradientLayer.startPoint=CGPointMake(0, 0);
     
    
    gradientLayer.type=kCAGradientLayerAxial;
    [layer addSublayer:gradientLayer];
    
    shapeLayer=[CAShapeLayer layer];
    shapeLayer.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    shapeLayer.lineWidth=self.frame.size.width/2*0.1;
    NSLog(@"%f",self.frame.size.width*0.1);
    shapeLayer.strokeEnd=0.5;
    shapeLayer.lineCap=kCALineCapRound;
    shapeLayer.fillColor=[UIColor clearColor].CGColor;
    shapeLayer.strokeColor=[UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0].CGColor;
    UIBezierPath *bezierPath=[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:self.frame.size.width/2-shapeLayer.lineWidth startAngle:-M_PI_2 endAngle:-M_PI_2+M_PI*2*_progress clockwise:YES];
    //绘制
    //[bezierPath stroke];
    shapeLayer.path=bezierPath.CGPath;
    [self.layer addSublayer:shapeLayer];
    
    layer.mask=shapeLayer;
    [self.layer addSublayer:layer];
     
}
*/
#pragma mark -懒加载
-(UILabel *)percentageLabel{
    if(_percentageLabel==nil)
    {
        _percentageLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _percentageLabel.text=@"0%";
        _percentageLabel.textColor=[UIColor greenColor];
        _percentageLabel.font=[UIFont systemFontOfSize:12.0f];
        _percentageLabel.textAlignment=NSTextAlignmentCenter;
        [self bringSubviewToFront:_percentageLabel];
    }
    return _percentageLabel;
}

-(void)setProgress:(float)progress{
    _progress=progress;
    _percentageLabel.text=[NSString stringWithFormat:@"%.f%%",_progress*100];
    
    //增加动画.strokeEnd:行程结束
    CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.3;
    pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fromValue=[NSNumber numberWithFloat:mainShapeLayer.strokeEnd];
    pathAnimation.toValue=[NSNumber numberWithFloat:_progress];
    pathAnimation.autoreverses=NO;
        //pathAnimation.repeatCount = INFINITY;
    [mainShapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    mainShapeLayer.strokeEnd=_progress;
}
@end
