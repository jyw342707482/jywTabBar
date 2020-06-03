//
//  JYW_AddressBookViewModel.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/1.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_AddressBookViewModel.h"
#import "JYW_AddressBookModel.h"
#import "JYW_AddressBookGroupModel.h"
@implementation JYW_AddressBookViewModel



//获取页面数据
-(NSDictionary*)getPageData{
    //定义一个nsstring用来获取Info.plist的路径
    NSString *addressBookListPath = [[NSBundle mainBundle]pathForResource:@"AddressBookList" ofType:@"plist"];
    //定义一个字典用来存放Info.plist的内容，字典通过文件路径初始化
    NSDictionary *abDictionary=[[NSDictionary alloc] initWithContentsOfFile:addressBookListPath];
    return abDictionary;
}
//获取通讯录数据
-(NSMutableArray*)getAddressBookDataWithAddressBookArray:(NSArray*)abArray JYW_AddressBookGroupModelArray:(NSMutableArray *)adgmArray{
    for(NSDictionary *dic in abArray){
        JYW_AddressBookModel *jywABM=[[JYW_AddressBookModel alloc] initWithAvatar:[dic objectForKey:@"avatar"] nickname:[dic objectForKey:@"nickname"] tagStr:[dic objectForKey:@"tagStr"] labelGroupIndex:[[dic objectForKey:@"labelGroupIndex"] intValue] pinyin:[dic objectForKey:@"pinyin"]];
        if([jywABM.pinyin isEqualToString:@""]){
            [jywABM setNicenameTransformPinYin:jywABM.nickname];
        }
        JYW_AddressBookGroupModel *jywABGM=adgmArray[jywABM.labelGroupIndex];
        [jywABGM.addressBookModelArray addObject:jywABM];
    }
    return adgmArray;
}
//获取分组数据
-(NSMutableArray*)getGroupDataWithLabelArray:(NSArray*)lArray{
    NSMutableArray *returnMutableArray=[[NSMutableArray alloc] init];
    for(NSString *groupStr in lArray){
        JYW_AddressBookGroupModel *jywABGM=[[JYW_AddressBookGroupModel alloc] initWithGroupStr:groupStr  addressBookModelArray:[[NSMutableArray alloc] init]];
        [returnMutableArray addObject:jywABGM];
    }
    return returnMutableArray;
}

@end
