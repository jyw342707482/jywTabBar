//
//  JYW_RunLoopExamplesViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/24.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_RunLoopExamplesViewController.h"
static NSString *CellTableIndentifier = @"CellTableIdentifier";
@interface JYW_RunLoopExamplesViewController ()
{
    NSArray *tableGroup;
    NSArray *tableDSArray;
    NSArray *subtitleArray;
    
    
    NSRunLoop *limitDateForModeRunLoop;
    
}
@end

@implementation JYW_RunLoopExamplesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableGroup=@[
        @"Accessing Run Loops and Modes(访问运行循环和模式)",
        @"Managing Timers(管理计时器)",
        @"Managing Ports(管理端口)",
        @"Running a Loop(运行循环)",
        @"Scheduling and Canceling Messages(安排和取消消息)",
        @"Instance Methods(实例方法)",
    ];
    tableDSArray=@[
        @[@"",@"currentRunLoop",
          @"currentMode",
          @"- limitDateForMode:",
          @"mainRunLoop",
          @"- getCFRunLoop"
        ],
        @[@"",@"- addTimer:forMode:"],
        @[@"",@"- addPort:forMode:",
          @"- removePort:forMode:"
        ],
        @[@"",@"- run",
          @"- runMode:beforeDate:",
          @"- runUntilDate:",
          @"- acceptInputForMode:beforDate"
        ],
        @[@"",@"- performSelector:target:argument:order:modes:",
          @"- cancelPerformSelector:target:argument:",
          @"- cancelPerformSelectorsWithTarget:"
        ],
        @[@"",@"- performBlock:",
          @"- performInModes:block:"
        ]
    ];
    subtitleArray=@[
        @[@"",@"返回当前线程的运行循环。",
          @"接收器的当前输入模式。",
          @"在指定模式下通过运行循环执行一次遍历，并返回计划启动下一个计时器的日期。",
          @"返回主线程的运行循环。",
          @"返回接收者的基础CFRunLoop对象,来达到线程安全的目的。"
        ],
        @[@"",@"用给定的输入模式注册给定的计时器。"],
        @[@"",@"将端口作为输入源添加到运行循环的指定模式。",
          @"从运行循环的指定输入模式中删除端口。"
        ],
        @[@"",@"将接收器置于永久循环中，在此期间它将处理来自所有连接的输入源的数据。",
          @"运行一次循环，直到指定的日期为止，以指定的模式阻止输入。",
          @"运行循环直到指定的日期，在此期间它将处理来自所有附加输入源的数据。",
          @"运行循环一次或直到指定的日期，仅接受指定模式的输入。"
        ],
        @[@"",@"安排在接收方上发送消息。",
          @"取消发送先前安排的消息。",
          @"取消预定给定目标的所有未完成有序表演。"
        ],
        @[@"",@"",@""]
    ];
}
#pragma mark -Accessing Run Loops and Modes(访问运行循环和模式)
//currentRunLoop(返回当前线程的运行循环。)
-(void)currentRunLoop{
    //NSTimer *timer;
    dispatch_queue_t queue=dispatch_queue_create("jyw.jyw.tabBar", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSRunLoop *rloop=[NSRunLoop currentRunLoop];
        NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(currentRunLoopTimer) userInfo:nil repeats:YES];
        [rloop addTimer:timer forMode:NSDefaultRunLoopMode];
        [rloop run];
    });
}
-(void)currentRunLoopTimer{
    dispatch_async(dispatch_get_main_queue(), ^{
        self->messageTextView.text=@"runloop子线程运行中。";
    });
    NSLog(@"runloop");
}
/*
NSDefaultRunLoopMode: App默认的mode，一般情况下App都是运行在这个mode下的。
 NSEventTrackingRunLoopMode：模态跟踪事件时，例如鼠标拖动循环，应将运行循环设置为此模式。
NSModalPanelRunLoopMode ： 等待诸如NSSavePanel或NSOpenPanel之类的模式面板的输入时，应将运行循环设置为此模式。
 
UITrackingRunLoopMode ： 进行控件中跟踪时设置的模式。
 NSRunLoopCommonModes： 占位mode，可以向其中添加其他mode用以检测多个mode的事件
 */
//currentMode(接收器的当前输入模式。)
-(void)currentMode{
    NSString *str=@"NSDefaultRunLoopMode: App默认的mode，一般情况下App都是运行在这个mode下的;NSEventTrackingRunLoopMode：模态跟踪事件时，例如鼠标拖动循环，应将运行循环设置为此模式;NSModalPanelRunLoopMode ： 等待诸如NSSavePanel或NSOpenPanel之类的模式面板的输入时，应将运行循环设置为此模式; UITrackingRunLoopMode ： 进行控件中跟踪时设置的模式;NSRunLoopCommonModes： 占位mode，可以向其中添加其他mode用以检测多个mode的事件";
    messageTextView.text=str;
}
//limitDateForMode
/*
(获取下个响应时间
解释：例如定时器的执行，其并不是按时间的间隔进行调用方法，而是在定时器注册到runloop中后，runloop会设置一个一个的时间点进行调用，比如10，20，30。如果错过了某个时间点，定时器并不会延时调用，而是直接等待下一个时间点调用，所以定时器并不是精准的。)*/
-(void)limitDateForMode{
    dispatch_queue_t queue=dispatch_queue_create("jyw.jyw.tabBar", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        self->limitDateForModeRunLoop=[NSRunLoop currentRunLoop];
        NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(limitDateForModeTimer) userInfo:nil repeats:YES];
        [self->limitDateForModeRunLoop addTimer:timer forMode:NSRunLoopCommonModes];
        [self->limitDateForModeRunLoop run];
    });
}
-(void)limitDateForModeTimer{
    NSDate *d=[self->limitDateForModeRunLoop limitDateForMode:NSRunLoopCommonModes];
    dispatch_async(dispatch_get_main_queue(), ^{
        self->messageTextView.text=[NSString stringWithFormat:@"runloop子线程下次运行时间:%@",d];
    });
    NSLog(@"runloop");
}
//mainRunLoop(获取主线程运行循环)
-(void)mainRunLoop{
    NSTimer *mainTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(mainRunLoopTimer) userInfo:nil repeats:YES];
    NSRunLoop *rLoop=[NSRunLoop mainRunLoop];
    [rLoop addTimer:mainTimer forMode:NSDefaultRunLoopMode];
}
-(void)mainRunLoopTimer{
    dispatch_async(dispatch_get_main_queue(), ^{
        self->messageTextView.text=@"mainRunLoop运行中";
    });
    NSLog(@"mainRunLoop");
}
//getCFRunLoop(返回接收者的基础CFRunLoop对象,来达到线程安全的目的。)
-(void)getCFRunLoop{
    messageTextView.text=@"返回接收者的基础CFRunLoop对象,来达到线程安全的目的。";
}

#pragma mark -Managing Ports(管理端口)
//addPort:forMode:(将端口作为输入源添加到运行循环的指定模式。)
-(void)addPort_forMode{
    NSRunLoop *rLoop=[NSRunLoop mainRunLoop];
    NSPort *mPort=[NSPort port];
    [rLoop addPort:mPort forMode:NSDefaultRunLoopMode];
    NSLog(@"%@",rLoop);
    [rLoop removePort:mPort forMode:NSDefaultRunLoopMode];
}

#pragma mark -Running a Loop(运行循环)
//run 将接收器置于永久循环中，在此期间它将处理来自所有连接的输入源的数据。
-(void)run{
    messageTextView.text=@"将接收器置于永久循环中，在此期间它将处理来自所有连接的输入源的数据。";
}
//- runMode:beforeDate:运行一次循环，直到指定的日期为止，以指定的模式阻止输入。
-(void)runMode_beforeDate{
    dispatch_queue_t queue=dispatch_queue_create("jyw.jyw.tabBar", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSRunLoop *rloop=[NSRunLoop currentRunLoop];
        NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runMode_beforeDateTimer) userInfo:nil repeats:YES];
        [rloop addTimer:timer forMode:NSDefaultRunLoopMode];
        
        [rloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    });
}
-(void)runMode_beforeDateTimer{
    dispatch_async(dispatch_get_main_queue(), ^{
        self->messageTextView.text=@"mainRunLoop,运行一次循环，直到指定的日期为止，以指定的模式阻止输入";
    });
}
//- runUntilDate:运行循环直到指定的日期，在此期间它将处理来自所有附加输入源的数据。
-(void)runUntilDate{
    dispatch_queue_t queue=dispatch_queue_create("jyw.jyw.tabBar", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSRunLoop *rloop=[NSRunLoop currentRunLoop];
        NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runUnitilDateTimer) userInfo:nil repeats:YES];
        [rloop addTimer:timer forMode:NSDefaultRunLoopMode];
        [rloop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    });
}
-(void)runUnitilDateTimer{
    dispatch_async(dispatch_get_main_queue(), ^{
        self->messageTextView.text=@"mainRunLoop,运行循环直到指定的日期，在此期间它将处理来自所有附加输入源的数据";
    });
}
//- acceptInputForMode:beforDate运行循环一次或直到指定的日期，仅接受指定模式的输入。
-(void)acceptInputForMode_beforDate{
    
    dispatch_queue_t queue=dispatch_queue_create("jyw.jyw.tabBar", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSRunLoop *rloop=[NSRunLoop currentRunLoop];
        NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(acceptInputForMode_beforDateTimer) userInfo:nil repeats:YES];
        [rloop addTimer:timer forMode:NSDefaultRunLoopMode];
        [rloop acceptInputForMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    });
}
-(void)acceptInputForMode_beforDateTimer{
    dispatch_async(dispatch_get_main_queue(), ^{
        self->messageTextView.text=@"mainRunLoop,运行循环一次或直到指定的日期，仅接受指定模式的输入";
    });
}

#pragma mark -Scheduling and Canceling Messages(安排和取消消息)
//- performSelector:target:argument:order:modes:(安排在接收方上发送消息。)
-(void)performSelector_target_argument_order_modes{
    //主线程上调用
    [[NSRunLoop currentRunLoop]performSelector:@selector(performSelector_target_argument_order_modesSelector:) target:self argument:@"安排在接收方上发送消息。(主线程调用)" order:0 modes:@[NSDefaultRunLoopMode]];
    /*
    //子线程上调用
    dispatch_queue_t queue=dispatch_queue_create("jyw.jyw.tabbar", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSRunLoop *rLoop=[NSRunLoop currentRunLoop];
        [rLoop addPort:[NSPort port] forMode:NSRunLoopCommonModes];
        [rLoop performSelector:@selector(performSelector_target_argument_order_modesSelector:) target:self argument:@"安排在接收方上发送消息。(子线程调用)" order:1 modes:@[NSDefaultRunLoopMode]];
    });
     */
}
-(void)performSelector_target_argument_order_modesSelector:(id)str{
    messageTextView.text=str;
}

//- cancelPerformSelector:target:argument:(取消发送先前安排的消息。)
-(void)cancelPerformSelector_target_argument{
    [[NSRunLoop currentRunLoop] cancelPerformSelector:@selector(performSelector_target_argument_order_modesSelector:) target:self argument:@"安排在接收方上发送消息。(主线程调用)"];
    
}
//- cancelPerformSelectorsWithTarget:(取消预定给定目标的所有未完成有序表演。)
-(void)cancelPerformSelectorsWithTarget{
    [[NSRunLoop currentRunLoop] cancelPerformSelectorsWithTarget:self];
}
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
                    
                    break;
                case 1:
                    [self currentRunLoop];
                    break;
                case 2:
                    [self currentMode];
                    break;
                case 3:
                    [self limitDateForMode];
                    break;
                case 4:
                    [self mainRunLoop];
                    break;
                case 5:
                    [self getCFRunLoop];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            [self mainRunLoop];
            break;
        case 2:
            switch (indexPath.row) {
                case 1:
                    [self addPort_forMode];
                    break;
                case 2:
                    [self addPort_forMode];
                    break;
                default:
                    break;
            }
            break;
        case 3:
            switch (indexPath.row) {
                case 1:
                    [self run];
                    break;
                case 2:
                    [self runMode_beforeDate];
                    break;
                case 3:
                    [self runUntilDate];
                    break;
                case 4:
                    [self acceptInputForMode_beforDate];
                    break;
                default:
                    break;
            }
            break;
        case 4:
            switch (indexPath.row) {
                case 1:
                    [self performSelector_target_argument_order_modes];
                    break;
                case 2:
                    [self cancelPerformSelector_target_argument];
                    break;
                case 3:
                    [self cancelPerformSelectorsWithTarget];
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
