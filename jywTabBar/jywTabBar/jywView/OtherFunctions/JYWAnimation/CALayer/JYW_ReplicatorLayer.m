//
//  JYW_ScrollLayer.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/8.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_ReplicatorLayer.h"

@implementation JYW_ReplicatorLayer

- (void)drawRect:(CGRect)rect{
    self.backgroundColor=[UIColor whiteColor];
    CAReplicatorLayer *rLayer=[CAReplicatorLayer layer];
    rLayer.frame=CGRectMake(0, 0, 200, 100);
    rLayer.instanceCount=6;
    rLayer.instanceDelay=0.1;
    
    rLayer.instanceColor=[UIColor greenColor].CGColor;
    rLayer.instanceTransform=CATransform3DMakeTranslation(30,0,0);
    rLayer.instanceGreenOffset=-0.1;
    //rLayer.instanceBlueOffset=-1/6;
    //rLayer.instanceRedOffset=-1/6;
    
    
    CALayer *layer = [CALayer layer];
    // 2.1.设置layer对象的位置
    layer.position = CGPointMake(20, 100);
    // 2.2.设置layer对象的锚点
    layer.anchorPoint = CGPointMake(0, 1);
    // 2.3.设置layer对象的位置大小
    layer.frame = CGRectMake(5, 0, 20, 100);
    // 2.5.设置layer对象的颜色
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    [rLayer addSublayer:layer];
    [self.layer addSublayer:rLayer];
    
    CABasicAnimation *bAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    //bAnimation.fromValue=@(0);
    bAnimation.toValue=@(0.1);
    bAnimation.duration=0.6;
    bAnimation.repeatCount=INT_MAX;
    //设置动画反转
    bAnimation.autoreverses = YES;
    [layer addAnimation:bAnimation forKey:@"transform.scale.y"];
}

/*
 Setting Instance Display Properties 设置实例显示属性
 instanceCount
 要创建的副本数，包括源图层。
 instanceDelay
 指定复制副本之间的延迟（以秒为单位）。可动画的。
 instanceTransform
 转换矩阵应用于前一个实例以生成当前实例。可动画的。
 
 Modifying Instance Layer Geometry 修改实例层几何
 preservesDepth 深度
 定义此层是否将其子层展平到其平面中。
 
 Accessing Instance Color Values 访问实例颜色值
 instanceColor
 定义用于与源对象相乘的颜色。可动画的。
 instanceRedOffset
 定义为每个复制实例添加到颜色的红色部分的偏移量。可动画的。
 instanceGreenOffset
 定义为每个复制实例添加到颜色的绿色部分的偏移量。可动画的。
 instanceBlueOffset
 定义为每个复制实例添加到颜色的蓝色分量的偏移量。可动画的。
 instanceAlphaOffset
 定义为每个复制实例添加到颜色的alpha分量的偏移量。可动画的。
 */
@end
