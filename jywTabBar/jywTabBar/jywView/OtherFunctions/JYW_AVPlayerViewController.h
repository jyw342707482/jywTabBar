//
//  JYW_AVPlayerViewController.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/5.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYW_AVPlayerViewController : UIViewController
{
    IBOutlet UIView *avPlayerBackGroundView;
    IBOutlet NSLayoutConstraint *avPlayerBackGroundViewHeight;
    IBOutlet UIView *avPlayerView;
    
    IBOutlet UIView *toobarBackGroundView;
    IBOutlet UIView *toobarView;//播放工具条
    IBOutlet UIButton *startAndEndPlayButton;//播放/暂停按钮
    IBOutlet UIButton *fullScreenButton;//全屏/小窗口按钮
    IBOutlet UIButton *shareButton;//分享按钮
    IBOutlet UIProgressView *bufferProgressView;//缓冲进度条
    IBOutlet UISlider *playSlider;//快进/快退滑块
    IBOutlet UILabel *timeLabel;//播放时间
}
@end

NS_ASSUME_NONNULL_END
