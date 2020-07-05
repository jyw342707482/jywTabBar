//
//  JYWGrade.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/20.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYWGrade.h"

@implementation JYWGrade

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
     
    /*
    //图层工程图的渐变样式。
    kCAGradientLayerAxial
    轴向梯度（也称为线性梯度）沿轴线在两个定义的端点之间变化。 垂直于轴的线上的所有点都具有相同的颜色值。
    kCAGradientLayerConic
    kCAGradientLayerRadial
     */
    
    gradientLayer.type=kCAGradientLayerAxial;
    [layer addSublayer:gradientLayer];
    
    
    shapeLayer=[CAShapeLayer layer];
    shapeLayer.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    shapeLayer.lineWidth=self.frame.size.height;
    shapeLayer.strokeEnd=self.progress;
    shapeLayer.lineCap=kCALineCapRound;
    shapeLayer.fillColor=[UIColor clearColor].CGColor;
    shapeLayer.strokeColor=[UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0].CGColor;
    UIBezierPath *bezierPath=[UIBezierPath bezierPath];
    //[bezierPath moveToPoint:CGPointMake(0,self.frame.size.height/2)];
    //[bezierPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height/2)];
    [bezierPath moveToPoint:CGPointMake(0,self.frame.size.height/2)];
    [bezierPath addLineToPoint:CGPointMake(self.frame.size.width,self.frame.size.height/2)];
    //绘制
    //[bezierPath stroke];
    shapeLayer.path=bezierPath.CGPath;
    [self.layer addSublayer:shapeLayer];
    
    layer.mask=shapeLayer;
    [self.layer addSublayer:layer];
    /*
     //增加动画.strokeEnd:行程结束
    CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1;
    pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fromValue=[NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue=[NSNumber numberWithFloat:shapeLayer.strokeEnd];
    pathAnimation.autoreverses=NO;
        //pathAnimation.repeatCount = INFINITY;
    [shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    //shapeLayer.path=bezierPath.CGPath;
     */
}
-(void)addAnimationWithColorArray:(NSArray*)colorArray locationArray:(NSArray*)locationArray{
    CAGradientLayer *gradientLayer=[CAGradientLayer layer];
    gradientLayer.frame=(CGRect){CGPointMake(0, 0), self.frame.size};
    //gradientLayer.position = self.center;
    [self.layer addSublayer: gradientLayer];
    //渐变颜色组，一组CGColorRef对象
    gradientLayer.colors=colorArray;
    //NSNumber对象的可选数组，用于定义每个渐变色标的位置。 可以动画。
    gradientLayer.locations=locationArray;
    //在图层的坐标空间中绘制时渐变的终点。 可以动画。
    gradientLayer.endPoint=CGPointMake(1, 0);
    //在图层的坐标空间中绘制时渐变的起点。 可以动画。
    gradientLayer.startPoint=CGPointMake(0, 0);
    /*
    //图层工程图的渐变样式。
    kCAGradientLayerAxial
    轴向梯度（也称为线性梯度）沿轴线在两个定义的端点之间变化。 垂直于轴的线上的所有点都具有相同的颜色值。
    kCAGradientLayerConic
    kCAGradientLayerRadial
     */
    gradientLayer.type=kCAGradientLayerAxial;
}

#pragma mark -懒加载
-(UILabel *)percentageLabel{
    if(_percentageLabel==nil)
    {
        _percentageLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 80, 20)];
        _percentageLabel.text=@"0%";
        _percentageLabel.textColor=[UIColor greenColor];
        _percentageLabel.font=[UIFont systemFontOfSize:12.0f];
        [self bringSubviewToFront:_percentageLabel];
    }
    return _percentageLabel;
}
-(void)setProgress:(float)progress{
    _progress=progress;
    _percentageLabel.text=[NSString stringWithFormat:@"%.2f%%",_progress*100];
    
    //增加动画.strokeEnd:行程结束
    CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.3;
    pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fromValue=[NSNumber numberWithFloat:shapeLayer.strokeEnd];
    pathAnimation.toValue=[NSNumber numberWithFloat:_progress];
    pathAnimation.autoreverses=NO;
        //pathAnimation.repeatCount = INFINITY;
    [shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    shapeLayer.strokeEnd=_progress;
    //[self bringSubviewToFront:_percentageLabel];
}
@end
