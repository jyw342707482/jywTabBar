//
//  JYW_Animation1ViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/5.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_Animation1ViewController.h"

@interface JYW_Animation1ViewController ()
{
    CALayer *layer1;
}
@end

@implementation JYW_Animation1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initLayer1];
}

-(void)initLayer1{
    
    // 创建输入CIImage对象
    CIImage * inputImg = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"pic5"]];
    // 创建滤镜
    CIFilter * filter = [CIFilter filterWithName:@"CIColorInvert"];
    // 设置滤镜属性值为默认值
    [filter setDefaults];//kCICategoryDistortionEffect
    // 设置输入图像
    [filter setValue:inputImg forKey:@"inputImage"];
    // 获取输出图像
    CIImage * outputImg = [filter valueForKey:@"outputImage"];

    // 创建CIContex上下文对象
    CIContext * context = [CIContext contextWithOptions:nil];
    CGImageRef cgImg = [context createCGImage:outputImg fromRect:outputImg.extent];
    UIImage *resultImg = [UIImage imageWithCGImage:cgImg];
    CGImageRelease(cgImg);
    
    layer1=[[CALayer alloc] init];
    layer1.frame=CGRectMake(0, 0, 100, 100);
    layer1.backgroundColor=[UIColor redColor].CGColor;
    layer1.contents=(__bridge id)resultImg.CGImage;
    layer1.contentsRect=CGRectMake(0, 0, 1, 1);
    layer1.masksToBounds=YES;
    //设置内容（图片）位置
    //layer1.contentsGravity=kCAGravityBottom;
    [self.view.layer addSublayer:layer1];
    [self addCIFilters];
    [self addAnimation];
}
-(void)addCIFilters{
    //self.view setlayer
    
    CIFilter *filter=[[CIFilter alloc] init];
    filter.name=@"myFilter";
    layer1.filters=@[filter];
    [layer1 setValue:[NSNumber numberWithInt:100] forKey:@"filters.myFilter.inputRadius"];
}
-(void)addAnimation{
    
    CABasicAnimation *bAnimation=[CABasicAnimation animationWithKeyPath:@"position.x"];
    bAnimation.fromValue=@(layer1.frame.origin.x);
    bAnimation.toValue=@(200);
    bAnimation.duration=5;
    bAnimation.beginTime=0;
    
    CABasicAnimation *bAnimation1=[CABasicAnimation animationWithKeyPath:@"position.y"];
    bAnimation1.fromValue=@(layer1.frame.origin.y);
    bAnimation1.toValue=@(200);
    bAnimation1.duration=5;
    bAnimation1.beginTime=0;
    
    CABasicAnimation *bAnimation2=[CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    bAnimation2.fromValue=@(0);
    bAnimation2.toValue=@(10);
    bAnimation2.duration=5;
    bAnimation2.beginTime=0;
    
    CAAnimationGroup *aGroup=[[CAAnimationGroup alloc] init];
    aGroup.animations=@[bAnimation,bAnimation1,bAnimation2];
    aGroup.repeatCount=INTMAX_MAX;
    aGroup.duration=5;
    //动画运行完毕是否删除
    aGroup.removedOnCompletion=NO;
    
    [layer1 addAnimation:aGroup forKey:@"bAnimation"];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point=[[touches anyObject] locationInView:self.view];
    CALayer *layer2=[layer1.presentationLayer hitTest:point];
    CALayer *layer3=[layer1.modelLayer hitTest:point];
    messageTextView.text=[NSString stringWithFormat:@"%@;   presentaionLayer:%f,%f;modelLayer:%f,%f",messageTextView.text,layer2.frame.origin.x,layer2.frame.origin.y,layer3.frame.origin.x,layer3.frame.origin.y];
}
@end
