//
//  JYW_Carousel.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/26.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYW_CarouselFlowLayout.h"
NS_ASSUME_NONNULL_BEGIN
@interface JYW_CarouselConfig : NSObject
@property(nonatomic,assign)float autoPlaySecond;//自动播放间隔秒数
@property(nonatomic,assign)float restoreAutoPlaySecond;//恢复自动播放间隔秒数
@property(nonatomic,assign)float itemSpacing;//单元间距
@property(nonatomic,assign)float sectionInsetTop;//内边距（上，下相同）
@property(nonatomic,assign)float sectionInsetLeft;//内边距（左，右相同）
@property(nonatomic,strong)UIColor *backgroundColor;//背景颜色
@property(nonatomic,strong)NSMutableArray*imageArray;//图片数组
+(instancetype)defaultConfig;
@end


typedef NS_ENUM(NSInteger, FlowDirection){
    FlowDirectionLeft=0,
    FlowDirectionRight=1
};
//委托代理
@protocol JYW_Carousel_Delegate <NSObject>
//图片点击事件，返回图片的index值
-(void)JYW_Carousel_ImageClick:(NSInteger)index;
@end
@interface JYW_Carousel : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>
{
    FlowDirection *flowDirection;
    int imageIndex;
    NSTimer *autoplayTimer;
    JYW_CarouselConfig *jyw_CarouselConfig;
}
@property(nonatomic,strong)UICollectionView *collectionView;
//自动网格布局
@property(nonatomic,strong)JYW_CarouselFlowLayout * flowLayout;

@property(nonatomic,weak) id<JYW_Carousel_Delegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame JYW_CarouselConfig:(JYW_CarouselConfig *)config;

@end

NS_ASSUME_NONNULL_END
