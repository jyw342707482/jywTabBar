//
//  JYW_AddressBookViewModel.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/1.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYW_AddressBookViewModel : NSObject
//获取页面数据
-(NSDictionary*)getPageData;
//获取通讯录数据
-(NSMutableArray*)getAddressBookDataWithAddressBookArray:(NSArray*)abArray JYW_AddressBookGroupModelArray:(NSMutableArray *)adgmArray;
//获取分组数据
-(NSMutableArray*)getGroupDataWithLabelArray:(NSArray*)lArray;
@end

NS_ASSUME_NONNULL_END
