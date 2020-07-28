//
//  JYW_ EncodeAndUnEncode.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/20.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_EncodeAndUnEncode.h"
#import <objc/runtime.h>
@implementation JYW_EncodeAndUnEncode
//解档
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
         unsigned int count = 0;
               //返回实例变量列表
        Ivar * ivarlist = class_copyIvarList([self class], &count);
        for (int i = 0; i<count; i++) {
            Ivar alvar = ivarlist[i];
            const char * name = ivar_getName(alvar);
            id value = [coder decodeObjectForKey:[NSString stringWithUTF8String:name]];
            if (!value) {
                       
            }else{
                [self setValue:value forKey:[NSString stringWithUTF8String:name]];
            }
        }
        free(ivarlist);
    }
    return self;
}
//归档
- (void)encodeWithCoder:(NSCoder *)coder
{
    //[super encodeWithCoder:coder];
    //获取某个类的成员变量
    unsigned int count = 0;
    Ivar * ivarlist = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar alvar = ivarlist[i];
        //获取成员变量的名称
        const char * ivarname = ivar_getName(alvar);
        id value = [self valueForKey:[NSString stringWithUTF8String:ivarname]];
        if (!value) {
            
        }else{
            [coder encodeObject:value forKey:[NSString stringWithUTF8String:ivarname]];
        }
    }
    free(ivarlist);
}
@end
