//
//  JYW_CFRunLoopExamplesViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/26.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_CFRunLoopExamplesViewController.h"
static NSString *CellTableIndentifier = @"CellTableIdentifier";
@interface JYW_CFRunLoopExamplesViewController ()
{
    NSArray *tableGroup;
    NSArray *tableDSArray;
    NSArray *subtitleArray;
}
@end

@implementation JYW_CFRunLoopExamplesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableGroup=@[@"Getting a RunLoop(获取运行循环)",
                 /*
                 @"Starting and Stopping a RunLoop(启动和停止运行循环)",
                 @"Managing Sources(管理来源)",
                 @"Managing Observers(管理观察员)",
                 @"Managing Run Loop Modes(管理运行循环模式)",
                 @"Managing Timers(管理计时器)",
                 @"Scheduling Blocks(排班)",
                 @"Getting the CFRunLoop Type ID(获取CFRunLoop类型ID)",
                 @"Data Types(数据类型)"*/
    ];
    tableDSArray=@[
        @[@"CFRunLoopGetCurrent",
          @"CFRunLoopGetMain"
        ],
    ];
    subtitleArray=@[
        @[@"返回当前线程的CFRunLoop对象。",
          @"返回主CFRunLoop对象。"
        ],
    ];
}
#pragma mark -Getting a RunLoop(获取运行循环)
//CFRunLoopGetCurrent(返回当前线程的CFRunLoop对象。)
-(void)CFRunLoopGetCurrent{
    CFRunLoopRef rLoopRef=CFRunLoopGetCurrent();
    NSTimeInterval fireDate=CFAbsoluteTimeGetCurrent();
    /*
    CFRunLoopTimerRef timer=CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 1, 0, 0, ^(CFRunLoopTimerRef timer) {
        NSLog(@"CFRunLoopGetCurrent(返回当前线程的CFRunLoop对象。)");
    });
    CFRunLoopAddTimer(rLoopRef, timer, kCFRunLoopCommonModes);
    CFRunLoopRunInMode(kCFRunLoopCommonModes, 1, false);
    */
    CFRunLoopTimerContext timer_context= {0,
    NULL, NULL, NULL,
    NULL};
    CFRunLoopSourceContext source_context= {0,
    NULL, NULL, NULL,
    NULL};
    CFRunLoopTimerRef timer=CFRunLoopTimerCreate(kCFAllocatorDefault, fireDate, 1, 0, 0, &CFRunLoopGetCurrentTimer, &timer_context);
    CFRunLoopAddTimer(rLoopRef, timer, kCFRunLoopCommonModes);
    CFRunLoopSourceRef source=CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &source_context);
    
    CFRunLoopAddSource(rLoopRef, source, kCFRunLoopCommonModes);
    CFRunLoopRunInMode(kCFRunLoopCommonModes, 1, true);
}
void
CFRunLoopGetCurrentTimer(CFRunLoopTimerRef timer __unused, void *info)
{
    //CFRunLoopSourceSignal(info);
};

#pragma mark -UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableGroup.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(16, 0, tableView.frame.size.width-32, 40)];
    titleLabel.text=tableGroup[section];
    titleLabel.textAlignment=NSTextAlignmentRight;
    titleLabel.font=[UIFont systemFontOfSize:14.0f];
    titleLabel.numberOfLines=0;
    [headerView addSubview:titleLabel];
    return headerView;
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    footerView.backgroundColor=[UIColor blueColor];
    return footerView;
}
-(float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableDSArray[section] count];
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
        //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    //UIImage *img = [UIImage imageNamed:@"group"];
    //cell.imageView.image = img;
    //添加图片
    cell.textLabel.text = [[tableDSArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [[subtitleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    //添加右侧注释
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    [self CFRunLoopGetCurrent];
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    
    
}

@end
