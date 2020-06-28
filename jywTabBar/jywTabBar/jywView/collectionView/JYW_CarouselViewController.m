//
//  JYW_CarouselViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/26.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_CarouselViewController.h"
#import "JYW_Carousel.h"
@interface JYW_CarouselViewController ()<JYW_Carousel_Delegate>

@property(nonatomic,strong) IBOutlet JYW_Carousel *jyw_Carousel;

@end

@implementation JYW_CarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *imageArray=@[@"pic1",@"pic2",@"pic3",@"pic4",@"pic5",@"pic6",@"pic7"];
    JYW_CarouselConfig *config=[JYW_CarouselConfig defaultConfig];
    config.sectionInsetLeft=40;
    config.sectionInsetTop=10;
    config.imageArray=imageArray;
    self.jyw_Carousel=[[JYW_Carousel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) JYW_CarouselConfig:config];
    self.jyw_Carousel.delegate=self;
    [self.view addSubview:self.jyw_Carousel];
}
-(void)JYW_Carousel_ImageClick:(NSInteger)index{
    NSLog(@"imageIndex:%d",index);
}


@end
