//
//  JYW_ProductListViewModel.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/3.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_ProductListViewModel.h"
#import "JYW_ProductModel.h"
@implementation JYW_ProductListViewModel
//获取页面数据
-(NSArray*)getPageData{
    //定义一个nsstring用来获取Info.plist的路径
    NSString *productListPath = [[NSBundle mainBundle]pathForResource:@"ProductList" ofType:@"plist"];
    //定义一个字典用来存放Info.plist的内容，字典通过文件路径初始化
    NSArray *plpArray=[[NSArray alloc] initWithContentsOfFile:productListPath];
    return plpArray;
}
//返回商品列表数据
-(NSMutableArray *)getProductListDataWithArray:(NSArray*)pArray{
    NSMutableArray *returnArray=[[NSMutableArray alloc] init];
    for(NSDictionary *dic in pArray){
        JYW_ProductModel *jywPM=[[JYW_ProductModel alloc] initWithPImagePath:[dic objectForKey:@"pImagePath"] title:[dic objectForKey:@"title"] tags:[dic objectForKey:@"tags"] sellingPrice:[[dic objectForKey:@"sellingPrice"] floatValue] numberOfSales:[[dic objectForKey:@"numberOfSales"] intValue]];
        [returnArray addObject:jywPM];
    }
    return returnArray;
}
@end
