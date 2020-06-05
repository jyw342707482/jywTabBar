//
//  JYW_VideoModel.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/5.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_VideoModel.h"

@implementation JYW_VideoModel
@synthesize title;
@synthesize fileSize;
@synthesize videoDuration;
@synthesize playRate;
-(instancetype)initWithTitle:(NSString*)t fileSize:(float)fs videoDuration:(int)vd playRate:(float)pr{
    self=[super init];
    if(self){
        title=t;
        fileSize=fs;
        videoDuration=vd;
        playRate=pr;
    }
    return self;
}
@end
