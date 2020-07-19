//
//  JYW_TestViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/26.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_TestViewController.h"

@interface JYW_TestViewController ()

@end

@implementation JYW_TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self caAnimation];
}
/*
-(void)caAnimation1{
    // 黑色的背景框
    //在其坐标空间中绘制三次贝塞尔曲线样条的图层。
    CAShapeLayer *bordLayer = [CAShapeLayer layer];
    //创建并返回一个新的用圆角矩形路径初始化的UIBezierPath对象。
    UIBezierPath *bordPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 148, 116) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(6, 6)];
    bordLayer.path = bordPath.CGPath;
    self.view.layer.mask=bordLayer;
    //self.alertView.layer.mask = bordLayer;
    
    // 进度的底色
    UIBezierPath *bgRoundPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(20, 20) radius:20 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    self.bgProgressLayer.path = bgRoundPath.CGPath;
    [self.bgProgressView.layer addSublayer:self.bgProgressLayer];
    
    // 进度的颜色
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(20, 20) radius:20 startAngle:-M_PI_2 endAngle:-M_PI_2 + M_PI *2 clockwise:YES];
    self.progressLayer.path = roundPath.CGPath;
    [self.progressView.layer addSublayer:self.progressLayer];
    self.progressLayer.strokeStart = 0;
    self.progressLayer.strokeEnd = 0;
}
*/
-(void)caAnimation{
    for(int i=0;i<6;i++)
    {
        CALayer *layer=[CALayer layer];
        layer.frame=CGRectMake(0, 0, 10, 10);
        layer.backgroundColor=[UIColor redColor].CGColor;
        layer.cornerRadius=5.0;
        /*
        //设置投影
        layer.shadowColor = [UIColor redColor].CGColor;//shadowColor阴影颜色
        layer.shadowOffset = CGSizeMake(0,5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        layer.shadowOpacity = 0.5;//阴影透明度，默认0
        layer.shadowRadius = 5;//阴影半径，默认3
        */
        
        CAKeyframeAnimation *frameAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
        frameAnimation.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30, 30) radius:15 startAngle:0 endAngle:80  clockwise:YES].CGPath;
        //动画持续时间
        frameAnimation.duration=30;
        frameAnimation.beginTime=i*0.4;
        
        frameAnimation.fillMode = kCAFillModeForwards;
        //确定在完成后是否从目标层的动画中删除动画。
        frameAnimation.removedOnCompletion=NO;
        frameAnimation.calculationMode = kCAAnimationPaced;
        frameAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        
        //动画组
        //组动画
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[frameAnimation];
        group.duration = 30;
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
        //动画重复次数
        group.repeatCount = 10;
        //[layer addAnimation:frameAnimation forKey:@"moveTheCircleOne"];
        [layer addAnimation:group forKey:@"moveTheCircleOne"];
        [self.view.layer addSublayer:layer];
    }
    /*
    CALayer *layer=[CALayer layer];
    layer.frame=CGRectMake(0, 0, 10, 10);
    layer.backgroundColor=[UIColor redColor].CGColor;
    layer.cornerRadius=5.0;
    
    
    CAKeyframeAnimation *frameAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // keyframe 0: (0, 310), keyframe 1: (0.25, 60), keyframe 2: (0.5, 120), keyframe 3: (0.75, 60)
    //frameAnimation.keyTimes = @[@0, @0.3, @0.7];
    //frameAnimation.values = @[[NSValue valueWithCGRect:CGRectMake(10, 10, 10, 10)],
    //[NSValue valueWithCGRect:CGRectMake(20, 20, 10, 10)],
    //[NSValue valueWithCGRect:CGRectMake(30, 30, 10, 10)]];
    frameAnimation.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30, 30) radius:15 startAngle:0 endAngle:80  clockwise:YES].CGPath;
    //动画持续时间
    frameAnimation.duration=30;
    frameAnimation.beginTime=CACurrentMediaTime();*/
    /*
     fillMode,确定接收者的演示文稿在其有效期限完成后是否被冻结或删除。
     kCAFillModeRemoved//动画完成后，接收者将从演示文稿中删除。
     kCAFillModeForwards//动画完成后，接收器在其最终状态下仍然可见。
     kCAFillModeBackwards//动画完成时，接收器会将值从零钳位到零。
     kCAFillModeBoth//接收器将值固定在对象时间空间的两端
     kCAFillModeFrozen//在OS X v10.5发行之前不建议使用该模式。
     */
    /*
    frameAnimation.fillMode = kCAFillModeForwards;
    //确定在完成后是否从目标层的动画中删除动画。
    frameAnimation.removedOnCompletion=NO;
    frameAnimation.calculationMode = kCAAnimationPaced;
    frameAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    //[layer addAnimation:frameAnimation forKey:nil];
    //[self.view.layer addSublayer:layer];
     */
    /*
    CABasicAnimation *rotationZAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationZAnimation.fromValue = @(0);
    rotationZAnimation.toValue = @(5);//@(M_PI*2);
    //HUGE_VAL:double类型无穷大，HUGE_VALF:float类型无穷大，HUGE_VALL:long double无穷大
    rotationZAnimation.repeatDuration = HUGE_VAL;
    //动画持续事件
    rotationZAnimation.duration = 1.0;
    rotationZAnimation.cumulative = YES;
    //CACurrentMediaTime:返回当前的绝对时间，以秒为单位。
    rotationZAnimation.beginTime = CACurrentMediaTime();
    [layer addAnimation:rotationZAnimation forKey:@"rotationZAnimation"];
    [self.view.layer addSublayer:layer];
    */
    
    /*
    NSArray *values = [self valueArrayWithWidth:100];
    CAKeyframeAnimation *boundsAnimation = [self bounsAnimationWithValues:values];
    [self.view.layer addAnimation:boundsAnimation forKey:nil];
     */
}

- (NSArray *)valueArrayWithWidth:(CGFloat)width {
    return @[[NSValue valueWithCGRect:CGRectMake(0, 0, width * 0.7, width * 0.7)],
             [NSValue valueWithCGRect:CGRectMake(0, 0, width, width)],
             [NSValue valueWithCGRect:CGRectMake(0, 0, width * 0.9, width * 0.9)]];
}
- (CAKeyframeAnimation *)bounsAnimationWithValues:(NSArray *)values {
    CAKeyframeAnimation *boundsAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation.duration = 0.6;
    boundsAnimation.beginTime = CACurrentMediaTime();
    boundsAnimation.values = values;
    boundsAnimation.keyTimes = @[@(0),@(0),@(0)];
    boundsAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    boundsAnimation.removedOnCompletion = NO;
    boundsAnimation.fillMode = kCAFillModeForwards;
    return boundsAnimation;
}
@end
