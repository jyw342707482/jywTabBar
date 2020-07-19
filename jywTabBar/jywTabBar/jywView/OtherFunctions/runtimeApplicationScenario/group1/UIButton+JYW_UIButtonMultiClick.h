//
//  UIButton+JYW_UIButtonMultiClick.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/19.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (JYW_UIButtonMultiClick)
@property (nonatomic, assign) NSTimeInterval jyw_acceptEventInterval; // 时间间隔
@property (nonatomic, assign) NSTimeInterval jyw_acceptEventTime;
-(void)method_exchangeImplementations;
@end

NS_ASSUME_NONNULL_END
