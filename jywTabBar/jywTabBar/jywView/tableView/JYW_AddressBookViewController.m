//
//  JYW_AddressBookViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/1.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_AddressBookViewController.h"
#import "JYW_AddressBookViewModel.h"
#import "JYW_AddressBookGroupModel.h"
@interface JYW_AddressBookViewController ()
{
    JYW_AddressBookViewModel *jyw_addressBookViewModel;
    NSMutableArray *addressBookArray;
    NSArray *labelGroupArray;
    NSString *ContactPersonCount;
}
@end

@implementation JYW_AddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pageSettings];
}
-(BOOL)shouldAutorotate{
    return YES;
}
//页面设置
-(void)pageSettings{
    //设置导航标题
    self.title=@"通讯录列表";
    
    //添加导航右侧按钮
    //添加导航右侧按钮，按钮类型为系统加号
    UIBarButtonItem *rightBarButton1=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(tbViewAddRow:)];
    //添加导航右侧按钮，按钮类型为系统放大镜
    UIBarButtonItem *rightBarButton2=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(tbViewSection:)];
    self.navigationItem.rightBarButtonItems=@[rightBarButton1,rightBarButton2];
     
    
    //初始化页面数据
    jyw_addressBookViewModel=[[JYW_AddressBookViewModel alloc] init];
    NSDictionary *jywPageData=[jyw_addressBookViewModel getPageData];
    ContactPersonCount=[jywPageData objectForKey:@"ContactPersonCount"];
    addressBookArray=[jyw_addressBookViewModel getGroupDataWithLabelArray:[jywPageData objectForKey:@"labelGroup"]];
    [jyw_addressBookViewModel getAddressBookDataWithAddressBookArray:[jywPageData objectForKey:@"addressBookArray"] JYW_AddressBookGroupModelArray:addressBookArray];
    labelGroupArray=[jywPageData objectForKey:@"labelGroup"];
    
    /*
    //列表头部视图
    UIView *tableHeaderView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    tableHeaderView.backgroundColor=[UIColor redColor];
    addressBookTableView.tableHeaderView=tableHeaderView;
    */
    //列表尾部视图
    UIView *tableFooderView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    titleLabel.text=[NSString stringWithFormat:@"%@位联系人",ContactPersonCount];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font=[UIFont systemFontOfSize:16];
    [tableFooderView addSubview:titleLabel];
    addressBookTableView.tableFooterView=tableFooderView;
    //刷新列表
    [addressBookTableView reloadData];
}

//导航右侧按钮-搜索点击事件
-(IBAction)tbViewSection:(id)sender{
    NSLog(@"点击搜索");
}
//导航右侧按钮-添加点击事件
-(IBAction)tbViewAddRow:(id)sender{
    NSLog(@"点击添加");
}

//返回节头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JYW_AddressBookGroupModel *jywABGM=addressBookArray[section];
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    headerView.backgroundColor=[UIColor grayColor];
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(16, 0, 30, 40)];
    titleLabel.text=jywABGM.groupStr;
    titleLabel.font=[UIFont systemFontOfSize:14];
    [headerView addSubview:titleLabel];
    return headerView;
}
//返回节头部视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
//返回节尾部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGFLOAT_MIN)];
    return footerView;
    /*
    if(addressBookArray.count-1==section)
    {
        UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        titleLabel.text=[NSString stringWithFormat:@"%@位联系人",ContactPersonCount];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.font=[UIFont systemFontOfSize:16];
        [footerView addSubview:titleLabel];
        return footerView;
    }
    else
    {
        
    }*/
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
    return addressBookArray.count;
}
//返回每节的行数量
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    JYW_AddressBookGroupModel *jywABGM=addressBookArray[section];
    return jywABGM.addressBookModelArray.count;
}
//返回每行高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 50;
}
//返回每行的视图
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIndentifier = @"CellTableIdentifier";
    //单元格ID
    //重用单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellTableIndentifier];
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
    JYW_AddressBookGroupModel *jywABGM=addressBookArray[indexPath.section];
    JYW_AddressBookModel *jywABM=jywABGM.addressBookModelArray[indexPath.row];
    UIImage *img = [UIImage imageNamed:jywABM.avatar];
    cell.imageView.image = img;
    //添加图片
    cell.textLabel.text =[NSString stringWithFormat:@"%@(%@)",jywABM.nickname,jywABM.tagStr];
    
    
    return cell;
}
@end
