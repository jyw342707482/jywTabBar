//
//  JYW_ UIBezierPathViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/7.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_UIBezierPathViewController.h"
#import "JYW_BezierPathView1.h"
#import "JYW_BezierPathView2.h"
#import "JYW_BezierPathView3.h"
#import "JYW_BezierPathView4.h"
#import "JYW_BezierPathView5.h"
#import "JYW_BezierPathView6.h"
#import "JYW_BezierPathView7.h"
#import "JYW_BezierPathView8.h"
@interface JYW_UIBezierPathViewController ()

@end

@implementation JYW_UIBezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initBezierPath1];
    [self initBezierPath2];
    [self initBezierPath3];
    [self initBezierPath4];
    [self initBezierPath5];
    [self initBezierPath6];
    [self initBezierPath7];
    [self initBezierPath8];
}
-(void)initBezierPath1{
    //创建一个新的实例，并返回空
    JYW_BezierPathView1 *bpv1=[[JYW_BezierPathView1 alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    [self.view addSubview:bpv1];
}
-(void)initBezierPath2{
    //创建一个矩形
    JYW_BezierPathView2 *bpv2=[[JYW_BezierPathView2 alloc] initWithFrame:CGRectMake(120, 10, 100, 100)];
    [self.view addSubview:bpv2];
}
-(void)initBezierPath3{
    //创建矩形中的椭圆形
    JYW_BezierPathView3 *bpv3=[[JYW_BezierPathView3 alloc] initWithFrame:CGRectMake(240, 10, 100, 100)];
    [self.view addSubview:bpv3];
}
-(void)initBezierPath4{
    //创建圆角矩形
    JYW_BezierPathView4 *bpv4=[[JYW_BezierPathView4 alloc] initWithFrame:CGRectMake(10, 120, 100, 100)];
    [self.view addSubview:bpv4];
}
-(void)initBezierPath5{
    //创建圆角矩形
    JYW_BezierPathView5 *bpv5=[[JYW_BezierPathView5 alloc] initWithFrame:CGRectMake(120, 120, 100, 100)];
    [self.view addSubview:bpv5];
}
-(void)initBezierPath6{
    //创建圆弧
    JYW_BezierPathView6 *bpv6=[[JYW_BezierPathView6 alloc] initWithFrame:CGRectMake(240, 120, 100, 100)];
    [self.view addSubview:bpv6];
}
-(void)initBezierPath7{
    //创建，用路径
    JYW_BezierPathView7 *bpv7=[[JYW_BezierPathView7 alloc] initWithFrame:CGRectMake(10, 240, 100, 100)];
    [self.view addSubview:bpv7];
}
-(void)initBezierPath8{
    //bezierPathByReversingPath,反向绘制
    //创建，用路径
    JYW_BezierPathView8 *bpv8=[[JYW_BezierPathView8 alloc] initWithFrame:CGRectMake(120, 240, 100, 100)];
    [self.view addSubview:bpv8];
}
/*
 Creating a UIBezierPath Object 创建路径
 
 + bezierPath
 创建并返回一个新的UIBezierPath对象。
 + bezierPathWithRect：
 创建并返回一个新的用矩形路径初始化的UIBezierPath对象。
 + bezierPathWithOvalInRect：
 创建并返回一个新的UIBezierPath对象，该对象初始化为指定矩形中的椭圆形路径
 + bezierPathWithRoundedRect：cornerRadius：
 创建并返回一个新的UIBezierPath对象，该对象使用圆角矩形路径初始化。
 + bezierPathWithRoundedRect：byRoundingCorners：cornerRadii：
 创建并返回一个新的UIBezierPath对象，该对象使用圆角矩形路径初始化。
 + bezierPathWithArcCenter：radius：startAngle：endAngle：clockwise：
 创建并返回一个新的用圆弧初始化的UIBezierPath对象。
 + bezierPathWithCGPath：
 创建并返回一个新的UIBezierPath对象，该对象初始化为Core Graphics路径的内容。
 -bezierPathByReversingPath
 创建并返回一个新的Bézier路径对象，其中包含当前路径的反向内容。
 - 在里面
 创建并返回一个空路径对象。
 -initWithCoder：
*/

/*
 构建路径

 -moveToPoint：
 将接收器的当前点移动到指定位置。
 -addLineToPoint：
 在接收者的路径上附加一条直线。
 -addArcWithCenter：radius：startAngle：endAngle：顺时针：
 在接收者的路径上添加弧线。
 -addCurveToPoint：controlPoint1：controlPoint2：
 在接收者的路径上附加三次贝塞尔曲线。
 -addQuadCurveToPoint：controlPoint：
 在接收者的路径上附加二次贝塞尔曲线。
 -closePath
 关闭最近添加的子路径。
 -removeAllPoints
 从接收器中删除所有点，从而有效删除所有子路径。
 -appendPath：
 将指定路径对象的内容附加到接收者的路径。
 CGPath
 路径的核心图形表示。
 -CGPath
 路径的核心图形表示。
 currentPoint
 图形路径中的当前点。
 */

/*
 访问工程图属性

 lineWidth
 路径的线宽。
 lineCapStyle
 描边时路径的端点形状。
 lineJoinStyle
 描边路径的连接段之间的关节形状。
 miterLimit
 该极限值有助于避免连接的线段之间的交界处出现尖峰。
 flatness
 确定弯曲路径段的渲染精度的因素。
 usesEvenOddFillRule
 一个布尔值，指示是否将奇偶缠绕规则用于绘制路径。
 -setLineDash：count：phase：
 设置路径的划线模式。
 -getLineDash：count：phase：
 检索路径的划线模式。
 */

/*
 Drawing Paths 绘制路径
 - fill
 使用当前绘图属性绘制接收者路径所包围的区域。
 -fillWithBlendMode：alpha：
 使用指定的混合模式和透明度值绘制接收者路径所包围的区域。
 - stroke
 使用当前绘图属性沿接收者的路径绘制一条线。
 -strokeWithBlendMode：alpha：
 使用指定的混合模式和透明度值沿接收者的路径绘制一条线。
 */

/*
 剪切路径
 -addClip
 将接收者的路径所包围的区域与当前图形上下文的剪切路径相交，并使生成的形状成为当前的剪切路径。
 */

/*
 Hit Detection 命中检测
 -containsPoint：
 返回一个布尔值，该值指示接收器包围的区域是否包含指定点。
 空的
 一个布尔值，指示路径是否具有任何有效元素。
 界线
 路径的边界矩形。
 */

 /*
 Applying Transformations 应用转换
 -applyTransform：
 使用指定的仿射变换矩阵变换路径中的所有点。
 */

 /*
 Constants 常数
 UIRectCorner
 矩形的角。
 */
@end
