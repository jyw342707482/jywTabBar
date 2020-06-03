//
//  JYW_AddressBookModel.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/1.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYW_AddressBookModel : NSObject
@property (nonatomic,readwrite)NSString *avatar;//朋友头像名称
@property (nonatomic,readwrite)NSString *nickname;//朋友昵称
@property (nonatomic,readwrite)NSString *tagStr;//朋友标签
@property (nonatomic,readwrite)int labelGroupIndex;//分组索引
@property (nonatomic,readwrite)NSString *pinyin;//朋友昵称拼音
-(instancetype)initWithAvatar:(NSString*)aName nickname:(NSString*)nn tagStr:(NSString*)tStr labelGroupIndex:(int)lgi pinyin:(NSString *)py;
//将昵称转换成拉丁字母
-(BOOL)setNicenameTransformPinYin:(NSString*)nickname;
@end

NS_ASSUME_NONNULL_END
