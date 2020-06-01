//
//  JYW_FictionTableViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/27.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_FictionTableViewController.h"
#import "JYW_FictionViewModel.h"
#import "JYW_FictionMainModel.h"
#import "JYW_FictionModel.h"
#import "JYW_FictionTableViewCell.h"
#import "JYW_SelectAudioView.h"
#import "UIView+JYW_Border.h"
@interface JYW_FictionTableViewController ()<JYW_SelectAudioView_Delegate,JYW_FictionViewModel_Delegate>
{
    JYW_FictionMainModel *fictionMainModel;
    //NSMutableArray *tableDSArray;
    JYW_FictionViewModel *fvModel;
    
    JYW_SelectAudioView *jyw_SelectAudioView;
    UIRefreshControl *fictionTableViewRefreshContol;
}
@end

@implementation JYW_FictionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    fvModel=[[JYW_FictionViewModel alloc] init];
    fvModel.delegate=self;
    [self pageSettings];
    [self setControlData];
}
//设置控件的值
-(void)setControlData{
    self.audioLabel.text=[NSString stringWithFormat:@"共%d集",fictionMainModel.audioCount];
}
//页面设置
-(void)pageSettings{
    //设置导航标题
    self.title=@"小说播放列表";
    //tableDSArray=@[@"小说播放列表",@"Group"];
    fictionMainModel=[fvModel setPageDataWithDictionary:[fvModel getFictionData]];
    
    
    jyw_SelectAudioView=[[JYW_SelectAudioView alloc] initWithFrame:self.fictionAudioListView.bounds];
    [jyw_SelectAudioView setViewControlWithAudioCount:fictionMainModel.audioCount NumberOfAudiosPerLabel:5];
    jyw_SelectAudioView.delegate=self;
    [self.fictionAudioListView addSubview:jyw_SelectAudioView];
    self.fictionAudioListViewConstraintHeight.constant=jyw_SelectAudioView.frame.size.height;
    self.fictionAudioListViewConstraintTop.constant=jyw_SelectAudioView.frame.size.height*-1;
    [self.fictionAudioListView drawTopBorderWithBorderWidth:0.5 borderColor:[UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1.0]];
    
    fictionTableViewRefreshContol=[[UIRefreshControl alloc]init];
    fictionTableViewRefreshContol.attributedTitle=[[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [fictionTableViewRefreshContol addTarget:self action:@selector(fictionTableViewRefreshContolAction:) forControlEvents:UIControlEventValueChanged];
    [self.fictionTableView addSubview:fictionTableViewRefreshContol];
    
}
-(IBAction)fictionTableViewRefreshContolAction:(UIRefreshControl *)rControl{
    if (rControl.refreshing) {
        rControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载中..."];
        // 1. 远程请求数据
        [self requestAPIData];
        
    }
}

- (void)requestAPIData {
    // 模拟远程请求所耗费的时间
    [NSThread sleepForTimeInterval:2];
    //获取网络数据
    [fvModel getFictionDataWithPageSize:3 pageNum:2];
}
-(void)fictionDataBackWithNSDictionary:(NSDictionary *)dic NSError:(NSError*)error{
    // 重新加载数据
    [self.fictionTableView reloadData];
    //结束刷新
    [fictionTableViewRefreshContol endRefreshing];
}
//fictionAudioListView，标签点击事件
-(void)JYW_SelectAudioView_LabelClick:(long)index{
    
}

//展开fictionAudioListView点击事件
-(IBAction)audioLabel_click:(id)sender{
    if(self.fictionAudioListView.hidden)
    {
        //显示
        self.fictionAudioListView.hidden=NO;
        self.fictionAudioListBackgroundView.hidden=NO;
        self.fictionAudioListBackgroundView.alpha=0;
        [UIView animateWithDuration:1 animations:^{
            self.fictionAudioListViewConstraintTop.constant=0;
            CGRect fictionAudioListViewRect=self.fictionAudioListView.frame;
            fictionAudioListViewRect.origin.y=50;
            self.fictionAudioListView.frame=fictionAudioListViewRect;
            
            //self.fictionAudioListBackgroundView.transform = CGAffineTransformMakeScale(1, 1);

            self.fictionAudioListBackgroundView.alpha = 0.5;
        } completion:^(BOOL finished)
        {
            //
        }];
    }
    else
    {
        //隐藏
        [UIView animateWithDuration:1 animations:^{
            
            CGRect fictionAudioListViewRect=self.fictionAudioListView.frame;
            fictionAudioListViewRect.origin.y=-self.fictionAudioListView.frame.size.height;
            self.fictionAudioListView.frame=fictionAudioListViewRect;
            self.fictionAudioListBackgroundView.alpha = 0;
            
        } completion:^(BOOL finished)
        {
            self.fictionAudioListView.hidden=YES;
            self.fictionAudioListBackgroundView.hidden=YES;
            self.fictionAudioListViewConstraintTop.constant=-self.fictionAudioListView.frame.size.height;
        }];
    }
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return fictionMainModel.fmArray.count;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 64;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIndentifier = @"CellTableIdentifier";
    //单元格ID
    //重用单元格
    JYW_FictionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
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
        cell = [[JYW_FictionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIndentifier];
        
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
    JYW_FictionModel *fm=fictionMainModel.fmArray[indexPath.row];
    cell.fm=fm;
    
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  /*
    //获取storyboard
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];

    //根据storyboard创建控制对象
     Detail * celldetail = [storyboard instantiateViewControllerWithIdentifier:@"celldetail"];

    [celldetail viewDidLoad];

    [self.navigationController pushViewController:celldetail animated:YES];
   */
}
@end
