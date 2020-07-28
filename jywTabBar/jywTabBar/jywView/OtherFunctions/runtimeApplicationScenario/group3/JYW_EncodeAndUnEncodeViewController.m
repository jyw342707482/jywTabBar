//
//  JYW_EncodeAndUnEncodeViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/20.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_EncodeAndUnEncodeViewController.h"
#import "JYW_EncodeAndUnEncode.h"
@interface JYW_EncodeAndUnEncodeViewController ()
{
    JYW_EncodeAndUnEncode *eaue;
}
@end

@implementation JYW_EncodeAndUnEncodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(IBAction)btnJD_Click:(UIButton *)sender{
    //归档的路径
    //如果不存在
    NSString* docPatn = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* path = [docPatn stringByAppendingPathComponent:@"moive.archiver"];
    //解档
    JYW_EncodeAndUnEncode * unmoive = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSLog(@"已解档");
    NSLog(@"获取电影的信息:电影:%@||电影类别:%@||电影地址:%@",unmoive.title,unmoive.genres,unmoive.imageUrl);
}
-(IBAction)btnGD_Click:(UIButton *)sender{
    eaue=[[JYW_EncodeAndUnEncode alloc] init];
    eaue.title=@"title1";
    eaue.genres=@"genres1";
    eaue.imageUrl=@"imageUrl1";
    //归档的路径
    //如果不存在
    NSString* docPatn = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* path = [docPatn stringByAppendingPathComponent:@"moive.archiver"];
    //自定义对象存到文件中
    [NSKeyedArchiver archiveRootObject:eaue toFile:path];
    NSLog(@"已归档");
}
@end
