//
//  NSObject+JYW_DictionaryTurnModel.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/22.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "NSObject+JYW_DictionaryTurnModel.h"
#import <objc/runtime.h>
//字典转模型
@implementation NSObject (JYW_DictionaryTurnModel)
-(BOOL)dictionaryTurnModel1:(NSDictionary*)dictionary{
    /*NSObject * obj;
    if(self==nil){
        obj = [[self class] new];
    }*/
    @try {
        unsigned int outCount=0;
        Ivar *ivars=class_copyIvarList([self class], &outCount);
        for(unsigned int i=0;i<outCount;i++){
            Ivar ivar=ivars[i];
            const char *ivarName=ivar_getName(ivar);
            NSString *propertyName=[NSString stringWithUTF8String:ivarName] ;
            propertyName=[propertyName substringFromIndex:1];
            id propertValue=[dictionary objectForKey:propertyName];
            if(propertValue==nil){
                continue;
            }
            [self setValue:propertValue forKey:propertyName];
        }
        return YES;
    } @catch (NSError *error) {
        NSLog(@"%@", error.localizedRecoveryOptions);
        return NO;
    }
}
-(BOOL)dictionaryTurnModel2:(NSDictionary*)dictionary{
    //NSObject * obj = [[self class] new];
    NSObject * obj;
    if(self==nil){
        obj = [[self class] new];
    }
    @try {
        unsigned int outCount=0;
        Ivar *ivars=class_copyIvarList([self class], &outCount);
        for(unsigned int i=0;i<outCount;i++){
            Ivar ivar=ivars[i];
            const char *ivarName=ivar_getName(ivar);
            NSString *propertyName=[NSString stringWithUTF8String:ivarName] ;
            propertyName=[propertyName substringFromIndex:1];
            id propertValue=[dictionary objectForKey:propertyName];
            if(propertValue==nil){
                continue;
            }
            
            const char *typeEncoding=ivar_getTypeEncoding(ivar);
            NSString *typeEncodingStr=[NSString stringWithUTF8String:typeEncoding];
            // 如果属性是对象类型（字典或者数组中包含字典）
            NSRange range = [typeEncodingStr rangeOfString:@"@"];
            if(range.location!=NSNotFound)
            {
                typeEncodingStr = [typeEncodingStr substringWithRange:NSMakeRange(2, typeEncodingStr.length - 3)];
            }
            if([typeEncodingStr isEqualToString:@"NSArray"]){
                
                // 如果是数组类型，将数组中的每个模型进行字典转模型，先创建一个临时数组存放模型
                NSArray *array = (NSArray *)propertValue;
                NSMutableArray *mArray = [NSMutableArray array];
                // 获取到每个模型的类型
                id class ;
                if ([self respondsToSelector:@selector(getClassType1)]) {
                    //获取数组中每个字典对应转换的类型，即重写gainClassType方法返回的类型：Lesson
                    NSString *classStr = [self getClassType1];
                    //class=objc_getClass([classStr cStringUsingEncoding:NSUTF8StringEncoding]);
                    class = NSClassFromString(classStr);
                    
                    // 将数组中的所有模型进行字典转模型
                    for (int i = 0; i < array.count; i++) {
                        id classChild=[class new];
                        [classChild dictionaryTurnModel1:propertValue[i]];
                        [mArray addObject:classChild];
                    }
                    [self setValue:mArray forKey:propertyName];
                }
                else
                {
                    [self setValue:nil forKey:propertyName];
                }
                
            }
            else if([typeEncodingStr isEqualToString:@"NSDictionary"]){
                NSDictionary *dic=(NSDictionary *)propertValue;
                // 获取到每个模型的类型
                id class ;
                if ([self respondsToSelector:@selector(getClassType1)]) {
                    //获取数组中每个字典对应转换的类型，即重写gainClassType方法返回的类型：Lesson
                    NSString *classStr = [self getClassType1];
                    class=objc_getClass([classStr cStringUsingEncoding:NSUTF8StringEncoding]);
                    //class = NSClassFromString(classStr);
                    class=[class new];
                    [class dictionaryTurnModel1:dic];
                    
                    [self setValue:class forKey:propertyName];
                }
                else
                {
                    [self setValue:nil forKey:propertyName];
                }
            }
            else {
                [self setValue:propertValue forKey:propertyName];
            }
            
        }
        return YES;
    } @catch (NSError *error) {
        NSLog(@"%@", error.localizedRecoveryOptions);
        return NO;
    }
}
-(NSString *)getClassType1{
    return @"JYW_DictionaryTurnModel1";
}
@end
