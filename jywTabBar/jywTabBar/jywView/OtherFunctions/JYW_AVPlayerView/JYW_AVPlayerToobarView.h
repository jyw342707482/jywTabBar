//
//  JYW_AVPlayerToobarView.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/6.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYW_AVPlayerModel.h"
NS_ASSUME_NONNULL_BEGIN
//委托代理
@protocol JYW_AVPlayerToobarView_Delegate <NSObject>
//播放/暂停按钮点击事件
-(void)JYW_AVPlayerToobarView_StartAndEndPlayButton_Click;
//分享按钮点击事件
-(void)JYW_AVPlayerToobarView_ShareButton_Click;
//全屏/窗口按钮点击事件
-(void)JYW_AVPlayerToobarView_FullScreenButton_Click;
//返回按钮点击事件
-(void)JYW_AVPlayerToobarView_BackButton_Click;
@end
@interface JYW_AVPlayerToobarView : UIView
{
    JYW_AVPlayerModel *jyw_AVPlayerModel;
}
@property(nonatomic,strong) IBOutlet UIView *titleView;//标题
@property(nonatomic,strong) IBOutlet UILabel *titleLabel;//标题
@property(nonatomic,strong) IBOutlet UIButton *backButton;//返回按钮

@property(nonatomic,strong) IBOutlet UIView *toobarView;//播放工具条
@property(nonatomic,strong) IBOutlet UIButton *startAndEndPlayButton;//播放/暂停按钮
@property(nonatomic,strong) IBOutlet UIButton *fullScreenButton;//全屏/小窗口按钮
@property(nonatomic,strong) IBOutlet UIProgressView *bufferProgressView;//缓冲进度条
@property(nonatomic,strong) IBOutlet UISlider *playSlider;//快进/快退滑块
@property(nonatomic,strong) IBOutlet UILabel *playTimeLabel;//播放总时间
@property(nonatomic,strong) IBOutlet UILabel *playTimeNowLabel;//当前播放时长

-(instancetype)initWithJYW_AVPayerModel:(JYW_AVPlayerModel*)avPlayerModel;
@property (nonatomic,weak)id<JYW_AVPlayerToobarView_Delegate>delegate;//声明

@end

NS_ASSUME_NONNULL_END
