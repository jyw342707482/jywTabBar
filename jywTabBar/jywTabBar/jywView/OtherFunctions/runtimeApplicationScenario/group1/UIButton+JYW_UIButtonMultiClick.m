//
//  UIButton+JYW_UIButtonMultiClick.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/19.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "UIButton+JYW_UIButtonMultiClick.h"
#import <objc/runtime.h>
@implementation UIButton (JYW_UIButtonMultiClick)
// 因category不能添加属性，只能通过关联对象的方式。
static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";

- (NSTimeInterval)jyw_acceptEventInterval {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setJyw_acceptEventInterval:(NSTimeInterval)jyw_acceptEventInterval {
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(jyw_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";

- (NSTimeInterval)jyw_acceptEventTime {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setJyw_acceptEventTime:(NSTimeInterval)jyw_acceptEventTime {
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(jyw_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    [super load];
    /*
    Method normal = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method newMethod = class_getInstanceMethod(self, @selector(jyw_sendAction:to:forEvent:));
    method_exchangeImplementations(normal, newMethod);
     */
}
-(void)method_exchangeImplementations{
    Method normal = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
    Method newMethod = class_getInstanceMethod([self class], @selector(jyw_sendAction:to:forEvent:));
    method_exchangeImplementations(normal, newMethod);
}
- (void)jyw_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([NSDate date].timeIntervalSince1970 - self.jyw_acceptEventTime < self.jyw_acceptEventInterval) {
        return;
    }
    if (self.jyw_acceptEventInterval > 0) {
        self.jyw_acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
    [self jyw_sendAction:action to:target forEvent:event];
}
@end
