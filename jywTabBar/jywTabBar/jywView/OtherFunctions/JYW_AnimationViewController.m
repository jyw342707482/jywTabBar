//
//  JYW_AnimationViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/18.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_AnimationViewController.h"
#import "JYWProgressRing1.h"
#import "JYWFinish.h"
#import "JYWGrade.h"
#import "JYWGradeRing.h"
@interface JYW_AnimationViewController ()
{
    //加载
    JYWProgressRing1 *jywpr;
    //完成
    JYWFinish *finish;
    //渐变加载
    JYWGrade *grade;
    //渐变加载，环形
    JYWGradeRing *gradeRing;
}
@end

@implementation JYW_AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载等待
    jywpr = [[JYWProgressRing1 alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    jywpr.progress=0.1;
    [self.view addSubview:jywpr];
    [jywpr play];
    
    //完成
    finish=[[JYWFinish alloc] initWithFrame:CGRectMake(50, 200, 50, 50)];
    [self.view addSubview:finish];
    [finish play];
    
    //渐变加载进度条
    NSArray *colorArray= @[(__bridge id)[UIColor yellowColor].CGColor,
    (__bridge id)[UIColor redColor].CGColor];
    NSArray *locationArray=@[@(0.01),@(1.0)];
    grade=[[JYWGrade alloc] initWithFrame:CGRectMake(80, 320, 200, 20) colorArray:colorArray locationArray:locationArray];
    //grade=[[JYWGrade alloc] initWithFrame:CGRectMake(80, 300, 300, 20)];
    //grade.backgroundColor=[UIColor blueColor];
    [self.view addSubview:grade];
    //[grade addAnimationWithColorArray:colorArray locationArray:locationArray];
    //[grade addAnimation];
    
    //渐变加载进度条（环形）
    gradeRing=[[JYWGradeRing alloc] initWithFrame:CGRectMake(80, 393, 70, 70) colorArray:colorArray locationArray:locationArray];
    //gradeRing.backgroundColor=[UIColor redColor];
    [self.view addSubview:gradeRing];
}
#pragma mark -加载等待
-(IBAction)JYWProgressRing1_play:(id)sender{
    [jywpr play];
}
-(IBAction)JYWProgressRing1_stop:(id)sender{
    [jywpr stop];
}

#pragma mark -完成动画
-(IBAction)JYWFinish_play:(id)sender{
    [finish play];
}
-(IBAction)JYWFinish_stop:(id)sender{
    [finish stop];
}

#pragma mark -加载进度条
-(IBAction)gradeAddProgress_Up:(UIButton *)btn{
    if(grade.progress<=1){
        grade.progress+=0.05;
    }
}
-(IBAction)gradeAddProgress_Down:(UIButton *)btn{
    if(grade.progress>=0.05){
        grade.progress-=0.05;
    }
}

#pragma mark -加载进度条（环形）
-(IBAction)gradeRingAddProgress_Up:(UIButton *)btn{
    if(gradeRing.progress<=1){
        gradeRing.progress+=0.05;
    }
}
-(IBAction)gradeRingAddProgress_Down:(UIButton *)btn{
    if(gradeRing.progress>=0.05){
        gradeRing.progress-=0.05;
    }
}
@end
