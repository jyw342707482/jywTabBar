//
//  NSArray+JYW_Crash.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/20.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//处理数组越界问题
//转载：https://blog.csdn.net/weixin_38735568/article/details/95939608
@interface NSArray (JYW_Crash)
-(void)method_exchangeImplementations;
@end

NS_ASSUME_NONNULL_END
