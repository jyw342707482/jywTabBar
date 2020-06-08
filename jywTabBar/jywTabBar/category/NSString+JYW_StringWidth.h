//
//  NSString+JYW_StringWidth.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/6.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (JYW_StringWidth)
//返回字符串str的CGSize
+(CGSize)getStingWidthFontSize:(float)fontSize String:(NSString*)str;
@end

NS_ASSUME_NONNULL_END
