//
//  JYW_SharedAddressBookViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/9.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_SharedAddressBookViewController.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

#import "JYW_GroupEditViewController.h"

static NSString *contactIdentifier=@"cellIdentifier";
static NSString *letterIdentifier=@"letterCellIdentifier";
@interface JYW_SharedAddressBookViewController ()<JYW_GroupEditViewController_Delegate,
CNContactViewControllerDelegate>
{
    CNContactStore *contactStore;
    NSMutableArray *contactsGroup;
    NSMutableArray *contactsArray;
}
@end

@implementation JYW_SharedAddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pageSetting];
    contactStore=[[CNContactStore alloc] init];
    [self initAddressBook];
}
#pragma mark -页面设置
-(void)pageSetting{
    UIBarButtonItem *rightButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(contactAdd:)];
    self.navigationItem.rightBarButtonItem=rightButtonItem;
}
//新建点击事件
-(IBAction)contactAdd:(id)sender{
    UIAlertController *alertView=[UIAlertController alertControllerWithTitle:@"" message:@"选择新建内容" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *alertAction1=[UIAlertAction actionWithTitle:@"新建组" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //跳转新页面
        JYW_GroupEditViewController *geView=[[JYW_GroupEditViewController alloc] init];
        geView.delegate=self;
        [self.navigationController pushViewController:geView animated:YES];
    }];
    UIAlertAction *alertAction2=[UIAlertAction actionWithTitle:@"新建联系人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        /*
        //跳转新页面
        CNMutableContact *cnContact=[[CNMutableContact alloc] init];
        CNContactViewController *cvc=[CNContactViewController viewControllerForNewContact:cnContact];
        cvc.delegate=self;
        [self.navigationController pushViewController:cvc animated:YES];
         */
        CNMutableContact *contact=[self initializeContact];
        [self addMemberWithContact:contact toGroup:contactsGroup[0]];
        //[self addContact:contact];
    }];
    [alertView addAction:alertAction2];
    [alertView addAction:alertAction1];
    [self presentViewController:alertView animated:NO completion:nil];
    
}
-(void)groupEditBack{
    //查询联系人组
    contactsGroup=(NSMutableArray *)[self queryGroup];
    [contactTableView reloadData];
}
- (void)contactViewController:(CNContactViewController *)viewController didCompleteWithContact:(CNContact *)contact{
    [viewController.navigationController popViewControllerAnimated:YES];
}
#pragma mark -tableViewDelegete
//返回节头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView==contactTableView){
        CNGroup *group=contactsGroup[section];
        UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        headerView.backgroundColor=[UIColor colorWithRed:213.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:1.0];
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(16, 0, 100, 40)];
        titleLabel.text=group.name;
        titleLabel.font=[UIFont systemFontOfSize:14];
        [headerView addSubview:titleLabel];
        
        UIButton *editButton=[UIButton buttonWithType:UIButtonTypeSystem];
        editButton.frame=CGRectMake(headerView.frame.size.width-56, 0, 40, 40);
        editButton.tag=section;
        [editButton setTitle:@"修改" forState:UIControlStateNormal];
        [editButton addTarget:self action:@selector(editButton_Clcik:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:editButton];
        return headerView;
    }
    else{
        UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGFLOAT_MIN)];
        return headerView;
    }
        
}
//返回节头部视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView==contactTableView){
        return 40;
    }
    else{
        return CGFLOAT_MIN;
    }
    
}
//返回节尾部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGFLOAT_MIN)];
    return footerView;
    
}
//返回节尾部视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
/*
- (CGFloat)tableView:(UITableView *)tableView heightForFooderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
    
    if(addressBookArray.count-1==section)
    {
        return 100;
    }
    else
    {
        return CGFLOAT_MIN;
    }
}
*/
//返回列表节数量
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==contactTableView){
        return contactsGroup.count;
    }
    else{
        return 1;
    }
}
//返回每节的行数量
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==contactTableView){
        NSArray *contactArray=contactsArray[section];
        return contactArray.count;
    }
    else{
        return 0;
    }
}
//返回每行高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if(tableView==contactTableView){
        return 50;
    }
    else{
        return 20;
    }
}
//返回每行的视图
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==contactTableView)
    {
        //重用单元格
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contactIdentifier];
        //初始化单元格
        if(cell == nil)
        {
            /*
             UITableViewCellStyle:
             UITableViewCellStyleDefault
             具有文本标签（黑色和左对齐）和可选图像视图的单元格的简单样式。
             UITableViewCellStyleValue1
             单元格的样式，在单元格的左侧带有标签，带有左对齐和黑色文本； 右侧是带有较小蓝色文本并且右对齐的标签。 设置应用程序使用此样式的单元格。
             UITableViewCellStyleValue2
             单元格的样式，该单元格的左侧具有标签，标签的文本右对齐且为蓝色； 单元格右侧的另一个标签是较小的文本，该文本左对齐并且为黑色。 “电话/联系人”应用程序使用此样式的单元格。
             UITableViewCellStyleSubtitle
             单元格的样式，该单元格的顶部带有左对齐标签，而其下方则是带有较小灰色文本的左对齐标签。
             */
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:contactIdentifier];
            //自带有两种基础的tableView样式，UITableViewCellStyleValue1、2. 后面的文章会讲解自定义样式
            /*
             accessoryType:
             UITableViewCellAccessoryNone、
             UITableViewCellAccessoryDisclosureIndicator、
             UITableViewCellAccessoryDetailDisclosureButton、
             UITableViewCellAccessoryCheckmark、
             UITableViewCellAccessoryDetailButton、
             */
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        NSArray *contactArray=contactsArray[indexPath.section];
        CNContact *contact=contactArray[indexPath.row];
        
        UIImage *img = [UIImage imageWithData:contact.imageData];
        cell.imageView.image = img;
        NSString *phoneStr=@"";
        NSArray *phoneNumbers=contact.phoneNumbers;
        if(phoneNumbers.count>0)
        {
            CNLabeledValue *label=contact.phoneNumbers[0];
            CNPhoneNumber *number=label.value;
            phoneStr=number.stringValue;
        }
        //添加图片
        cell.textLabel.text =[NSString stringWithFormat:@"%@(%@)",contact.givenName,phoneStr];
        
        
        return cell;
    }
    else
    {
        //重用单元格
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:letterIdentifier];
        //初始化单元格
        if(cell == nil)
        {
            /*
             UITableViewCellStyle:
             UITableViewCellStyleDefault
             具有文本标签（黑色和左对齐）和可选图像视图的单元格的简单样式。
             UITableViewCellStyleValue1
             单元格的样式，在单元格的左侧带有标签，带有左对齐和黑色文本； 右侧是带有较小蓝色文本并且右对齐的标签。 设置应用程序使用此样式的单元格。
             UITableViewCellStyleValue2
             单元格的样式，该单元格的左侧具有标签，标签的文本右对齐且为蓝色； 单元格右侧的另一个标签是较小的文本，该文本左对齐并且为黑色。 “电话/联系人”应用程序使用此样式的单元格。
             UITableViewCellStyleSubtitle
             单元格的样式，该单元格的顶部带有左对齐标签，而其下方则是带有较小灰色文本的左对齐标签。
             */
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:letterIdentifier];
            //自带有两种基础的tableView样式，UITableViewCellStyleValue1、2. 后面的文章会讲解自定义样式
            /*
             accessoryType:
             UITableViewCellAccessoryNone、
             UITableViewCellAccessoryDisclosureIndicator、
             UITableViewCellAccessoryDetailDisclosureButton、
             UITableViewCellAccessoryCheckmark、
             UITableViewCellAccessoryDetailButton、
             */
            //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        /*
        UIButton *letterButton=[UIButton buttonWithType:UIButtonTypeCustom];
        letterButton.tag=indexPath.row;
        letterButton.layer.masksToBounds=YES;
        letterButton.layer.cornerRadius=10;
        letterButton.frame=CGRectMake(0, 0, 20, 20);
        letterButton.backgroundColor=[UIColor clearColor];
        [letterButton setTitle:labelGroupArray[indexPath.row] forState:UIControlStateNormal];
        [letterButton setTitleColor:[UIColor colorWithRed:63.0/255.0 green:63.0/255.0 blue:63.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [letterButton setTitle:labelGroupArray[indexPath.row] forState:UIControlStateSelected];
        [letterButton setTitleColor:[UIColor colorWithRed:225.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateSelected];
        letterButton.titleLabel.font=[UIFont systemFontOfSize:12.0f];
        [letterButton addTarget:self action:@selector(letterButton_TouchDown:) forControlEvents:UIControlEventTouchDown];
        [letterButton addTarget:self action:@selector(letterButton_TouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        //添加关联属性
        objc_setAssociatedObject(letterButton, @"indexpath", indexPath,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        //OBJC_ASSOCIATION_RETAIN_NONATOMIC
        [cell.contentView addSubview:letterButton];
        cell.backgroundColor=[UIColor clearColor];
         */
        return cell;
    }
}
-(IBAction)editButton_Clcik:(UIButton*)sender{
    JYW_GroupEditViewController *gedvc=[[JYW_GroupEditViewController alloc] init];
    CNMutableGroup *mutableGroup=[contactsGroup[sender.tag] mutableCopy];
    gedvc.contactGroup=mutableGroup;
    gedvc.editType=1;
    [self.navigationController pushViewController:gedvc animated:YES];
}
/*
-(IBAction)letterButton_TouchDown:(UIButton *)sender{
    if(sender!=letterButtonSelected){
        letterButtonSelected.backgroundColor=[UIColor clearColor];
    }
    letterButtonSelected=sender;
    sender.selected=YES;
    sender.backgroundColor=[UIColor greenColor];
    //获取关联属性
    NSIndexPath *indexpath=objc_getAssociatedObject(letterButtonSelected, @"indexpath");
    
    JYW_AddressBookGroupModel *jywABGM=addressBookArray[indexpath.row];
    if(jywABGM.addressBookModelArray.count>0){
        //JYW_AddressBookModel *jywABM=jywABGM.addressBookModelArray[indexpath.row];
        //滑动到某一行
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexpath.row];
        [addressBookTableView scrollToRowAtIndexPath:scrollIndexPath
                                 atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}
-(IBAction)letterButton_TouchUpInside:(UIButton *)sender{
    sender.selected=NO;
    //sender.backgroundColor=[UIColor greenColor];
}
 */
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat tableHeaderViewHeight = CGRectGetHeight(addressBookTableView.tableHeaderView.bounds);
    // 差值 = 头视图高度 - 导航条高度
    if (offsetY >= tableHeaderViewHeight - 40) {
        // 顶部偏移距离：导航条高度
        addressBookTableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    } else {
        addressBookTableView.contentInset = UIEdgeInsetsZero;
    }
}*/
-(void)initAddressBook{
    /*
     CNAuthorizationStatusNotDetermined
     用户尚未选择应用程序是否可以访问联系人数据。
     CNAuthorizationStatusRestricted
     该应用程序无权访问联系人数据。用户可能无法更改此应用程序的状态，这可能是由于诸如家长控制之类的有效限制所致。
     CNAuthorizationStatusDenied
     用户明确拒绝访问该应用程序的联系数据。
     CNAuthorizationStatusAuthorized
     该应用程序有权访问联系人数据。
     */
    //获取权限状态
    switch ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts]) {
        case CNAuthorizationStatusNotDetermined:
            //用户尚未选择应用程序是否可以访问联系人数据。
            NSLog(@"还未授权。");
            //授权操作
            [self setAuthorize];
            break;
        case CNAuthorizationStatusRestricted:
            //该应用程序无权访问联系人数据。用户可能无法更改此应用程序的状态，这可能是由于诸如家长控制之类的有效限制所致。
            [self messageWithString:@"无权限，请去开启。"];
            break;
        case CNAuthorizationStatusDenied:
            //用户明确拒绝访问该应用程序的联系数据。
            [self messageWithString:@"已拒绝，需要去设置中开启。"];
            break;
        case CNAuthorizationStatusAuthorized:
            //该应用程序有权访问联系人数据。
            NSLog(@"已授权");
            //获取联系人
            [self getContacts];
            
            break;
        default:
            break;
    }
}
//授权操作
-(void)setAuthorize{
    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if(granted)
        {
            NSLog(@"已授权");
            //获取联系人
            [self getContacts];
        }
        else
        {
            NSLog(@"未授权");
        }
    }];
}
//获取联系人
-(void)getContacts{
    contactsGroup=(NSMutableArray*)[self queryGroup];
    contactsArray=[[NSMutableArray alloc] init];
    for(CNGroup *group in contactsGroup){
        NSArray *contactArray=[self queryContactWithGroupIdentifier:group.identifier];
        [contactsArray addObject:contactArray];
    }
    [contactTableView reloadData];
}
//提示
-(void)messageWithString:(NSString*)str{
    UIAlertController *messageAlert=[UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [messageAlert addAction:defaultAction];
    [self presentViewController:messageAlert animated:YES completion:nil];
}
#pragma mark -联系人操作（增、删、改）
/**
 *查询联系人
 *@param identifier，组唯一标识
 *@return 联系人的数组
 */
-(NSArray *)queryContactWithGroupIdentifier:(NSString*)identifier{
    CNContactStore *store = [[CNContactStore alloc] init];
    // 检索条件
    NSPredicate *predicate = [CNContact predicateForContactsInGroupWithIdentifier:identifier];
    // 提取数据
    NSArray *keyDescriptorArray=@[
        CNContactIdentifierKey,//唯一标识
        CNContactPreviousFamilyNameKey,//姓
        CNContactMiddleNameKey,//名
        CNContactGivenNameKey,//名称
        CNContactPhoneticFamilyNameKey,//姓拼音
        CNContactPhoneticGivenNameKey,//名拼音
        CNContactPhoneNumbersKey,//电话
        CNContactImageDataKey,//图片
        CNGroupIdentifierKey,//组标识
        CNGroupNameKey,//组名
    ];
    NSArray *contact = [store unifiedContactsMatchingPredicate:predicate keysToFetch:keyDescriptorArray error:nil];
    return contact;
}
/**
 *  设置联系人的基本属性
 *
 *  @return 返回联系人的对象
 */
- (CNMutableContact *)initializeContact{
    // 创建联系人对象
    CNMutableContact *contact = [[CNMutableContact alloc] init];
    // 设置联系人的头像
    // 设置联系人姓名
    contact.givenName=@"益伟";
    // 设置姓氏
    contact.familyName = @"姜";
    // 设置联系人邮箱
    CNLabeledValue *homeEmail = [CNLabeledValue labeledValueWithLabel:CNLabelHome value:@"12345qq.com"];
    CNLabeledValue *workEmail = [CNLabeledValue labeledValueWithLabel:CNLabelWork value:@"32467@sina.cn"];
    CNLabeledValue *otherEmail = [CNLabeledValue labeledValueWithLabel:CNLabelOther value:@"jjsjjs.com"];
    contact.emailAddresses = @[homeEmail,workEmail,otherEmail];
    // 设置机构名
    contact.organizationName = @"互联网";
    // 设置部门
    contact.departmentName = @"IT";
    // 设置工作的名称
    contact.jobTitle = @"ios";
    // 设置社会的简述
    CNSocialProfile *profile = [[CNSocialProfile alloc] initWithUrlString:@"12306.cn" username:@"Paul" userIdentifier:nil service:@"IT行业"];
    CNLabeledValue *socialProfile = [CNLabeledValue labeledValueWithLabel:CNSocialProfileServiceGameCenter value:profile];
    contact.socialProfiles = @[socialProfile];
    // 设置电话号码
    CNPhoneNumber *mobileNumber = [[CNPhoneNumber alloc] initWithStringValue:@"13800138000"];
    CNLabeledValue *mobilePhone = [[CNLabeledValue alloc] initWithLabel:CNLabelPhoneNumberMobile value:mobileNumber];
    contact.phoneNumbers = @[mobilePhone];
    // 设置与联系人的关系
    CNContactRelation *friend = [[CNContactRelation alloc] initWithName:@"朋友"];
    CNLabeledValue *relation = [CNLabeledValue labeledValueWithLabel:CNLabelContactRelationFriend value:friend];
    contact.contactRelations = @[relation];
    // 设置生日
    NSDateComponents *birthday = [[NSDateComponents alloc] init];
    birthday.day = 6;
    birthday.month = 5;
    birthday.year = 1985;
    contact.birthday = birthday;
    
    

    return contact;
}

/**
 *  在group里删除成员
 *
 *  @param contact 被删除的联系人
 *  @param group   在该group里删除联系人
 */
- (void)deleteMemberWithContact:(CNContact *)contact toGroup:(CNGroup *)group{
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest removeMember:contact fromGroup:group];
    // 写入
    CNContactStore *store = [[CNContactStore alloc] init];
    
    //执行操作，并返回结果yes、no
    [store executeSaveRequest:saveRequest error:nil];

}

/**
 *  向group添加成员
 *
 *  @param contact 被添加的联系人
 *  @param group   添加到该group
 */
- (void)addMemberWithContact:(CNContact *)contact toGroup:(CNGroup *)group{
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest addMember:contact toGroup:group];
    // 写入
    CNContactStore *store = [[CNContactStore alloc] init];
    NSPredicate *predicate=[CNContact predicateForContactsInGroupWithIdentifier:group.identifier];
    NSError *er=[[NSError alloc] init];
    BOOL returnM=[store executeSaveRequest:saveRequest error:&er];
    NSLog(@"%@,",er.localizedDescription);
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

/**
 *  删除group操作
 *
 *  @param group 被删除的group
 */
- (void)deleteWithGroup:(CNMutableGroup *)group{
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest deleteGroup:group];
    // 写入
    CNContactStore *store = [[CNContactStore alloc] init];
    [store executeSaveRequest:saveRequest error:nil];
}

/**
 *  查询
 *
 *  @return 返回数组
 */
- (NSArray *)queryGroup{
    CNContactStore *store = [[CNContactStore alloc] init];
    // 查询所有的group(predicate参数为空时会查询所有的group)
    NSArray *arr = [store groupsMatchingPredicate:nil error:nil];
    return arr;
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
 *  查询操作
 *
 *  @return 返回数组
 */
- (NSArray *)queryContactWithName:(NSString *)name{
    CNContactStore *store = [[CNContactStore alloc] init];
    // 检索条件
    NSPredicate *predicate = [CNContact predicateForContactsMatchingName:name];
    // 提取数据 （keysToFetch:@[CNContactGivenNameKey]是设置提取联系人的哪些数据）
    NSArray *contact = [store unifiedContactsMatchingPredicate:predicate keysToFetch:@[CNContactGivenNameKey] error:nil];
    return contact;
}

/**
 *  更新联系人
 *
 *  @param contact 被更新的联系人
 */
- (void)updateContact:(CNMutableContact *)contact{
// 创建联系人请求
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest updateContact:contact];
    // 重新写入
    CNContactStore *store = [[CNContactStore alloc] init];
    [store executeSaveRequest:saveRequest error:nil];

}

/**
 *  删除联系人
 *
 *  @param contact 被删除的联系人
 */
- (void)deleteContact:(CNMutableContact *)contact{
    // 创建联系人请求
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest deleteContact:contact];
    // 写入操作
    CNContactStore *store = [[CNContactStore alloc] init];
    [store executeSaveRequest:saveRequest error:nil];

}

/**
 *  添加联系人
 *
 *  @param contact 联系人
 */
- (void)addContact:(CNMutableContact *)contact{
    // 创建联系人请求
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest addContact:contact toContainerWithIdentifier:nil];
    // 写入联系人
    CNContactStore *store = [[CNContactStore alloc] init];
    NSError *er;
    BOOL r=[store executeSaveRequest:saveRequest error:&er];
    NSLog(@"%@",er.localizedDescription);
}
/*
Requesting Access to the User's Contacts 请求访问用户的联系人
-requestAccessForEntityType：completionHandler：//请求访问用户的联系人。
+ authorizationStatusForEntityType：//返回当前授权状态以访问联系人数据。
CNAuthorizationStatus//用户可以授予应用程序访问指定实体类型的授权状态。
CNEntityType//用户可以授予访问权限的实体。
 
 
Fetching Contacts 获取联系人
-enumerateContactsWithFetchRequest：error：usingBlock：//返回一个布尔值，该值指示与联系人获取请求匹配的所有联系人的枚举是否成功执行。
-UnifiedMeContactWithKeysToFetch：error：//获取作为“我”卡的统一联系人。
-UnifiedContactWithIdentifier：keysToFetch：error：//获取指定联系人标识符的统一联系人。
-UnifiedContactsMatchingPredicate：keysToFetch：error：//获取与指定谓词匹配的所有统一联系人。
 
 
Fetching Groups and Containers 获取组和容器
-defaultContainerIdentifier//返回默认容器的标识符。
-groupsMatchingPredicate：error：//获取与指定谓词匹配的所有组。
-containerMatchingPredicate：error：//获取所有与指定谓词匹配的容器。
 
 
Saving Changes 保存更改
-executeSaveRequest：error：//执行保存请求并返回成功或失败。
 
 
Responding to Contact Store Changes 响应联系人存储更改
CNContactStoreDidChangeNotification//当联系人存储发生更改时发布。
 
 
Instance Properties 实例属性
currentHistoryToken
 
 
Instance Methods 实例方法
-enumeratorForChangeHistoryFetchRequest：error：
-enumeratorForContactFetchRequest：error：
*/


/*
 Contact Identification 联系人识别
 CNContactIdentifierKey
 联系人的唯一标识符。
 CNContactTypeKey
 联系人的类型。
 CNContactPropertyAttribute
 联系人的姓名组件属性键。
 
 
 Name 名称
 CNContactNamePrefixKey
 联系人姓名的前缀。
 CNContactGivenNameKey
 联系人的名字。
 CNContactMiddleNameKey
 联系人的中间名。
 CNContactFamilyNameKey
 联系人的姓氏。
 CNContactPreviousFamilyNameKey
 联系人的以前的姓氏。
 CNContactNameSuffixKey
 联系人的姓名后缀。
 CNContactNicknameKey
 联系人的昵称。
 CNContactPhoneticGivenNameKey
 联系人姓名的拼音。
 CNContactPhoneticMiddleNameKey
 联系人中间名的拼音。
 CNContactPhoneticFamilyNameKey
 联系人姓氏的拼音。
 
 
 Work 工作
 CNContactJobTitleKey
 联系人的职务。
 CNContactDepartmentNameKey
 联系人的部门名称。
 CNContactOrganizationNameKey
 联系人的组织名称。
 CNContactPhoneticOrganizationNameKey
 联系人的组织名称的拼音。
 
 
 Addresses 地址
 CNContactPostalAddressesKey
 联系人的邮政地址。
 CNContactEmailAddressesKey
 联系人的电子邮件地址。
 CNContactUrlAddressesKey
 联系人的URL地址。
 CNContactInstantMessageAddressesKey
 联系人的即时消息地址。
 
 
 Phone 电话
 CNContactPhoneNumbersKey
 联系人的电话号码。
 
 
 Social Profiles  社会概况
 CNContactSocialProfilesKey
 联系人的社交资料。
 
 
 Birthday 生日
 CNContactBirthdayKey
 联系人的生日。
 CNContactNonGregorianBirthdayKey
 联系人的非格里高利生日。
 CNContactDatesKey
 与联系人关联的日期。
 
 
 Notes 笔记
 CNContactNoteKey
 与联系人关联的注释。
 com.apple.developer.contacts.notes
 一个布尔值，指示应用程序是否可以访问联系人中存储的注释。
 
 
 Images 图片
 CNContactImageDataKey
 联系人的图像数据。
 CNContactThumbnailImageDataKey
 联系人的缩略图数据。
 CNContactImageDataAvailableKey
 联系人的图像数据可用性。
 
 
 RelationShips 人际关系
 CNContactRelationsKey
 联系人的关系。
 
 
 Groups and Containers 组和容器
 CNGroupNameKey
 组的名称。
 CNGroupIdentifierKey
 组的标识符。
 CNContainerNameKey
 容器的名称。
 CNContainerTypeKey
 容器的类型。
 
 
 Instant Messaging Keys 即时消息键
 CNInstantMessageAddressServiceServiceKey
 即时消息地址服务密钥。
 CNInstantMessageAddressUsernameKey
 即时消息地址用户名密钥。
 
 
 Social Profile Keys 社会档案键
 CNSocialProfileServiceKey
 社交资料服务。
 CNSocialProfileURLStringKey
 社交个人资料网址。
 CNSocialProfileUsernameKey
 社交个人资料用户名。
 CNSocialProfileUserIdentifierKey
 社交个人资料用户标识符。
 */

/*
 Creating the Contact Viewer 创建联系人查看器
 + viewControllerForContact：
 初始化现有联系人的视图控制器。
 + viewControllerForUnknownContact：
 为未知联系人初始化视图控制器。
 + viewControllerForNewContact：
 初始化新联系人的视图控制器。
 
 
 Handling Interactions with the Interface 处理与界面的交互
 delegate 代表
 待通知的代表。
 CNContactViewControllerDelegate
 您用于响应与联系人视图控制器的用户交互的方法。
 
 
 Required Keys 要求的钥匙
 + descriptorForRequiredKeys
 返回在视图控制器上设置之前必须在联系人上获取的所有键的描述符。
 
 
 Displaying Contact Properties 显示联系人属性
 contact 联系
 正在显示的联系人。
 AlternativeName
 联系人没有显示名称时使用的名称。
 message 信息
 在联系人姓名下显示的消息。
 displayPropertyKeys
 要显示的联系人属性键。
 
 
 Configuring the Contact's Relationships 配置联系人的关系
 parentGroup
 要在其中添加新联系人的组。
 parentContainer
 在其中添加新联系人的容器。
 
 
 Contact Store 联系商店
 contactStore
 从中获取联系人或将其保存到的联系人存储。
 
 
 Customizing Contact Card 定制联系卡
 allowEditing
 确定用户是否可以编辑联系人的信息。
 allowActions
 确定是否显示用于执行诸如发送文本消息或发起FaceTime呼叫之类的按钮。
 shouldShowLinkedContacts
 确定是否显示来自链接到正在显示的联系人的联系人的数据。
 
 
 Highlighting a Property 突出显示属性
 -highlightPropertyWithKey：identifier：
 突出显示正在显示的联系人的属性。
 */
@end
