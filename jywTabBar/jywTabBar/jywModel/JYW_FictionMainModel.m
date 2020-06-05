//
//  JYW_FictionMainModel.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/29.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_FictionMainModel.h"
#import "JYW_FictionModel.h"

@implementation JYW_FictionMainModel
@synthesize customerId;
@synthesize playedIndex;
@synthesize audioCount;
@synthesize fmArray;
-(instancetype)initWithCustomerId:(int)cId playedIndex:(int)pIndex fictionModelArray:(NSMutableArray*)fictionModelArray{
    self=[super init];
    if(self){
        customerId=cId;
        playedIndex=pIndex;
        NSMutableArray *fArray=[[NSMutableArray alloc] init];
        for(NSDictionary *dic in fictionModelArray){
            JYW_FictionModel *fm=[[JYW_FictionModel alloc] initWithTitle:[dic objectForKey:@"title"] fileSize:[[dic objectForKey:@"fileSize"] floatValue] playingTime:[[dic objectForKey:@"playingTime"] intValue] playingState:[[dic objectForKey:@"playingState"] intValue] playedTime:[[dic objectForKey:@"playedTime"] intValue] downloadState:[[dic objectForKey:@"downloadState"] intValue] fId:[[dic objectForKey:@"fId"] intValue]];
            [fArray addObject:fm];
        }
        fmArray=fArray;
        audioCount=(int)[fmArray count];
    }
    
    return self;
}
@end
