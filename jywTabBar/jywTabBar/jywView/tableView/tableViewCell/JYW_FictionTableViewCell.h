//
//  JYW_FictionTableViewCell.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/28.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYW_FictionModel.h"
#import "JYWGradeRing.h"
NS_ASSUME_NONNULL_BEGIN
//代理
@protocol JYW_FictionTableViewCell_Delegate <NSObject>
-(void)JYW_FictionTableViewCell_Finish:(long)index;
@end
@interface JYW_FictionTableViewCell : UITableViewCell
{
    //IBOutlet UIStackView *vStackView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIImageView *downloadStateImageView;
    IBOutlet UIImageView *fileSizeImageView;
    IBOutlet UILabel *fileSizeLabel;
    IBOutlet UIImageView *playingTimeImageView;
    IBOutlet UILabel *playingTimeLabel;
    IBOutlet UILabel *playedTimeLabel;
    JYWGradeRing *jywGradeRing;
    NSTimer *jywGradeRingTimer;
}
@property(nonatomic,readwrite)JYW_FictionModel *fm;
@property(nonatomic,weak) id<JYW_FictionTableViewCell_Delegate> delegate;
@end

NS_ASSUME_NONNULL_END
