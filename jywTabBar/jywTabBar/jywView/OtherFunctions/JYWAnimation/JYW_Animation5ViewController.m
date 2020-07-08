//
//  JYW_Animation5ViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/7.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_Animation5ViewController.h"

@interface JYW_Animation5ViewController ()
{
    NSArray *imageArray;
    CATransition *caTransition;
    UIImageView *imageView;
    int imgIndex;
    CALayer *tCALayer;
}
@end

@implementation JYW_Animation5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    imageArray=@[@"pic1",@"pic2",@"pic3",@"pic4",@"pic5"];
    [self initCALayer];
}

-(void)initCALayer{
    tCALayer=[CALayer layer];
    tCALayer.frame=CGRectMake(0, 0, 300, 200);
    tCALayer.contents=(id)[UIImage imageNamed:imageArray[imgIndex]].CGImage;
    [self.view.layer addSublayer:tCALayer];
    UITapGestureRecognizer *layerTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(layerTap:)];
    layerTap.numberOfTouchesRequired=1;
    //addGestureRecognizer
    [self.view addGestureRecognizer:layerTap];
}
-(IBAction)layerTap:(UITapGestureRecognizer*)sender{
    caTransition=[CATransition animation];
    caTransition.type=kCATransitionPush;
    caTransition.subtype=kCATransitionFromLeft;
    //caTransition.startProgress=0.1f;
    //caTransition.endProgress=1.0f;
    caTransition.duration=1;
    caTransition.removedOnCompletion=YES;
    [tCALayer addAnimation:caTransition forKey:@"caTransition"];
    imgIndex++;
    if(imgIndex==imageArray.count){
        imgIndex=0;
    }
    tCALayer.contents=(id)[UIImage imageNamed:imageArray[imgIndex]].CGImage;
}


@end
