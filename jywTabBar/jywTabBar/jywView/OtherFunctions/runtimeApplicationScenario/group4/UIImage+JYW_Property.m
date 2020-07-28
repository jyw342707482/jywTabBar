//
//  UIImage+JYW_.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/22.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "UIImage+JYW_AddProperty.h"
#import <objc/runtime.h>
@implementation UIImage (JYW_AddProperty)
//static char downLoadURLKey;
-(NSString *)downLoadURL{
    return objc_getAssociatedObject(self, @selector(downLoadURL));
}
-(void)setDownLoadURL:(NSString *)downLoadURL{
    objc_setAssociatedObject(self, @selector(downLoadURL), downLoadURL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
