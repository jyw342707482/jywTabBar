//
//  JYW_ProductListViewModel.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/3.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYW_ProductListViewModel : NSObject
//获取页面数据
-(NSArray*)getPageData;
//返回商品列表数据
-(NSMutableArray *)getProductListDataWithArray:(NSArray*)pArray;
@end

NS_ASSUME_NONNULL_END
