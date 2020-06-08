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
@synthesize filePath;
@synthesize videoDurationStr;
-(instancetype)initWithTitle:(NSString*)t fileSize:(float)fs videoDuration:(int)vd playRate:(float)pr filePath:(NSURL*)fp{
    self=[super init];
    if(self){
        title=t;
        fileSize=fs;
        videoDuration=vd;
        playRate=pr;
        filePath=fp;
    }
    return self;
}
-(void)setVideoDuration:(long)videoDuration{
    NSInteger seconds = videoDuration;

    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time;
    if(![str_second isEqualToString:@"00"]){
        format_time = str_second;
    }
    if(![str_minute isEqualToString:@""]){
        format_time = [NSString stringWithFormat:@"%@:%@",str_minute,format_time];
    }
    if(![str_hour isEqualToString:@""]){
        format_time = [NSString stringWithFormat:@"%@:%@",str_hour,format_time];
    }

    videoDurationStr=format_time;
}
@end
