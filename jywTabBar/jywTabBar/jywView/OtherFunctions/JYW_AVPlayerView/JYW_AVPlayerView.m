//
//  JYW_AVPlayerView.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/6.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_AVPlayerView.h"
@implementation JYW_AVPlayerView
//根据父窗体大小，决定窗口大小
-(instancetype)initWithJYW_AVPayerModel:(JYW_AVPlayerModel*)avPlayerModel superViewController:(UIViewController*)sVC{
    self=[super init];
    if(self){
        jyw_AVPlayerModel=avPlayerModel;
        fullScreenOrWindow=0;
        self.superVC=sVC;
        [self createControls];
    }
    return self;
}
//根据父窗体大小，决定窗口大小，是否自动播放
-(instancetype)initWithJYW_AVPayerModel:(JYW_AVPlayerModel*)avPlayerModel  Autoplay:(BOOL)ap superViewController:(UIViewController*)sVC{
    self=[super init];
    if(self){
        jyw_AVPlayerModel=avPlayerModel;
        autoplay=ap;
        fullScreenOrWindow=0;
        self.superVC=sVC;
        [self createControls];
    }
    return self;
}
/*
如果要设置AVPlayerLayer的布局，目前iOS不支持layer设置AutoLayout，也不支持autoresizingMask，所以无法给playerLayer设置约束，当然可以采用原始的方法，就是在viewDidLayoutSubviews中再次设置playerLayer的frame，但是这样在屏幕旋转时会有一片短暂的空白区域，虽然很快就消失了，但是这样效果不是很好。

解决方案: 通过UIView来处理，自定义一个UIView的子类，设置这个view的layerClass为AVPlayerLayer类型，然后直接使用这个子类的layer作为AVPlayerLayer，那么此时不需要设置playerLayer的frame，设置这个view的约束或frame即可。
https://www.jianshu.com/p/f22c5d6d80af
**/
+ (Class)layerClass {
    return [AVPlayerLayer class];
}
//创建播放器、播放工具条
-(void)createControls{
    
    //创建工具条
    jyw_AVPlayerToobarView=[[JYW_AVPlayerToobarView alloc] initWithJYW_AVPayerModel:jyw_AVPlayerModel];
    jyw_AVPlayerToobarView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.0f];
    jyw_AVPlayerToobarView.translatesAutoresizingMaskIntoConstraints=NO;
    jyw_AVPlayerToobarView.delegate=self;
    [self addSubview:jyw_AVPlayerToobarView];
    //创建播放器
    //如果要切换视频需要调AVPlayer的replaceCurrentItemWithPlayerItem:方法
    avPlayerItem=[AVPlayerItem playerItemWithURL:jyw_AVPlayerModel.getFilePath];
    
    avPlayer = [AVPlayer playerWithPlayerItem:avPlayerItem];
    //视频播放是否阻止显示和设备休眠
    //avPlayer.preventsDisplaySleepDuringVideoPlayback=YES;
    avPlayerLayer =(AVPlayerLayer*)self.layer;
    //显示播放器
    [avPlayerLayer setPlayer:avPlayer];
    //通过KVO来观察status属性的变化，来获得播放之前的错误信息
    [avPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)updateConstraints NS_AVAILABLE_IOS(6_0) NS_REQUIRES_SUPER{
    [super updateConstraints];
    [self addSelfViewConstraint];
    [self addToobarViewConstraint];
}
//设置当前播放器窗口的Constraint
-(void)addSelfViewConstraint{
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
-(void)addToobarViewConstraint{
    //设置jyw_AVPlayerToobarView（播放工具条）
    //设置左停靠
    [self addConstraint:[NSLayoutConstraint constraintWithItem:jyw_AVPlayerToobarView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:jyw_AVPlayerToobarView.superview attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    //设置右停靠
    [self addConstraint:[NSLayoutConstraint constraintWithItem:jyw_AVPlayerToobarView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:jyw_AVPlayerToobarView.superview attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    //设置下停靠
    [self addConstraint:[NSLayoutConstraint constraintWithItem:jyw_AVPlayerToobarView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:jyw_AVPlayerToobarView.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    //设置上停靠
    [self addConstraint:[NSLayoutConstraint constraintWithItem:jyw_AVPlayerToobarView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:jyw_AVPlayerToobarView.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
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
                if([_delegate respondsToSelector:@selector(JYW_AVPlayerView_ErrorMessage:)])
                {
                    [_delegate JYW_AVPlayerView_ErrorMessage:@"AVPlayerItem 有误"];
                }
                break;
            case AVPlayerItemStatusReadyToPlay:
                
                if([_delegate respondsToSelector:@selector(JYW_AVPlayerView_ReadyMessage:)])
                {
                    [_delegate JYW_AVPlayerView_ReadyMessage:@"准好播放了"];
                }
                //jyw_AVPlayerModel
                //获取总播放时长
                long pt=avPlayerItem.duration.value /avPlayerItem.duration.timescale;
                
                if(avPlayerItem.duration.value %avPlayerItem.duration.timescale>0)
                {
                    pt++;
                }
                [jyw_AVPlayerModel setPlayTime:pt];
                /*
                playSlider.maximumValue = vm.videoDuration;
                [startAndEndPlayButton setTitle:@"暂停" forState:UIControlStateNormal];
                startAndEndPlayButton.enabled=YES;
                timeLabel.text=[NSString stringWithFormat:@"00:00:00/%@",vm.videoDurationStr];
                [self addPeriodicTimeObserver];
                 */
                
                if(autoplay){
                    [self JYW_Play];
                }
                break;
            case AVPlayerItemStatusUnknown:
                if([_delegate respondsToSelector:@selector(JYW_AVPlayerView_ErrorMessage:)])
                {
                    [_delegate JYW_AVPlayerView_ErrorMessage:@"视频资源出现未知错误"];
                }
                break;
            default:
                break;
        }
    }
    //移除监听（观察者）
    [object removeObserver:self forKeyPath:@"status"];
}
# pragma -Mark -播放/暂停
//开始播放
-(void)JYW_Play{
    [avPlayer play];
    [jyw_AVPlayerToobarView.startAndEndPlayButton setSelected:YES];
    nowPlaying=YES;
}
//暂停播放
-(void)JYW_Pause{
    [avPlayer pause];
    [jyw_AVPlayerToobarView.startAndEndPlayButton setSelected:NO];
    nowPlaying=NO;
}
//播放/暂停按钮点击事件
-(void)JYW_AVPlayerToobarView_StartAndEndPlayButton_Click{
    if(nowPlaying)
    {
        [self JYW_Pause];
    }
    else{
        [self JYW_Play];
    }
}

//播放速率
-(void)JYW_RateWithRateType:(RateType)type{
    switch (type) {
        case RateUp:
            if(avPlayer.rate==1)
            {
                avPlayer.rate=2;
            }
            break;
        case RateDown:
            if(avPlayer.rate==2)
            {
                avPlayer.rate=1;
            }
            break;
    }
}
# pragma Mark -全屏/窗口
/*
//全屏/窗口
-(void)JYW_FullScreenOrWindowWithType:(FullScreenOrWindowType)type{
    switch (type) {
        case Window:
            fullScreenOrWindow=0;
            [jyw_AVPlayerToobarView.fullScreenButton setSelected:NO];
            [self removeSelfConstraint];
            [self backWindow];
            break;
        case FullScreen:
            fullScreenOrWindow=1;
            [jyw_AVPlayerToobarView.fullScreenButton setSelected:YES];
            [self removeSelfConstraint];
            [self createFullScreenView];
            [self setCurrentDeviceOrientation];
            break;
    }
}*/
//移除当前view的约束
-(void)removeSelfConstraint
{
    NSArray *layeroutArray=[self.superview constraints];
    for(NSLayoutConstraint *lc in layeroutArray){
        if(lc.firstItem==self)
        {
            [self.superview removeConstraint:lc];
        }
    }
}
//创建全屏窗口
-(void)createFullScreenView{
    [self removeFromSuperview];
    if(self.fullScreenVC==nil)
    {
        self.fullScreenVC=[[UIViewController alloc] init];
    }
    [self.fullScreenVC.view addSubview:self];
    [self addSelfViewConstraint];
    /*
    self.superVC.navigationController.navigationBar.hidden=YES;
    self.superVC.tabBarController.tabBar.hidden=YES;
    self.superVC.tabBarController.tabBar.translucent=YES;
    [self.superVC.navigationController pushViewController:self.fullScreenVC animated:YES];
    */
    //全屏弹出
    self.fullScreenVC.modalPresentationStyle=UIModalPresentationFullScreen;
    [self.superVC presentViewController:self.fullScreenVC animated:YES completion:nil];
    
}
//取消全屏，返回窗口
-(void)backWindow{
    [self.windowView addSubview:self];
    [self addSelfViewConstraint];
    /*
    self.superVC.navigationController.navigationBar.hidden=NO;
    self.superVC.tabBarController.tabBar.hidden=NO;
    self.superVC.tabBarController.tabBar.translucent=NO;
    [self.fullScreenVC.navigationController popViewControllerAnimated:YES];
     */
    [self.fullScreenVC dismissViewControllerAnimated:YES completion:nil];
}
//调整view方向
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
//全屏/窗口按钮点击事件
-(void)JYW_AVPlayerToobarView_FullScreenButton_Click{
    if(fullScreenOrWindow==0)
    {
        fullScreenOrWindow=1;
        [jyw_AVPlayerToobarView.fullScreenButton setSelected:YES];
        [self removeSelfConstraint];
        [self createFullScreenView];
        [self setCurrentDeviceOrientationWithType:1];
    }
    else
    {
        fullScreenOrWindow=0;
        [jyw_AVPlayerToobarView.fullScreenButton setSelected:NO];
        [self removeSelfConstraint];
        [self backWindow];
        [self setCurrentDeviceOrientationWithType:0];
    }
}
//返回按钮点击事件
-(void)JYW_AVPlayerToobarView_BackButton_Click{
    [self JYW_AVPlayerToobarView_FullScreenButton_Click];
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
