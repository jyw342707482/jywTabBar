//
//  JYW_GroupEditViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/11.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_GroupEditViewController.h"
#import "UIView+JYW_Border.h"
@interface JYW_GroupEditViewController ()

@end

@implementation JYW_GroupEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pageSetting];
}
#pragma mark -页面设置
-(void)pageSetting{
    [AddGroupView drawBottomBorderWithBorderWidth:0.5f borderColor:[UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1]];
    UIBarButtonItem *buttonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButton:)];
    self.navigationItem.rightBarButtonItem=buttonItem;
    if(self.editType==1)
    {
        groupTextField.text=self.contactGroup.name;
    }
}
-(void)navigationBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)saveButton:(id)sender{
    if([groupTextField.text isEqualToString:@""]){
        messageLabel.text=@"组名不能为空";
        return;
    }
    if([groupTextField.text length]>20){
        messageLabel.text=@"组名必须小于20个字符";
        return;
    }
    if(self.editType==0){
        [self addGroupWithName:groupTextField.text];
        if(_delegate && [_delegate respondsToSelector:@selector(groupEditBack)]){
            [_delegate groupEditBack];
            [self navigationBack];
        }
    }
    else{
        if([self.contactGroup.name isEqualToString:groupTextField.text]){
            return;
        }
        self.contactGroup.name=groupTextField.text;
        [self updateGroup:self.contactGroup];
        if(_delegate && [_delegate respondsToSelector:@selector(groupEditBack)]){
            [_delegate groupEditBack];
            [self navigationBack];
        }
    }
}
/**
 *  添加群组
 *
 *  @param name 群组的名称
 */
- (void)addGroupWithName:(NSString *)name{
    CNMutableGroup *group = [[CNMutableGroup alloc] init];
    group.name = name;
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest addGroup:group toContainerWithIdentifier:nil];
    // 写入
    CNContactStore *store = [[CNContactStore alloc] init];
    [store executeSaveRequest:saveRequest error:nil];
}
/**
 *  更新group
 *
 *  @param group 被更新的group
 */
- (void)updateGroup:(CNMutableGroup *)group{
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest updateGroup:group];
    // 写入
    CNContactStore *store = [[CNContactStore alloc] init];
    
    [store executeSaveRequest:saveRequest error:nil];
}
/*
Getting the Group Information 获取组信息
name 名称
组的名称。
identifier 识别码
设备上组的唯一标识符。
 
 
Generating Search Predicates for Groups
+ predicateForGroupsWithIdentifiers：
返回一个谓词以查找具有指定标识符的组。
+ predicateForGroupsInContainerWithIdentifier：
返回一个谓词以在指定容器中查找组。
+ predicateForSubgroupsInGroupWithIdentifier：
返回一个谓词，以查找指定父组中的子组。
 
 
Getting Group Related Keys 获取与组相关的密钥
CNGroupIdentifierKey
组的标识符。
CNGroupNameKey
组的名称。
*/

@end
