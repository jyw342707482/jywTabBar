//
//  JYW_Snowflake.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/19.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_Snowflake.h"

@implementation JYW_Snowflake

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        self.backgroundColor=[UIColor blackColor];
        //[self addAnimation];
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
    //设置发射位置
    emitterLayer.emitterPosition=CGPointMake( self.frame.size.width/2,-10);
    emitterLayer.emitterSize=CGSizeMake(self.frame.size.width, 0);
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
    emitterLayer.emitterMode= kCAEmitterLayerSurface;
    /*
    发射源的形状
    kCAEmitterLayerCircle
    kCAEmitterLayerCuboid
    kCAEmitterLayerLine
    kCAEmitterLayerPoint
    kCAEmitterLayerSphere
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
    //emitterLayer.renderMode= kCAEmitterLayerAdditive;
    // 发射方向
    emitterLayer.velocity= 1;
    // 随机产生粒子，
    //emitterLayer.seed=(arc4random() % 100) + 1;
    //图层阴影的不透明度
    emitterLayer.shadowOpacity = 1.0;
    //用于渲染图层阴影的模糊半径（以磅为单位）。 可动画的。
    emitterLayer.shadowRadius  = 0.5;
    //图层阴影的偏移量
    emitterLayer.shadowOffset  = CGSizeMake(0.0, 0.0);
    
    // 粒子边缘的颜色
    emitterLayer.shadowColor  = [[UIColor whiteColor] CGColor];
    
    emitterLayer.emitterCells=@[
        [self addCAEmitterCellWithScale:0.1 BirthRate:15],
        //[self addCAEmitterCellWithScale:0.08 BirthRate:4],
        //[self addCAEmitterCellWithScale:0.06 BirthRate:5],
        //[self addCAEmitterCellWithScale:0.04 BirthRate:10],
        //[self addCAEmitterCellWithScale:0.02 BirthRate:15],
    ];
    [self.layer addSublayer:emitterLayer];
    /*
    // 形成遮罩
    UIImage *image= [UIImage imageNamed:@"alpha"];
    CALayer *layer= [CALayer layer];
    layer.frame = (CGRect){CGPointZero, self.bounds.size};
    layer.contents= (__bridge id)(image.CGImage);
    layer.position= self.center;
    emitterLayer.mask= layer;
     */
}
-(CAEmitterCell *)addCAEmitterCellWithScale:(float)scale BirthRate:(float)birthRate{
    CAEmitterCell *eCell=[CAEmitterCell emitterCell];
    //速率
    eCell.birthRate = birthRate;
    //生命周期
    eCell.lifetime = 100;
    //速度
    eCell.velocity = 10;
    //速度范围
    eCell.velocityRange=50;
    //缩放比例
    eCell.scale = scale;
    eCell.scaleRange=0.02;
    //Y轴加速度分量
    eCell.yAcceleration=2;
    //X轴加速度分量
    //cell.xAcceleration=75;
    //发射角度
    eCell.emissionRange =M_PI*0.5;//M_PI_4;//-M_PI*2;
    //eCell.emissionLongitude=M_PI_2;
    //是个CGImageRef的对象,既粒子要展现的图片
    //CFBridgingRelease将非Objective-C指针移动到Objective-C，还将所有权转移到ARC。
    eCell.contents = CFBridgingRelease([[UIImage imageNamed:@"snow"] CGImage]);
    //粒子颜色
    eCell.color=[UIColor whiteColor].CGColor;
    // 一个粒子的颜色green 能改变的范围
    eCell.greenRange=0.2;
    // 一个粒子的颜色red 能改变的范围
    eCell.redRange= 0.2;
    // 一个粒子的颜色blue 能改变的范围
    eCell.blueRange= 0.2;
    // 子旋转角度范围
    eCell.spinRange= M_PI;
    //alphaRange透明度
    eCell.alphaRange=0.8;
    
    return eCell;
}
@end
