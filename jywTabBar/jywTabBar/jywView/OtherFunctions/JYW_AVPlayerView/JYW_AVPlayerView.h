//
//  JYW_AVPlayerView.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/6.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "JYW_AVPlayerToobarView.h"
#import "JYW_AVPlayerModel.h"
#import "JYW_AVPlayerFullScreenViewController.h"
NS_ASSUME_NONNULL_BEGIN

//c写法
typedef enum {
    Window = 0,
    FullScreen = 1
    
} FullScreenOrWindowType;
//oc写法
typedef NS_ENUM(NSInteger, RateType) {
    RateUp = 1,//快进+1
    RateDown = -1//快进-1
};
//委托代理
@protocol JYW_AVPlayerView_Delegate <NSObject>
//返回播放错误信息
-(void)JYW_AVPlayerView_ErrorMessage:(NSString*)errorMessage;
//返回播放状态准备完毕，可以播放了
-(void)JYW_AVPlayerView_ReadyMessage:(NSString*)message;
//分享按钮点击事件
-(void)JYW_AVPlayerView_ShareButton_Click;
@end
@interface JYW_AVPlayerView : UIView<JYW_AVPlayerToobarView_Delegate>
{
    JYW_AVPlayerToobarView *jyw_AVPlayerToobarView;
    JYW_AVPlayerModel *jyw_AVPlayerModel;
    float windowHeight;//窗口高度，小窗口，全屏时为0；
    
    AVPlayer *avPlayer;
    AVPlayerItem *avPlayerItem;
    AVPlayerLayer *avPlayerLayer;
    //当前view的父view
    UIView *currentSuperView;
    
    //是否正在播放no暂停，yes播放
    BOOL nowPlaying;
    //全屏，还是窗口
    FullScreenOrWindowType fullScreenOrWindow;
    //是否自动播放yes准备好后播放，no准备好后不播放
    BOOL autoplay;
    
    
}
# pragma Mark - 属性
//父窗体对象
@property (nonatomic,strong) UIViewController *superVC;
//全屏的窗口
@property (nonatomic,strong) UIViewController *fullScreenVC;
//窗口父view
@property (nonatomic,strong) UIView *windowView;



@property (nonatomic,weak)id<JYW_AVPlayerView_Delegate>delegate;//声明
//根据父窗体大小，决定窗口大小
-(instancetype)initWithJYW_AVPayerModel:(JYW_AVPlayerModel*)avPlayerModel superViewController:(UIViewController*)sVC;
//根据父窗体大小，决定窗口大小，是否自动播放
-(instancetype)initWithJYW_AVPayerModel:(JYW_AVPlayerModel*)avPlayerModel  Autoplay:(BOOL)ap superViewController:(UIViewController*)sVC;
//开始播放
-(void)JYW_Play;
//暂停播放
-(void)JYW_Pause;
//播放速率
-(void)JYW_RateWithRateType:(RateType)type;


@end

NS_ASSUME_NONNULL_END
