//
//  JYWPlayerView.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/11.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYWPlayerView.h"
@implementation JYWPlayerViewConfig
//设置默认值
+(instancetype)defaultConfig{
    JYWPlayerViewConfig *config=[[JYWPlayerViewConfig alloc] init];
    //工具条自动隐藏时长
    config.toobarHiddenTime=5;
    //视频地址类型，0，本地，1，网络,默认0
    config.filePathType=0;
    return config;
}

-(void)setFilePathStr:(NSString *)filePathStr{
    _filePathStr=filePathStr;
    if(self.filePathType==0){
        self.filePath=[self getLocalURLWithFilePath:filePathStr];
    }
    else{
        self.filePath=[self getWebURLWithFilePath:filePathStr];
    }
}
-(void)setPlayTime:(Float64)playTime{
    _playTime=playTime;
    NSString *playTimeStr=[NSString stringWithFormat:@"%.0f",self.playTime];
    self.playTimeStr=[self playTimeFormat:[playTimeStr intValue]];
    self.playNowTimeFormat=[self playNowTimeFormat:self.playNowTimeFormatType];
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

//格式化总播放时长
-(NSString *)playTimeFormat:(long)t{
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",t/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(t%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",t%60];
    //format of time
    NSString *format_time=@"";
    //时间格式类型
    if(![str_hour isEqualToString:@"00"]){
        format_time =str_hour;
        // [NSString stringWithFormat:@"%@:%@",str_hour,format_time];
        self.playNowTimeFormatType=0;
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
        self.playNowTimeFormatType=1;
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
        self.playNowTimeFormatType=2;
    }
    return format_time;
}
//格式化总播放时长
-(NSString *)playNowTimeFormat:(int)type{
    if(type==0){
        return @"00:00:00";
    }
    else if(type==1){
        return @"00:00";
    }
    else{
        return @"00'";
    }
}
@end

@implementation JYWPlayerView
#pragma mark -重写layerClass
/*
如果要设置AVPlayerLayer的布局，目前iOS不支持layer设置AutoLayout，也不支持autoresizingMask，所以无法给playerLayer设置约束，当然可以采用原始的方法，就是在viewDidLayoutSubviews中再次设置playerLayer的frame，但是这样在屏幕旋转时会有一片短暂的空白区域，虽然很快就消失了，但是这样效果不是很好。

解决方案: 通过UIView来处理，自定义一个UIView的子类，设置这个view的layerClass为AVPlayerLayer类型，然后直接使用这个子类的layer作为AVPlayerLayer，那么此时不需要设置playerLayer的frame，设置这个view的约束或frame即可。
https://www.jianshu.com/p/f22c5d6d80af
**/

+ (Class)layerClass {
    return [AVPlayerLayer class];
}
#pragma mark -重写updateConstraints
- (void)updateConstraints NS_AVAILABLE_IOS(6_0) NS_REQUIRES_SUPER{
    [super updateConstraints];
    [self initPlayerViewConstraint];
    [self initToobarViewConstraint];
}
//注销KVO监听
-(void)JYW_DeallocKVO{
    [self.avPlayer removeTimeObserver:playerObserve];
    //移除进入后台消息通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    //移除回到前台消息通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    //移除视频播放完消息通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.avPlayerItem];
    
    //移除监听（观察者）
    [self.avPlayerItem removeObserver:self forKeyPath:@"status"];
    [self.avPlayerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.avPlayerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [self.avPlayerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [self.avPlayerItem.asset cancelLoading];
    [self.avPlayerItem cancelPendingSeeks];
    //[self.avPlayer.currentItem cancelPendingSeeks];
    //[self.avPlayer.currentItem.asset cancelLoading];
}
-(void)JYW_Dealloc{
    [self JYW_Pause];
    [self.jywPlayerToobarView removeFromSuperview];
    [self.avPlayerLayer removeFromSuperlayer];
    self.avPlayerLayer=nil;
    self.avPlayerItem=nil;
    self.avPlayer=nil;
    [self removeFromSuperview];
}
-(void)dealloc{
    
    //[self JYW_Dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame Config:(JYWPlayerViewConfig*)config{
    self=[super initWithFrame:frame];
    if(self){
        self.jywPlayerViewConfig=config;
        layouType=1;
        windowFrame=frame;
        [self initAVPlayerFrame:frame];
        [self initToobarView];
        [self initNotificationAndKVO];
    }
    return self;
}
//约束创建
-(instancetype)initWithConfig:(JYWPlayerViewConfig*)config{
    self=[super init];
    if(self){
        self.jywPlayerViewConfig=config;
        layouType=0;
        self.translatesAutoresizingMaskIntoConstraints=NO;
        [self initAVPlayerConstraint];
        [self initToobarView];
        [self initNotificationAndKVO];
    }
    return self;
}
-(instancetype)initWithTitle:(NSString *)titleStr filePath:(NSString *)filePathStr{
    self=[super init];
    if(self){
        self.jywPlayerViewConfig= [JYWPlayerViewConfig defaultConfig];
        self.jywPlayerViewConfig.title=titleStr;
        self.jywPlayerViewConfig.filePathStr=filePathStr;
        layouType=0;
        self.translatesAutoresizingMaskIntoConstraints=NO;
        [self initAVPlayerConstraint];
        [self initToobarView];
        [self initNotificationAndKVO];
    }
    return self;
}
#pragma mark -创建控件
//创建播放器
-(void)initAVPlayerFrame:(CGRect)frame{
    //创建播放器
    //如果要切换视频需要调AVPlayer的replaceCurrentItemWithPlayerItem:方法
    self.avPlayerItem=[AVPlayerItem playerItemWithURL:self.jywPlayerViewConfig.filePath];
    self.avPlayer = [AVPlayer playerWithPlayerItem:self.avPlayerItem];
    //视频播放是否阻止显示和设备休眠
    //avPlayer.preventsDisplaySleepDuringVideoPlayback=YES;
    //设置播放页面
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    //设置播放页面的大小
    self.avPlayerLayer.frame = frame;
    //设置播放窗口和当前视图之间的比例显示内容
    //layer.videoGravity = AVLayerVideoGravityResizeAspect;
    //添加播放视图到self.view
    [self.layer addSublayer:self.avPlayerLayer];
}
-(void)initAVPlayerConstraint{
    //创建播放器
    //如果要切换视频需要调AVPlayer的replaceCurrentItemWithPlayerItem:方法
    self.avPlayerItem=[AVPlayerItem playerItemWithURL:self.jywPlayerViewConfig.filePath];
    self.avPlayer = [AVPlayer playerWithPlayerItem:self.avPlayerItem];
    //视频播放是否阻止显示和设备休眠
    //avPlayer.preventsDisplaySleepDuringVideoPlayback=YES;
    self.avPlayerLayer =(AVPlayerLayer*)self.layer;
    //显示播放器
    [self.avPlayerLayer setPlayer:self.avPlayer];
}
//创建工具条
-(void)initToobarView{
    self.jywPlayerToobarView=[[JYWPlayerToobarView alloc] initWithTitle:self.jywPlayerViewConfig.title playTime:[NSString stringWithFormat:@"%.0f",self.jywPlayerViewConfig.playTime]];
    self.jywPlayerToobarView.delegate=self;
    self.jywPlayerToobarView.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:self.jywPlayerToobarView];
}
#pragma mark -KVO监听
//添加通知消息和KVO监听
- (void)initNotificationAndKVO
{
    // 进入后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(JYW_Pause) name:UIApplicationDidEnterBackgroundNotification object:nil];
    // 回到前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(JYW_Play) name:UIApplicationWillEnterForegroundNotification object:nil];
    //播放完一遍
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:self.avPlayerItem];
    [self.avPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.avPlayerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [self.avPlayerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    [self.avPlayerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    /*
    if (_needLoad) {
        [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        [self.playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
        [self.playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    }
     */
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
                if([_delegate respondsToSelector:@selector(JYWPlayerView_ErrorMessage:)])
                {
                    [_delegate JYWPlayerView_ErrorMessage:@"AVPlayerItem 有误"];
                }
                break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"准备好了");
                if([_delegate respondsToSelector:@selector(JYWPlayerView_ReadyMessage:)])
                {
                    [_delegate JYWPlayerView_ReadyMessage:@"准好播放了"];
                }
                //滑块
                [self initSliderObserve];
                //自动隐藏toobar工具条
                [self toobarShow];
                break;
            case AVPlayerItemStatusUnknown:
                if([_delegate respondsToSelector:@selector(JYWPlayerView_ErrorMessage:)])
                {
                    [_delegate JYWPlayerView_ErrorMessage:@"视频资源出现未知错误"];
                }
                break;
            default:
                break;
        }
    }
    else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {  //监听播放器的下载进度
        
        NSArray *loadedTimeRanges = [self.avPlayerItem loadedTimeRanges];
        // 获取缓冲区域
        CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        // 计算缓冲总进度
        NSTimeInterval timeInterval = startSeconds + durationSeconds;
        CMTime duration = self.avPlayerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        self.jywPlayerToobarView.playProgressView.progress= timeInterval / totalDuration;
        NSLog(@"下载进度：%.2f   %f  %f", timeInterval / totalDuration,timeInterval,totalDuration);
        /*
        //加载总进度，是否大于当前播放时间+5
        if(timeInterval>self.avPlayer.currentTime.value/self.avPlayer.currentTime.timescale+5){
            NSLog(@"缓冲时长大于播放时长");
            if(nowPlaying==NO){//当前是在暂停播放
                [self JYW_Play];
                NSLog(@"播放111");
            }
        }
        else{
            NSLog(@"缓冲时长小于播放时长");
        }*/
        //return self.avPlayerItem.value / self.avPlayerItem.timescale;
        /*
        if (timeInterval > self.getCurrentPlayingTime+5){ // 缓存 大于 播放 当前时长+5

            if ([self.status_playType  isEqual: @"等待播放"]) { // 接着之前 播放时长 继续播放
                [self.player play];
                self.status_playType = @"正在播放";
            }
        }else{
            self.status_playType = @"等待播放"; // 出现问题，等待播放
            NSLog(@"等待播放，网络出现问题");
        }
        */
        /*
        CGFloat timeee = [[NSString stringWithFormat:@"%.3f",timeInterval] floatValue];
        CGFloat totall = [[NSString stringWithFormat:@"%.3f",totalDuration] floatValue];
        
        if (timeee >= totall) {
            
            NSLog(@"下载wan");
            //[self stopAnimation];
            
            AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
            AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                                preferredTrackID:kCMPersistentTrackID_Invalid];
            AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                                preferredTrackID:kCMPersistentTrackID_Invalid];
            NSError *erroraudio = nil;
            //获取AVAsset中的音频 或 者视频
            AVAssetTrack *assetAudioTrack = [[self.avPlayerItem.asset tracksWithMediaType:AVMediaTypeAudio] firstObject];
            //向通道内加入音频或者视频
            [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, self.avPlayerItem.asset.duration)
                                ofTrack:assetAudioTrack
                                 atTime:kCMTimeZero
                                  error:&erroraudio];
            
            NSError *errorVideo = nil;
            AVAssetTrack *assetVideoTrack = [[self.avPlayerItem.asset tracksWithMediaType:AVMediaTypeVideo]firstObject];
            [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, self.avPlayerItem.asset.duration)
                                ofTrack:assetVideoTrack
                                 atTime:kCMTimeZero
                                  error:&errorVideo];
            
            AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                              presetName:AVAssetExportPresetPassthrough];
            
            exporter.outputURL = [NSURL fileURLWithPath:_savePath];;
            exporter.outputFileType = AVFileTypeMPEG4;
            exporter.shouldOptimizeForNetworkUse = YES;
            [exporter exportAsynchronouslyWithCompletionHandler:^{
                
                if( exporter.status == AVAssetExportSessionStatusCompleted && _needLoad){
                    NSLog(@"保存成功");
                    _needLoad = NO;
                    [self.playerItem removeObserver:self forKeyPath:@"status"];
                    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
                    [self.playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
                    [self.playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
                    //保存到相册（如果要保存到相册，需要先确认项目是否允许访问相册）
                    // UISaveVideoAtPathToSavedPhotosAlbum(_savePath, nil, nil, nil);
                    
                }else if( exporter.status == AVAssetExportSessionStatusFailed ){
                    
                    NSLog(@"保存shibai");
                }
            }];
        }*/
        
    } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) { //监听播放器在缓冲数据的状态
        
        NSLog(@"缓冲不足暂停了");
        [self JYW_Pause];
        //开启加载转子，并显示
        [self.jywPlayerToobarView.animationView startAnimation];
        self.jywPlayerToobarView.animationView.hidden=NO;
        
    } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
        
        NSLog(@"缓冲达到可播放程度了");
        //暂停加载转子，并隐藏
        [self.jywPlayerToobarView.animationView stopAnimation];
        self.jywPlayerToobarView.animationView.hidden=YES;
        [self JYW_Play];
        
    }
}
//播放完毕
-(void)playerItemDidReachEnd{
    NSLog(@"播放完毕");
    //让播放进度回到0
    [self.avPlayer seekToTime:kCMTimeZero];
    //self.jywPlayerToobarView.playSlider.value=0;
    [self JYW_Pause];
}
# pragma mark -播放进度同步UISlider
-(void)initSliderObserve{
    //jyw_AVPlayerToobarView.playTimeNowLabel.text=[NSString stringWithFormat:@"%.0f'",CMTimeGetSeconds(self.avPlayer.currentItem.currentTime)];
    //jyw_AVPlayerToobarView.playSlider.value = CMTimeGetSeconds(self.avPlayer.currentItem.currentTime)/ CMTimeGetSeconds(self.avPlayer.currentItem.duration);
    
    //总播放时长
    Float64 pt=CMTimeGetSeconds(self.avPlayer.currentItem.duration);
    self.jywPlayerViewConfig.playTime=pt;
    self.jywPlayerToobarView.playTimeLabel.text=self.jywPlayerViewConfig.playTimeStr;
    self.jywPlayerToobarView.playTimeNowLabel.text=self.jywPlayerViewConfig.playNowTimeFormat;
    self.jywPlayerToobarView.playTimeLabel.hidden=NO;
    self.jywPlayerToobarView.playTimeNowLabel.hidden=NO;
    
    //用弱引用避免互相引用
    __weak typeof(self) weakSelf = self;
    //对于1分钟以内的视频就每1/30秒刷新一次页面，大于1分钟的每秒一次就行
    CMTime interval = pt > 60 ? CMTimeMake(1, 1) : CMTimeMake(1, 30);
    //这个方法就是每隔多久调用一次block，函数返回的id类型的对象在不使用时用-removeTimeObserver:释放，官方api是这样说的
    playerObserve = [self.avPlayer addPeriodicTimeObserverForInterval:interval queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //CGFloat currentTime=CMTimeGetSeconds(time);
        weakSelf.jywPlayerToobarView.playTimeNowLabel.text=[NSString stringWithFormat:@"%.0f'",CMTimeGetSeconds(weakSelf.avPlayer.currentItem.currentTime)];
        //weakSelf.jyw_AVPlayerToobarView.playTimeNowLabel.text=[NSString stringWithFormat:@"%.0f'",CMTimeGetSeconds(self.avPlayer.currentItem.currentTime)];
        weakSelf.jywPlayerToobarView.playSlider.value = CMTimeGetSeconds(weakSelf.avPlayer.currentItem.currentTime)/ CMTimeGetSeconds(weakSelf.avPlayer.currentItem.duration);
    }];
}
#pragma mark -toobarView delegate
//播放/暂停按钮点击事件
-(void)JYWPlayerToobarView_StartAndEndPlayButton_Click{
    if(nowPlaying){
        [self JYW_Pause];
    }
    else
    {
        [self JYW_Play];
    }
}
//全屏/窗口按钮点击事件
-(void)JYWPlayerToobarView_FullScreenButton_Click{
    if(fullScreenOrWindow==0)
    {
        fullScreenOrWindow=1;
        [self.jywPlayerToobarView.fullScreenButton setSelected:YES];
        //[self removeSelfConstraint];
        [self JYW_FullScreen];
        [self setCurrentDeviceOrientationWithType:1];
    }
    else
    {
        fullScreenOrWindow=0;
        [self.jywPlayerToobarView.fullScreenButton setSelected:NO];
        //[self removeSelfConstraint];
        [self backWindow];
        //[self setCurrentDeviceOrientationWithType:0];
    }
}
//返回按钮点击事件
-(void)JYWPlayerToobarView_BackButton_Click{
    [self JYWPlayerToobarView_FullScreenButton_Click];
}
//调整播放进度
-(void)JYWPlayerToobarView_ChangePlayProgress:(float)playProgress{
    float fps = [[[self.avPlayer.currentItem.asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] nominalFrameRate];
    CMTime time = CMTimeMakeWithSeconds(CMTimeGetSeconds(self.avPlayer.currentItem.duration) * playProgress, fps);
    //[self.avPlayer seekToTime:time];
    [self.avPlayer seekToTime:time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}
//播放器滑块点下事件
-(void)JYWPlayerToobarView_PlaySlider_TouchDown{
    [self JYW_Pause];
}
//播放器滑块抬起事件
-(void)JYWPlayerToobarView_PlaySlider_TouchUp{
    [self JYW_Play];
}
# pragma mark -JYWPlayerViewdelegate
//播放总时长更改
-(void)playTime_ValueChange:(NSString*)valueStr{
    self.jywPlayerToobarView.playTimeLabel.text=valueStr;
}
//播放时长格式类型更改
-(void)playTimeType_ValueChange:(NSString*)valueStr{
    self.jywPlayerToobarView.playTimeNowLabel.text=valueStr;
}
#pragma mark -方法
//开始播放
-(void)JYW_Play{
    [self.avPlayer play];
    [self.jywPlayerToobarView.startAndEndPlayButton setSelected:YES];
    [self.jywPlayerToobarView.toobarPlayButton setSelected:YES];
    //是否正在播放no暂停，yes播放
    nowPlaying=YES;
}
//暂停播放
-(void)JYW_Pause{
    [self.avPlayer pause];
    [self.jywPlayerToobarView.startAndEndPlayButton setSelected:NO];
    [self.jywPlayerToobarView.toobarPlayButton setSelected:NO];
    nowPlaying=NO;
}
//替换视频
-(void)JYW_ReplaceVideoWithTitleStr:(NSString*)title VideoFilePath:(NSString*)filePath{
    //[self JYW_DeallocKVO];
    self.jywPlayerViewConfig.title=title;
    self.jywPlayerViewConfig.filePathStr=filePath;
    self.jywPlayerToobarView.titleLabel.text=self.jywPlayerViewConfig.title;
    [self toobarShow];
    self.avPlayerItem=[AVPlayerItem playerItemWithURL:self.jywPlayerViewConfig.filePath];
    [self.avPlayer replaceCurrentItemWithPlayerItem:self.avPlayerItem];
    [self initNotificationAndKVO];
    
}
//全屏/窗口
-(void)JYW_FullScreen{
    [self removeFromSuperview];
    if(self.jywPlayerViewConfig.fullScreenVC==nil)
    {
        self.jywPlayerViewConfig.fullScreenVC=[[JYW_PlayerFullScreenViewController alloc] init];
    }
    self.jywPlayerToobarView.titleLabelLeadingConstraint.constant=40;
    [self.jywPlayerViewConfig.fullScreenVC.view addSubview:self];
    //全屏弹出
    self.jywPlayerViewConfig.fullScreenVC.modalPresentationStyle=UIModalPresentationFullScreen;
    [self.jywPlayerViewConfig.superVC presentViewController:self.jywPlayerViewConfig.fullScreenVC animated:YES completion:nil];
    self.jywPlayerToobarView.backButton.hidden=NO;
    if(layouType==ConstraintType){
        [self initPlayerViewConstraint];
    }
    else{
        self.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        self.avPlayerLayer.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
     
    [self setCurrentDeviceOrientationWithType:1];
    
        
    //[self addSelfViewConstraint];
    /*
    self.superVC.navigationController.navigationBar.hidden=YES;
    self.superVC.tabBarController.tabBar.hidden=YES;
    self.superVC.tabBarController.tabBar.translucent=YES;
    [self.superVC.navigationController pushViewController:self.fullScreenVC animated:YES];
    */
    
}
//取消全屏，返回窗口
-(void)backWindow{
    [self removeFromSuperview];
    [self.jywPlayerViewConfig.fullScreenVC dismissViewControllerAnimated:YES completion:nil];
    self.jywPlayerToobarView.titleLabelLeadingConstraint.constant=15;
    [self.jywPlayerViewConfig.superView addSubview:self];
    [self setCurrentDeviceOrientationWithType:1];
    self.jywPlayerToobarView.backButton.hidden=YES;
    if(layouType==FrameType)
    {
        self.frame=windowFrame;
        self.avPlayerLayer.frame=windowFrame;
    }
    else
    {
        [self initPlayerViewConstraint];
    }
    
}
//type:0竖屏，1横屏
-(void)setCurrentDeviceOrientationWithType:(NSInteger)type{
    if(type==0)
    {
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
        /*if([UIDevice currentDevice].orientation != UIDeviceOrientationPortrait){
            NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
            [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
        }*/
    }
    else{
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
        /*if([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait){
            NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
            [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
        }*/
    }
}
#pragma mark -工具toobar自动隐藏
-(void)initTimer{
    toobarHiddenTimer=[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(toobarHidden) userInfo:nil repeats:NO];
}
//工具条隐藏
-(void)toobarHidden{
    [toobarHiddenTimer invalidate];
    toobarHiddenTimer=nil;
    self.jywPlayerToobarView.toobarView.hidden=YES;
    self.jywPlayerToobarView.titleView.hidden=YES;
    self.jywPlayerToobarView.toobarPlayButton.hidden=YES;
}
//工具条显示
-(void)toobarShow{
    [self initTimer];
    self.jywPlayerToobarView.toobarView.hidden=NO;
    self.jywPlayerToobarView.titleView.hidden=NO;
    self.jywPlayerToobarView.toobarPlayButton.hidden=NO;
}
//Toobar点击事件，提供隐藏/显示入口
-(void)JYWPlayerToobarView_Click:(BOOL)show{
    if(show){
        [self toobarShow];
    }
    else{
        [self toobarHidden];
    }
}
#pragma mark -约束
//设置当前播放器窗口的Constraint
-(void)initPlayerViewConstraint{
    //设置当前播放窗口
    //设置左停靠
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    //设置右停靠
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    //设置上停靠
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    //设置下停靠
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
}
//设置jyw_AVPlayerToobarView的约束
-(void)initToobarViewConstraint{
    //设置jywPlayerToobarView（播放工具条）
    //设置左停靠
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.jywPlayerToobarView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.jywPlayerToobarView.superview attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    //设置右停靠
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.jywPlayerToobarView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.jywPlayerToobarView.superview attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    //设置下停靠
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.jywPlayerToobarView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.jywPlayerToobarView.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    //设置上停靠
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.jywPlayerToobarView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.jywPlayerToobarView.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
}
@end
