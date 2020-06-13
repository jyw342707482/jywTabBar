//
//  JYW_AVListViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/13.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_AVListViewController.h"
#import "JYWPlayerView.h"
#import "AppDelegate.h"

static NSString *tableViewCellIdentifier = @"tableViewCellIdentifier";

@interface JYW_AVListViewController ()
{
    NSArray *videoArray;
    AppDelegate *appDelegate;
    //视频播放index
    NSInteger videoPlayIndex;
}
@end

@implementation JYW_AVListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"视频列表";
    //添加导航右侧按钮
    //添加导航右侧按钮，按钮类型为系统加号
    UIBarButtonItem *leftBarButton1=[[UIBarButtonItem alloc] initWithTitle:@"＜返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButton_Back:)];
    self.navigationItem.leftBarButtonItem=leftBarButton1;
    videoArray=@[@"video1",@"video2",@"video3"];
    appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    //注册cell
    [self.videoTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewCellIdentifier];
    
}
#pragma mark -返回按钮
-(IBAction)leftBarButton_Back:(id)sender{
    
    [appDelegate.tabBarJYWPlayerView JYW_Pause];
    [appDelegate.tabBarJYWPlayerView JYW_DeallocKVO];
    [appDelegate.tabBarJYWPlayerView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -视频播放列表
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
    return 300;
}
//返回每行的视图
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier forIndexPath:indexPath];
    //cell.delegate = self;
    return cell;
}
//在willDisplayCell里面处理数据能优化tableview的滑动流畅性，cell将要出现的时候调用
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *mainCell = (UITableViewCell *)cell;
    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
    img.image=[UIImage imageNamed:videoArray[indexPath.row]];
    //img.userInteractionEnabled=YES;
    [mainCell.contentView addSubview:img];
    UIView *playerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
    [mainCell.contentView addSubview:playerView];
    UITapGestureRecognizer *img_Tap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(videoImage_Tap:)];
    [img_Tap setNumberOfTouchesRequired:1];
    playerView.userInteractionEnabled=YES;
    playerView.tag=indexPath.row;
    [playerView addGestureRecognizer:img_Tap];
}
-(IBAction)videoImage_Tap:(UITapGestureRecognizer*)sender{
    videoPlayIndex=sender.view.tag;
    NSLog(@"%f-%f",sender.view.superview.frame.size.width,sender.view.superview.frame.size.height);
    //[self createPlayerConstraintWithSuperView:sender.view];
    [self createPlayerFrame:sender.view.frame superView:sender.view];
}
#pragma mark -创建播放器
-(void)createPlayerFrame:(CGRect)frame superView:(UIView*)superView{
    if(appDelegate.tabBarJYWPlayerView==nil){
        JYWPlayerViewConfig *playerViewConfig=[JYWPlayerViewConfig defaultConfig];
        playerViewConfig.filePathStr=videoArray[videoPlayIndex];
        playerViewConfig.title=videoArray[videoPlayIndex];
        playerViewConfig.superVC=self;
        playerViewConfig.superView=superView;
        appDelegate.tabBarJYWPlayerView=[[JYWPlayerView alloc] initWithFrame:frame Config:playerViewConfig];
        appDelegate.tabBarJYWPlayerView.backgroundColor=[UIColor blackColor];
        [superView addSubview:appDelegate.tabBarJYWPlayerView];
        [appDelegate.tabBarJYWPlayerView initToobarViewConstraint];
    }
    else{
        appDelegate.tabBarJYWPlayerView.jywPlayerViewConfig.superVC=self;
        appDelegate.tabBarJYWPlayerView.jywPlayerViewConfig.superView=superView;
        [appDelegate.tabBarJYWPlayerView JYW_ReplaceVideoWithTitleStr:videoArray[videoPlayIndex] VideoFilePath:videoArray[videoPlayIndex]];
        [superView addSubview:appDelegate.tabBarJYWPlayerView];
    }
    
    [appDelegate.tabBarJYWPlayerView JYW_Play];
    //[self.videoTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:videoPlayIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}
-(void)createPlayerConstraintWithSuperView:(UIView*)superView{
    if(appDelegate.tabBarJYWPlayerView==nil){
        JYWPlayerViewConfig *playerViewConfig=[JYWPlayerViewConfig defaultConfig];
        playerViewConfig.filePathStr=videoArray[videoPlayIndex];
        playerViewConfig.title=videoArray[videoPlayIndex];
        playerViewConfig.superVC=self;
        playerViewConfig.superView=superView;
        appDelegate.tabBarJYWPlayerView=[[JYWPlayerView alloc] initWithConfig:playerViewConfig];
        [superView addSubview:appDelegate.tabBarJYWPlayerView];
        [appDelegate.tabBarJYWPlayerView initPlayerViewConstraint];
        /*
        appDelegate.tabBarJYWPlayerView=[[JYWPlayerView alloc] initWithTitle:videoArray[videoPlayIndex] filePath:videoArray[videoPlayIndex]];
        appDelegate.tabBarJYWPlayerView.jywPlayerViewConfig.superView=self.playerView;
        appDelegate.tabBarJYWPlayerView.jywPlayerViewConfig.superVC=self;*/
        appDelegate.tabBarJYWPlayerView.backgroundColor=[UIColor blackColor];
    }
    else{
        appDelegate.tabBarJYWPlayerView.jywPlayerViewConfig.superVC=self;
        appDelegate.tabBarJYWPlayerView.jywPlayerViewConfig.superView=superView;
        [superView addSubview:appDelegate.tabBarJYWPlayerView];
        [appDelegate.tabBarJYWPlayerView JYW_ReplaceVideoWithTitleStr:videoArray[videoPlayIndex] VideoFilePath:videoArray[videoPlayIndex]];
        [appDelegate.tabBarJYWPlayerView initPlayerViewConstraint];
    }
    
    [appDelegate.tabBarJYWPlayerView JYW_Play];
    //[self.videoTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:videoPlayIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}
@end
