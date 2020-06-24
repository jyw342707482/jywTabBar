//
//  JYWFinish.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/18.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//完成动画
@interface JYWFinish : UIView
{
    CAShapeLayer *shape;
}
-(void)play;
-(void)stop;
@end

NS_ASSUME_NONNULL_END
