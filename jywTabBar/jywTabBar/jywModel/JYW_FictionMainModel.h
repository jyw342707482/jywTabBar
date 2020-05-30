//
//  JYW_FictionMainModel.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/29.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYW_FictionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JYW_FictionMainModel : NSObject
@property(nonatomic,readwrite)int customerId;//客户id
@property(nonatomic,readwrite)int playedIndex;//上次播放位置
@property(nonatomic,readwrite)int audioCount;//音频数量,由fmArray计算出来
@property(nonatomic,readwrite)NSMutableArray *fmArray;//音频列表
-(instancetype)initWithCustomerId:(int)cId playedIndex:(int)pIndex fictionModelArray:(NSMutableArray*)fictionModelArray;
@end

NS_ASSUME_NONNULL_END
