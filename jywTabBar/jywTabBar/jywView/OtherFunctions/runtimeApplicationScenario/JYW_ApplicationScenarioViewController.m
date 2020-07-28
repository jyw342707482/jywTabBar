//
//  JYW_ApplicationScenarioViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/19.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_ApplicationScenarioViewController.h"
//防止UIButton连点
#import "JYW_ButtonDoubleClickViewController.h"
//防止数组越界
#import "JYW_NSArrayCrashViewController.h"
//归档、解档
#import "JYW_EncodeAndUnEncodeViewController.h"
//添加属性
#import "JYW_AddPropertyViewController.h"
//字典转模型
#import "JYW_DictionaryTurnModelViewController.h"

@interface JYW_ApplicationScenarioViewController ()
{
    NSArray *tableDSArray;
    NSArray *subtitleArray;
}
@end
static NSString *CellTableIndentifier = @"CellTableIdentifier";
@implementation JYW_ApplicationScenarioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableDSArray=@[@"防止UIButton按钮重复点击",
                   @"防止NSArray、NSMutableArray访问越界",
                   @"归档、解档",
                   @"快速接受新工程",
                   @"添加属性",
                   @"字典转模型"
    ];
    subtitleArray=@[@"使用到方法交换，对象关联",
                    @"使用到方法交换",
                    @"使用class_copyIvarList,获取类对象的实例",
                    @"UIViewController (JYW_Category)",
                    @"私用对象关联",
                    @"使用获取类的属性"
    ];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableDSArray count];
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    
    //UIImage *img = [UIImage imageNamed:@"group"];
    //cell.imageView.image = img;
    //添加图片
    cell.textLabel.text = [tableDSArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [subtitleArray objectAtIndex:indexPath.row];
    //添加右侧注释
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0){
        JYW_ButtonDoubleClickViewController *bv=[[JYW_ButtonDoubleClickViewController alloc] init];
        [self.navigationController pushViewController:bv animated:YES];
    }
    else if(indexPath.row==1){
        JYW_NSArrayCrashViewController *cv=[[JYW_NSArrayCrashViewController alloc] init];
        [self.navigationController pushViewController:cv animated:YES];
    }
    else if(indexPath.row==2){
        JYW_EncodeAndUnEncodeViewController *eaue=[[JYW_EncodeAndUnEncodeViewController alloc] init];
        [self.navigationController pushViewController:eaue animated:YES];
    }
    else if(indexPath.row==3){
        UIAlertController *aController=[UIAlertController alertControllerWithTitle:@"提示" message:@"实现文件：UIViewController+JYW_Category" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *aAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [aController addAction:aAction];
        [self presentViewController:aController animated:YES completion:nil];
    }
    else if(indexPath.row==4){
        JYW_AddPropertyViewController *addP=[[JYW_AddPropertyViewController alloc] init];
        [self.navigationController pushViewController:addP animated:YES];
    }
    else if(indexPath.row==5){
        JYW_DictionaryTurnModelViewController *addP=[[JYW_DictionaryTurnModelViewController alloc] init];
        [self.navigationController pushViewController:addP animated:YES];
    }
}

@end
