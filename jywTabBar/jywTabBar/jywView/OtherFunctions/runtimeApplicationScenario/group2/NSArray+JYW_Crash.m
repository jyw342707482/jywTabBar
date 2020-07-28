//
//  NSArray+JYW_Crash.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/20.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "NSArray+JYW_Crash.h"
#import <objc/runtime.h>
@implementation NSArray (JYW_Crash)
//此方法只运行一次，就是在整个程序初始时调用一次。
+ (void)load{
    [super load];
    /*
    //替换不可变数组方法
    Method oldObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method newObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtSafeIndex:));
    method_exchangeImplementations(oldObjectAtIndex, newObjectAtIndex);
    
    //替换可变数组方法
    Method oldMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
    Method newMutableObjectAtIndex =  class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(mutableObjectAtSafeIndex:));
    method_exchangeImplementations(oldMutableObjectAtIndex, newMutableObjectAtIndex);*/
}
-(void)method_exchangeImplementations{
    //替换不可变数组方法
    Method oldObjectAtIndex = class_getInstanceMethod([self class], @selector(objectAtIndex:));
    Method newObjectAtIndex = class_getInstanceMethod([self class], @selector(objectAtSafeIndex:));
    method_exchangeImplementations(oldObjectAtIndex, newObjectAtIndex);
    
    //替换可变数组方法
    Method oldMutableObjectAtIndex = class_getInstanceMethod([self class], @selector(objectAtIndex:));
    Method newMutableObjectAtIndex =  class_getInstanceMethod([self class], @selector(mutableObjectAtSafeIndex:));
    method_exchangeImplementations(oldMutableObjectAtIndex, newMutableObjectAtIndex);
}

- (id)objectAtSafeIndex:(NSUInteger)index {
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self objectAtSafeIndex:index];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
    }else {
        return [self objectAtSafeIndex:index];
    }
}
- (id)mutableObjectAtSafeIndex:(NSUInteger)index{
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self mutableObjectAtSafeIndex:index];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
    }else {
        return [self mutableObjectAtSafeIndex:index];
    }
}
@end
