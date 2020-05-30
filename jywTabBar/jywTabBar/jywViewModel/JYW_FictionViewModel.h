//
//  JYW_FictionViewModel.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/28.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYW_FictionMainModel.h"
NS_ASSUME_NONNULL_BEGIN
//代理
@protocol JYW_FictionViewModel_Delegate <NSObject>
-(void)fictionDataBack;
@end
@interface JYW_FictionViewModel : NSObject
//获取小说列表数据
-(NSDictionary*)getFictionData;
//获取小说列表数据,pageSize每页的条数，pageNum第几页
-(void)getFictionDataWithPageSize:(int)pageSize pageNum:(int)pageNum;
//设置页面数据
-(JYW_FictionMainModel*)setPageDataWithDictionary:(NSDictionary*)dic;
@property (nonatomic,weak)id<JYW_FictionViewModel_Delegate>delegate;//声明
@end

NS_ASSUME_NONNULL_END
