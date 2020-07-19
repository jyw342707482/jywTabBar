//
//  JYW_RuntimeExplanation.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/15.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_RuntimeExplanation.h"
#import <objc/runtime.h>
#import "JYW_NSObjectExplanation.h"
//runtime 说明
@implementation JYW_RuntimeExplanation

#pragma mark -Working with Classes(同类一起工作)
-(void)workingWithClasses{
    //返回类的超类
    NSLog(@"返回类的超类：%@",class_getSuperclass([self class]));
    //返回类的名称
    NSLog(@"返回类的名称：%s",class_getName([self class]));
    //返回一个布尔值，该值指示类对象是否为元类。
    NSLog(@"判断类是否为元类：%d",class_isMetaClass([self class]));
    //返回类实例的大小
    NSLog(@"返回类实例大小：%zu",class_getInstanceSize([self class]));
    //返回给定类的指定实例变量的Ivar。
    NSLog(@"返回给定类的指定实例变量的Ivar：%@",class_getInstanceVariable([self class], "variable_int"));
    //返回给定类的指定类变量的Ivar。
    NSLog(@"返回给定类的指定类变量的Ivar：%@",class_getClassVariable([self class], "variable_int"));
    //将新的实例变量添加到类
    //NSLog(@"将新的实例变量添加到类：%d",class_addIvar([self class], "variable_int1", size_t size, uint8_t alignment, "test"))
}
@end
/*
 与班级一起工作
 class_addIvar
 将新的实例变量添加到类。
 class_copyIvarList
 描述由类声明的实例变量。
 class_getIvarLayout
 返回给定类的Ivar布局的描述。
 class_setIvarLayout
 设置给定类的Ivar布局。
 class_getWeakIvarLayout
 返回给定类的弱Ivar布局的描述。
 class_setWeakIvarLayout
 设置给定类的弱Ivar的布局。
 class_getProperty
 返回具有给定类的给定名称的属性。
 class_copyPropertyList
 描述类声明的属性。
 class_addMethod
 向具有给定名称和实现的类中添加新方法。
 class_getInstanceMethod
 返回给定类的指定实例方法。
 class_getClassMethod
 返回一个指向描述给定类的给定类方法的数据结构的指针。
 class_copyMethodList
 描述由类实现的实例方法。
 class_replaceMethod
 替换给定类的方法的实现。
 class_getMethodImplementation
 返回将特定消息发送到类的实例时将调用的函数指针。
 class_getMethodImplementation_stret
 返回将特定消息发送到类的实例时将调用的函数指针。
 class_respondsToSelector
 返回一个布尔值，该值指示类的实例是否响应特定的选择器。
 class_addProtocol
 将协议添加到类。
 class_addProperty
 将属性添加到类。
 class_replaceProperty
 替换类的属性。
 class_conformsToProtocol
 返回一个布尔值，该值指示类是否符合给定的协议。
 class_copyProtocolList
 描述类采用的协议。
 class_getVersion
 返回类定义的版本号。
 class_setVersion
 设置类定义的版本号。
 objc_getFutureClass
 由CoreFoundation的免费桥接使用。
 objc_setFutureClass
 由CoreFoundation的免费桥接使用。
 */
