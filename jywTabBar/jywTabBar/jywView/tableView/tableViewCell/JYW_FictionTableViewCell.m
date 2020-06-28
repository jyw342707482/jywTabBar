//
//  JYW_FictionTableViewCell.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/28.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_FictionTableViewCell.h"

@implementation JYW_FictionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        titleLabel=[[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        downloadStateImageView=[[UIImageView alloc] init];
        [self.contentView addSubview:downloadStateImageView];
        fileSizeImageView=[[UIImageView alloc] init];
        [self.contentView addSubview:fileSizeImageView];
        fileSizeLabel=[[UILabel alloc] init];
        [self.contentView addSubview:fileSizeLabel];
        playingTimeImageView=[[UIImageView alloc] init];
        [self.contentView addSubview:playingTimeImageView];
        playingTimeLabel=[[UILabel alloc] init];
        [self.contentView addSubview:playingTimeLabel];
        playedTimeLabel=[[UILabel alloc] init];
        [self.contentView addSubview:playedTimeLabel];
        /*
        //titleLabel.text=@"aa";
        //titleLabel.backgroundColor=[UIColor redColor];
        //titleLabel.translatesAutoresizingMaskIntoConstraints=NO;
        [self.contentView addSubview:titleLabel];
        
        NSLayoutConstraint *titleWidth=[NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:200];
        NSLayoutConstraint *titleLeading=[NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:titleLabel.superview attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
        [titleLabel addConstraints:@[titleWidth,titleLeading]];
         */
    }
    /*
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen alloc].bounds.size.width , 50)];
    [self.contentView addSubview:mainView];
    
    titleLabel=[[UILabel alloc] init];
    titleLabel.text=@"aa";
    titleLabel.backgroundColor=[UIColor redColor];
    
    titleLabel.translatesAutoresizingMaskIntoConstraints=NO;
    
    [mainView addSubview:titleLabel];
    //self.contentView.translatesAutoresizingMaskIntoConstraints=NO;
    [titleLabel addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:200]];
    [titleLabel addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:titleLabel.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:16]];
    
    vStackView=[[UIStackView alloc] init];
    vStackView.backgroundColor=[UIColor redColor];
    vStackView.translatesAutoresizingMaskIntoConstraints=NO;
    [vStackView setAxis:UILayoutConstraintAxisVertical];
    [self.contentView addSubview:vStackView];
    //[vStackView addConstraint:[NSLayoutConstraint constraintWithItem:vStackView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:16]];
    //[vStackView addConstraint:[NSLayoutConstraint constraintWithItem:vStackView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:8]];
    //[vStackView addConstraint:[NSLayoutConstraint constraintWithItem:vStackView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:16]];
    [vStackView addConstraint:[NSLayoutConstraint constraintWithItem:vStackView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50]];
    //[vStackView addConstraint:[NSLayoutConstraint constraintWithItem:vStackView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:8]];
    */
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    float cellWith=[UIScreen mainScreen].bounds.size.width;
    titleLabel.frame=CGRectMake(16, 8, cellWith-62, 20);
    titleLabel.font=[UIFont systemFontOfSize:15];
    
    downloadStateImageView.frame=CGRectMake(cellWith-36, 8, 20, 20);
    //downloadStateImageView.image=[UIImage imageNamed:@"下载"];
    //添加手势
    downloadStateImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * downloadStateImageView_tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(downloadStateImageView_click:)];
    [downloadStateImageView addGestureRecognizer:downloadStateImageView_tapGesture];
    [downloadStateImageView_tapGesture setNumberOfTapsRequired:1];
    
    float line2X=16;
    fileSizeImageView.frame=CGRectMake(line2X, 36, 20, 20);
    fileSizeImageView.image=[UIImage imageNamed:@"文件"];
    line2X+=25;
    
    fileSizeLabel.frame=CGRectMake(line2X, 36, 60, 20);
    fileSizeLabel.font=[UIFont systemFontOfSize:12];
    line2X+=60;
    
    playingTimeImageView.frame=CGRectMake(line2X, 36, 20, 20);
    playingTimeImageView.image=[UIImage imageNamed:@"文件"];
    line2X+=25;
    
    playingTimeLabel.frame=CGRectMake(line2X, 36, 50, 20);
    playingTimeLabel.font=[UIFont systemFontOfSize:12];
    line2X+=60;
    
    playedTimeLabel.frame=CGRectMake(cellWith-100, 36, 84, 20);
    playedTimeLabel.textAlignment=NSTextAlignmentRight;
    playedTimeLabel.font=[UIFont systemFontOfSize:12];
}
-(void)setFm:(JYW_FictionModel *)fm{
    titleLabel.text=fm.title;
    fileSizeLabel.text=[NSString stringWithFormat:@"%.2f MB",fm.fileSize];
    playingTimeLabel.text=[NSString stringWithFormat:@"%d:%d",fm.playingTime/60,fm.playingTime%60];
    //playingState;//播放状态0未播放，1已播放，未播完，2已播完
    if(fm.playingState==0)
    {
        //downloadState;//下载状态，0未下载，1下载中，2下载完成
        if(fm.downloadState==0)
        {
            playedTimeLabel.text=@"未下载";
            downloadStateImageView.image=[UIImage imageNamed:@"下载"];
        }
        else if(fm.downloadState==1)
        {
            playedTimeLabel.text=@"下载中";
            downloadStateImageView.image=[UIImage imageNamed:@"下载"];
        }
        else
        {
            playedTimeLabel.text=@"已下载";
            downloadStateImageView.image=[UIImage imageNamed:@"已下载"];
        }
        playedTimeLabel.textColor=[UIColor blueColor];
    }
    else if(fm.playingState==1)
    {
        playedTimeLabel.text=@"已播完";
        playedTimeLabel.textColor=[UIColor grayColor];
    }
    else
    {
        playedTimeLabel.text=@"已播完";
        playedTimeLabel.textColor=[UIColor grayColor];
    }
}

-(IBAction)downloadStateImageView_click:(UITapGestureRecognizer *)sender{
    //渐变加载进度条
    NSArray *colorArray= @[(__bridge id)[UIColor yellowColor].CGColor,
    (__bridge id)[UIColor redColor].CGColor];
    NSArray *locationArray=@[@(0.01),@(1.0)];
    jywGradeRing=[[JYWGradeRing alloc] initWithFrame:downloadStateImageView.frame colorArray:colorArray locationArray:locationArray];
    [self.contentView addSubview:jywGradeRing];
    jywGradeRing.backgroundColor=[UIColor whiteColor];
    jywGradeRingTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(jywGradeRingTimer) userInfo:nil repeats:YES];
}
-(void)jywGradeRingTimer{
    if(jywGradeRing.progress>=1){
        //时间控件销毁
        [jywGradeRingTimer invalidate];
        jywGradeRingTimer=nil;
        //下载动画销毁
        [jywGradeRing removeFromSuperview];
        //设置音频状态
        self.fm.downloadState=2;
        playedTimeLabel.text=@"已下载";
        downloadStateImageView.image=[UIImage imageNamed:@"已下载"];
        //发回下载完成
        if(self.delegate && [self.delegate respondsToSelector:@selector(JYW_FictionTableViewCell_Finish:)]){
            [_delegate JYW_FictionTableViewCell_Finish:self.tag];
        }
    }else {
        jywGradeRing.progress+=0.1;
    }
}
@end
