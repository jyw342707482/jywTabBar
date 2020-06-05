//
//  JYW_AVPlayerViewModel.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/5.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_AVPlayerViewModel.h"
#import <AVFoundation/AVFoundation.h>
#import "JYW_VideoModel.h"
@implementation JYW_AVPlayerViewModel
//获取视频列表
-(NSMutableArray*)getVideoList{
    NSArray *videoNameArray=@[@"video1",@"video2",@"video3"];
    NSMutableArray *returnArray=[[NSMutableArray alloc] init];
    for(NSString *fileNameStr in videoNameArray){
        //本地视频路径
        NSString *localFilePath = [[NSBundle mainBundle] pathForResource:fileNameStr ofType:@"mp4"];
        NSURL *localVideoUrl = [NSURL fileURLWithPath:localFilePath];
        //网络地址
        //NSURL*playUrl = [NSURL URLWithString:@"http://baobab.wdjcdn.com/14573563182394.mp4"];
        //获取视频的文件大小，和总时长秒
        AVURLAsset * asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:localFilePath]];
        CMTime   time = [asset duration];
        int seconds = ceil(time.value/time.timescale);
        if(time.value%time.timescale>0)
        {
            seconds++;
        }
        NSInteger   fileSize = [[NSFileManager defaultManager] attributesOfItemAtPath:localFilePath error:nil].fileSize;
        float fileSizeMB=(fileSize/1024.0/1024.0);
        JYW_VideoModel *jywVM=[[JYW_VideoModel alloc] initWithTitle:fileNameStr fileSize:fileSizeMB videoDuration:seconds playRate:1.0 filePath:localVideoUrl];
        [returnArray addObject:jywVM];
    }
    return returnArray;
}
@end
