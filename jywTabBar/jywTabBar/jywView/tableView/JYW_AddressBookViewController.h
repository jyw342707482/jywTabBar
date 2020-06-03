//
//  JYW_AddressBookViewController.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/1.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYW_AddressBookViewController : UIViewController
{
    IBOutlet UITableView *addressBookTableView;//通讯录分组列表
    IBOutlet UITableView *letterTableView;//字母分组列表
}

@end

NS_ASSUME_NONNULL_END
