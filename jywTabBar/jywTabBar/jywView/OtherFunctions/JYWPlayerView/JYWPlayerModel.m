//
//  JYWPlayerModel.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/11.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYWPlayerModel.h"

@implementation JYWPlayerModel

-(instancetype)initWithTitle:(NSString *)titleStr FilePath:(NSString *)filePathStr{
    self=[super init];
    if(self){
        self.title=titleStr;
        self.filePath=[self getLocalURLWithFilePath:filePathStr];
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
//修改总播放时长
-(void)editPlayTime:(long)t{
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",t/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(t%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",t%60];
    //format of time
    NSString *format_time=@"";
    //时间格式类型
    int playTimeType=0;
    if(![str_hour isEqualToString:@"00"]){
        format_time =str_hour;
        // [NSString stringWithFormat:@"%@:%@",str_hour,format_time];
        playTimeType=0;
    }
    if(![str_minute isEqualToString:@"00"]){
        if([format_time isEqualToString:@""])
        {
            format_time =str_minute;
        }
        else
        {
            format_time = [NSString stringWithFormat:@"%@:%@",format_time,str_minute];
        }
        playTimeType=1;
    }
    if(![str_second isEqualToString:@"00"]){
        if([format_time isEqualToString:@""])
        {
            format_time =[NSString stringWithFormat:@"%@'",str_second];
        }
        else
        {
            format_time = [NSString stringWithFormat:@"%@:%@",format_time,str_second];
        }
        playTimeType=2;
    }
    
    
    NSString *playTime=format_time;
    if(_delegate && [_delegate respondsToSelector:@selector(playTime_ValueChange:)])
    {
        [_delegate playTime_ValueChange:playTime];
    }
    NSString *playTimeNow;
    if(playTimeType==0){
        playTimeNow=@"00:00:00";
    }
    else if(playTimeType==1){
        playTimeNow=@"00:00";
    }
    else
    {
        playTimeNow=@"00'";
    }
    if(_delegate && [_delegate respondsToSelector:@selector(playTimeType_ValueChange:)])
    {
        [_delegate playTimeType_ValueChange:playTimeNow];
    }
}
@end
