//
//  JYWAudioPlayerView.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/25.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYWAudioPlayerView.h"
@implementation JYWAudioPlayerViewConfig
+(instancetype)defaultConfig{
    JYWAudioPlayerViewConfig *defaultObject=[[JYWAudioPlayerViewConfig alloc] init];
    defaultObject.audioURLType=0;
    return defaultObject;
}
-(void)setAudioURLStr:(NSString *)audioURLStr{
    _audioURLStr=audioURLStr;
    if(_audioURLType==0){
        _audioURL=[self getLocalURLWithFilePath:_audioURLStr];
    }
    else{
        _audioURL=[self getWebURLWithFilePath:_audioURLStr];
    }
}

//返回本地文件路径
-(NSURL*)getLocalURLWithFilePath:(NSString *)path{
    //本地视频路径
    NSString *localFilePath = [[NSBundle mainBundle] pathForResource:path ofType:@"mp3"];
    NSURL *localFileUrl = [NSURL fileURLWithPath:localFilePath];
    return localFileUrl;
}
//返回网络地址
-(NSURL*)getWebURLWithFilePath:(NSString *)path{
    //网络地址,@"http://baobab.wdjcdn.com/14573563182394.mp4"
    NSURL*playUrl = [NSURL URLWithString:path];
    return playUrl;
}
//秒转时间
-(NSString*)secondTurnTime:(Float64)second{
    long s=second;
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",s/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",s%60];
    //format of time
    NSString *format_time=[NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    return format_time;
}

@end

@implementation JYWAudioPlayer
-(instancetype)initWithFrame:(CGRect)frame JYWAudioPlayerViewConfig:(JYWAudioPlayerViewConfig *)jywAudioPlayerViewConfig{
    self=[super initWithFrame:frame];
    if(self){
        [self addSubview:self.audioProgressView];
        [self addSubview:self.audioPlayerSlider];
        [self addSubview:self.playAndStopButton];
        [self addSubview:self.upButton];
        [self addSubview:self.nextButton];
        [self addSubview:self.playTimeLabel];
        
        self.jywAudioPlayerViewConfig=jywAudioPlayerViewConfig;
        [self initAVPlayer];
        [self initNotificationAndKVO];
    }
    return self;
}
-(void)initAVPlayer{
    //创建播放器
    AVAsset *asset=[AVAsset assetWithURL:self.jywAudioPlayerViewConfig.audioURL];
    //如果要切换视频需要调AVPlayer的replaceCurrentItemWithPlayerItem:方法
    self.avAudioPlayerItem=[AVPlayerItem playerItemWithAsset:asset];
    //self.avAudioPlayerItem=[AVPlayerItem playerItemWithURL:self.jywAudioPlayerViewConfig.audioURL];
    self.avAudioPlayer = [AVPlayer playerWithPlayerItem:self.avAudioPlayerItem];
}
//播放
-(void)JYWPlay{
    [self.avAudioPlayer play];
    self.isPlaying=YES;
    self.playAndStopButton.selected=YES;
}
//暂停播放
-(void)JYWPause{
    [self.avAudioPlayer pause];
    self.isPlaying=NO;
    self.playAndStopButton.selected=NO;
}
//重新载入音频
-(void)JYWReLoadAudioWithURL:(NSString*)url{
    [self JYWPause];
    [self deallocNotificationAndKVO];
    self.jywAudioPlayerViewConfig.audioURLStr=url;
    self.avAudioPlayerItem=[AVPlayerItem playerItemWithURL:self.jywAudioPlayerViewConfig.audioURL];
    [self.avAudioPlayer replaceCurrentItemWithPlayerItem:self.avAudioPlayerItem];
    [self initNotificationAndKVO];
    [self JYWReLoadData];
    [self JYWPlay];
}
//重置数据
-(void)JYWReLoadData{
    self.audioPlayerSlider.value=0;
}

#pragma mark -KVO监听
//销毁通知消息和KVO监听
-(void)deallocNotificationAndKVO{
    [self.avAudioPlayer removeTimeObserver:playerObserve];//400-919-1122
    //移除进入后台消息通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    //移除回到前台消息通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    //移除视频播放完消息通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.avAudioPlayerItem];
    
    //移除监听（观察者）
    [self.avAudioPlayerItem removeObserver:self forKeyPath:@"status"];
    [self.avAudioPlayerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.avAudioPlayerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [self.avAudioPlayerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [self.avAudioPlayerItem.asset cancelLoading];
    [self.avAudioPlayerItem cancelPendingSeeks];
}
//添加通知消息和KVO监听
- (void)initNotificationAndKVO
{
    // 进入后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(JYWPause) name:UIApplicationDidEnterBackgroundNotification object:nil];
    // 回到前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(JYWPlay) name:UIApplicationWillEnterForegroundNotification object:nil];
    //播放完一遍
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:self.avAudioPlayerItem];
    [self.avAudioPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.avAudioPlayerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [self.avAudioPlayerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    [self.avAudioPlayerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
}
//KVO监听播放状态回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:
(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        //取出status的新值
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey]intValue];
        switch (status) {
            case AVPlayerItemStatusFailed:
                NSLog(@"item 有误");
                if([_delegate respondsToSelector:@selector(JYWAudioPlayer_ErrorMessage:)])
                {
                    [_delegate JYWAudioPlayer_ErrorMessage:@"AVPlayerItem 有误"];
                }
                break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"准备好了");
                if([_delegate respondsToSelector:@selector(JYWAudioPlayer_ReadyMessage:)])
                {
                    [_delegate JYWAudioPlayer_ReadyMessage:@"准好播放了"];
                }
                //滑块
                [self initSliderObserve];
                break;
            case AVPlayerItemStatusUnknown:
                if([_delegate respondsToSelector:@selector(JYWAudioPlayer_ErrorMessage:)])
                {
                    [_delegate JYWAudioPlayer_ErrorMessage:@"视频资源出现未知错误"];
                }
                break;
            default:
                break;
        }
    }
    else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {  //监听播放器的下载进度
        
        NSArray *loadedTimeRanges = [self.avAudioPlayerItem loadedTimeRanges];
        // 获取缓冲区域
        CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        // 计算缓冲总进度
        NSTimeInterval timeInterval = startSeconds + durationSeconds;
        CMTime duration = self.avAudioPlayerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        self.audioProgressView.progress= timeInterval / totalDuration;
        
        
    } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) { //监听播放器在缓冲数据的状态
        
        NSLog(@"缓冲不足暂停了");
        [self JYWPause];
        //开启加载转子，并显示
        //[self.jywPlayerToobarView.animationView startAnimation];
        //self.jywPlayerToobarView.animationView.hidden=NO;
        
    } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
        NSLog(@"缓冲达到可播放程度了");
        //暂停加载转子，并隐藏
        //[self.jywPlayerToobarView.animationView stopAnimation];
        //self.jywPlayerToobarView.animationView.hidden=YES;
        //[self JYW_Play];
        
    }
}
//播放完毕
-(void)playerItemDidReachEnd{
    NSLog(@"播放完毕");
    //让播放进度回到0
    [self.avAudioPlayer seekToTime:kCMTimeZero];
    //self.jywPlayerToobarView.playSlider.value=0;
    [self JYWPause];
    if(_delegate && [_delegate respondsToSelector:@selector(JYWAudioPlayer_PlayEnd)])
    {
        [_delegate JYWAudioPlayer_PlayEnd];
    }
}
# pragma mark -播放进度同步UISlider
-(void)initSliderObserve{
    //总播放时长
    Float64 pt=CMTimeGetSeconds(self.avAudioPlayer.currentItem.duration);
    self.jywAudioPlayerViewConfig.playTime=pt;
    self.jywAudioPlayerViewConfig.playTimeStr=[self.jywAudioPlayerViewConfig secondTurnTime:pt];
    
    self.playTimeLabel.text=[NSString stringWithFormat:@"%@/00:00",self.jywAudioPlayerViewConfig.playTimeStr];
    
    
    //用弱引用避免互相引用
    __weak typeof(self) weakSelf = self;
    //对于1分钟以内的视频就每1/30秒刷新一次页面，大于1分钟的每秒一次就行
    CMTime interval = pt > 60 ? CMTimeMake(1, 1) : CMTimeMake(1, 30);
    //这个方法就是每隔多久调用一次block，函数返回的id类型的对象在不使用时用-removeTimeObserver:释放，官方api是这样说的
    playerObserve = [self.avAudioPlayer addPeriodicTimeObserverForInterval:interval queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        CGFloat currentTime=CMTimeGetSeconds(time);
        NSString *playTimeNowStr=[weakSelf.jywAudioPlayerViewConfig secondTurnTime:currentTime];
        weakSelf.playTimeLabel.text=[NSString stringWithFormat:@"%@/%@'",weakSelf.jywAudioPlayerViewConfig.playTimeStr,playTimeNowStr];
        //weakSelf.jyw_AVPlayerToobarView.playTimeNowLabel.text=[NSString stringWithFormat:@"%.0f'",CMTimeGetSeconds(self.avPlayer.currentItem.currentTime)];
        weakSelf.audioPlayerSlider.value = CMTimeGetSeconds(weakSelf.avAudioPlayer.currentItem.currentTime)/ CMTimeGetSeconds(weakSelf.avAudioPlayer.currentItem.duration);
    }];
}
# pragma mark -懒加载
-(UIProgressView *)audioProgressView{
    if(_audioProgressView==nil){
        _audioProgressView=[[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 2)];
        _audioProgressView.progress=0;
        _audioProgressView.progressTintColor=[UIColor greenColor];
    }
    return _audioProgressView;
}

-(UISlider *)audioPlayerSlider{
    if(_audioPlayerSlider==nil){
        _audioPlayerSlider=[[UISlider alloc] initWithFrame:CGRectMake(-1, 0, self.frame.size.width+1, 2)];
        [_audioPlayerSlider setThumbImage:[UIImage imageNamed:@"round"] forState:UIControlStateHighlighted];
        [_audioPlayerSlider setThumbImage:[UIImage imageNamed:@"round"] forState:UIControlStateNormal];
        _audioPlayerSlider.maximumValue=1;
        [_audioPlayerSlider addTarget:self action:@selector(playSlider_TouchDown:) forControlEvents:UIControlEventTouchDown];
        [_audioPlayerSlider addTarget:self action:@selector(playSlider_TouchUp:) forControlEvents:UIControlEventTouchUpInside];
        [_audioPlayerSlider addTarget:self action:@selector(playSlider_TouchUp:) forControlEvents:UIControlEventTouchUpOutside];
        [_audioPlayerSlider addTarget:self action:@selector(playSlider_ValueChange:) forControlEvents:UIControlEventValueChanged];
        
        audioPlayerSlider_Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(audioPlayerSlider_Tap:)];
        [audioPlayerSlider_Tap setNumberOfTouchesRequired:1];
        [_audioPlayerSlider addGestureRecognizer:audioPlayerSlider_Tap];
         
    }
    return _audioPlayerSlider;
}
-(UIButton*)playAndStopButton{
    if(_playAndStopButton==nil){
        _playAndStopButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _playAndStopButton.frame=CGRectMake(self.frame.size.width/2-20, 40, 40, 40);
        [_playAndStopButton setImage:[UIImage imageNamed:@"play1Btn"] forState:UIControlStateNormal];
        [_playAndStopButton setImage:[UIImage imageNamed:@"pauseBtn"] forState:UIControlStateSelected];
        [_playAndStopButton addTarget:self action:@selector(playAndStopButton_Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playAndStopButton;
}
-(UIButton*)upButton{
    if(_upButton==nil){
        _upButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _upButton.frame=CGRectMake(self.frame.size.width/4-15, 45, 30, 30);
        [_upButton setImage:[UIImage imageNamed:@"upBtn"] forState:UIControlStateNormal];
        [_upButton addTarget:self action:@selector(upButton_Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _upButton;
}
-(UIButton*)nextButton{
    if(_nextButton==nil){
        _nextButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.frame=CGRectMake(self.frame.size.width/4*3-15, 45, 30, 30);
        
        [_nextButton setImage:[UIImage imageNamed:@"nextBtn"] forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(nextButton_Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}
-(UILabel*)playTimeLabel{
    if(_playTimeLabel==nil){
        _playTimeLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 20)];
        _playTimeLabel.text=@"00:00/00:00";
        _playTimeLabel.textColor=[UIColor grayColor];
        _playTimeLabel.font=[UIFont systemFontOfSize:12.0f];
        _playTimeLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _playTimeLabel;
}
#pragma mark -事件
//playSlider 滑块手势点击事件
-(IBAction)audioPlayerSlider_Tap:(UITapGestureRecognizer *)sender{
    CGPoint touchPoint = [sender locationInView:self.audioPlayerSlider];
    CGFloat value = touchPoint.x / CGRectGetWidth(self.audioPlayerSlider.bounds);
    [self.audioPlayerSlider setValue:value animated:YES];
    [self audioPlayerValueChange:value];
}

//播放器滑块点下事件
-(IBAction)playSlider_TouchDown:(id)sender{
    audioPlayerSlider_Tap.enabled=NO;
    [self JYWPause];
}
//playSlider 滑块抬起事件
-(IBAction)playSlider_TouchUp:(id)sender{
    audioPlayerSlider_Tap.enabled=YES;
    [self JYWPlay];
}
//playSlider滑块值变化事件
-(IBAction)playSlider_ValueChange:(UISlider *)sender{
    [self audioPlayerValueChange:self.audioPlayerSlider.value];
}
-(void)audioPlayerValueChange:(Float64)value{
    CMTime time=CMTimeMake(CMTimeGetSeconds(self.avAudioPlayerItem.duration)*value,1);
    [self.avAudioPlayer seekToTime:time];
}
//播放/停止点击事件
-(IBAction)playAndStopButton_Click:(UIButton *)btn{
    if(self.playAndStopButton.selected==YES){
        self.playAndStopButton.selected=YES;
        [self JYWPause];
    }
    else{
        self.playAndStopButton.selected=NO;
        [self JYWPlay];
    }
}
//上一集点击事件
-(IBAction)upButton_Click:(UIButton *)btn{
    if(_delegate && [_delegate respondsToSelector:@selector(JYWAudioPlayer_Up)])
    {
        [_delegate JYWAudioPlayer_Up];
    }
}
//下一集点击事件
-(IBAction)nextButton_Click:(UIButton *)btn{
    if(_delegate && [_delegate respondsToSelector:@selector(JYWAudioPlayer_Next)])
    {
        [_delegate JYWAudioPlayer_Next];
    }
}
@end
