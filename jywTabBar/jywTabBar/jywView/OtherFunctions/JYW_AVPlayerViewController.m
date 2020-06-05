//
//  JYW_AVPlayerViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/5.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_AVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface JYW_AVPlayerViewController ()
{
    AVPlayer *avPlayer;
    AVPlayerItem *avPlayerItem;
    AVPlayerLayer *avPlayerLayer;
}
@end

@implementation JYW_AVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pageSetting];
}

-(void)pageSetting{
    self.title=@"AVPlayer播放";
    avPlayerViewHeight.constant=[UIScreen mainScreen].bounds.size.width*0.618;
    //本地视频路径
    NSString *localFilePath = [[NSBundle mainBundle] pathForResource:@"video1" ofType:@"mp4"];
    NSURL *localVideoUrl = [NSURL fileURLWithPath:localFilePath];
    
    //获取视频的文件大小，和总时长秒
    AVURLAsset * asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:localFilePath]];
    CMTime   time = [asset duration];
    int seconds = ceil(time.value/time.timescale);
    if(time.value%time.timescale>0)
    {
        seconds++;
    }
    NSInteger   fileSize = [[NSFileManager defaultManager] attributesOfItemAtPath:localFilePath error:nil].fileSize;
    float fileSizeMB=fileSize/1024.0/1024.0;
    //NSURL*playUrl = [NSURL URLWithString:@"http://baobab.wdjcdn.com/14573563182394.mp4"];
    //avPlayer = [[AVPlayer alloc] initWithURL:playUrl];
    avPlayerItem = [AVPlayerItem playerItemWithURL:localVideoUrl];//如果要切换视频需要调AVPlayer的replaceCurrentItemWithPlayerItem:方法
    
    avPlayer = [AVPlayer playerWithPlayerItem:avPlayerItem];
    //视频播放是否阻止显示和设备休眠
    //avPlayer.preventsDisplaySleepDuringVideoPlayback=YES;
    avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
    avPlayerLayer.frame = avPlayerView.bounds;//放置播放器的视图
    [avPlayerView.layer addSublayer:avPlayerLayer];
    [avPlayer play];
}

@end


/*
Managing Playback 管理播放
play//开始播放
pause//暂停播放
rate//播放速率
actionAtItemEnd//当前播放器项目完成播放时要执行的操作
AVPlayerActionAtItemEnd//播放完成后应采取的动作。
replaceCurrentItemWithPlayerItem://用新的播放器项目替换当前的播放器项目。
preventsDisplaySleepDuringVideoPlayback//一个布尔值，指示视频播放是否阻止显示和设备休眠。
 */
/*
Managing Automatic Waiting Behavior 管理自动等待行为
automaticallyWaitsToMinimizeStalling//一个布尔值，指示播放器是否应自动延迟播放以最小化停顿。
reasonForWaitingToPlay//播放器当前等待播放开始或继续的原因。
AVPlayerWaitingReason//播放器等待的原因开始或继续播放。
timeControlStatus//一种状态，指示在等待适当的网络条件时是当前正在进行播放，无限期暂停还是暂停播放。
AVPlayerTimeControlStatus//播放器状态指示播放速率变化。
- playImmediatelyAtRate://以指定的速率立即播放可用的媒体数据。
 */
/**
 Managing Time 管理时间
 - currentTime//返回当前播放器项目的当前时间。
 - seekToTime://将当前播放时间设置为指定时间。
 - seekToDate://将当前播放时间设置为日期对象指定的时间。
 - seekToTime:completionHandler:将当前播放时间设置为指定的时间，并在操作完成或中断时执行指定的块。
 - seekToDate:completionHandler://将当前播放时间设置为日期对象指定的时间,并在操作完成或中断时执行指定的块。
 - seekToTime:toleranceBefore:toleranceAfter://设置指定时间范围内的当前播放时间。
 - seekToTime:toleranceBefore:toleranceAfter:completionHandler:在指定的时间范围内设置当前播放时间，并在操作完成或中断时调用指定的块。
 */
/*
 Getting Player Properties 获取播放器属性
 status//一种状态，指示是否可以使用播放器进行播放。
 AVPlayerStatus//是否可以成功播放项目的状态。
 error//导致失败的错误。
 currentItem//播放器的当前播放器项目。
 outputObscuredDueToInsufficientExternalProtection//一个布尔值，指示是否由于外部保护不足而遮挡了输出。
 **/
/*
 Managing Audio Output 管理音频输出
 muted//一个布尔值，指示播放器的音频输出是否被静音。
 volume//播放器的音频播放音量。
 audioOutputDeviceUniqueID//指定用于播放音频的Core Audio输出设备的唯一ID。

 **/
/*
 Managing External Playback 管理外部播放
 allowsExternalPlayback//一个布尔值，指示播放器是否允许切换到外部播放模式。
 externalPlaybackActive//一个布尔值，指示播放器当前是否在外部播放模式下播放视频。
 usesExternalPlaybackWhileExternalScreenIsActive//一个布尔值，指示在外部屏幕模式处于活动状态时，播放器是否应自动切换到外部播放模式。
 externalPlaybackVideoGravity//播放器的视频重力仅适用于外部播放模式。
 AVLayerVideoGravity//一个值，用于定义视频在图层边界矩形内的显示方式。

 **/
