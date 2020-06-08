//
//  NSString+JYW_StringWidth.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/6.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "NSString+JYW_StringWidth.h"

@implementation NSString (JYW_StringWidth)
+(CGSize)getStingWidthFontSize:(float)fontSize  String:(NSString*)str{
    CGSize size=[str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
    return size;
}
@end
