//
//  JYW_AVPlayerToobarView.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/6.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_AVPlayerToobarView.h"
#import "NSString+JYW_StringWidth.h"
@implementation JYW_AVPlayerToobarView

-(instancetype)initWithJYW_AVPayerModel:(nonnull JYW_AVPlayerModel *)avPlayerModel{
    self=[super init];
    if(self){
        jyw_AVPlayerModel=avPlayerModel;
        [self createControls];
    }
    return self;
}
//创建控件
-(void)createControls{
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
    
}
- (void)updateConstraints NS_AVAILABLE_IOS(6_0) NS_REQUIRES_SUPER{
    [super updateConstraints];
    ///设置titleView
    [self setTitleView];
    ///设置toobarView
    [self setToobarView];
}
//设置titleViewLayout适配
-(void)setTitleView{
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
    [self.backButton addConstraint:[NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:40.0f]];
    
    //设置标题
    //设置左停靠
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.backButton attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
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
    CGSize playTimeLabelWidth=[NSString getStingWidthFontSize:12.0 String:self.playTimeLabel.text];
    [self.playTimeLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.playTimeLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:playTimeLabelWidth.width]];
    
    ///设置playTimeNowLabel
    //设置右停靠在fullScreenButton全屏按钮上
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.playTimeNowLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.startAndEndPlayButton attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    //设置下停靠
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.playTimeNowLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.playTimeNowLabel.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    //设置上停靠
    [self.toobarView addConstraint:[NSLayoutConstraint constraintWithItem:self.playTimeNowLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.playTimeNowLabel.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    //设置宽度
    [self.playTimeNowLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.playTimeNowLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:playTimeLabelWidth.width]];
}

# pragma Mark -Action
//播放/暂停按钮点击事件
-(IBAction)startAndEndPlayButtonAction_Click:(id)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(JYW_AVPlayerToobarView_StartAndEndPlayButton_Click)])
    {
        [_delegate JYW_AVPlayerToobarView_StartAndEndPlayButton_Click];
    }
}
//全屏/窗口按钮点击事件
-(IBAction)fullScreenButtonAction_Click:(id)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(JYW_AVPlayerToobarView_FullScreenButton_Click)])
    {
        [_delegate JYW_AVPlayerToobarView_FullScreenButton_Click];
    }
}
-(IBAction)backButtonAction_Click:(id)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(JYW_AVPlayerToobarView_BackButton_Click)])
    {
        [_delegate JYW_AVPlayerToobarView_BackButton_Click];
    }
}

# pragma Mark - 懒加载
//标题view
-(UIView *)titleView{
    if(_titleView==nil){
        _titleView =[[UIView alloc] init];
        _titleView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.5];
        _titleView.translatesAutoresizingMaskIntoConstraints=NO;
    }
    return _titleView;
}
//返回按钮
-(UIButton *)backButton{
    if(_backButton==nil){
        _backButton =[[UIButton alloc] init];
        [_backButton setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
        _backButton.translatesAutoresizingMaskIntoConstraints=NO;
        [_backButton addTarget:self action:@selector(backButtonAction_Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
//标题
-(UILabel *)titleLabel{
    if(_titleLabel==nil){
        _titleLabel =[[UILabel alloc] init];
        _titleLabel.text=jyw_AVPlayerModel.getTitle;
        _titleLabel.textColor=[UIColor whiteColor];
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
        _toobarView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.5];
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
        _playTimeLabel.text=jyw_AVPlayerModel.getPlayTime;
        _playTimeLabel.textColor=[UIColor whiteColor];
        _playTimeLabel.font=[UIFont systemFontOfSize:12.0f];
        _playTimeLabel.translatesAutoresizingMaskIntoConstraints=NO;
    }
    return _playTimeLabel;
}
//当前播放时长
-(UILabel *)playTimeNowLabel{
    if(_playTimeNowLabel==nil){
        _playTimeNowLabel =[[UILabel alloc] init];
        //（playTimeType类型0：00:00:00，1：00:00，2：00秒）
        if([jyw_AVPlayerModel getPlayTimeType]==0)
        {
            _playTimeNowLabel.text=@"00:00:00";
        }
        else if([jyw_AVPlayerModel getPlayTimeType]==1)
        {
            _playTimeNowLabel.text=@"00:00";
        }
        else if([jyw_AVPlayerModel getPlayTimeType]==2)
        {
            _playTimeNowLabel.text=@"00";
        }
        
        _playTimeNowLabel.textAlignment=NSTextAlignmentRight;
        _playTimeNowLabel.textColor=[UIColor whiteColor];
        _playTimeNowLabel.font=[UIFont systemFontOfSize:12.0f];
        _playTimeNowLabel.translatesAutoresizingMaskIntoConstraints=NO;
    }
    return _playTimeNowLabel;
}
@end
