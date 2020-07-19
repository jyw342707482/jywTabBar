//
//  JYW_RuntimeExamplesViewController.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/15.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYW_RuntimeExamplesViewController : UIViewController
{
    IBOutlet UITextView *messageTextView;
}
@property NSString *value1;
@property (nonatomic, assign) NSTimeInterval jyw_acceptEventInterval; // 时间间隔
@end

NS_ASSUME_NONNULL_END
