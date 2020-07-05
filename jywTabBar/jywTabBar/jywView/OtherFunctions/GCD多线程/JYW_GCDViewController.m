//
//  JYW_GCDViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/30.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_GCDViewController.h"

@interface JYW_GCDViewController ()
{
    NSArray *tbArray;
    NSArray *tbSubtitleArray;
}
@end

@implementation JYW_GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tbArray=@[@"dispatch_get_global_queue",
              @"dispatch_queue_create",
              @"dispatch_queue_create_with_target",
              @"dispatch_queue_main_t",
              @"dispatch_queue_global_t",
              @"dispatch_queue_serial_t",
              @"dispatch_queue_concurrent_t",
              @"dispatch_queue_attr_make_with_qos_class",
              @"dispatch_async_f",
              @"dispatch_after",
              @"dispatch_once",
              @"dispatch_once_f",
              @"dispatch_apply",
              @"dispatch_queue_get_label",
              @"dispatch_set_target_queue"
    ];
    tbSubtitleArray=@[@"获取全局队列",
                      @"创建一个新的队列",
                      @"创建一个新的队列",
                      @"绑定到主线程并在该线程上串行执行",
                      @"使用全局线程池中的线程并发执行任务的调度队列",
                      @"分派队列，按先进先出（FIFO）顺序连续执行任务",
                      @"一个调度队列，它以任何顺序并发执行任务，并遵守可能存在的任何障碍",
                      @"创建调度队列的属性",
                      @"提交应用程序定义的函数以在调度队列上异步执行并立即返回",
                      @"使块在指定时间执行",
                      @"在应用程序的生存期内，仅执行一次块对象",
                      @"在应用程序的生存期内，仅执行一次应用程序定义的功能",
                      @"将单个块提交给调度队列，并使该块执行指定的次数",
                      @"返回在创建时分配给调度队列的标签",
                      @"指定要在其上执行与当前对象关联的工作的调度队列"
    ];
    
}
#pragma mark dispatch_get_main_queue，返回与应用程序的主线程关联的串行调度队列。主要用于更新UI显示
-(void)updateControlData{
    
}

#pragma mark dispatch_get_global_queue,会获取一个全局队列，我们姑且理解为系统为我们开启的一些全局线程。我们用priority指定队列的优先级，而flag作为保留字段备用（一般为0）
-(void)dispatchGetGlobalQueue{
    //查询全局队列，
    /*
     dispatch_get_global_queue
     参数：identifier
     QOS_CLASS_DEFAULT，DISPATCH_QUEUE_PRIORITY_DEFAULT
     QOS_CLASS_USER_INTERACTIVE,user interactive 等级表示任务需要被立即执行，用来在响应事件之后更新 UI，来提供好的用户体验。这个等级最好保持小规模。
     QOS_CLASS_USER_INITIATED,DISPATCH_QUEUE_PRIORITY_HIGH，user initiated 等级表示任务由 UI 发起异步执行。适用场景是需要及时结果同时又可以继续交互的时候。
     QOS_CLASS_UTILITY,DISPATCH_QUEUE_PRIORITY_LOW，utility 等级表示需要长时间运行的任务，伴有用户可见进度指示器。经常会用来做计算，I/O，网络，持续的数据填充等任务。这个任务节能。
     QOS_CLASS_BACKGROUND，background 等级表示用户不会察觉的任务，使用它来处理预加载，或者不需要用户交互和对时间不敏感的任务。
     全局队列不是用户创建的，只能被获取，为了方便 GCD 的使用，apple 默认为我们提供的。
     1、QOS_CLASS_USER_INTERACTIVE
                 __QOS_CLASS_AVAILABLE(macos(10.10), ios(8.0)) = 0x21,
     表示任务会被立即执行，在响应事件之后更新 UI，来提供好的用户体验。（不要放太耗时操作）。
     2、QOS_CLASS_USER_INITIATED
                 __QOS_CLASS_AVAILABLE(macos(10.10), ios(8.0)) = 0x19,
     表示任务由 UI 发起异步执行。适用场景是需要获取结果同时又可以继续交互的时候。(不要放太耗时操作)
     3、QOS_CLASS_DEFAULT
                 __QOS_CLASS_AVAILABLE(macos(10.10), ios(8.0)) = 0x15,
     默认优先级 (不是给程序员使用的，用来重置对列使用的)
     4、QOS_CLASS_UTILITY
                 __QOS_CLASS_AVAILABLE(macos(10.10), ios(8.0)) = 0x11,
     表示需要长时间运行的任务 (耗时操作，可以使用这个选项)
     5、QOS_CLASS_BACKGROUND
                 __QOS_CLASS_AVAILABLE(macos(10.10), ios(8.0)) = 0x09,
     表示用户不需要知道任务什么时候完成。选择这个选项速度慢得令人发指，非常不利于调试！（后台）
     6、QOS_CLASS_UNSPECIFIED
                 __QOS_CLASS_AVAILABLE(macos(10.10), ios(8.0)) = 0x00,
     未指定
     */
    /*
     performSelectorOnMainThread
     转载https://www.jianshu.com/p/fcc72b27dbd2
     datawaitUntilDone:这个参数设置为YES和NO的区别:
     设置为YES:只有当这个线程执行完毕,才会接着往下执行,否则一直等待
     设置为NO:不管这个线程有没有执行完毕,都可以继续往下执行
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:nil waitUntilDone:YES];
    });
}
-(IBAction)fetchedData:(id)sender{
    messageTextView.text=[NSString stringWithFormat:@"%@/n%@",messageTextView.text,@"dispatch_get_global_queue,会获取一个全局队列，我们姑且理解为系统为我们开启的一些全局线程。我们用priority指定队列的优先级，而flag作为保留字段备用（一般为0）"];
}

#pragma mark -dispatch_queue_create,创建一个新的调度队列，您可以向其提交块。
-(void)dispatchQueueCreate{
    /*
     转载：https://blog.csdn.net/liudongxinios/article/details/51463513
     DISPATCH_QUEUE_SERIAL:创建串行队列
     DISPATCH_QUEUE_CONCURRENT:创建并行队列
     */
    /*
     //串行
    dispatch_queue_t dqt=dispatch_queue_create("jyw.jyw.oc.jywTabBar", DISPATCH_QUEUE_SERIAL);
    //同步执行
    dispatch_sync(dqt, ^{
        NSLog(@"dispatch_queue_create,sync");
    });
    //异步执行
    dispatch_async(dqt, ^{
        NSLog(@"dispatch_queue_create,async");
    });*/
     //并行
    dispatch_queue_t dqt=dispatch_queue_create("jyw.jyw.oc.jywTabBar", DISPATCH_QUEUE_CONCURRENT);
    //异步执行
    dispatch_async(dqt, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@/n%@",self->messageTextView.text,@"dispatch_queue_create,async,创建一个新的调度队列，您可以向其提交块"];
        });
        
    });
    //同步执行
    dispatch_sync(dqt, ^{
        messageTextView.text=[NSString stringWithFormat:@"%@/n%@",messageTextView.text,@"dispatch_queue_create,sync,创建一个新的调度队列，您可以向其提交块"];
    });
}
#pragma mark -dispatch_queue_create_with_target,创建一个新的调度队列，您可以向其提交块。
-(void)dispatchQueueCreateWithTarget{
    /*
    //创建并行
    dispatch_queue_t dqt=dispatch_queue_create_with_target("jyw.jyw.oc.jywTabBar", DISPATCH_QUEUE_CONCURRENT, DISPATCH_TARGET_QUEUE_DEFAULT);
    //异步执行
    dispatch_async(dqt, ^{
        NSLog(@"dispatch_queue_create_with_target,async");
    });
    //同步执行
    dispatch_sync(dqt, ^{
        NSLog(@"dispatch_queue_create_with_target,sync");
    });*/
    
     //创建串行
    dispatch_queue_t dqt=dispatch_queue_create_with_target("jyw.jyw.oc.jywTabBar", DISPATCH_QUEUE_SERIAL,DISPATCH_TARGET_QUEUE_DEFAULT);
    //同步执行
    dispatch_sync(dqt, ^{
        messageTextView.text=[NSString stringWithFormat:@"%@/n%@",messageTextView.text,@"dispatch_queue_create_with_target,sync,创建一个新的调度队列，您可以向其提交块"];
    });
    //异步执行
    dispatch_async(dqt, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@/n%@",self->messageTextView.text,@"dispatch_queue_create_with_target,async,创建一个新的调度队列，您可以向其提交块"];
        });
        
    });
}
#pragma mark -dispatch_queue_main_t,绑定到应用程序主线程并在该线程上串行执行任务的调度队列。
-(void)dispatchQueueMainT{
    dispatch_queue_main_t dqmt=(dispatch_queue_main_t)dispatch_queue_create("jyw.jyw.oc.jywTabBar", DISPATCH_QUEUE_SERIAL);
    //同步执行
    dispatch_sync(dqmt, ^{
        messageTextView.text=[NSString stringWithFormat:@"%@/n%@",messageTextView.text,@"dispatch_queue_main_t,sync,绑定到应用程序主线程并在该线程上串行执行任务的调度队列"];
    });
    //异步执行
    dispatch_async(dqmt, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@/n%@",self->messageTextView.text,@"dispatch_queue_main_t,async,绑定到应用程序主线程并在该线程上串行执行任务的调度队列"];
        });
    });
}
#pragma mark -dispatch_queue_global_t,使用全局线程池中的线程并发执行任务的调度队列。
-(void)dispatchQueueGlobalT{
    dispatch_queue_global_t dqgt=(dispatch_queue_global_t)dispatch_queue_create("jyw.jyw.oc.jywTabBar", DISPATCH_QUEUE_CONCURRENT);
    //同步执行
    dispatch_sync(dqgt, ^{
        messageTextView.text=[NSString stringWithFormat:@"%@/n%@",messageTextView.text,@"dispatch_queue_global_t,sync,使用全局线程池中的线程并发执行任务的调度队列"];
    });
    //异步执行
    dispatch_async(dqgt, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@/n%@",self->messageTextView.text,@"dispatch_queue_global_t,async,使用全局线程池中的线程并发执行任务的调度队列"];
        });
    });
}
#pragma mark -dispatch_queue_serial_t,分派队列，按先进先出（FIFO）顺序连续执行任务。
-(void)dispatchQueueSerialT{
    dispatch_queue_serial_t dqst=(dispatch_queue_serial_t)dispatch_queue_create("jyw.jyw.oc.jywTabBar", DISPATCH_QUEUE_SERIAL);
    //同步执行
    dispatch_sync(dqst, ^{
        messageTextView.text=[NSString stringWithFormat:@"%@/n%@",messageTextView.text,@"dispatch_queue_serial_t,sync,分派队列，按先进先出（FIFO）顺序连续执行任务"];
    });
    //异步执行
    dispatch_async(dqst, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@/n%@",self->messageTextView.text,@"dispatch_queue_serial_t,async,分派队列，按先进先出（FIFO）顺序连续执行任务"];
        });
        
    });
}
#pragma mark -dispatch_queue_concurrent_t,一个调度队列，它以任何顺序并发执行任务，并遵守可能存在的任何障碍。
-(void)dispatchQueueConcurrentT{
    dispatch_queue_concurrent_t dqct=(dispatch_queue_concurrent_t)dispatch_queue_create("jyw.jyw.oc.jywTabBar", DISPATCH_QUEUE_CONCURRENT);
    //同步执行
    dispatch_sync(dqct, ^{
        messageTextView.text=[NSString stringWithFormat:@"%@/n%@",messageTextView.text,@"dispatch_queue_concurrent_t,sync,一个调度队列，它以任何顺序并发执行任务，并遵守可能存在的任何障碍"];
    });
    //异步执行
    dispatch_async(dqct, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@/n%@",self->messageTextView.text,@"dispatch_queue_concurrent_t,async,一个调度队列，它以任何顺序并发执行任务，并遵守可能存在的任何障碍"];
        });
        
    });
    
}
#pragma mark -dispatch_queue_attr_make_with_qos_class,返回适合于创建具有所需服务质量信息的调度队列的属性。
-(void)dispatchQueueAttrMakeWithQosClass{
    //创建属性，并行，默认队列，优先值1
    dispatch_queue_attr_t dqat=dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT, QOS_CLASS_DEFAULT, 1);
    dispatch_queue_t dqt=dispatch_queue_create("jyw.jyw.oc.jywTabBar", dqat);
    //同步执行
    dispatch_sync(dqt, ^{
        messageTextView.text=[NSString stringWithFormat:@"%@/n%@",messageTextView.text,@"dispatch_queue_attr_make_with_qos_class,sync,返回适合于创建具有所需服务质量信息的调度队列的属性"];
    });
    //异步执行
    dispatch_async(dqt, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@/n%@",self->messageTextView.text,@"dispatch_queue_attr_make_with_qos_class,async,返回适合于创建具有所需服务质量信息的调度队列的属性"];
        });
        
    });
    
}
#pragma mark -dispatch_async_f,提交应用程序定义的函数以在调度队列上异步执行并立即返回。
//带有后缀_f(比如dispatch_sync_f，dispatch_after_f)就是提交给队列一个C语言函数，因为极少用到这种形式
static JYW_GCDViewController *selfViewGCD;
-(void)dispatchAsyncF{
    selfViewGCD=self;
    int centent=1;
    //异步执行
    dispatch_async_f(dispatch_get_main_queue(), &centent, dispatchAsyncF_Function);
}
void dispatchAsyncF_Function (void *centent){
    int *a=centent;
    [selfClass messageStrWithInt:*a];
}
-(void)messageStrWithInt:(int)i{
    messageTextView.text=[NSString stringWithFormat:@"%@/n%@,%d",messageTextView.text,@"dispatch_once_f,在应用程序的生存期内，仅执行一次应用程序定义的功能",i];
}
#pragma mark -dispatch_after,使块在指定时间执行。
-(void)dispatchAfter{
    /*转载：https://blog.csdn.net/u013410274/article/details/80512198 */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5*USEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@/n%@",self->messageTextView.text,@"dispatch_after,使块在指定时间执行"];
        });
        
    });
}
#pragma mark -dispatch_once,在应用程序的生存期内，仅执行一次块对象。
-(void)dispatchOnce{
    /*
     转载：https://blog.csdn.net/qq_18683985/article/details/90412618
     */
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        messageTextView.text=[NSString stringWithFormat:@"%@/n%@",self->messageTextView.text,@"dispatch_once,在应用程序的生存期内，仅执行一次块对象"];
    });
}
#pragma mark -dispatch_once_f,在应用程序的生存期内，仅执行一次应用程序定义的功能。
static JYW_GCDViewController *selfClass =nil;
-(void)dispatchOnceF{
    /*
     转载：https://www.jianshu.com/p/df74a54b6b75
     */
    selfClass=self;
    dispatch_once_t onceToken;
    NSArray *array=@[@"1",@"2"];
    dispatch_function_t func=&function;
    dispatch_once_f(&onceToken, (__bridge_retained void*)array, func);
    
}
void function (void *array){
    NSArray *a=(__bridge id)array;
    [selfClass messageStrWithNSArray:a];
}
-(void)messageStrWithNSArray:(NSArray *)array{
    messageTextView.text=[NSString stringWithFormat:@"%@/n%@,%@,%@",messageTextView.text,@"dispatch_once_f,在应用程序的生存期内，仅执行一次应用程序定义的功能",array[0],array[1]];
}
#pragma mark -dispatch_apply,将单个块提交给调度队列，并使该块执行指定的次数。
-(void)dispatchApply{
    /*
    转载：https://www.cnblogs.com/denz/p/5218187.html
     */
    NSArray *array=@[@"a",@"b",@"c",@"d",@"e",@"f"];
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        dispatch_apply(array.count, queue, ^(size_t index) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self->messageTextView.text=[NSString stringWithFormat:@"%@/n%@,%zu:%@",self->messageTextView.text,@"dispatch_apply,将单个块提交给调度队列，并使该块执行指定的次数",index,[array objectAtIndex:index]];
            });
            
        });
        
    });
}
#pragma mark -dispatch_queue_get_label,返回在创建时分配给调度队列的标签。
-(void)dispatchQueueGetLabel{
    //DISPATCH_CURRENT_QUEUE_LABEL,将此常量传递给dispatch_queue_get_label函数以检索当前队列的标签。
    dispatch_queue_t queue=dispatch_queue_create("jyw.jyw.oc.tabBar", DISPATCH_CURRENT_QUEUE_LABEL);
    const char *label=dispatch_queue_get_label(queue);
    messageTextView.text=[NSString stringWithFormat:@"%@/n%@,%s",messageTextView.text,@"dispatch_queue_get_label,返回在创建时分配给调度队列的标签",label];
}
#pragma mark -dispatch_set_target_queue，指定要在其上执行与当前对象关联的工作的调度队列。
-(void)dispatchSetTargetQueue{
/*
 转载：https://www.jianshu.com/p/1945f4b8b203
 */
    dispatch_queue_t queue=dispatch_queue_create("jyw.jyw.oc.tabBar", DISPATCH_QUEUE_PRIORITY_DEFAULT);
    dispatch_set_target_queue(queue, dispatch_get_main_queue());
    messageTextView.text=[NSString stringWithFormat:@"%@/n%@",messageTextView.text,@"dispatch_set_target_queue,指定要在其上执行与当前对象关联的工作的调度队列"];
}
#pragma mark -tableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tbArray.count;
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
    cell.textLabel.text = [tbArray objectAtIndex:indexPath.row];
    
    
    cell.detailTextLabel.text = [tbSubtitleArray objectAtIndex:indexPath.row];
    //添加右侧注释
    
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self dispatchGetGlobalQueue];
            break;
        case 1:
            [self dispatchQueueCreate];
            break;
        case 2:
            [self dispatchQueueCreateWithTarget];
            break;
        case 3:
            [self dispatchQueueMainT];
            break;
        case 4:
            [self dispatchQueueGlobalT];
            break;
        case 5:
            [self dispatchQueueSerialT];
            break;
        case 6:
            [self dispatchQueueConcurrentT];
            break;
        case 7:
            [self dispatchQueueAttrMakeWithQosClass];
            break;
        case 8:
            [self dispatchAsyncF];
            break;
        case 9:
            [self dispatchAfter];
            break;
        case 10:
            [self dispatchOnce];
            break;
        case 11:
            [self dispatchOnceF];
            break;
        case 12:
            [self dispatchApply];
            break;
        case 13:
            [self dispatchQueueGetLabel];
            break;
        case 14:
            [self dispatchSetTargetQueue];
            break;
        default:
            break;
    }
}
#pragma mark -GCD
/*
 方法
//返回与应用程序的主线程关联的串行调度队列。主要用于更新UI显示
dispatch_get_main_queue
//返回具有指定服务质量类的系统定义的全局并发队列。
dispatch_get_global_queue
//创建一个新的调度队列，您可以向其提交块。
dispatch_queue_create
//创建一个新的调度队列，您可以向其提交块。
dispatch_queue_create_with_target
 */
/*
 属性
DISPATCH_QUEUE_SERIAL//以FIFO顺序串行执行块的调度队列。
DISPATCH_QUEUE_CONCURRENT//同时执行块的调度队列。
*/
/*
对象
dispatch_queue_t//应用程序向其提交块以进行后续执行的轻量级对象。
dispatch_queue_main_t//绑定到应用程序主线程并在该线程上串行执行任务的调度队列。
dispatch_queue_global_t//使用全局线程池中的线程并发执行任务的调度队列。
dispatch_queue_serial_t//分派队列，按先进先出（FIFO）顺序连续执行任务。
dispatch_queue_concurrent_t//一个调度队列，它以任何顺序并发执行任务，并遵守可能存在的任何障碍。
 */
/*
 属性
dispatch_queue_attr_t//描述调度队列行为的属性。
dispatch_queue_attr_make_with_qos_class//返回适合于创建具有所需服务质量信息的调度队列的属性。
dispatch_queue_get_qos_class//返回指定队列的服务质量类。
dispatch_qos_class_t//服务质量类，指定执行任务的优先级。
dispatch_queue_attr_make_initially_inactive//返回一个属性，该属性将调度队列配置为最初处于非活动状态。
dispatch_queue_attr_make_with_autorelease_frequency//返回一个属性，该属性指定调度队列如何管理其执行的块的自动释放池。
dispatch_autorelease_frequency_t//指示调度队列为其任务创建自动释放池的频率的常数。
 
dispatch_async//提交一个块以在调度队列上异步执行并立即返回。
dispatch_async_f//提交应用程序定义的函数以在调度队列上异步执行并立即返回。
dispatch_after//使块在指定时间执行。
dispatch_after_f//使应用程序定义的函数入队以在指定时间执行。
dispatch_function_t//提交给调度队列的函数原型。
dispatch_block_t//提交给分派队列的块的原型，不带任何参数，没有返回值。
 
 同步执行任务
dispatch_sync//提交要执行的块对象，并在该块完成执行后返回。
dispatch_sync_f//提交应用程序定义的函数以在调度队列上同步执行。

 仅执行一次任务
dispatch_once//在应用程序的生存期内，仅执行一次块对象。
dispatch_once_f//在应用程序的生存期内，仅执行一次应用程序定义的功能。
dispatch_once_t//与dispatch_once函数一起使用的谓词。

 并行执行任务
dispatch_apply//将单个块提交给调度队列，并使该块执行指定的次数。
dispatch_apply_f//将单个功能提交到调度队列，并使该功能执行指定的次数。
 DISPATCH_APPLY_AUTO
 
dispatch_queue_get_label//返回在创建时分配给调度队列的标签。
DISPATCH_CURRENT_QUEUE_LABEL//将此常量传递给dispatch_queue_get_label函数以检索当前队列的标签。
dispatch_set_target_queue//指定要在其上执行与当前对象关联的工作的调度队列。

 获取和设置上下文数据
dispatch_get_specific//返回与当前调度队列关联的密钥的值。
dispatch_queue_set_specific//设置指定调度队列的键/值数据。
dispatch_queue_get_specific//获取与指定的调度队列关联的键的值。

 管理主调度队列
dispatch_main//执行提交到主队列的块。
*/
@end
