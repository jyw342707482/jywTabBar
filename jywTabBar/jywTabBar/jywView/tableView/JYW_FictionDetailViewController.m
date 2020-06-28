//
//  JYW_FictionDetailViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/24.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_FictionDetailViewController.h"
#import "JYW_Snowflake.h"
#import "JYW_FictionModel.h"
#import "JYWAudioPlayerView.h"
@interface JYW_FictionDetailViewController ()<JYWAudioPlayer_Delegate>
{
    JYW_Snowflake *snowflake;
    JYWAudioPlayer *jywAudioPlayer;
}
@end

@implementation JYW_FictionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self initUISwipeGestureRecognizer];
    [self initJYW_Snowflake];
    [self pageSetting];
    [self pageDataSetting];
    [self initJYWAudioPlayerView];
}
#pragma mark -页面设置
-(void)pageSetting{
    float topHeight=0;
    if (@available(iOS 11.0, *)) {
        topHeight=48;
    }
    titleViewTopConstraint.constant=topHeight;
}
#pragma mark -页面数据设置
-(void)pageDataSetting{
    JYW_FictionModel *fm=self.jyw_FictionMainModel.fmArray[self.jyw_FictionMainModel.playedIndex];
    //titleLabel.text=fm.title;
    setTitleLabel.text=fm.title;
}
#pragma mark -添加轻扫手势
/*
-(void)initUISwipeGestureRecognizer{
    //UISwipeGestureRecognizer
    UISwipeGestureRecognizer *swipeGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back_SwipeGesture:)];
    swipeGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    [swipeGesture setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:swipeGesture];
}
-(IBAction)back_SwipeGesture:(UISwipeGestureRecognizer *)sender{
    [self back_Click:self.view];
}
 */
#pragma mark -创建背景动画
-(void)initJYW_Snowflake{
    snowflake=[[JYW_Snowflake alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    snowflake.birthRate=5;
    snowflake.backgroundColor=[UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1.0];
    [self.view addSubview:snowflake];
    [self.view sendSubviewToBack:snowflake];
    [snowflake play];
}
#pragma mark -初始化音频控件
-(void)initJYWAudioPlayerView{
    JYWAudioPlayerViewConfig *jywAudioPlayerViewConfig=[JYWAudioPlayerViewConfig defaultConfig];
    jywAudioPlayerViewConfig.audioURLStr=@"audio";
    jywAudioPlayer=[[JYWAudioPlayer alloc] initWithFrame:CGRectMake(0, 0, playerView.frame.size.width, playerView.frame.size.height) JYWAudioPlayerViewConfig:jywAudioPlayerViewConfig];
    jywAudioPlayer.delegate=self;
    [playerView addSubview:jywAudioPlayer];
}
#pragma mark -事件
//返回点击事件
-(IBAction)back_Click:(id)sender{
    //[snowflake removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//播放/暂停按钮点击事件
-(IBAction)playButton_Click:(id)sender{
    if(jywAudioPlayer.isPlaying){
        [jywAudioPlayer JYWPause];
        [playButton setImage:[UIImage imageNamed:@"playBtn"] forState:UIControlStateNormal];
        
    }else{
        [jywAudioPlayer JYWPlay];
        [playButton setImage:[UIImage imageNamed:@"pauseBtn"] forState:UIControlStateNormal];
    }
    
}

#pragma mark -JYWAudioPlayer_Delegate
//播放错误提示
-(void)JYWAudioPlayer_ErrorMessage:(NSString*)errorMessage{
    NSLog(errorMessage);
}
//播放器准备完毕
-(void)JYWAudioPlayer_ReadyMessage:(NSString*)message{
    NSLog(message);
    [jywAudioPlayer JYWPlay];
}
//播放完成
-(void)JYWAudioPlayer_PlayEnd{
    NSLog(@"播放完毕");
}
//上一集
-(void)JYWAudioPlayer_Up{
    NSLog(@"上一集");
    self.jyw_FictionMainModel.playedIndex-=1;
    [self pageDataSetting];
    [jywAudioPlayer JYWReLoadAudioWithURL:@"audio1"];
    //[jywAudioPlayer JYWPlay];
}
//下一集
-(void)JYWAudioPlayer_Next{
    NSLog(@"下一集");
    self.jyw_FictionMainModel.playedIndex+=1;
    [self pageDataSetting];
    [jywAudioPlayer JYWReLoadAudioWithURL:@"audio2"];
    //[jywAudioPlayer JYWPlay];
}

@end
