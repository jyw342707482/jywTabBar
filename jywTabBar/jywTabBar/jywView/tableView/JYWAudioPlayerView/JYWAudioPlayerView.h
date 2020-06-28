//
//  JYWAudioPlayerView.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/25.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface JYWAudioPlayerViewConfig : NSObject
@property(nonatomic,copy) NSString *audioURLStr;
@property(nonatomic,strong) NSURL *audioURL;
@property(nonatomic,assign) NSInteger audioURLType;//音频地址类型，0：本地地址，1网络地址
@property(nonatomic,assign) Float64 playTime;//播放总时长
@property(nonatomic,copy)NSString *playTimeStr;//播放总时长(格式化)
@property(nonatomic,assign) Float64 playTimeNow;//当前播放位置
-(NSString*)secondTurnTime:(Float64)second;//秒转时间
//设置默认值
+(instancetype)defaultConfig;
@end



//代理
@protocol JYWAudioPlayer_Delegate <NSObject>
//播放错误提示
-(void)JYWAudioPlayer_ErrorMessage:(NSString*)errorMessage;
//播放器准备完毕
-(void)JYWAudioPlayer_ReadyMessage:(NSString*)message;
//播放完成
-(void)JYWAudioPlayer_PlayEnd;
//上一集
-(void)JYWAudioPlayer_Up;
//下一集
-(void)JYWAudioPlayer_Next;
@end
@interface JYWAudioPlayer : UIView
{
    id playerObserve;
    UITapGestureRecognizer *audioPlayerSlider_Tap;
}
@property(nonatomic,strong) UISlider *audioPlayerSlider;//播放进度条；
@property(nonatomic,strong) UIProgressView *audioProgressView;//下载进度条
@property(nonatomic,strong) UIButton *playAndStopButton;//播放/暂停按钮
@property(nonatomic,strong) UIButton *upButton;//上一首按钮
@property(nonatomic,strong) UIButton *nextButton;//下一首
@property(nonatomic,strong) UILabel *playTimeLabel;//播放时长

@property(nonatomic,strong) AVPlayer *avAudioPlayer;
@property(nonatomic,strong) AVPlayerItem *avAudioPlayerItem;
@property(nonatomic,strong) JYWAudioPlayerViewConfig *jywAudioPlayerViewConfig;
@property(nonatomic,assign) BOOL isPlaying;//是否是正在播放
@property(nonatomic,weak) id<JYWAudioPlayer_Delegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame JYWAudioPlayerViewConfig:(JYWAudioPlayerViewConfig *)jywAudioPlayerViewConfig;
//播放
-(void)JYWPlay;
//暂停播放
-(void)JYWPause;
//重新载入音频
-(void)JYWReLoadAudioWithURL:(NSString*)url;
@end

NS_ASSUME_NONNULL_END
