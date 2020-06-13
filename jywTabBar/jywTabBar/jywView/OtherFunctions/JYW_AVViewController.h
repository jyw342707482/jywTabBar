//
//  JYW_AVViewController.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/11.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface JYW_AVViewController : UIViewController<UITableViewDelegate>
@property (nonatomic,strong) AVPlayer *avPlayer;
@property (nonatomic,strong) AVPlayerItem *avPlayerItem;
@property (nonatomic,strong) AVPlayerLayer *avPlayerLayer;
@property (nonatomic) IBOutlet UITableView *videoTableView;
@property (nonatomic) IBOutlet UIView *playerView;
@end

NS_ASSUME_NONNULL_END
