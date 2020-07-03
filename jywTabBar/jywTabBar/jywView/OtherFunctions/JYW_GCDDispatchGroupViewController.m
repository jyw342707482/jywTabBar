//
//  JYW_GCDDispatchGroupViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/2.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_GCDDispatchGroupViewController.h"

@interface JYW_GCDDispatchGroupViewController ()
{
    NSArray *titleArray;
    NSArray *subtitleArray;
}
@end

@implementation JYW_GCDDispatchGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    titleArray=@[@"dispatch_group_create",
                 @"dispatch_group_async",
                 @"dispatch_group_async_f",
                 @"dispatch_group_wait",
    ];
    subtitleArray=@[@"创建一个新组，可以向其分配块对象",
                    @"异步调度一个块以执行，并同时将其与指定的调度组关联",
                    @"将应用程序定义的功能提交给调度队列，并将其与指定的调度组关联",
                    @"同步等待先前提交的块对象完成；如果块在指定的超时时间之前未完成，则返回"
    ];
}
#pragma mark -dispatch_group_create,创建一个新组，可以向其分配块对象
-(void)dispatchGroupCreate{
    dispatch_group_t dgt=dispatch_group_create();
}
#pragma mark -dispatch_group_async,异步调度一个块以执行，并同时将其与指定的调度组关联
-(void)dispatchGroupAsync{
    dispatch_group_t dgt=dispatch_group_create();
    dispatch_group_async(dgt, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   dispatch_group_async,异步调度一个块以执行，并同时将其与指定的调度组关联",self->messageTextView.text];
        });
    });
    dispatch_group_notify(dgt, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   dispatch_group_notify,安排一组先前提交的块对象完成后将要提交给队列的块对象",self->messageTextView.text];
        });
    });
}
#pragma mark -dispatch_group_async_f,将应用程序定义的功能提交给调度队列，并将其与指定的调度组关联
static JYW_GCDDispatchGroupViewController *selfView;
-(void)dispatchGroupAsyncF{
    selfView=self;
    dispatch_group_t dgt=dispatch_group_create();
    NSArray *array=@[@"1",@"2"];
    dispatch_function_t dft=&func;
    dispatch_group_async_f(dgt, dispatch_get_global_queue(0, 0), (__bridge_retained void*)array, dft);
    
    dispatch_group_notify_f(dgt, dispatch_get_global_queue(0, 0), (__bridge_retained void*)array, dft);
}
void func (void *array){
    NSArray *a=(__bridge id)array;
    [selfView dispatchGroupAsyncFuncMessage:a];
}
-(void)dispatchGroupAsyncFuncMessage:(NSArray *)array{
    dispatch_async(dispatch_get_main_queue(), ^{
        self->messageTextView.text=[NSString stringWithFormat:@"%@;   dispatch_group_async_f,%@,%@,将应用程序定义的功能提交给调度队列，并将其与指定的调度组关联",self->messageTextView.text,array[0],[array objectAtIndex:1]];
    });
}
void func1 (void *array){
    NSArray *a=(__bridge id)array;
    [selfView dispatchGroupAsyncFunc1Message:a];
}
-(void)dispatchGroupAsyncFunc1Message:(NSArray *)array{
    dispatch_async(dispatch_get_main_queue(), ^{
        self->messageTextView.text=[NSString stringWithFormat:@"%@;   dispatch_group_notify_f,%@,%@,调度一组先前提交的块对象完成后，将应用程序定义的函数提交给队列",self->messageTextView.text,array[0],[array objectAtIndex:1]];
    });
}

#pragma mark -dispatch_group_wait,同步等待先前提交的块对象完成；如果块在指定的超时时间之前未完成，则返回
-(void)dispatchGroupWait{
    dispatch_group_t dgt=dispatch_group_create();
    dispatch_group_async(dgt, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   dispatch_group_wait,,同步等待先前提交的块对象完成；如果块在指定的超时时间之前未完成，则返回",self->messageTextView.text];
        });
    });
    
    long rLong=dispatch_group_wait(dgt, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5*USEC_PER_SEC)));
    if(rLong==0)
    {
        messageTextView.text=[NSString stringWithFormat:@"%@;   dispatch_group_wait,完成,同步等待先前提交的块对象完成；如果块在指定的超时时间之前未完成，则返回",messageTextView.text];
    }
    else{
        messageTextView.text=[NSString stringWithFormat:@"%@;   dispatch_group_wait,未完成,同步等待先前提交的块对象完成；如果块在指定的超时时间之前未完成，则返回",messageTextView.text];
    }
}
#pragma mark -dispatch_group_enter,通知group，下面的任务要加入到group中执行
/*
 转载：https://www.cnblogs.com/zhou--fei/p/6213752.html
 */
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
            [self dispatchGroupCreate];
            break;
        case 1:
            [self dispatchGroupAsync];
            break;
        case 2:
            [self dispatchGroupAsyncF];
            break;
        case 3:
            [self dispatchGroupWait];
            break;
        default:
            break;
    }
}
/*
Creating a Dispatch Group,创建一个调度组
dispatch_group_create
创建一个新组，您可以向其分配块对象。
dispatch_group_t
提交给队列以进行异步调用的一组块对象。
OS_dispatch_group


Adding Work to the Group,向小组添加工作
dispatch_group_async//异步调度一个块以执行，并同时将其与指定的调度组关联。
dispatch_group_async_f//将应用程序定义的功能提交给调度队列，并将其与指定的调度组关联。


Adding a Completion Handler,添加完成处理程序
dispatch_group_notify//安排一组先前提交的块对象完成后将要提交给队列的块对象。
dispatch_group_notify_f//调度一组先前提交的块对象完成后，将应用程序定义的函数提交给队列。


Waiting For Tasks to Finish Executing,等待任务完成执行
dispatch_group_wait//同步等待先前提交的块对象完成；如果块在指定的超时时间之前未完成，则返回。

Updating the Group Manually,手动更新组
dispatch_group_enter//明确表示一个块已进入该组。
dispatch_group_leave//明确表示组中的一个块已完成执行。
*/

@end
