//
//  JYWPlayerToobarView.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/11.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYWPlayerToobarView.h"

@implementation JYWPlayerToobarView

-(instancetype)initWithTitle:(NSString *)titleStr playTime:(NSString *)playTimeStr{
    self=[super init];
    if(self)
    {
        self.title=titleStr;
        self.playTime=playTimeStr;
        [self initUI];
    }
    return self;
}
#pragma mark -创建控件
//创建控件
-(void)initUI{
    //标题
    //titleView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    [self addSubview:self.titleView];
    [self.titleView addSubview:self.backButton];
    [self.titleView addSubview:self.titleLabel];
    
    //操作工具栏
    [self addSubview:self.toobarView];
    //暂停/播放按钮
    [self.toobarView addSubview:self.startAndEndPlayButton];
    //全屏/窗口按钮
    [self.toobarView addSubview:self.fullScreenButton];
    //播放总时间
    [self.toobarView addSubview:self.playTimeLabel];
    //当前播放时长
    [self.toobarView addSubview:self.playTimeNowLabel];
    //缓冲进度条
    [self.toobarView addSubview:self.playProgressView];
    //播放滑块
    [self.toobarView addSubview:self.playSlider];
    //暂停时的播放大图标
    [self addSubview:self.toobarPlayButton];
    //等待
    //[self addSubview:self.jyw_AnimationView];
    
    UITapGestureRecognizer *toobarView_Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toobarView_Tap:)];
    [toobarView_Tap setNumberOfTouchesRequired:1];
    [self addGestureRecognizer:toobarView_Tap];
}
#pragma mark -重置新视频video
//重置视频播放数据
-(void)replaceWithTitle:(NSString *)titleStr playTime:(NSString *)playTimeStr{
    self.title=titleStr;
    self.titleLabel.text=self.title;
    self.playTime=playTimeStr;
    self.playTimeLabel.text=playTimeStr;
}
#pragma mark -重写updateConstraints
- (void)updateConstraints NS_AVAILABLE_IOS(6_0) NS_REQUIRES_SUPER{
    [super updateConstraints];
    ///设置titleView
    [self setTitleView];
    ///设置toobarView
    [self setToobarView];
}


# pragma mark -Action
//暂停时的播放大图标，点击事件
-(IBAction)toobarPlayImageView_Tap:(UITapGestureRecognizer *)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(JYWPlayerToobarView_StartAndEndPlayButton_Click)])
    {
        [_delegate JYWPlayerToobarView_StartAndEndPlayButton_Click];
    }
}

//toobar 点击事件
-(IBAction)toobarView_Tap:(UITapGestureRecognizer *)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(JYWPlayerToobarView_Click:)])
    {
        [_delegate JYWPlayerToobarView_Click:self.titleView.hidden];
    }
}
//播放/暂停按钮点击事件
-(IBAction)startAndEndPlayButtonAction_Click:(id)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(JYWPlayerToobarView_StartAndEndPlayButton_Click)])
    {
        [_delegate JYWPlayerToobarView_StartAndEndPlayButton_Click];
    }
}
//全屏/窗口按钮点击事件
-(IBAction)fullScreenButtonAction_Click:(id)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(JYWPlayerToobarView_FullScreenButton_Click)])
    {
        [_delegate JYWPlayerToobarView_FullScreenButton_Click];
    }
}
//返回点击事件
-(IBAction)backButtonAction_Click:(id)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(JYWPlayerToobarView_BackButton_Click)])
    {
        [_delegate JYWPlayerToobarView_BackButton_Click];
    }
}
//playSlider 滑块手势点击事件
-(IBAction)playSlider_Tap:(UITapGestureRecognizer *)sender{
    CGPoint touchPoint = [sender locationInView:self.playSlider];
    CGFloat value = touchPoint.x / CGRectGetWidth(self.playSlider.bounds);
    [self.playSlider setValue:value animated:YES];
    if(_delegate && [_delegate respondsToSelector:@selector(JYWPlayerToobarView_ChangePlayProgress:)])
    {
        [_delegate JYWPlayerToobarView_ChangePlayProgress:value];
    }
}
//playSlider 滑块点下事件
-(IBAction)playSlider_TouchDown:(id)sender{
    self.playSlider_Tap.enabled=NO;
    if(_delegate && [_delegate respondsToSelector:@selector(JYWPlayerToobarView_PlaySlider_TouchDown)])
    {
        [_delegate JYWPlayerToobarView_PlaySlider_TouchDown];
    }
}
//playSlider 滑块抬起事件
-(IBAction)playSlider_TouchUp:(id)sender{
    self.playSlider_Tap.enabled=YES;
    if(_delegate && [_delegate respondsToSelector:@selector(JYWPlayerToobarView_PlaySlider_TouchUp)])
    {
        [_delegate JYWPlayerToobarView_PlaySlider_TouchUp];
    }
}
//playSlider滑块值变化事件
-(IBAction)playSlider_ValueChange:(UISlider *)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(JYWPlayerToobarView_ChangePlayProgress:)])
    {
        [_delegate JYWPlayerToobarView_ChangePlayProgress:sender.value];
    }
}
# pragma mark - 懒加载
//toobarPlayButton，暂停时的播放/暂停大图标
-(UIButton *)toobarPlayButton{
    if(_toobarPlayButton==nil){
        _toobarPlayButton =[[UIButton alloc] init];
        _toobarPlayButton.layer.borderColor=[UIColor whiteColor].CGColor;
        _toobarPlayButton.layer.borderWidth=1.0f;
        _toobarPlayButton.layer.masksToBounds=YES;
        _toobarPlayButton.layer.cornerRadius=20.0f;
        [_toobarPlayButton setImage:[UIImage imageNamed:@"playBtn"] forState:UIControlStateNormal];
        [_toobarPlayButton setImage:[UIImage imageNamed:@"pauseBtn"] forState:UIControlStateSelected];
        _toobarPlayButton.translatesAutoresizingMaskIntoConstraints=NO;
        [_toobarPlayButton addTarget:self action:@selector(startAndEndPlayButtonAction_Click:) forControlEvents:UIControlEventTouchUpInside];
        _toobarPlayButton.translatesAutoresizingMaskIntoConstraints=NO;
    }
    return _toobarPlayButton;
}
//标题view
-(UIView *)titleView{
    if(_titleView==nil){
        _titleView =[[UIView alloc] init];
        //_titleView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.5];
        _titleView.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        _titleView.translatesAutoresizingMaskIntoConstraints=NO;
    }
    return _titleView;
}
//返回按钮
-(UIButton *)backButton{
    if(_backButton==nil){
        _backButton =[[UIButton alloc] init];
        [_backButton setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
        _backButton.hidden=YES;
        _backButton.translatesAutoresizingMaskIntoConstraints=NO;
        [_backButton addTarget:self action:@selector(backButtonAction_Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
//标题
-(UILabel *)titleLabel{
    if(_titleLabel==nil){
        _titleLabel =[[UILabel alloc] init];
        _titleLabel.text=self.title;
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.textAlignment=NSTextAlignmentLeft;
        _titleLabel.font=[UIFont systemFontOfSize:14.0f];
        _titleLabel.translatesAutoresizingMaskIntoConstraints=NO;
    }
    return _titleLabel;
}
//工具条view
-(UIView *)toobarView{
    if(_toobarView==nil)
    {
        _toobarView =[[UIView alloc] init];
        //_toobarView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.5];
        _toobarView.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        _toobarView.translatesAutoresizingMaskIntoConstraints=NO;
    }
    return _toobarView;
}
//播放/暂停按钮
-(UIButton *)startAndEndPlayButton{
    if(_startAndEndPlayButton==nil){
        _startAndEndPlayButton =[[UIButton alloc] init];
        [_startAndEndPlayButton setImage:[UIImage imageNamed:@"playBtn"] forState:UIControlStateNormal];
        [_startAndEndPlayButton setImage:[UIImage imageNamed:@"pauseBtn"] forState:UIControlStateSelected];
        _startAndEndPlayButton.translatesAutoresizingMaskIntoConstraints=NO;
        [_startAndEndPlayButton addTarget:self action:@selector(startAndEndPlayButtonAction_Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startAndEndPlayButton;
}
//全屏/窗口
-(UIButton *)fullScreenButton{
    if(_fullScreenButton==nil){
        _fullScreenButton =[[UIButton alloc] init];
        [_fullScreenButton setImage:[UIImage imageNamed:@"maxBtn"] forState:UIControlStateNormal];
        [_fullScreenButton setImage:[UIImage imageNamed:@"minBtn"] forState:UIControlStateSelected];
        _fullScreenButton.translatesAutoresizingMaskIntoConstraints=NO;
        [_fullScreenButton addTarget:self action:@selector(fullScreenButtonAction_Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenButton;
}
//播放总时间
-(UILabel *)playTimeLabel{
    if(_playTimeLabel==nil){
        _playTimeLabel =[[UILabel alloc] init];
        _playTimeLabel.text=self.playTime;
        _playTimeLabel.textColor=[UIColor whiteColor];
        _playTimeLabel.font=[UIFont systemFontOfSize:12.0f];
        _playTimeLabel.hidden=YES;
        _playTimeLabel.textAlignment=NSTextAlignmentCenter;
        _playTimeLabel.translatesAutoresizingMaskIntoConstraints=NO;
    }
    return _playTimeLabel;
}
//当前播放时长
-(UILabel *)playTimeNowLabel{
    if(_playTimeNowLabel==nil){
        _playTimeNowLabel =[[UILabel alloc] init];
        //（playTimeType类型0：00:00:00，1：00:00，2：00秒）
        /*
        if(jyw_AVPlayerModel.playTimeType==0)
        {
            _playTimeNowLabel.text=@"00:00:00";
        }
        else if(jyw_AVPlayerModel.playTimeType==1)
        {
            _playTimeNowLabel.text=@"00:00";
        }
        else if(jyw_AVPlayerModel.playTimeType==2)
        {
            _playTimeNowLabel.text=@"00";
        }
        */
        _playTimeNowLabel.textAlignment=NSTextAlignmentCenter;
        _playTimeNowLabel.textColor=[UIColor whiteColor];
        _playTimeNowLabel.font=[UIFont systemFontOfSize:12.0f];
        _playTimeNowLabel.hidden=YES;
        _playTimeNowLabel.translatesAutoresizingMaskIntoConstraints=NO;
    }
    return _playTimeNowLabel;
}
//播放滑块
-(UISlider *)playSlider{
    if(_playSlider==nil){
        _playSlider=[[UISlider alloc] init];
        [_playSlider setThumbImage:[UIImage imageNamed:@"round"] forState:UIControlStateHighlighted];
        [_playSlider setThumbImage:[UIImage imageNamed:@"round"] forState:UIControlStateNormal];
        _playSlider.maximumValue=1;
        _playSlider.translatesAutoresizingMaskIntoConstraints=NO;
        [_playSlider addTarget:self action:@selector(playSlider_TouchDown:) forControlEvents:UIControlEventTouchDown];
        [_playSlider addTarget:self action:@selector(playSlider_TouchUp:) forControlEvents:UIControlEventTouchUpInside];
        [_playSlider addTarget:self action:@selector(playSlider_TouchUp:) forControlEvents:UIControlEventTouchUpOutside];
        [_playSlider addTarget:self action:@selector(playSlider_ValueChange:) forControlEvents:UIControlEventValueChanged];
        self.playSlider_Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playSlider_Tap:)];
        [self.playSlider_Tap setNumberOfTouchesRequired:1];
        [self.playSlider addGestureRecognizer:self.playSlider_Tap];
    }
    return _playSlider;
}
//进度条
-(UIProgressView*)playProgressView{
    if(_playProgressView==nil){
        _playProgressView=[[UIProgressView alloc] init];
        _playProgressView.progress=0;
        _playProgressView.progressTintColor=[UIColor greenColor];
        _playProgressView.translatesAutoresizingMaskIntoConstraints=NO;
    }
    return _playProgressView;
}


#pragma mark -约束
//设置titleViewLayout适配
-(void)setTitleView{
    //toobarPlayButton
    //设置宽高，居中对齐
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.toobarPlayButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.toobarPlayButton.superview attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.toobarPlayButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.toobarPlayButton.superview attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    [self.toobarPlayButton addConstraint:[NSLayoutConstraint constraintWithItem:self.toobarPlayButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:40.0f]];
    [self.toobarPlayButton addConstraint:[NSLayoutConstraint constraintWithItem:self.toobarPlayButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:40.0f]];
    
    //设置左停靠
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.titleView.superview attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    //设置右停靠
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.titleView.superview attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    //设置上停靠
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleView.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    //设置高度
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:40.0f]];
    
    //设置返回按钮
    //设置左停靠
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.backButton.superview attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    //设置下停靠
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    //设置上停靠
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    //设置宽度
    [self.backButton addConstraint:[NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:40.0f]];
    
    //设置标题
    //设置左停靠
    self.titleLabelLeadingConstraint=[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.titleLabel.superview attribute:NSLayoutAttributeLeading multiplier:1.0f constant:15.0f];
    [self.titleView addConstraint:self.titleLabelLeadingConstraint];
    //设置右停靠
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.titleLabel.superview attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    //设置下停靠
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.titleLabel.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    //设置上停靠
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
}
//设置toobarViewLayout适配
-(void)setToobarView{
    ///设置toobarView
    //设置左停靠
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.toobarView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.toobarView.superview attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    //设置右停靠
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.toobarView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.toobarView.superview attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    //设置下停靠
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.toobarView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.toobarView.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    //设置高度
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.toobarView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:40.0f]];
    
    ///设置startAndEndPlayButton
    //设置左停靠
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.startAndEndPlayButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.startAndEndPlayButton.superview attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    //设置下停靠
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.startAndEndPlayButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.startAndEndPlayButton.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    //设置上停靠
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.startAndEndPlayButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.startAndEndPlayButton.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    //设置宽度
    [self.startAndEndPlayButton addConstraint:[NSLayoutConstraint constraintWithItem:self.startAndEndPlayButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:40.0f]];
    
    ///设置fullScreenButton全屏
    //设置右停靠
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.fullScreenButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.fullScreenButton.superview attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    //设置下停靠
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.fullScreenButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.fullScreenButton.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    //设置上停靠
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.fullScreenButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.fullScreenButton.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    //设置宽度
    [self.fullScreenButton addConstraint:[NSLayoutConstraint constraintWithItem:self.fullScreenButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:40.0f]];
    
    
    ///设置playTimeLabel
    //设置右停靠在shareButton全屏按钮上
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.playTimeLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.fullScreenButton attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    //设置下停靠
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.playTimeLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.playTimeLabel.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    //设置上停靠
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.playTimeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.playTimeLabel.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    //设置宽度
    //CGSize playTimeLabelWidth=[NSString getStingWidthFontSize:12.0 String:self.playTimeLabel.text];
    [self.playTimeLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.playTimeLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:55.0f]];
    
    ///设置playTimeNowLabel
    //设置右停靠在fullScreenButton全屏按钮上
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.playTimeNowLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.startAndEndPlayButton attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    //设置下停靠
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.playTimeNowLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.playTimeNowLabel.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    //设置上停靠
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.playTimeNowLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.playTimeNowLabel.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    //设置宽度
    [self.playTimeNowLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.playTimeNowLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:55.0]];
    
    
    ///设置playSlider
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.playSlider attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.playTimeNowLabel attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    //设置右侧停靠
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.playSlider attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.playTimeLabel attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    //设置上停靠
    //[self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.playSlider attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:100.0f]];
    //设置水平居中
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.playSlider attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.toobarView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
     
    ///设置playProgressView
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.playProgressView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.playTimeNowLabel attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    //设置右侧停靠
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.playProgressView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.playTimeLabel attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    //设置高度
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.playProgressView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:1.0f]];
    //设置水平居中
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.playProgressView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.toobarView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    
    //jyw_AnimationView
    /*
    //水平居中
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.jyw_AnimationView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    //垂直居中
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.jyw_AnimationView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
     */
}
@end
