//
//  JYW_AddressBookModel.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/1.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_AddressBookModel.h"

@implementation JYW_AddressBookModel
@synthesize avatar;
@synthesize nickname;
@synthesize tagStr;
@synthesize labelGroupIndex;
@synthesize pinyin;
-(instancetype)initWithAvatar:(NSString*)aName nickname:(NSString*)nn tagStr:(NSString*)tStr labelGroupIndex:(int)lgi pinyin:(NSString *)py{
    self=[super init];
    avatar=aName;
    nickname=nn;
    tagStr=tStr;
    labelGroupIndex=lgi;
    pinyin=py;
    return self;
}
-(BOOL)setNicenameTransformPinYin:(NSString*)nickname{
    NSMutableString * nicknamePY = [[NSMutableString alloc]initWithString:nickname];
    if(!CFStringTransform((__bridge CFMutableStringRef) nicknamePY, NULL, kCFStringTransformMandarinLatin, NO)){
        return NO;
    }
    if(!CFStringTransform((__bridge CFMutableStringRef) nicknamePY, NULL, kCFStringTransformStripDiacritics, NO)){
        return NO;
    }
    //3.去除掉首尾的空白字符和换行字符
    pinyin = [nicknamePY stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //4.去除掉其它位置的空白字符和换行字符
    pinyin = [pinyin stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    pinyin = [pinyin stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    pinyin = [pinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
    //uppercaseString;//大写
    //lowercaseString;//小写
    //capitalizedString;//首字母大写
    pinyin=[pinyin capitalizedString];
    UniChar firstChar=[pinyin characterAtIndex:0];
    switch (firstChar) {
        case 65:
            labelGroupIndex=0;
            break;
        case 66:
            labelGroupIndex=1;
            break;
        case 67:
            labelGroupIndex=2;
            break;
        case 68:
            labelGroupIndex=3;
            break;
        case 69:
            labelGroupIndex=4;
            break;
        case 70:
            labelGroupIndex=5;
            break;
        case 71:
            labelGroupIndex=6;
            break;
        case 72:
            labelGroupIndex=7;
            break;
        case 73:
            labelGroupIndex=8;
            break;
        case 74:
            labelGroupIndex=9;
            break;
        case 75:
            labelGroupIndex=10;
            break;
        case 76:
            labelGroupIndex=11;
            break;
        case 77:
            labelGroupIndex=12;
            break;
        case 78:
            labelGroupIndex=13;
            break;
        case 79:
            labelGroupIndex=14;
            break;
        case 80:
            labelGroupIndex=15;
            break;
        case 81:
            labelGroupIndex=16;
            break;
        case 82:
            labelGroupIndex=17;
            break;
        case 83:
            labelGroupIndex=18;
            break;
        case 84:
            labelGroupIndex=19;
            break;
        case 85:
            labelGroupIndex=20;
            break;
        case 86:
            labelGroupIndex=21;
            break;
        case 87:
            labelGroupIndex=22;
            break;
        case 88:
            labelGroupIndex=23;
            break;
        case 89:
            labelGroupIndex=24;
            break;
        case 90:
            labelGroupIndex=25;
            break;
        
        default:
            labelGroupIndex=26;
            break;
    }
    NSLog(@"%@",pinyin);
    return YES;
}
@end
