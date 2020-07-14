//
//  JYW_GroupEditViewController.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/11.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Contacts/Contacts.h>
NS_ASSUME_NONNULL_BEGIN
@protocol JYW_GroupEditViewController_Delegate <NSObject>

-(void)groupEditBack;

@end
@interface JYW_GroupEditViewController : UIViewController
{
    IBOutlet UIView *AddGroupView;
    IBOutlet UITextField *groupTextField;
    IBOutlet UILabel *messageLabel;
}
@property(nonatomic,assign) int editType;//0:Add,1修改
@property(nonatomic,strong) CNMutableGroup *contactGroup;
@property(nonatomic,weak) id<JYW_GroupEditViewController_Delegate> delegate;
@end

NS_ASSUME_NONNULL_END
