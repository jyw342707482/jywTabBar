//
//  JYW_FictionTableViewController.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/27.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYW_FictionTableViewController : UIViewController
{
    
}
@property (weak, nonatomic) IBOutlet UIView *fictionStateView;
@property (weak, nonatomic) IBOutlet UILabel *audioLabel;//音频数量
@property (weak, nonatomic) IBOutlet UIView *fictionAudioListView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fictionAudioListViewConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fictionAudioListViewConstraintTop;


@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UIView *fictionAudioListBackgroundView;
@property (weak, nonatomic) IBOutlet UITableView *fictionTableView;

@end

NS_ASSUME_NONNULL_END
