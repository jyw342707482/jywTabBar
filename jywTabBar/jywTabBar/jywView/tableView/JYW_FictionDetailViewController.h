//
//  JYW_FictionDetailViewController.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/24.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "JYW_FictionMainModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JYW_FictionDetailViewController : UIViewController<AVAudioPlayerDelegate>
{
    IBOutlet UIView *titleView;//标题
    IBOutlet NSLayoutConstraint *titleViewTopConstraint;
    IBOutlet UIView *backView;//返回view
    IBOutlet UILabel *titleLabel;//标题label
    
    IBOutlet UIImageView *coverImageView;//封面图
    IBOutlet UILabel *setTitleLabel;//集的标题
    IBOutlet UIView *playerView;//音频播放器控件容器
    IBOutlet UILabel *authorAndTypeOfLabel;//作者和作品类型
    IBOutlet UIButton *playButton;//播放/暂停按钮
    IBOutlet UIButton *downButton;//下一集
    IBOutlet UIButton *upButton;//上一集
}
@property (nonatomic,readwrite) JYW_FictionMainModel *jyw_FictionMainModel;
@end

NS_ASSUME_NONNULL_END
