//
//  JYW_FictionViewModel.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/28.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_FictionViewModel.h"
#import "JYW_FictionModel.h"
#import "JYW_FictionMainModel.h"
#import "AFHTTPSessionManager.h"

@implementation JYW_FictionViewModel
-(NSDictionary*)getFictionData{
    //定义一个nsstring用来获取Info.plist的路径
    NSString *fictionListPath = [[NSBundle mainBundle]pathForResource:@"FictionList" ofType:@"plist"];
    //定义一个字典用来存放Info.plist的内容，字典通过文件路径初始化
    NSDictionary *fmmDic=[[NSDictionary alloc] initWithContentsOfFile:fictionListPath];
    return fmmDic;
}
//获取小说列表数据,pageSize每页的条数，pageNum第几页
-(void)getFictionDataWithPageSize:(int)pageSize pageNum:(int)pageNum{
    //网络请求数据
    [self getAFNetworking];
}
//设置页面数据
-(JYW_FictionMainModel*)setPageDataWithDictionary:(NSDictionary*)dic{
    JYW_FictionMainModel *fmm=[[JYW_FictionMainModel alloc] initWithCustomerId:[[dic objectForKey:@"customerId"] intValue] playedIndex:[[dic objectForKey:@"playedIndex"] intValue]  fictionModelArray:[dic objectForKey:@"fmArray"]];
    return fmm;
}
//设置tableView数据源
-(NSMutableArray*)setTableViewDataSourceWithArray:(NSArray*)array{
    NSMutableArray *returnArray=[[NSMutableArray alloc] init];
    for(NSDictionary *dic in array){
        JYW_FictionModel *fm=[[JYW_FictionModel alloc] initWithTitle:[dic objectForKey:@"title"] fileSize:[[dic objectForKey:@"fileSize"] floatValue] playingTime:[[dic objectForKey:@"playingTime"] intValue] playingState:[[dic objectForKey:@"playingState"] intValue] playedTime:[[dic objectForKey:@"playedTime"] intValue] downloadState:[[dic objectForKey:@"downloadState"] intValue] fId:[[dic objectForKey:@"fId"] intValue]];
        [returnArray addObject:fm];
    }
    return returnArray;
}

- (void)getAFNetworking {
    /*
    NSString *URLString = @"http://example.com";
    NSDictionary *parameters = @{@"foo": @"bar", @"baz": @[@1, @2, @3]};
    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:parameters error:nil];
     */
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURL *URL = [NSURL URLWithString:@"http://httpbin.org/get"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask=[manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
            if([self.delegate respondsToSelector:@selector(fictionDataBackWithNSDictionary:NSError:)])
            {
                [self.delegate fictionDataBackWithNSDictionary:nil NSError:error];
            }
        } else {
            NSLog(@"%@ %@", response, responseObject);
            if([self.delegate
                respondsToSelector:@selector(fictionDataBackWithNSDictionary:NSError:)])
            {
                [self.delegate fictionDataBackWithNSDictionary:responseObject NSError:nil];
            }
        }
    }];
    [dataTask resume];
    
}
@end
