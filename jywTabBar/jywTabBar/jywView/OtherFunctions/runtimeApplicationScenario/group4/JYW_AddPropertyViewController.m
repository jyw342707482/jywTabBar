//
//  JYW_ViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/22.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_AddPropertyViewController.h"
#import "UIImage+JYW_AddProperty.h"
@interface JYW_AddPropertyViewController ()
{
    UIImageView *imageView;
}
@end

@implementation JYW_AddPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)btn_click:(UIButton *)sender{
    if(imageView==nil){
        UIImage *img=[UIImage imageNamed:@"audioCover"];
        img.downLoadURL=@"avatar1";
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 200, 300)];
        imageView.image=img;
        [self.view addSubview:imageView];
        UILabel *messageLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 180, 200, 20)];
        messageLabel.text=[@"添加的属性是:" stringByAppendingString:img.downLoadURL];
        [self.view addSubview:messageLabel];
    }
}

@end
