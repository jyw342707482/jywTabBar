//
//  JYW_GCDDispatchWorkItemViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/2.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_GCDDispatchWorkItemViewController.h"

@interface JYW_GCDDispatchWorkItemViewController ()
{
    NSArray *titleArray;
    NSArray *subtitleArray;
}
@end

@implementation JYW_GCDDispatchWorkItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    titleArray=@[@"dispatch_block_create",
                 @"dispatch_block_create_with_qos_class",
                 @"dispatch_block_perform",
                 @"dispatch_block_notify",
                 @"dispatch_block_wait"
    ];
    subtitleArray=@[@"使用现有块和给定的标志在堆上创建一个新的调度块",
                    @"创建一个新的调度快",
                    @"从指定的块和标志创建，同步执行和释放调度块",
                    @"计划在指定调度块的执行完成后将通知块提交给队列",
                    @"同步等待，直到指定的调度块的执行完成或指定的超时时间结束为止"
    ];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark -dispatch_block_create,使用现有块和给定的标志在堆上创建一个新的调度块
-(void)dispatchBlockCreate{
    /*
     dispatch_block_flags_t
     转载：https://blog.csdn.net/u011374318/article/details/88142069
     DISPATCH_BLOCK_ASSIGN_CURRENT
     DISPATCH_BLOCK_BARRIER
     DISPATCH_BLOCK_DETACHED
     DISPATCH_BLOCK_ENFORCE_QOS_CLASS
     DISPATCH_BLOCK_INHERIT_QOS_CLASS
     DISPATCH_BLOCK_NO_QOS_CLASS
     */
    //创建
    dispatch_block_t dbt=dispatch_block_create(DISPATCH_BLOCK_ASSIGN_CURRENT, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   dispatch_block_create,使用现有块和给定的标志在堆上创建一个新的调度块",self->messageTextView.text];
        });
    });
    dispatch_async(dispatch_get_global_queue(0, 0), dbt);
    //取消
    //dispatch_block_cancel(dbt);
}
#pragma mark -dispatch_block_create_with_qos_class,从现有块和给定的标志创建一个新的调度块，并为其分配指定的服务质量类和相对优先级
-(void)dispatchBlockCreateWithQosClass{
    //创建
    dispatch_block_t dbt=dispatch_block_create_with_qos_class(DISPATCH_BLOCK_ASSIGN_CURRENT, QOS_CLASS_USER_INTERACTIVE, -1, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   dispatch_block_create_with_qos_class,从现有块和给定的标志创建一个新的调度块，并为其分配指定的服务质量类和相对优先级",self->messageTextView.text];
        });
    });
    dispatch_async(dispatch_get_global_queue(0, 0), dbt);
    //取消
    //dispatch_block_cancel(dbt);
}
#pragma mark -dispatch_block_perform,从指定的块和标志创建，同步执行和释放调度块。
-(void)dispatchBlockPerform{
    dispatch_block_t block = dispatch_block_create(DISPATCH_BLOCK_DETACHED, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   dispatch_block_perform,从指定的块和标志创建，同步执行和释放调度块",self->messageTextView.text];
        });
    });
    dispatch_block_perform(DISPATCH_BLOCK_DETACHED, block);
}
#pragma mark -dispatch_block_notify,计划在指定调度块的执行完成后将通知块提交给队列。
-(void)dispatchBlockNotify{
    dispatch_block_t dbt1=dispatch_block_create(DISPATCH_BLOCK_ASSIGN_CURRENT, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   dispatch_block_notify,1,计划在指定调度块的执行完成后将通知块提交给队列",self->messageTextView.text];
        });
    });
    
    dispatch_block_notify(dbt1, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   dispatch_block_notify,2,计划在指定调度块的执行完成后将通知块提交给队列",self->messageTextView.text];
        });
    });
    dispatch_async(dispatch_get_global_queue(0, 0), dbt1);
}
#pragma mark -dispatch_block_wait,同步等待，直到指定的调度块的执行完成或指定的超时时间结束为止。
-(void)dispatchBlockWait{
    dispatch_block_t dbt=dispatch_block_create(DISPATCH_BLOCK_ASSIGN_CURRENT, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   dispatch_block_wait,dbt,同步等待，直到指定的调度块的执行完成或指定的超时时间结束为止",self->messageTextView.text];
        });
    });
    dispatch_async(dispatch_get_global_queue(0, 0), dbt);
    //DISPATCH_TIME_NOW
    long resutl=dispatch_block_wait(dbt, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)));
    if (resutl == 0) {
        messageTextView.text=[NSString stringWithFormat:@"%@;   dispatch_block_wait,执行成功,同步等待，直到指定的调度块的执行完成或指定的超时时间结束为止",messageTextView.text];
    } else {
        messageTextView.text=[NSString stringWithFormat:@"%@;   dispatch_block_wait,执行超时,同步等待，直到指定的调度块的执行完成或指定的超时时间结束为止",messageTextView.text];
    }
    
    //dispatch_block_testcancel//测试给定的调度块是否已取消。
    //如果取消了调度块，则返回非零值，否则返回零。
    long rlong=dispatch_block_testcancel(dbt);
    if(rlong==0)
    {
        messageTextView.text=[NSString stringWithFormat:@"%@;   dispatch_block_testcancel,未取消,测试给定的调度块是否已取消",messageTextView.text];
    }
    else{
        messageTextView.text=[NSString stringWithFormat:@"%@;   dispatch_block_testcancel,已取消,测试给定的调度块是否已取消",messageTextView.text];
    }
}
#pragma mark -tableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
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
        //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    //添加图片
    cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
    
    
    cell.detailTextLabel.text = [subtitleArray objectAtIndex:indexPath.row];
    //添加右侧注释
    
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self dispatchBlockCreate];
            break;
        case 1:
            [self dispatchBlockCreateWithQosClass];
            break;
        case 2:
            [self dispatchBlockPerform];
            break;
        case 3:
            [self dispatchBlockNotify];
            break;
        case 4:
            [self dispatchBlockWait];
            break;
        default:
            break;
    }
}
/*
Creating a Work Item,创建工作项
dispatch_block_create//使用现有块和给定的标志在堆上创建一个新的调度块。
dispatch_block_create_with_qos_class//从现有块和给定的标志创建一个新的调度块，并为其分配指定的服务质量类和相对优先级。
dispatch_block_t//提交给分派队列的块的原型，不带任何参数，没有返回值。
dispatch_block_flags_t//传递给dispatch_block_create和dispatch_block_create_with_qos_class函数的标志。


Scheduling Work Items,安排工作项目
dispatch_block_perform//从指定的块和标志创建，同步执行和释放调度块。


Adding a Completion Handle,添加完成处理程序
dispatch_block_notify//计划在指定调度块的执行完成后将通知块提交给队列。


Delaying Execution of a Work Item,延迟执行工作项
dispatch_block_wait//同步等待，直到指定的调度块的执行完成或指定的超时时间结束为止。


Canceling a Work Item,取消工作项目
dispatch_block_cancel//异步取消指定的调度块。
dispatch_block_testcancel//测试给定的调度块是否已取消。
*/

@end
