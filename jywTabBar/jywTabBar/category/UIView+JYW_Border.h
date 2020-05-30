//
//  UIView+JYW_Border.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/29.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JYW_Border)
//设置左侧边框
-(void)drawLeftBorderWithBorderWidth:(float)borderWidth borderColor:(UIColor *)borderColor;
//设置右侧边框
-(void)drawRightBorderWithBorderWidth:(float)borderWidth borderColor:(UIColor *)borderColor;
//设置上边框
-(void)drawTopBorderWithBorderWidth:(float)borderWidth borderColor:(UIColor *)borderColor;
//设置下边框
-(void)drawBottomBorderWithBorderWidth:(float)borderWidth borderColor:(UIColor *)borderColor;
@end

NS_ASSUME_NONNULL_END
