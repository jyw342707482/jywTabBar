//
//  JYWPlayerToobarView.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/11.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
//委托代理
@protocol JYWPlayerToobarView_Delegate <NSObject>
//Toobar点击事件，提供隐藏/显示入口
-(void)JYWPlayerToobarView_Click:(BOOL)show;
//播放/暂停按钮点击事件
-(void)JYWPlayerToobarView_StartAndEndPlayButton_Click;
//全屏/窗口按钮点击事件
-(void)JYWPlayerToobarView_FullScreenButton_Click;
//返回按钮点击事件
-(void)JYWPlayerToobarView_BackButton_Click;
//调整播放进度
-(void)JYWPlayerToobarView_ChangePlayProgress:(float)playProgress;
//播放器滑块点下事件
-(void)JYWPlayerToobarView_PlaySlider_TouchDown;
//播放器滑块抬起事件
-(void)JYWPlayerToobarView_PlaySlider_TouchUp;
@end
@interface JYWPlayerToobarView : UIView
@property(nonatomic) IBOutlet UIButton *toobarPlayButton;//暂停时的播放/暂停大图标
@property(nonatomic) IBOutlet UIView *titleView;//标题
@property(nonatomic) IBOutlet UILabel *titleLabel;//标题
@property(nonatomic) IBOutlet NSLayoutConstraint *titleLabelLeadingConstraint;
@property(nonatomic) IBOutlet UIButton *backButton;//返回按钮

@property(nonatomic) IBOutlet UIView *toobarView;//播放工具条
@property(nonatomic) IBOutlet UIButton *startAndEndPlayButton;//播放/暂停按钮
@property(nonatomic) IBOutlet UIButton *fullScreenButton;//全屏/小窗口按钮
@property(nonatomic) IBOutlet UIProgressView *bufferProgressView;//缓冲进度条

@property(nonatomic) IBOutlet UISlider *playSlider;//快进/快退滑块
@property(nonatomic) IBOutlet UIProgressView *playProgressView;//缓冲进度条
@property(nonatomic) IBOutlet UILabel *playTimeLabel;//播放总时间
@property(nonatomic) IBOutlet UILabel *playTimeNowLabel;//当前播放时长

@property(nonatomic) NSString *title;//标题
@property(nonatomic) NSString *playTime;//总播放时长
//playSlider播放滑块点击事件
@property UITapGestureRecognizer *playSlider_Tap;
@property (nonatomic,weak)id<JYWPlayerToobarView_Delegate>delegate;//声明
-(instancetype)initWithTitle:(NSString *)titleStr playTime:(NSString *)playTimeStr;
//重置视频播放数据
-(void)replaceWithTitle:(NSString *)titleStr playTime:(NSString *)playTimeStr;
@end

NS_ASSUME_NONNULL_END
