//
//  JYW_SelectAudioView.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/29.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//代理
@protocol JYW_SelectAudioView_Delegate <NSObject>
-(void)JYW_SelectAudioView_LabelClick:(long)index;
@end
@interface JYW_SelectAudioView : UIView
{
    IBOutlet UIScrollView *audioScrollView;
    
}
//设置view上的选集按钮
-(void)setViewControlWithAudioCount:(int)audioCount NumberOfAudiosPerLabel:(int)noapl;
@property (nonatomic,weak)id<JYW_SelectAudioView_Delegate>delegate;//声明
@end

NS_ASSUME_NONNULL_END
