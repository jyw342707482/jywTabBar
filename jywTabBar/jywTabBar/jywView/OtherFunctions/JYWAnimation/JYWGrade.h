//
//  JYWGrade.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/20.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYWGrade : UIView
{
    CAShapeLayer *shapeLayer;
}
@property (nonatomic)NSArray *colorArray;
@property (nonatomic)NSArray *locationArray;
@property (nonatomic,strong)UILabel *percentageLabel;//显示百分数
@property (nonatomic,assign)float progress;//进度0-1

-(instancetype)initWithFrame:(CGRect)frame colorArray:(NSArray*)colorArray locationArray:(NSArray*)locationArray;
//-(void)addAnimationWithColorArray:(NSArray*)colorArray locationArray:(NSArray*)locationArray;
//-(void)addAnimation;
@end

NS_ASSUME_NONNULL_END
