//
//  JYW_TextLayer.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/8.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_TextLayer.h"

@implementation JYW_TextLayer

- (void)drawRect:(CGRect)rect{
    CATextLayer *tLayer=[CATextLayer layer];
    tLayer.frame=CGRectMake(0, 0, 200, 50);
    tLayer.string=@"阿拉法律结束了房价拉数据法律撒娇法拉盛，阿里将带来看房，阿拉基倒垃圾发。";
    /*可以是CTFontRef，CGFontRef，NSFont的实例（仅适用于macOS）或命名字体的字符串。 在iOS中，不能将UIFont对象分配给此属性。 默认为Helvetica。
    仅当string属性不是NSAttributedString时才使用font属性。*/
    tLayer.font=CGFontCreateWithFontName((CFStringRef)[UIFont systemFontOfSize:12.0f].fontName);
    tLayer.fontSize=13.0f;
    tLayer.foregroundColor=[UIColor redColor].CGColor;
    tLayer.wrapped=YES;
    tLayer.alignmentMode=kCAAlignmentLeft;
    tLayer.truncationMode=kCATruncationMiddle;
    [self.layer addSublayer:tLayer];
    
    
    NSMutableAttributedString *mAttributedString=[[NSMutableAttributedString alloc] initWithString:@"阿拉法律结束了房价拉数据法律撒娇法拉盛，阿里将带来看房，阿拉基倒垃圾发。"];
    [mAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:[@"阿拉法律结束了房价拉数据法律撒娇法拉盛，阿里将带来看房，阿拉基倒垃圾发。" rangeOfString:@"阿里将带来看房"]];
    CATextLayer *tLayer1=[CATextLayer layer];
    tLayer1.frame=CGRectMake(0, 50, 200, 50);
    tLayer1.string=mAttributedString;
    tLayer1.wrapped=YES;
    tLayer1.alignmentMode=kCAAlignmentLeft;
    tLayer1.truncationMode=kCATruncationMiddle;
    [self.layer addSublayer:tLayer1];
}
/*
 NSAttributedString
 转载：https://www.jianshu.com/p/15822a736396
 */
/*
 Getting and Setting the Text 获取和设置文本

 string 串
 接收方要呈现的文本。

 Text Visual Properties 文字视觉属性
 font 字形
 用于呈现收件人文本的字体。
 可以是CTFontRef，CGFontRef，NSFont的实例（仅适用于macOS）或命名字体的字符串。 在iOS中，不能将UIFont对象分配给此属性。 默认为Helvetica。
 仅当string属性不是NSAttributedString时才使用font属性。
 
 fontSize 字体大小
 用于呈现收件人文字的字体大小。 可动画的。
 foregroundColor 前景色
 用于呈现收件人文字的颜色。 可动画的。
 allowFontSubpixelQuantization
 确定是否允许对用于文本渲染的图形上下文进行子像素量化。
 文本对齐和截断

 Text Alignment and Truncation
 wrapped
 确定是否将文本换行以适合接收者的范围。
 alignmentMode
 确定文本的各行在接收者范围内如何水平对齐。
 truncationMode 截断模式
 确定如何将文本截断以适合接收者的范围。
 */
@end
