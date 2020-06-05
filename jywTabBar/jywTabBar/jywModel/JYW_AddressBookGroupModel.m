//
//  JYW_AddressBookGroupModel.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/1.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_AddressBookGroupModel.h"

@implementation JYW_AddressBookGroupModel
@synthesize groupStr;
@synthesize addressBookModelArray;
-(instancetype)initWithGroupStr:(NSString*)gStr addressBookModelArray:(NSMutableArray *)abmArray{
    self=[super init];
    if(self){
        groupStr=gStr;
        addressBookModelArray=abmArray;
    }
    
    return self;
}
@end
