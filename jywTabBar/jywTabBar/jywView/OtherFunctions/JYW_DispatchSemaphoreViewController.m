//
//  JYW_DispatchSemaphoreViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/4.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_DispatchSemaphoreViewController.h"

@interface JYW_DispatchSemaphoreViewController ()
{
    NSArray *titleArray;
    NSArray *subtitleArray;
}
@end

@implementation JYW_DispatchSemaphoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    titleArray=@[@"Dispatch Semaphore",
                 @"Dispatch Barrier"
        ];
    subtitleArray=@[@"异步线程同步操作",
                    @"线程阻断，"
        ];
}

#pragma mark -Dispatch Semaphore，信号量，用信号量机制使异步线程完成同步操作
/*
 转载：https://www.cnblogs.com/SUPER-F/p/8916490.html
 转载：https://blog.csdn.net/a18339063397/article/details/82663788
 */
#pragma mark -异步线程同步操作
-(void)dispatchSemaphore{
    //创建信号量
    dispatch_semaphore_t dst=dispatch_semaphore_create(3);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_signal(dst);
        NSLog(@"semaphore1,signal");
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   semaphore1,signal",self->messageTextView.text];
        });
        dispatch_semaphore_wait(dst, DISPATCH_TIME_FOREVER);
        NSLog(@"semaphore1,wait");
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   semaphore1,wait",self->messageTextView.text];
        });
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_semaphore_signal(dst);
        NSLog(@"semaphore2,signal");
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   semaphore2,signal",self->messageTextView.text];
        });
        dispatch_semaphore_wait(dst, DISPATCH_TIME_FOREVER);
        NSLog(@"semaphore2,wait");
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   semaphore2,wait",self->messageTextView.text];
        });
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_semaphore_signal(dst);
        NSLog(@"semaphore3,signal");
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   semaphore3,signal",self->messageTextView.text];
        });
        dispatch_semaphore_wait(dst, DISPATCH_TIME_FOREVER);
        NSLog(@"semaphore3,wait");
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   semaphore3,wait",self->messageTextView.text];
        });
    });
}
#pragma mark -dispatch Barrier
/*
 转载：https://www.jianshu.com/p/0adc07bc185e
 转载：https://blog.csdn.net/u013046795/article/details/47057585
 */
-(void)dispatchBarrier{
    dispatch_queue_t dqt=dispatch_queue_create("jyw.jyw.oc.tabBar", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(dqt, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   Barrier1",self->messageTextView.text];
        });
    });
    dispatch_async(dqt, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   Barrier2",self->messageTextView.text];
        });
    });
    dispatch_async(dqt, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   Barrier3",self->messageTextView.text];
        });
    });
    dispatch_barrier_async(dqt, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   Barrier100",self->messageTextView.text];
        });
    });
    dispatch_async(dqt, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   Barrier4",self->messageTextView.text];
        });
    });
    dispatch_async(dqt, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   Barrier5",self->messageTextView.text];
        });
    });
    dispatch_async(dqt, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self->messageTextView.text=[NSString stringWithFormat:@"%@;   Barrier6",self->messageTextView.text];
        });
    });
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
            [self dispatchSemaphore];
            break;
        case 1:
            [self dispatchBarrier];
            break;
        default:
            break;
    }
}

@end
