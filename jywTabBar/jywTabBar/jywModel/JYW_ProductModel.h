//
//  JYW_ProductModel.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/3.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYW_ProductModel : NSObject
@property (nonatomic,readwrite) NSString *pImagePath;
@property (nonatomic,readwrite) NSString *title;
@property (nonatomic,readwrite) NSArray *tags;
@property (nonatomic,readwrite) float sellingPrice;
@property (nonatomic,readwrite) int numberOfSales;
-(instancetype)initWithPImagePath:(NSString *)pImgPath title:(NSString *)t tags:(NSArray *)ts sellingPrice:(float)sp numberOfSales:(int)nos;
@end

NS_ASSUME_NONNULL_END
