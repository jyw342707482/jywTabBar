//
//  JYW_EmitterLayer.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/8.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_EmitterLayer.h"

@implementation JYW_EmitterLayer

- (void)drawRect:(CGRect)rect{
    self.backgroundColor=[UIColor blackColor];
    CAEmitterLayer *eLayer=[CAEmitterLayer layer];
    //eLayer.frame=CGRectMake(0, 0, 400, 1);
    eLayer.emitterPosition=CGPointMake(100, 0);
    //eLayer.emitterMode=kCAEmitterLayerOutline;//
    eLayer.emitterShape=kCAEmitterLayerLine;
    eLayer.emitterSize=CGSizeMake(200, 10);
    
    CAEmitterCell *cell1=[CAEmitterCell emitterCell];
    cell1.contents=(id)[UIImage imageNamed:@"FFRing"].CGImage;
    cell1.birthRate=10;//每秒产生粒子数量
    cell1.lifetime=1;//生命周期
    cell1.lifetimeRange=2;//生命周期，浮动范围
    cell1.velocity=100;//粒子速率
    cell1.velocityRange=60;//粒子速率，浮动范围
    cell1.scale=0.2;//粒子缩放比例；
    cell1.scaleRange=0.2;//粒子缩放比例，浮动范围
    cell1.emissionRange=M_PI*0.11;
    //cell1.yAcceleration=-300;//y轴加速
    cell1.emissionLongitude=-M_PI;
    
    
    
    //cell1.color=[UIColor redColor].CGColor;
    cell1.redRange=1;
    cell1.greenRange=1;
    cell1.blueRange=1;
    /*
    cell1.alphaRange=0.5;
    cell1.redSpeed=5;
    cell1.greenSpeed=10;
    cell1.blueSpeed=15;
    cell1.alphaSpeed=20;*/
    /*
    cell1.scale=2;
    cell1.scaleRange=2;
    cell1.contentsScale=0.1;
    
    cell1.spin=M_PI;
    cell1.spinRange=2;
    cell1.emissionLatitude=1;
    cell1.emissionLongitude=1;
    cell1.emissionRange=1;
    
    cell1.lifetime=3;
    cell1.lifetimeRange=2;
    cell1.birthRate=3;
    cell1.scaleSpeed=200;
    cell1.velocity=60;
    cell1.velocityRange=60;
    //xAcceleration
    cell1.yAcceleration=100;
    //应用于单元的加速度矢量的y分量。
     */
    eLayer.emitterCells=@[cell1];
    [self.layer addSublayer:eLayer];
}
/*
 Specifying Particle Emitter Cells 指定粒子发射器单元
 
 emitterCells 发射器细胞
 阵列发射极单元附着到该层。
 
 Emitter Geometry 发射极几何
 
 renderMode
 定义如何将粒子像元渲染到图层中。
 emitterPosition 发射器位置
 粒子发射器中心的位置。可动画的。
 emitterShape 发射器形状
 指定发射器形状。
 emitterZPosition 发射器Z位置
 指定沿z轴的粒子发射器形状的中心。可动画的。
 emitterDepth 发射器深度
 确定发射器形状的深度。
 emitterSize 发射器尺寸
 确定粒子发射器形状的大小。可动画的。
 
 
 Emitter Cell Attribute Multipliers 发射器单元属性乘数
 
 发射器单元属性乘数仅影响新创建的粒子，而现有粒子保持不变。

 例如，如果您的发射器的比例乘数设置为1（默认值），并且在发射了多个粒子之后，您的代码将其设置为2，则屏幕上已经存在的粒子不受影响，并保持相同的大小。只有新生成的粒子会受到此更改的影响，并且出现的大小是其同级的两倍。

 scale 规模
 定义应用于单元定义的粒子比例的乘数。
 seed 种子
 指定用于初始化随机数生成器的种子。
 spin 旋转
 定义应用于单元定义的粒子旋转的乘数。可动画的。
 velocity 速度
 定义应用于单元定义的粒子速度的乘数。可动画的。
 birthRate 出生率
 定义一个应用于单元格定义的出生率的乘数。可动画的
 emitterMode 发射器模式
 指定发射器模式。
 lifetime 一生
 定义在创建粒子时应用于单元格定义的寿命范围的乘数。可动画的。
 preservesDepth 深度
 定义层是否将粒子展平到其平面中。
 */


/*
 Creating and Initializing an Emitter Cell 创建和初始化发射极单元
 +emitterCell
 创建并返回CAEmitterCell的实例。
 Providing Emitter Cell Contents提供发射器单元内容
 contents 内容
 提供图层内容的对象。可动画的。
 contentsRect
 一个矩形（在单位坐标空间中），指定接收者应绘制的内容部分。可动画的。
 emitterCells 发射器细胞
 包含此单元格子单元格的可选数组。
 
 
 
 Setting Emitter Cell Visual Attroutes 设置发射器单元的视觉属性
 enabled 已启用
 一个布尔值，指示是否渲染此发射器的单元。
 color 颜色
 每个发射对象的颜色。可动画的。
 redRange
 单元的红色分量可以变化的量。可动画的。
 greenRange 绿色范围
 单元的绿色分量可以变化的量。可动画的。
 blueRange
 单元的蓝色分量可以变化的量。可动画的。
 alphaRange
 单元格的alpha分量可以变化的量。可动画的。
 redSpeed 红色速度
 红色分量在电池的整个生命周期中变化的速度（以秒为单位）。可动画的。
 greenSpeed 绿色速度
 绿色分量在电池的整个生命周期中变化的速度（以秒为单位）。可动画的。
 blueSpeed
 蓝色分量在电池的整个生命周期中变化的速度（以秒为单位）。可动画的。
 alphaSpeed
 Alpha分量在电池寿命中变化的速度（以秒为单位）。可动画的。
 magnificationFilter放大滤镜
 增加内容大小时使用的过滤器。
 minificationFilter
 减小内容大小时使用的过滤器。
 minificationFilterBias
 缩小过滤器用来确定详细程度的偏差因子。
 scale 规模
 指定应用于单元的比例因子。可动画的。
 scaleRange
 指定比例值可以变化的范围。可动画的。
 contentsScale
 单元格内容的比例因子。
 name 名称
 单元格的名称。
 style 样式
 可选字典，其中包含接收者未明确定义的其他样式值。
 
 
 Setting Emitter Cell Motion Attributes 设置发射器单元运动属性
 spin 旋转
 应用于弧度的旋转速度（以弧度/秒为单位）。可动画的。
 spinRange
 细胞旋转的量可以在其整个生命周期内变化。可动画的。
 emissionLatitude发射纬度
 发射角的纬度方向。可动画的。
 emissionLongitude 发射经度
 发射角的纵向方向。可动画的。
 emissionRange 发射范围
 以弧度为单位的角度，定义了围绕发射角度的圆锥。可动画的。
 
 
 Setting Emitter Cell Temporal Attributes 设置发射器单元时间属性
 lifetime
 电池寿命，以秒为单位。可动画的。
 lifeRange
 电池寿命可以变化的平均值。可动画的。
 birthRate
 每秒创建的发射对象的数量。可动画的。
 scaleSpeed
 刻度在整个单元生命周期内变化的速度。可动画的。
 velocity
 细胞的初始速度。可动画的。
 velocityRange
 细胞速度可以变化的量。可动画的。
 xAcceleration
 应用于单元的加速度矢量的x分量。
 yAcceleration
 应用于单元的加速度矢量的y分量。
 zAcceleration
 应用于单元的加速度矢量的z分量。
 
 
 Using Key-Value Coding Extensions 使用键值编码扩展
 + defaultValueForKey：
 返回具有指定键的属性的默认值。
 -shouldArchiveValueForKey：
 返回一个布尔值，该布尔值指示是否应存储给定键的值。
 */
@end
