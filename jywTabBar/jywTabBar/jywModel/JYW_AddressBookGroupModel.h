//
//  JYW_AddressBookGroupModel.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/1.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYW_AddressBookModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JYW_AddressBookGroupModel : NSObject
@property (nonatomic,readwrite)NSString *groupStr;
@property (nonatomic,readwrite)NSMutableArray *addressBookModelArray;
-(instancetype)initWithGroupStr:(NSString*)gStr addressBookModelArray:(NSMutableArray *)abmArray;
@end

NS_ASSUME_NONNULL_END
