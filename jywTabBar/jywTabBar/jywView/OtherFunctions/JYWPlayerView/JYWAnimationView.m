//
//  JYWAnimationView.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/13.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYWAnimationView.h"

@implementation JYWAnimationViewConfig

+ (instancetype)defaultConfig {
    JYWAnimationViewConfig *configure = [[JYWAnimationViewConfig alloc] init];
    configure.startAngle = - M_PI_2;
    configure.endAngle = M_PI + M_PI_2;
    configure.number = 5;
    configure.intervalDuration = 0.12;
    configure.duration = 2;
    configure.diameter = 8;
    configure.backgroundColor = [UIColor redColor];
    return configure;
}

@end

@interface JYWAnimationView ()

///默认配置
@property (nonatomic, strong) JYWAnimationViewConfig *defaultConfig;
///是否开始动画
@property (nonatomic, assign) BOOL isStart;
///是否暂停
@property (nonatomic, assign) BOOL isPause;
///layer数组
@property (nonatomic, strong) NSMutableArray<CALayer *> *layerArray;

@end
@implementation JYWAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layerArray = [NSMutableArray array];
    }
    return self;
}
- (void)animation {
    CGFloat origin_x = self.frame.size.width * 0.5;
    CGFloat origin_y = self.frame.size.height * 0.5;
    for (NSInteger i = 0; i < self.defaultConfig.number; i++) {
        CGFloat scale = (CGFloat)(self.defaultConfig.number + 1 - i) / (CGFloat)(self.defaultConfig.number + 1);
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = self.defaultConfig.backgroundColor.CGColor;
        layer.frame = CGRectMake(-500, -500, scale * self.defaultConfig.diameter, scale * self.defaultConfig.diameter);
        layer.cornerRadius = scale * self.defaultConfig.diameter * 0.5;
        //创建运动的轨迹动画
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        /*
         calculationMode
         kCAAnimationLinear//关键帧值之间的简单线性计算。
         kCAAnimationDiscrete//依次使用每个关键帧值，不计算任何插值。
         kCAAnimationPaced//插值线性关键帧值以在整个动画过程中产生均匀的速度。
         kCAAnimationCubic关键帧值之间的平滑样条线计算。
         kCAAnimationCubicPaced三次关键帧值被插值以在整个动画中产生均匀的速度。
         */
        pathAnimation.calculationMode = kCAAnimationPaced;
        /*
         fillMode,确定接收者的演示文稿在其有效期限完成后是否被冻结或删除。
         kCAFillModeRemoved//动画完成后，接收者将从演示文稿中删除。
         kCAFillModeForwards//动画完成后，接收器在其最终状态下仍然可见。
         kCAFillModeBackwards//动画完成时，接收器会将值从零钳位到零。
         kCAFillModeBoth//接收器将值固定在对象时间空间的两端
         kCAFillModeFrozen//在OS X v10.5发行之前不建议使用该模式。
         */
        pathAnimation.fillMode = kCAFillModeForwards;
        //确定在完成后是否从目标层的动画中删除动画。
        pathAnimation.removedOnCompletion = NO;
        //动画持续时间
        pathAnimation.duration = self.defaultConfig.duration - self.defaultConfig.intervalDuration * self.defaultConfig.number;
        //动画开始时间
        pathAnimation.beginTime = i * self.defaultConfig.intervalDuration;
        //可选的计时功能，用于定义动画的节奏。
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(origin_x, origin_y) radius:(self.frame.size.width - self.defaultConfig.diameter) * 0.5 startAngle:self.defaultConfig.startAngle endAngle:self.defaultConfig.endAngle  clockwise:YES].CGPath;
        //组动画
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[pathAnimation];
        group.duration = self.defaultConfig.duration;
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
        group.repeatCount = INTMAX_MAX;
        //设置运转的动画
        [layer addAnimation:group forKey:@"moveTheCircleOne"];
        [self.layerArray addObject:layer];
    }
}
//MARK:JmoVxia---更新配置
- (void)updateWithConfigure:(void(^)(JYWAnimationViewConfig *configure))configBlock {
    if (configBlock) {
        configBlock(self.defaultConfig);
    }
    CGFloat intervalDuration = (CGFloat)(self.defaultConfig.duration / 2.0 / (CGFloat)self.defaultConfig.number);
    self.defaultConfig.intervalDuration = MIN(self.defaultConfig.intervalDuration, intervalDuration);
    if (self.isStart) {
        [self stopAnimation];
        [self startAnimation];
    }
}
//MARK:JmoVxia---开始动画
- (void)startAnimation {
    [self animation];
    for (CALayer *layer in self.layerArray) {
        [self.layer addSublayer:layer];
    }
    self.isStart = YES;
}
//MARK:JmoVxia---结束动画
- (void)stopAnimation {
    for (CALayer *layer in self.layerArray) {
        [layer removeFromSuperlayer];
    }
    [self.layerArray removeAllObjects];
    self.isStart = NO;
}
//MARK:JmoVxia---暂停动画
- (void)pauseAnimation {
    if (self.isPause) {
        return;
    }
    self.isPause = YES;
    CFTimeInterval time = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0;
    self.layer.timeOffset = time;
}
//MARK:JmoVxia---恢复动画
- (void)resumeAnimation {
    if (!self.isPause) {
        return;
    }
    self.isPause = NO;
    CFTimeInterval pausedTime = self.layer.timeOffset;
    self.layer.speed = 1;
    self.layer.timeOffset = 0;
    self.layer.beginTime = 0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}
//MARK:JmoVxia---默认配置
- (JYWAnimationViewConfig *) defaultConfig {
    if (_defaultConfig == nil) {
        _defaultConfig = [JYWAnimationViewConfig defaultConfig];
    }
    return _defaultConfig;
}

@end
