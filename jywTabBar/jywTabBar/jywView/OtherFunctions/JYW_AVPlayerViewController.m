//
//  JYW_AVPlayerViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/5.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_AVPlayerViewController.h"
#import "JYW_AVPlayerView.h"
#import "JYW_AVPlayerModel.h"

@interface JYW_AVPlayerViewController ()
{
    JYW_AVPlayerModel *jyw_AVPlayerModel;
    JYW_AVPlayerView *jyw_AVPlayerView;
    
    NSLayoutConstraint *jyw_AVPlayerViewBottomConstraint;
}
@end

@implementation JYW_AVPlayerViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    jyw_AVPlayerModel=[[JYW_AVPlayerModel alloc] initWithTitle:@"video3" FilePath:@"video3"];
    jyw_AVPlayerView=[[JYW_AVPlayerView alloc] initWithJYW_AVPayerModel:jyw_AVPlayerModel superViewController:self];
    jyw_AVPlayerView.translatesAutoresizingMaskIntoConstraints=NO;
    jyw_AVPlayerView.backgroundColor=[UIColor blackColor];
    
    [self.view addSubview:jyw_AVPlayerView];
    jyw_AVPlayerView.windowView=self.view;
}
-(BOOL)shouldAutorotate{
    return YES;
}

@end



