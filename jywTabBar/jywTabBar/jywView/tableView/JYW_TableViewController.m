//
//  JYW_TableViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/27.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_TableViewController.h"
#import "JYW_FictionTableViewController.h"
@interface JYW_TableViewController ()
{
    NSArray *tableDSArray;
}
@end

@implementation JYW_TableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self pageSettings];
}
//页面设置
-(void)pageSettings{
    //设置导航标题
    self.title=@"列表";
    tableDSArray=@[@"小说播放列表",@"Group"];
    /*
    //添加导航右侧按钮，按钮类型为系统加号
    UIBarButtonItem *rightBarButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(tbViewAddRow:)];
    self.navigationItem.rightBarButtonItem=rightBarButton;
     */
}
/*
//添加行点击事件
-(IBAction)tbViewAddRow:(id)sender{
    
}
 */

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableDSArray.count;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 50;
}
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
    
    UIImage *img = [UIImage imageNamed:@"group"];
    cell.imageView.image = img;
    //添加图片
    cell.textLabel.text = [tableDSArray objectAtIndex:indexPath.row];
    
    
    cell.detailTextLabel.text = @"类型";
    //添加右侧注释
    
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYW_FictionTableViewController *ftvc=[[JYW_FictionTableViewController alloc] init];
    
    [self.navigationController pushViewController:ftvc animated:YES];
   
}
@end
