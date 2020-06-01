//
//  JYW_FictionTableViewCell.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/28.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYW_FictionModel.h"
NS_ASSUME_NONNULL_BEGIN

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
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(nonatomic,readwrite)JYW_FictionModel *fm;
@end

NS_ASSUME_NONNULL_END
