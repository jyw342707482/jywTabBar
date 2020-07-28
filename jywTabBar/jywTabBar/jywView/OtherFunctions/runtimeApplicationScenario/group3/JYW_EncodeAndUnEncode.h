//
//  JYW_ EncodeAndUnEncode.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/20.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYW_EncodeAndUnEncode : NSObject<NSCoding>
@property (nonatomic,copy)NSString * title; //电影名
@property (nonatomic,copy)NSString * genres; //电影的种类
@property (nonatomic,copy)NSString * imageUrl;//电影的图片

//解档
- (instancetype)initWithCoder:(NSCoder *)coder;
//归档
- (void)encodeWithCoder:(NSCoder *)coder;
@end

NS_ASSUME_NONNULL_END
