//
//  JYW_OtherFunctionsViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/5.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_OtherFunctionsViewController.h"
//视频
#import "JYW_AVViewController.h"
#import "JYW_AVListViewController.h"
//动画
#import "JYW_AnimationViewController.h"
#import "JYW_FireworksViewController.h"
#import "JYW_SnowflakeViewController.h"
//测试
#import "JYW_TestViewController.h"
//多线程
#import "JYW_GCDViewController.h"
#import "JYW_GCDDispatchWorkItemViewController.h"
#import "JYW_GCDDispatchGroupViewController.h"
#import "JYW_GCDDispatchSourceViewController.h"
#import "JYW_DispatchSemaphoreViewController.h"
//Code Animation动画
#import "JYW_Animation1ViewController.h"
#import "JYW_Animation2ViewController.h"
#import "JYW_Animation3ViewController.h"
#import "JYW_Animation4ViewController.h"
#import "JYW_Animation5ViewController.h"
#import "JYW_UIBezierPathViewController.h"
#import "JYW_CALayerViewController.h"
//runtime
#import "JYW_RuntimeExamplesViewController.h"
#import "JYW_ApplicationScenarioViewController.h"
//runloop
#import "JYW_RunLoopExamplesViewController.h"
#import "JYW_CFRunLoopExamplesViewController.h"
@interface JYW_OtherFunctionsViewController ()
{
    NSArray *tableDSArray;
    NSArray *subtitleArray;
}
@end

@implementation JYW_OtherFunctionsViewController

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
    self.title=@"OtherFunctions";
    tableDSArray=@[@"自定义AVPlayer播放器",@"视频列表",@"动画",@"烟花动画",@"下雪动画",
                   @"GCD多线程-Dispatch Queue",@"GCD多线程-Dispatch Work Item",@"GCD多线程-Dispatch Group",@"GCD多线程-Dispatch Source",@"GCD多线程-Dispatch Semaphore",
                   @"Code Animation CALayer",@"Code Animation CABasicAnimation",@"Code Animation CAKeyAnimation",@"Code Animation CASpringAnimation",@"Code Animation CATransition",@"UIBezierPath",
                   @"CALayer",@"runtime",@"runtime应用场景",
                   @"runloop",@"CFRunloop",
                   @"测试"];
    subtitleArray=@[@"类型",@"类型",@"类型",@"类型",@"类型",@"类型",@"块",@"组",@"资源、I/O",@"信号量、Barrier线程阻断",@"presentationLayer(展示层)/modelLayer(模型层)",@"动画",@"动画",@"弹簧动画",@"转场动画",@"贝塞尔曲线",@"CALayer",@"实例",@"实例",@"实例",@"实例",@"类型"];
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
    
    
    cell.detailTextLabel.text = [subtitleArray objectAtIndex:indexPath.row];
    //添加右侧注释
    
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        JYW_AVViewController *avPlayerView1=[[JYW_AVViewController alloc] init];
        [self.navigationController pushViewController:avPlayerView1 animated:YES];
    }
    else if(indexPath.row==1){
        JYW_AVListViewController *avPlayerView2=[[JYW_AVListViewController alloc] init];
        [self.navigationController pushViewController:avPlayerView2 animated:YES];
    }
    else if(indexPath.row==2){
        JYW_AnimationViewController *avc=[[JYW_AnimationViewController alloc] init];
        [self.navigationController pushViewController:avc animated:YES];
    }
    else if(indexPath.row==3){
        JYW_FireworksViewController *fvc=[[JYW_FireworksViewController alloc] init];
        //fvc.modalPresentationStyle=UIModalPresentationFullScreen;
        //[self presentViewController:fvc animated:YES completion:nil];
        [self.navigationController pushViewController:fvc animated:YES];
    }
    else if(indexPath.row==4){
        JYW_SnowflakeViewController *svc=[[JYW_SnowflakeViewController alloc] init];
        //[self presentViewController:svc animated:YES completion:nil];
        [self.navigationController pushViewController:svc animated:YES];
    }
    //GCD
    else if(indexPath.row==5){
        JYW_GCDViewController *gcd=[[JYW_GCDViewController alloc] init];
        [self.navigationController pushViewController:gcd animated:YES];
    }
    else if(indexPath.row==6){
        JYW_GCDDispatchWorkItemViewController *gcd=[[JYW_GCDDispatchWorkItemViewController alloc] init];
        [self.navigationController pushViewController:gcd animated:YES];
    }
    else if(indexPath.row==7)
    {
        JYW_GCDDispatchGroupViewController *gcd=[[JYW_GCDDispatchGroupViewController alloc] init];
        [self.navigationController pushViewController:gcd animated:YES];
    }
    else if(indexPath.row==8){
        JYW_GCDDispatchSourceViewController *gcd=[[JYW_GCDDispatchSourceViewController alloc] init];
        [self.navigationController pushViewController:gcd animated:YES];
    }
    else if(indexPath.row==9){
        JYW_DispatchSemaphoreViewController *gcd=[[JYW_DispatchSemaphoreViewController alloc] init];
        [self.navigationController pushViewController:gcd animated:YES];
    }
    //Code Animation
    else if(indexPath.row==10){
        JYW_Animation1ViewController *animation=[[JYW_Animation1ViewController alloc] init];
        [self.navigationController pushViewController:animation animated:YES];
    }
    else if(indexPath.row==11){
        JYW_Animation2ViewController *animation=[[JYW_Animation2ViewController alloc] init];
        [self.navigationController pushViewController:animation animated:YES];
    }
    else if(indexPath.row==12){
        JYW_Animation3ViewController *animation=[[JYW_Animation3ViewController alloc] init];
        [self.navigationController pushViewController:animation animated:YES];
    }
    else if(indexPath.row==13){
        JYW_Animation4ViewController *animation=[[JYW_Animation4ViewController alloc] init];
        [self.navigationController pushViewController:animation animated:YES];
    }
    else if(indexPath.row==14){
        JYW_Animation5ViewController *animation=[[JYW_Animation5ViewController alloc] init];
        [self.navigationController pushViewController:animation animated:YES];
    }
    else if(indexPath.row==15){
        JYW_UIBezierPathViewController *animation=[[JYW_UIBezierPathViewController alloc] init];
        [self.navigationController pushViewController:animation animated:YES];
    }
    else if(indexPath.row==16){
        JYW_CALayerViewController *animation=[[JYW_CALayerViewController alloc] init];
        [self.navigationController pushViewController:animation animated:YES];
    }
    else if(indexPath.row==17){
        JYW_RuntimeExamplesViewController *runT=[[JYW_RuntimeExamplesViewController alloc] init];
        [self.navigationController pushViewController:runT animated:YES];
    }
    else if(indexPath.row==18){
        JYW_ApplicationScenarioViewController *runT=[[JYW_ApplicationScenarioViewController alloc] init];
        [self.navigationController pushViewController:runT animated:YES];
    }
    else if(indexPath.row==19){
        JYW_RunLoopExamplesViewController *runloop=[[JYW_RunLoopExamplesViewController alloc] init];
        [self.navigationController pushViewController:runloop animated:YES];
    }
    else if(indexPath.row==20){
        JYW_CFRunLoopExamplesViewController *runloop=[[JYW_CFRunLoopExamplesViewController alloc] init];
        [self.navigationController pushViewController:runloop animated:YES];
    }
    else
    {
        JYW_TestViewController *avc=[[JYW_TestViewController alloc] init];
        [self.navigationController pushViewController:avc animated:YES];
    }
}

@end
