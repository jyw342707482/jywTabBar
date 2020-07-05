//
//  JYW_GCDDispatchSourceViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/2.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_GCDDispatchSourceViewController.h"

@interface JYW_GCDDispatchSourceViewController ()
{
    NSArray *titleArray;
    NSArray *subtitleArray;
}
@end

@implementation JYW_GCDDispatchSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    titleArray=@[@"Dispatch Source",
                 @"Dispatch I/O_Read",
                 @"Dispatch I/O_Read",
                 @"Dispatch I/O_Write"
    ];
    subtitleArray=@[@"计时器",
                    @"本地文件读取，异步串行",
                    @"本地文件读取，异步并行",
                    @"本地文件写入"
    ];
}
#pragma mark -dispatch_source_create//创建一个新的调度源以监视低级系统事件。
/*
 转载：https://blog.csdn.net/yanglei3kyou/article/details/88829148
 */
//计时器
-(void)dispatchSourceCreate{
    /*
     dispatch_source_type_t:
     DISPATCH_SOURCE_TYPE_TIMER//用于监视计时器的调度源。
     DISPATCH_SOURCE_TYPE_READ//用于监视对文件系统对象的读取操作。
     DISPATCH_SOURCE_TYPE_WRITE//用于监视对文件系统对象的写操作。
     DISPATCH_SOURCE_TYPE_VNODE//用于监视对文件系统对象的更改。
     DISPATCH_SOURCE_TYPE_SIGNAL//用于监视信号的调度源。
     DISPATCH_SOURCE_TYPE_PROC//用于监视流程的调度源。
     DISPATCH_SOURCE_TYPE_MEMORYPRESSURE//用于监视内存压力事件的调度源。
     DISPATCH_SOURCE_TYPE_MACH_SEND//用于监视mach发送端口的调度源。
     DISPATCH_SOURCE_TYPE_MACH_RECV//用于监视马赫数接收端口的调度源。
     DISPATCH_SOURCE_TYPE_DATA_ADD//用于监视涉及与AND运算符进行数据合并的自定义事件。
     DISPATCH_SOURCE_TYPE_DATA_OR//用于监视涉及使用OR运算符进行数据合并的自定义事件。
     */
    __block int timeout = 10; //倒计时时间
    // 任务执行所指定的队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    // 当前定时器源
    dispatch_source_t dst=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 任务执行开始时间
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
    // 任务执行间隔时间
    uint64_t interval = 1.0 * NSEC_PER_SEC;
    // 给定时器源绑定开始时间、间隔时间以及容忍误差时间
    dispatch_source_set_timer(dst, start, interval, 0);
    // 给定时器源绑定任务
    dispatch_source_set_event_handler(dst, ^{
        // 内部最好使用weak/strong修饰的self, 防止循环引用
        if(timeout==0)
        {
            dispatch_cancel(dst);
            dispatch_async(dispatch_get_main_queue(), ^{
                self->messageTextView.text=[NSString stringWithFormat:@"读秒;  %d,结束",timeout--];
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                self->messageTextView.text=[NSString stringWithFormat:@"读秒;  %d",timeout--];
            });
        }
    });
    // 启动定时器源
    dispatch_resume(dst);
}
#pragma mark -dispatch I/O Read 文件读取，异步串行
//转载：https://www.cnblogs.com/theManOfGod/p/5132590.html
-(void)dispatchIO_Read{
    NSString *writeFilePath=[[NSBundle mainBundle] pathForResource:@"dispatchIO_Write" ofType:@"txt"];
    dispatch_fd_t dfdt=open(writeFilePath.UTF8String, O_RDONLY);
    dispatch_queue_attr_t dqAttr=dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_UTILITY, -1);
    dispatch_queue_t dqt=dispatch_queue_create("jyw.jyw.oc.tabBar", dqAttr);
    dispatch_io_t iot=dispatch_io_create(DISPATCH_IO_STREAM, dfdt, dqt, ^(int error) {
        close(dfdt);
    });
    
    //文件大小
    long long fileSize = [[NSFileManager defaultManager] attributesOfItemAtPath:writeFilePath error:nil].fileSize;
    NSMutableData *tData=[[NSMutableData alloc] init];
    dispatch_io_read(iot, 0, fileSize, dqt, ^(bool done, dispatch_data_t  _Nullable data, int error) {
        if(error==0)
        {
            size_t len = dispatch_data_get_size(data);
            if (len > 0) {
                [tData appendData:(NSData *)data];
            }
        }
        if(done){
            dispatch_async(dispatch_get_main_queue(), ^{
                self->messageTextView.text=[NSString stringWithFormat:@"%@;  %@",self->messageTextView.text,[[NSString alloc] initWithData:tData encoding:NSUTF8StringEncoding]];
            });
            //close(dfdt);
        }
    });
}
#pragma mark -dispatch I/O Read 文件读取，异步并行
-(void)dispatchIO_Read1:(NSString *)fileStr{
    NSString *writeFilePath=[[NSBundle mainBundle] pathForResource:fileStr ofType:@"txt"];
    dispatch_fd_t dfdt=open(writeFilePath.UTF8String, O_RDONLY);
    dispatch_queue_attr_t dqAttr=dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_UTILITY, -1);
    dispatch_queue_t dqt=dispatch_queue_create("jyw.jyw.oc.tabBar", dqAttr);
    dispatch_io_t iot=dispatch_io_create(DISPATCH_IO_STREAM, dfdt, dqt, ^(int error) {
        close(dfdt);
    });
    
    off_t currentSize = 0;
    long long fileSize = [[NSFileManager defaultManager] attributesOfItemAtPath:writeFilePath error:nil].fileSize;
    size_t offset = 10*10;
    dispatch_group_t group = dispatch_group_create();
    NSMutableData *totalData = [[NSMutableData alloc] init];
    
    for (; currentSize <= fileSize; currentSize += offset) {
        dispatch_group_enter(group);
        dispatch_io_read(iot, currentSize, fileSize, dqt, ^(bool done, dispatch_data_t  _Nullable data, int error) {
            if (error == 0) {
                size_t len = dispatch_data_get_size(data);
                if (len > 0) {
                    [totalData appendData:(NSData *)data];
                    /*
                    const void *bytes = NULL;
                    (void)dispatch_data_create_map(data, (const void **)&bytes, &len);
                    [totalData replaceBytesInRange:NSMakeRange(currentSize, len) withBytes:bytes length:len];
                     */
                }
            }
            if (done) {
                dispatch_group_leave(group);
            }
        });
    }
    dispatch_group_notify(group, dqt, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;  %@",self->messageTextView.text,[[NSString alloc] initWithData:totalData encoding:NSUTF8StringEncoding]];
        });
    });
}
#pragma mark -dispatch I/O Write
-(void)dispatchIO_Write{
    NSString *writeFilePath=[[NSBundle mainBundle] pathForResource:@"dispatchIO_Write" ofType:@"txt"];
    dispatch_fd_t dfdt=open(writeFilePath.UTF8String, O_WRONLY);
    dispatch_queue_attr_t dqAttr=dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_UTILITY, -1);
    dispatch_queue_t dqt=dispatch_queue_create("jyw.jyw.oc.tabBar", dqAttr);
    dispatch_io_t iot=dispatch_io_create(DISPATCH_IO_STREAM, dfdt, dqt, ^(int error) {
        close(dfdt);
        //dispatch_io_close(iot, DISPATCH_IO_STOP);
    });
    
    NSString *dataStr=@"a;lkdjalsfjals;dfkalskdfjaslkdjflkajkdjksjfkdfjksdjfksdfjksfj";
    NSData * data=[dataStr dataUsingEncoding:NSUTF8StringEncoding];
    dispatch_data_t ddt=[self dispatchDataFromNsdata:data];
    dispatch_io_write(iot, 0, ddt, dqt, ^(bool done, dispatch_data_t  _Nullable data, int error) {
        if(error==0)
        {}
        if(done){
            dispatch_async(dispatch_get_main_queue(), ^{
                self->messageTextView.text=[NSString stringWithFormat:@"%@;  写入完成",self->messageTextView.text];
            });
            [self dispatchIO_Read1:@"dispatchIO_Write"];
        }
    });
    
}
#pragma mark -NSData 转 dispatch_data_t
/// @param nsdata NSData
- (dispatch_data_t)dispatchDataFromNsdata:(NSData *)nsdata {
    if (nsdata == nil) {
        return nil;
    }
    Byte byte[nsdata.length];
    [nsdata getBytes:byte length:nsdata.length];
    dispatch_data_t data = dispatch_data_create(byte, nsdata.length, nil, DISPATCH_DATA_DESTRUCTOR_DEFAULT);
    return data;
}

#pragma mark -dispatch_data_t 转 NSData
/// @param dispatchData dispatch_data_t
- (NSData *)nsdataFromDispatchData:(dispatch_data_t)dispatchData {
    if (dispatchData == nil) {
        return nil;
    }
    const void *buffer = NULL;
    size_t size = 0;
    dispatch_data_t new_data_file = dispatch_data_create_map(dispatchData, &buffer, &size);
    if(new_data_file) {/* to avoid warning really - since dispatch_data_create_map demands we care about the return arg */}
    NSData *nsdata = [[NSData alloc] initWithBytes:buffer length:size];
    return nsdata;
}
/*
 dispatch_data_apply
 转载：https://blog.csdn.net/buildSetting/article/details/50749465
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
            [self dispatchSourceCreate];
            break;
        case 1:
            [self dispatchIO_Read];
            break;
        case 2:
            [self dispatchIO_Read1:@"dispatchIO_Read"];
            break;
        case 3:
            [self dispatchIO_Write];
            break;
        default:
            break;
    }
}

/*
 dispatch source
Creating a Dispatch Source,创建调度源
dispatch_source_create//创建一个新的调度源以监视低级系统事件。
dispatch_source_t
协调特定低级系统事件（例如文件系统事件，计时器和UNIX信号）的处理的对象。
dispatch_source_type_t
调度源正在监视的系统对象类型的标识符。


Managing Event Handlers,管理事件处理程序
dispatch_source_set_registration_handler_f
设置给定调度源的注册处理函数。
dispatch_source_set_registration_handler
设置给定调度源的注册处理程序块。
dispatch_source_set_event_handler_f
为给定的调度源设置事件处理函数。
dispatch_source_set_event_handler
为给定的调度源设置事件处理程序块。
dispatch_source_set_cancel_handler_f
为给定的调度源设置取消处理函数。
dispatch_source_set_cancel_handler
为给定的调度源设置取消处理程序块。


Getting Dispatch Source Attributes,获取调度源属性
dispatch_source_get_data
返回调度源的待处理数据。
dispatch_source_get_mask
返回由调度源监视的事件的掩码。
dispatch_source_get_handle
返回与指定调度源关联的基础系统句柄。
dispatch_source_merge_data
将数据合并到调度源中，并将其事件处理程序块提交到其目标队列。
dispatch_source_proc_flags_t
与流程相关的事件。
dispatch_source_vnode_flags_t
涉及更改文件系统对象的事件。
dispatch_source_mach_send_flags_t
与马赫相关的事件。
dispatch_source_memorypressure_flags_t
内存压力事件。


Manageing Timer Parameters,管理计时器参数
dispatch_source_set_timer
设置计时器源的开始时间，间隔和回程值。
dispatch_source_timer_flags_t
在配置计时器调度源时使用的标志。


Canceling a Dispatch Source,取消派遣源
dispatch_source_cancel
异步取消调度源，以防止进一步调用其事件处理程序块。
dispatch_source_testcancel
测试给定的派遣源是否已取消。
*/


/*
 dispatch I/O
 Creating a Dispatch I/O Object,创建调度I / O对象
 dispatch_io_create
 创建一个调度I / O通道，并将其与指定的文件描述符关联。
 dispatch_io_create_with_io
 从现有通道创建一个新的调度I / O通道。
 dispatch_io_create_with_path
 创建具有关联路径名的调度I / O通道。
 dispatch_io_t
 调度I / O通道。
 dispatch_fd_t
 用于I / O操作的文件描述符。
 dispatch_io_type_t
 调度I / O通道的类型。
 OS_dispatch_io


 Reading from the File,从文件读取
 dispatch_read
 使用指定的文件描述符调度异步读取操作。
 dispatch_io_read
 在指定的通道上调度异步读取操作。
 dispatch_io_handler_t
 用于处理调度I / O通道上的操作的处理程序块。


 Writing to the File,写入文件
 dispatch_write
 使用指定的文件描述符调度异步写入操作。
 dispatch_io_write
 调度指定通道的异步写操作。


 Closing the File,关闭档案
 dispatch_io_close
 关闭指定的通道以进行新的读取和写入操作。
 dispatch_io_close_flags_t
 关闭I / O通道时要使用的其他标志。


 Managing the File Descriptor,管理文件描述符
 dispatch_io_get_descriptor
 返回与指定通道关联的文件描述符。
 dispatch_io_set_interval
 设置间隔（以纳秒为单位），在该间隔处调用通道的I / O处理程序。
 dispatch_io_interval_flags_t
 标志的类型，用于指定通道的调度间隔。
 dispatch_io_set_low_water
 设置入队处理程序块之前要处理的最小字节数。
 dispatch_io_set_high_water
 设置入队处理程序块之前要处理的最大字节数。


 Synchronizing File Operations,同步文件操作
 dispatch_io_barrier
 调度指定通道上的屏障操作。
 */

/*
 dispatch data
Creating a Dispatch Data Object,创建调度数据对象
dispatch_data_create//用指定的内存缓冲区创建一个新的调度数据对象。
dispatch_data_create_map//返回一个新的调度数据对象，其中包含指定对象内存的连续表示形式。
dispatch_data_create_concat//返回一个新的调度数据对象，该对象由来自其他两个数据对象的串联数据组成。
dispatch_data_create_subrange//返回一个新的调度数据对象，其内容由另一个对象的内存区域的一部分组成。
dispatch_data_copy_region//返回一个数据对象，该数据对象包含另一个数据对象中的一部分数据。
dispatch_data_empty//表示零长度存储区域的调度数据对象。
dispatch_data_t//一个不可变的对象，表示内存的连续或稀疏区域。
OS_dispatch_data
DISPATCH_DATA_DESTRUCTOR_DEFAULT
调度对象的默认数据析构函数。
DISPATCH_DATA_DESTRUCTOR_FREE
使用内存分配例程malloc系列创建内存缓冲区的调度数据对象的析构函数。


Getting the Number of Elements,获取元素数
dispatch_data_get_size//返回由调度数据对象管理的内存的逻辑大小


Applying Changes to the Data,将更改应用于数据
dispatch_data_apply//遍历调度数据对象的内存，并在每个区域上执行自定义代码。
dispatch_data_applier_t//为数据对象中的每个连续内存区域调用的块。
 */
@end
