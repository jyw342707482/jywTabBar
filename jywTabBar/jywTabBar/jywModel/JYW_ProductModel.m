//
//  JYW_ProductModel.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/3.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_ProductModel.h"

@implementation JYW_ProductModel
@synthesize pImagePath;
@synthesize title;
@synthesize tags;
@synthesize sellingPrice;
@synthesize numberOfSales;
-(instancetype)initWithPImagePath:(NSString *)pImgPath title:(NSString *)t tags:(NSArray *)ts sellingPrice:(float)sp numberOfSales:(int)nos{
    self=[super init];
    pImagePath=pImgPath;
    title=t;
    tags=ts;
    sellingPrice=sp;
    numberOfSales=nos;
    return self;
}
@end
