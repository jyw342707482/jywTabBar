//
//  JYW_ButtonDoubleClickViewController.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/19.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//防止UIButton按钮连击
//转载：https://blog.csdn.net/weixin_38735568/article/details/95939608
@interface JYW_ButtonDoubleClickViewController : UIViewController
{
    IBOutlet UIButton *btn;
}
@end

NS_ASSUME_NONNULL_END
