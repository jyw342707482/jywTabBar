//
//  JYWFireworks.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/19.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYWFireworks.h"

@implementation JYWFireworks

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        self.backgroundColor=[UIColor blackColor];
        
    }
    return self;
}
-(void)play{
    [self addAnimation];
}
-(void)stop{
    [emitterLayer removeFromSuperlayer];
}
-(void)addAnimation{
    emitterLayer=[[CAEmitterLayer alloc] init];
    //发射器的位置
    emitterLayer.emitterPosition=CGPointMake(self.frame.size.width/2, self.frame.size.height);
    
    // 发射源粒子尺寸大小
    emitterLayer.emitterSize= CGSizeMake(self.frame.size.width, 10);
    /*
    // 发射源模式
    kCAEmitterLayerOutline
    从粒子发射器的轮廓发射粒子。
    kCAEmitterLayerPoints
    从粒子发射器上的点发射粒子。
    kCAEmitterLayerSurface
    从粒子发射器的表面发射粒子。
    kCAEmitterLayerVolume
    从粒子发射器内的a位置发射粒子。
     */
    emitterLayer.emitterMode= kCAEmitterLayerOutline;
    /*
     发射源的形状
     kCAEmitterLayerCircle
     粒子从以（eritterPosition.x，发射器Position.y，发射器ZPosition）为半径的圆形发射器发射，该半径为发射器尺寸。
     kCAEmitterLayerCuboid
     从长方体（3D矩形）以相反的角发射粒子：[emitterPosition.x-发射器尺寸。宽度/ 2，发射器位置.y-发射器尺寸。高度/ 2，发射器Z位置-发射器深度/ 2]，[发射器位置.x +发射器尺寸。宽度/ 2，发射器Position.y +发射器尺寸。高度/ 2，发射器ZPosition + emitterDepth / 2]。
     kCAEmitterLayerLine
     粒子沿着从（emitterPosition.x-generatorSize.width / 2，发射器位置.y，发射器ZPosition）到（emitterPosition.x +发射器尺寸.width / 2，发射器位置.y，发射器ZPosition）的线发射。
     kCAEmitterLayerPoint
     粒子从（emitterPosition.x，itterPosition.y，itterZPosition）的单个点发射
     kCAEmitterLayerRectangle
     粒子从具有相对角的矩形发射[emitterPosition.x-generatorSize.width / 2，emitterPosition.y-发射器Size.height / 2，emitterZPosition]，[emitterPosition.x +发射器Size.width / 2，emitterPosition.y +发射器大小。高度/ 2，发射器Z位置]。
     kCAEmitterLayerSphere
     粒子从以（eritterPosition.x，itterPosition.y，emitterZPosition）为半径的球体发射，该球体的半径为generatorSize.width。
     */
    emitterLayer.emitterShape= kCAEmitterLayerLine;
    /*
     渲染模式
     kCAEmitterLayerAdditive
     使用源加法合成渲染粒子。
     kCAEmitterLayerBackToFront
     粒子从后到前渲染，按z位置排序。 此模式使用源覆盖合成。
     kCAEmitterLayerOldestFirst
     首先使粒子最旧。 此模式使用源覆盖合成。
     kCAEmitterLayerOldestLast
     最后使粒子最旧。 此模式使用源覆盖合成。
     kCAEmitterLayerUnordered
     粒子无序渲染。 此模式使用源覆盖合成。
     */
    emitterLayer.renderMode= kCAEmitterLayerAdditive;
    // 发射方向
    emitterLayer.velocity= 1;
    // 随机产生粒子，
    emitterLayer.seed=(arc4random() % 100) + 1;
    //指定沿z轴的粒子发射器形状的中心。 可动画的。
    //emitterLayer.zPosition=0.3;
    //确定发射器形状的深度。
    //emitterLayer.emitterDepth=3;
    
    CAEmitterCell *cell=[CAEmitterCell emitterCell];
    //速率
    cell.birthRate = 5.0;
    //生命周期
    cell.lifetime = 2;
    //速度
    cell.velocity = 200;
    //缩放比例
    cell.scale = 0.2;
    //cell.scaleRange=0.2;
    cell.velocity=300;
    //范围
    cell.velocityRange=50;
    //Y轴加速度分量
    cell.yAcceleration=75;
    //X轴加速度分量
    //cell.xAcceleration=75;
    //发射角度
    cell.emissionRange = 0.11 * M_PI;
    //cell.emissionLongitude=-M_PI_2;
    //是个CGImageRef的对象,既粒子要展现的图片
    //CFBridgingRelease将非Objective-C指针移动到Objective-C，还将所有权转移到ARC。
    cell.contents = (id)[[UIImage imageNamed:@"FFRing"] CGImage];
    //粒子颜色
    cell.color=[UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0].CGColor;
    // 一个粒子的颜色green 能改变的范围
    cell.greenRange=1.0;
    // 一个粒子的颜色red 能改变的范围
    cell.redRange= 1.0;
    // 一个粒子的颜色blue 能改变的范围
    cell.blueRange= 1.0;
    // 子旋转角度范围
    cell.spinRange= M_PI;
    //alphaRange透明度
    cell.alphaRange=0.8;
    /*
    cell.magnificationFilter=kCAFilterLinear;
    cell.minificationFilter=kCAFilterLinear;
    cell.minificationFilterBias=kCAFilterLinear;
    */
    
    // 爆炸
    CAEmitterCell *burst= [CAEmitterCell emitterCell];
    // 粒子产生系数
    burst.birthRate= 1.0;
    // 速度
    burst.velocity= 0;
    // 缩放比例
    burst.scale= 2.5;
    // shifting粒子red在生命周期内的改变速度
    burst.redSpeed= -1.5;
    // shifting粒子blue在生命周期内的改变速度
    burst.blueSpeed = +1.5;
    // shifting粒子green在生命周期内的改变速度
    burst.greenSpeed = +1.0;
    //生命周期
    burst.lifetime= 0.35;
    
    
    // 火花 and finally, the sparks
    CAEmitterCell *spark= [CAEmitterCell emitterCell];
    //粒子产生系数，默认为1.0
    spark.birthRate= 400;
    //速度
    spark.velocity= 125;
    // 360 deg//周围发射角度
    spark.emissionRange= 2 * M_PI;
    // gravity//y方向上的加速度分量
    spark.yAcceleration= 75;
    //粒子生命周期
    spark.lifetime= 3;
    //是个CGImageRef的对象,既粒子要展现的图片
    spark.contents=(id)[[UIImage imageNamed:@"FFTspark"] CGImage];
    //(id)[[UIImage imageNamed:@"FFTspark"] CGImage];
    //缩放比例速度
    spark.scaleSpeed= -0.2;
    //粒子green在生命周期内的改变速度
    spark.greenSpeed = -0.1;
    //粒子red在生命周期内的改变速度
    spark.redSpeed= 0.4;
    //粒子blue在生命周期内的改变速度
    spark.blueSpeed= -0.1;
    //粒子透明度在生命周期内的改变速度
    spark.alphaSpeed= -0.25;
    //子旋转角度
    spark.spin= 2* M_PI;
    //子旋转角度范围
    spark.spinRange= 2* M_PI;
    
        
    emitterLayer.emitterCells=@[cell];
    cell.emitterCells = @[burst];
    burst.emitterCells = @[spark];
    [self.layer addSublayer:emitterLayer];
}


@end
