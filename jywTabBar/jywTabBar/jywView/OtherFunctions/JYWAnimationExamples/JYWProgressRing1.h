//
//  JYWProgressRing1.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/18.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//加载等待动画，（背景、透明度、位置）
@interface JYWProgressRing1 : UIView
{
    //控件宽度
    CGFloat viewWidth;
    //环行进度条的圆环宽度
    CGFloat progressWidth;
    //圆环进度条半径
    CGFloat progressRadius;
    
    CAShapeLayer *arcLayer;
    UILabel *percentageLabel;
    NSTimer *progressTimer;
    
    NSMutableArray *layerArray;
    
}

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic,assign)CGFloat i;

-(void)play;
-(void)stop;
@end

NS_ASSUME_NONNULL_END
