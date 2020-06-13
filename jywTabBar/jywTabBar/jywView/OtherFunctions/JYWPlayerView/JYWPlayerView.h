//
//  JYWPlayerView.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/11.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "JYW_PlayerFullScreenViewController.h"
#import "JYWPlayerToobarView.h"
NS_ASSUME_NONNULL_BEGIN
//c写法
typedef enum {
    Window = 0,
    FullScreen = 1
    
} FullScreenOrWindowType;
//oc写法
typedef NS_ENUM(NSInteger, LayoutType) {
    ConstraintType = 0,//约束
    FrameType = 1//cgRect
};
@interface JYWPlayerViewConfig : NSObject
//自动播放
//工具条自动隐藏时长,默认5秒
@property (nonatomic) int toobarHiddenTime;
//视频地址类型，0，本地，1，网络,默认0
@property (nonatomic) int filePathType;

//播放器添加到那个view上,父view
@property (nonatomic) UIView *superView;
//播放器所在的viewController,父窗体对象
@property (nonatomic) UIViewController *superVC;
//全屏的窗口对象
@property (nonatomic) JYW_PlayerFullScreenViewController *fullScreenVC;

//标题
@property (nonatomic,copy) NSString *title;
//地址str
@property (nonatomic,copy) NSString *filePathStr;
//地址url
@property (nonatomic,readwrite) NSURL *filePath;
//播放总时长
@property (nonatomic,readwrite) Float64 playTime;
//播放总时长，字符串类型
@property (nonatomic,readwrite) NSString *playTimeStr;
//播放时长类型0：00:00:00,1：00:00,2：00'
@property (nonatomic,readwrite) int playNowTimeFormatType;
//正在播放时长，格式化
@property (nonatomic,readwrite) NSString *playNowTimeFormat;
//设置默认值
+(instancetype)defaultConfig;
@end
//委托代理
@protocol JYWPlayerView_Delegate <NSObject>
//返回播放错误信息
-(void)JYWPlayerView_ErrorMessage:(NSString*)errorMessage;
//返回播放状态准备完毕，可以播放了
-(void)JYWPlayerView_ReadyMessage:(NSString*)message;
@end


@interface JYWPlayerView : UIView<JYWPlayerToobarView_Delegate>
{
    //全屏，还是窗口
    FullScreenOrWindowType fullScreenOrWindow;
    //布局方式,视用约束，还是用固定大小
    LayoutType layouType;
    //是否正在播放no暂停，yes播放
    BOOL nowPlaying;
    //工具栏隐藏时间控件
    NSTimer *toobarHiddenTimer;
    id playerObserve;
    //窗口frame;
    CGRect windowFrame;
    
}
//工具条自动隐藏时长
//@property (nonatomic,readwrite) int toobarHiddenTime;
//父窗体对象
//@property (nonatomic) UIViewController *superVC;
//窗口父view
//@property (nonatomic) UIView *windowView;
//全屏的窗口
//@property (nonatomic) JYW_PlayerFullScreenViewController *fullScreenVC;

@property (nonatomic,readwrite) JYWPlayerViewConfig *jywPlayerViewConfig;
@property (nonatomic) AVPlayer *avPlayer;
@property (nonatomic) AVPlayerItem *avPlayerItem;
@property (nonatomic) AVPlayerLayer *avPlayerLayer;
@property (nonatomic) JYWPlayerToobarView *jywPlayerToobarView;

-(instancetype)initWithFrame:(CGRect)frame Config:(JYWPlayerViewConfig*)config;
-(instancetype)initWithConfig:(JYWPlayerViewConfig*)config;
-(instancetype)initWithTitle:(NSString *)titleStr filePath:(NSString *)filePathStr;
@property (nonatomic,weak)id<JYWPlayerView_Delegate>delegate;//声明
-(void)initAVPlayerFrame;
//替换视频
-(void)JYW_ReplaceVideoWithTitleStr:(NSString*)title VideoFilePath:(NSString*)filePath;
//开始播放
-(void)JYW_Play;
//暂停播放
-(void)JYW_Pause;
//全屏/窗口
//-(void)JYW_FullScreen;
//注销
-(void)JYW_Dealloc;
//注销KVO监听
-(void)JYW_DeallocKVO;
//添加约束，
-(void)initPlayerViewConstraint;
-(void)initToobarViewConstraint;
@end

NS_ASSUME_NONNULL_END
