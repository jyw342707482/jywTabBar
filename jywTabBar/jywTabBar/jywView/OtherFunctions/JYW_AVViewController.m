//
//  JYW_AVViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/11.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_AVViewController.h"
#import "JYWPlayerView.h"
//#import "JYWPlayerModel.h"
#import "AppDelegate.h"
@interface JYW_AVViewController ()
{
    NSArray *videoArray;
    AppDelegate *appDelegate;
    //视频播放index
    NSInteger videoPlayIndex;
}
@end

@implementation JYW_AVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pageSetting];
}
#pragma mark -返回按钮
-(IBAction)leftBarButton_Back:(id)sender{
    
    [appDelegate.tabBarJYWPlayerView JYW_Pause];
    [appDelegate.tabBarJYWPlayerView JYW_DeallocKVO];
    [appDelegate.tabBarJYWPlayerView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -页面设置
-(void)pageSetting{
    self.title=@"播放器";
    appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    //添加导航右侧按钮
    //添加导航右侧按钮，按钮类型为系统加号
    UIBarButtonItem *leftBarButton1=[[UIBarButtonItem alloc] initWithTitle:@"＜返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButton_Back:)];
    self.navigationItem.leftBarButtonItem=leftBarButton1;
    
    videoArray=@[@"video1",@"video2",@"video3"];
    [self createPlayerFrame];
    //[self createPlayerConstraint];
    /*
    if(appDelegate.tabBarJYWPlayerView==nil){
        [self createPlayer];
    }
    else
    {
        [self changeVideo];
    }*/
}
#pragma mark -创建播放器
-(void)createPlayerFrame{
    if(appDelegate.tabBarJYWPlayerView==nil){
        JYWPlayerViewConfig *playerViewConfig=[JYWPlayerViewConfig defaultConfig];
        playerViewConfig.filePathStr=videoArray[videoPlayIndex];
        playerViewConfig.title=videoArray[videoPlayIndex];
        playerViewConfig.superVC=self;
        playerViewConfig.superView=self.playerView;
        appDelegate.tabBarJYWPlayerView=[[JYWPlayerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300) Config:playerViewConfig];
        appDelegate.tabBarJYWPlayerView.backgroundColor=[UIColor blackColor];
    }
    else{
        appDelegate.tabBarJYWPlayerView.jywPlayerViewConfig.superVC=self;
        appDelegate.tabBarJYWPlayerView.jywPlayerViewConfig.superView=self.playerView;
        [appDelegate.tabBarJYWPlayerView JYW_ReplaceVideoWithTitleStr:videoArray[videoPlayIndex] VideoFilePath:videoArray[videoPlayIndex]];
    }
    [self.playerView addSubview:appDelegate.tabBarJYWPlayerView];
    [appDelegate.tabBarJYWPlayerView JYW_Play];
    [self.videoTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:videoPlayIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}
-(void)createPlayerConstraint{
    if(appDelegate.tabBarJYWPlayerView==nil){
        JYWPlayerViewConfig *playerViewConfig=[JYWPlayerViewConfig defaultConfig];
        playerViewConfig.filePathStr=videoArray[videoPlayIndex];
        playerViewConfig.title=videoArray[videoPlayIndex];
        playerViewConfig.superVC=self;
        playerViewConfig.superView=self.playerView;
        appDelegate.tabBarJYWPlayerView=[[JYWPlayerView alloc] initWithConfig:playerViewConfig];
        [self.playerView addSubview:appDelegate.tabBarJYWPlayerView];
        /*
        appDelegate.tabBarJYWPlayerView=[[JYWPlayerView alloc] initWithTitle:videoArray[videoPlayIndex] filePath:videoArray[videoPlayIndex]];
        appDelegate.tabBarJYWPlayerView.jywPlayerViewConfig.superView=self.playerView;
        appDelegate.tabBarJYWPlayerView.jywPlayerViewConfig.superVC=self;*/
        appDelegate.tabBarJYWPlayerView.backgroundColor=[UIColor blackColor];
    }
    else{
        appDelegate.tabBarJYWPlayerView.jywPlayerViewConfig.superVC=self;
        appDelegate.tabBarJYWPlayerView.jywPlayerViewConfig.superView=self.playerView;
        [self.playerView addSubview:appDelegate.tabBarJYWPlayerView];
        [appDelegate.tabBarJYWPlayerView JYW_ReplaceVideoWithTitleStr:videoArray[videoPlayIndex] VideoFilePath:videoArray[videoPlayIndex]];
        [appDelegate.tabBarJYWPlayerView initPlayerViewConstraint];
    }
    
    [appDelegate.tabBarJYWPlayerView JYW_Play];
    [self.videoTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:videoPlayIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}
#pragma mark -切换播放内容
-(void)changeVideo{
    [appDelegate.tabBarJYWPlayerView JYW_DeallocKVO];
    [appDelegate.tabBarJYWPlayerView JYW_ReplaceVideoWithTitleStr:videoArray[videoPlayIndex] VideoFilePath:videoArray[videoPlayIndex]];
}
#pragma mark -播放列表
//返回节头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    headerView.backgroundColor=[UIColor grayColor];
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(16, 0, headerView.frame.size.width-32, 40)];
    titleLabel.text=@"播放列表";
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font=[UIFont systemFontOfSize:14];
    [headerView addSubview:titleLabel];
    return headerView;
}
//返回节头部视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
//返回节尾部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGFLOAT_MIN)];
    return footerView;
    
}
//返回节尾部视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
//返回列表节数量
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//返回每节的行数量
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return videoArray.count;
}
//返回每行高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 50;
}
//返回每行的视图
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
    //UIImage *img = [UIImage imageNamed:jywABM.avatar];
    //cell.imageView.image = img;
    //添加图片
    cell.textLabel.text =videoArray[indexPath.row];
    
    
    return cell;
}
//行选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(videoPlayIndex!=indexPath.row){
        videoPlayIndex=indexPath.row;
        [self changeVideo];
    }
}
/*
-(void)updateViewConstraints NS_AVAILABLE_IOS(6_0){
    //设置当前播放窗口
    //设置左停靠
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:jywPlayerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:jywPlayerView.superview attribute:NSLayoutAttributeLeading multiplier:1.0f constant:10.0f]];
    //设置右停靠
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:jywPlayerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:jywPlayerView.superview attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:10.0f]];
    //设置上停靠
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:jywPlayerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:jywPlayerView.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:10.0f]];
    //设置下停靠
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:jywPlayerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:jywPlayerView.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:10.0f]];
    [super updateViewConstraints];
}
*/
@end
