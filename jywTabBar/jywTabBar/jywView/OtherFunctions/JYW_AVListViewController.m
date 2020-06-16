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
    videoArray=@[@"video1",@"video2",@"video3",@"video1",@"video2",@"video3"];
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
//cell离开tableView时调用
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //因为复用，同一个cell可能会走多次
    if(videoPlayIndex==indexPath.row){
        
        videoPlayIndex=indexPath.row+1;
        UITableViewCell *cell=[self.videoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:videoPlayIndex inSection:0]];
        if(cell.contentView.subviews.count>0)
        {
            UIView *avPlayerView=cell.contentView.subviews[1];
            [self createPlayerConstraintWithSuperView:avPlayerView];
        }
    }
}
/*
//告诉委托人，即将选择指定的行
-(void)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{}
//告诉委托人，即将取消选择指定的行
-(void)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{}
//告诉委托人，现在取消选择指定的行
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{}
//询问委托人，是否恶意使用两个手指平移手势在表格视图中选择多个项目
-(BOOL)tableView:(UITableView *)tableView shouldBeginMultipleSelectionInteractionAtIndexPath:(nonnull NSIndexPath *)indexPath{return NO;}
//告诉委托人，用户何时开始使用两个手指平移手势在表视图中选择多行。
-(void)tableView:(UITableView *)tableView didBeginMultipleSelectionInteractionAtIndexPath:(nonnull NSIndexPath *)indexPath{}
//告诉委托人用户何时停止使用两指平移手势在表视图中选择多行。
-(void)tableViewDidEndMultipleSelectionInteraction:(UITableView *)tableView{}
//向委托人询问指定位置的行的估计高度。
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{return 0;}

#pragma mark -估算表格内容的高度
//向委托人询问特定节的标题的估计高度。
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{return 0;}
//向代表询问特定节的页脚的估计高度。
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{return 0;}
//告诉委托人用户点击了指定行的详细信息按钮。
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(nonnull NSIndexPath *)indexPath{}

#pragma mark -响应行动作
//返回滑动动作以显示在行的前沿。
-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{return nil;}
//返回显示在行尾的滑动动作。
-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{return nil;}

#pragma mark -管理表视图突出显示
//询问代理人是否应突出显示指定的行。
-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(nonnull NSIndexPath *)indexPath{return NO;}
//告诉委托人突出显示了指定的行。
-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(nonnull NSIndexPath *)indexPath{}
//告诉代理人该突出显示已从指定索引路径的行中删除。
-(void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(nonnull NSIndexPath *)indexPath{}

#pragma mark -编辑表格行
//告诉代表该表视图即将进入编辑模式。
-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(nonnull NSIndexPath *)indexPath{}
//告诉代表表视图已离开编辑模式。
-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath{}
//向委托人询问表视图中特定位置的行的编辑样式。
-(UITableViewCellEditingStyle *)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{return nil;}
//更改删除确认按钮的默认标题。
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{return @"";}
//询问委托人，当表格视图处于编辑模式时，是否应缩进指定行的背景。
-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(nonnull NSIndexPath *)indexPath{return NO;}
#pragma mark -重新排序表格行
//要求委托返回新的索引路径，以重新定位行的拟议目标。
-(NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toProposedIndexPath:(nonnull NSIndexPath *)proposedDestinationIndexPath{return nil;}

#pragma mark -跟踪视图的删除
//告诉委托人指定的单元格已从表中删除。
-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{}
//告诉委托人已从表中删除了指定的标题视图。
-(void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(nonnull UIView *)view forSection:(NSInteger)section{}
//告诉代表该指定的页脚视图已从表中删除。
-(void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(nonnull UIView *)view forSection:(NSInteger)section{}

#pragma mark -管理表视图焦点
//询问委托人指定索引路径处的单元格本身是否可聚焦。
-(BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(nonnull NSIndexPath *)indexPath{return NO;}
//询问代理人是否允许由上下文指定的焦点更新发生。
-(BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(nonnull UITableViewFocusUpdateContext *)context{return NO;}
//告诉代理人该上下文指定的焦点更新刚刚发生。
-(void)tableView:(UITableView *)tableView didUpdateFocusInContext:(nonnull UITableViewFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator{}
//向委托人询问首选焦点视图的表视图的索引路径。
-(NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView{return nil;}
*/

-(IBAction)videoImage_Tap:(UITapGestureRecognizer*)sender{
    videoPlayIndex=sender.view.tag;
    NSLog(@"%f-%f",sender.view.superview.frame.size.width,sender.view.superview.frame.size.height);
    [self createPlayerConstraintWithSuperView:sender.view];
    //[self createPlayerFrame:sender.view.frame superView:sender.view];
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
        //[appDelegate.tabBarJYWPlayerView initVolumeAndBrightnessProgressViewConstratint];
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
