//
//  JYW_FictionModel.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/27.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_FictionModel.h"

@implementation JYW_FictionModel
@synthesize title;
@synthesize fileSize;
@synthesize playingTime;
@synthesize playedTime;
@synthesize playingState;
@synthesize downloadState;
@synthesize fId;
-(instancetype)initWithTitle:(NSString*)t fileSize:(float)fs playingTime:(int)pt playingState:(int)ps playedTime:(int)pdt downloadState:(int)ds fId:(int)ID{
    self=[super init];
    title=t;
    fileSize=fs;
    playingTime=pt;
    playingState=ps;
    playedTime=pdt;
    downloadState=ds;
    fId=ID;
    return self;
}
@end
