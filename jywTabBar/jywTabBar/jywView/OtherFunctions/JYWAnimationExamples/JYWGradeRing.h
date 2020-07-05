//
//  JYWGradeRing.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/20.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYWGradeRing.h"
NS_ASSUME_NONNULL_BEGIN

@interface JYWGradeRing : UIView
{
    CAShapeLayer *mainShapeLayer;
}
@property (nonatomic)NSArray *colorArray;
@property (nonatomic)NSArray *locationArray;
@property (nonatomic,strong)UILabel *percentageLabel;//显示百分数
@property (nonatomic,assign)float progress;//进度0-1

-(instancetype)initWithFrame:(CGRect)frame colorArray:(NSArray*)colorArray locationArray:(NSArray*)locationArray;
@end

NS_ASSUME_NONNULL_END
