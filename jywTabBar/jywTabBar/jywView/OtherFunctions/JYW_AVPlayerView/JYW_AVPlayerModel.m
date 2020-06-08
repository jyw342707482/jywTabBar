//
//  JYW_AVPlayerModel.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/6.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_AVPlayerModel.h"

@implementation JYW_AVPlayerModel
-(instancetype)initWithTitle:(NSString *)titleStr FilePath:(NSString *)filePathStr{
    self=[super init];
    if(self){
        title=titleStr;
        filePath=[self getLocalURLWithFilePath:filePathStr];
    }
    return self;
}
//返回本地文件路径
-(NSURL*)getLocalURLWithFilePath:(NSString *)path{
    //本地视频路径
    NSString *localFilePath = [[NSBundle mainBundle] pathForResource:path ofType:@"mp4"];
    NSURL *localFileUrl = [NSURL fileURLWithPath:localFilePath];
    return localFileUrl;
}
//返回网络地址
-(NSURL*)getWebURLWithFilePath:(NSString *)path{
    //网络地址,@"http://baobab.wdjcdn.com/14573563182394.mp4"
    NSURL*playUrl = [NSURL URLWithString:path];
    return playUrl;
}

//获取总播放时长
-(NSString*)getPlayTime{
    return playTime;
}
//修改总播放时长
-(void)setPlayTime:(long)t{
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",t/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(t%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",t%60];
    //format of time
    NSString *format_time;
    if(![str_second isEqualToString:@"00"]){
        format_time = str_second;
        playTimeType=2;
    }
    if(![str_minute isEqualToString:@""]){
        format_time = [NSString stringWithFormat:@"%@:%@",str_minute,format_time];
        playTimeType=1;
    }
    if(![str_hour isEqualToString:@""]){
        format_time = [NSString stringWithFormat:@"%@:%@",str_hour,format_time];
        playTimeType=0;
    }
    playTime=format_time;
}
//获取总播放时长格式类型
-(int)getPlayTimeType{
    return playTimeType;
}
//获取标题
-(NSString*)getTitle{
    return title;
}
//获取地址
-(NSURL*)getFilePath{
    return filePath;
}
@end
