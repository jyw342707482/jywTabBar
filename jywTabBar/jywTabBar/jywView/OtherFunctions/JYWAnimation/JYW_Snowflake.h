//
//  JYW_Snowflake.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/19.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//雪花动画
@interface JYW_Snowflake : UIView
{
    CAEmitterLayer *emitterLayer;
}
@property (nonatomic,assign)int birthRate;//雪花数量
-(void)play;//播放动画
-(void)stop;//停止动画
@end

NS_ASSUME_NONNULL_END
