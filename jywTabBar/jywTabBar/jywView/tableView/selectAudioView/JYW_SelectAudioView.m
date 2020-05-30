//
//  JYW_SelectAudioView.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/29.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_SelectAudioView.h"

@implementation JYW_SelectAudioView

-(void)setViewControlWithAudioCount:(int)audioCount NumberOfAudiosPerLabel:(int)noapl{
    
    
    //选集按钮数量
    int buttonCount=audioCount/noapl;
    buttonCount+=audioCount%noapl>0?1:0;
    //按钮行数
    int rowCount=buttonCount/4;
    rowCount+=buttonCount%4>0?1:0;
    [self createScrollViewWithContentSizeHeight:rowCount*50];
    
    int labelAudioCount=1;
    float labelX=0;
    float labelY=0;
    float labelWidth=[UIScreen mainScreen].bounds.size.width/4;
    int row=0;
    for(int i=0;i<buttonCount;i++)
    {
        NSString *labelText=[NSString stringWithFormat:@"%d-%d",labelAudioCount,labelAudioCount+noapl-1];
        [self createLabelWithX:labelX Y:labelY width:labelWidth height:50 text:labelText tag:i];
        labelAudioCount+=noapl;
        labelX+=labelWidth;
        row+=1;
        if(row>=4){
            labelY+=50;
            labelX=0;
            row=0;
        }
        
    }
}
-(void)createScrollViewWithContentSizeHeight:(float)cHeight{
    float viewHeight=[UIScreen mainScreen].bounds.size.height/2;
    if(cHeight<viewHeight)
    {
        viewHeight=cHeight;
    }
    audioScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, viewHeight)];
    audioScrollView.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, cHeight);
    //是否弹动
    audioScrollView.alwaysBounceVertical=NO;
    audioScrollView.alwaysBounceHorizontal=NO;
    //是否显示横向指示器
    audioScrollView.showsHorizontalScrollIndicator=NO;
    [self addSubview:audioScrollView];
    CGRect selfRect=self.frame;
    selfRect.size.height=viewHeight;
    self.frame=selfRect;
}
-(void)createLabelWithX:(float)labelX Y:(float)labelY width:(float)labelWidth height:(float)labelHeight text:(NSString *)labelText tag:(int)labelTag{
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelWidth, labelHeight)];
    label.text=labelText;
    label.tag=labelTag;
    
    label.textAlignment=NSTextAlignmentCenter;
    //label.backgroundColor=[UIColor redColor];
    label.numberOfLines=0;
    label.font=[UIFont systemFontOfSize:12];
    [audioScrollView addSubview:label];
    //添加手势
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer * label_tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(label_click:)];
    [label addGestureRecognizer:label_tapGesture];
    [label_tapGesture setNumberOfTapsRequired:1];
    
}
//选集标签点击事件
-(IBAction)label_click:(UITapGestureRecognizer *)sender{
    if([_delegate respondsToSelector:@selector(JYW_SelectAudioView_LabelClick:)])
    {
        [_delegate JYW_SelectAudioView_LabelClick:sender.view.tag];
    }
}
@end
