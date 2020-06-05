//
//  JYW_AVPlayerViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/5.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_AVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "JYW_VideoModel.h"
#import "JYW_AVPlayerViewModel.h"
@interface JYW_AVPlayerViewController ()
{
    AVPlayer *avPlayer;
    AVPlayerItem *avPlayerItem;
    AVPlayerLayer *avPlayerLayer;
    NSMutableArray *videoArray;
    
    JYW_AVPlayerViewModel *jyw_AVPlayerViewModel;
    long playVideoModelIndex;//当前播放的视频的index值
}
@end

@implementation JYW_AVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pageSetting];
}

-(void)pageSetting{
    self.title=@"AVPlayer播放";
    jyw_AVPlayerViewModel=[[JYW_AVPlayerViewModel alloc] init];
    videoArray=[jyw_AVPlayerViewModel getVideoList];
    avPlayerBackGroundViewHeight.constant=[UIScreen mainScreen].bounds.size.width*0.618;

    JYW_VideoModel *jywVM=videoArray[playVideoModelIndex];
    //如果要切换视频需要调AVPlayer的replaceCurrentItemWithPlayerItem:方法
    avPlayerItem=[AVPlayerItem playerItemWithURL:jywVM.filePath];
    
    //avPlayer = [[AVPlayer alloc] initWithURL:playUrl];
    avPlayer = [AVPlayer playerWithPlayerItem:avPlayerItem];
    //视频播放是否阻止显示和设备休眠
    //avPlayer.preventsDisplaySleepDuringVideoPlayback=YES;
    avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
    avPlayerLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, avPlayerBackGroundViewHeight.constant);//放置播放器的视图
    [avPlayerView.layer addSublayer:avPlayerLayer];
    
    [self toobarViewSetting];
    //通过KVO来观察status属性的变化，来获得播放之前的错误信息
    [avPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //[avPlayer play];
}
-(void)toobarViewSetting{
    toobarBackGroundView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.0];
    toobarView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.5];
}
//监听回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:
(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        //取出status的新值
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey]intValue];
        switch (status) {
            case AVPlayerItemStatusFailed:
                NSLog(@"item 有误");
                break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"准好播放了");
                [self videoPlay];
                break;
            case AVPlayerItemStatusUnknown:
                NSLog(@"视频资源出现未知错误");
                break;
            default:
                break;
        }
    }
    //移除监听（观察者）
    [object removeObserver:self forKeyPath:@"status"];
}
-(void)videoPlay{
    JYW_VideoModel *vm=videoArray[playVideoModelIndex];
    long vd=avPlayerItem.duration.value /avPlayerItem.duration.timescale;
    //vm.videoDuration=avPlayerItem.duration.value /avPlayerItem.duration.timescale;
    if(avPlayerItem.duration.value %avPlayerItem.duration.timescale>0)
    {
        vd++;
    }
    vm.videoDuration=vd;
    playSlider.maximumValue = vm.videoDuration;
    [startAndEndPlayButton setTitle:@"暂停" forState:UIControlStateNormal];
    startAndEndPlayButton.enabled=YES;
    timeLabel.text=[NSString stringWithFormat:@"00:00:00/%@",vm.videoDurationStr];
    [self addPeriodicTimeObserver];
    [avPlayer play];
}
- (void)addPeriodicTimeObserver {
    /*
    // Invoke callback every half second
    CMTime interval = CMTimeMakeWithSeconds(0.5, NSEC_PER_SEC);
    // Queue on which to invoke the callback
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    // Add time observer
    self.timeObserverToken =
        [self.player addPeriodicTimeObserverForInterval:interval
                                                  queue:mainQueue
                                             usingBlock:^(CMTime time) {
            // Use weak reference to self
            // Update player transport UI
        }];
     */
    /// 添加监听.以及回调
    __weak typeof(self) weakSelf = self;
    [avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        /// 更新播放进度
        [weakSelf updateSliderValue];
    }];
}
-(void)updateSliderValue{
    float psValue=playSlider.value;
    int s=psValue;
    int m=s/60;
    int h=0;
    if(m>=60)
    {
        h=m/60;
        m=m%60;
        
    }
    s=s%60;
    playSlider.value+=1.0;
    JYW_VideoModel *vm=videoArray[playVideoModelIndex];
    timeLabel.text=[NSString stringWithFormat:@"%d:%d:%d/%@",h,m,s,vm.videoDurationStr];
    
    //播完
    if(psValue==playSlider.maximumValue){
        NSLog(@"播完");
    }
    
}
//暂停/播放点击事件
-(IBAction)startAndEndPlayButton_Click:(id)sender{
    
    if([startAndEndPlayButton.titleLabel.text isEqualToString:@"暂停"]){
        [startAndEndPlayButton setTitle:@"播放" forState:UIControlStateNormal];
        [avPlayer pause];
    }
    else{
        [startAndEndPlayButton setTitle:@"暂停" forState:UIControlStateNormal];
        [avPlayer play];
    }
}
//视频播放速率+0.1点击事件
-(IBAction)playRateUp_Click:(id)sender{
    if(avPlayer.rate<=5.0)
    {
        avPlayer.rate+=0.5;
        NSLog(@"%f",avPlayer.rate);
    }
}
//视频播放速录-0.1点击事件
-(IBAction)playRateDown_Click:(id)sender{
    if(avPlayer.rate>0.5)
    {
        avPlayer.rate-=0.5;
        NSLog(@"%f",avPlayer.rate);
    }
    
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
