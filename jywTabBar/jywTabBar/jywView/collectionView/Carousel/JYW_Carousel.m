//
//  JYW_Carousel.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/26.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_Carousel.h"
#import "JYW_CarouselCollectionViewCell.h"
@implementation JYW_CarouselConfig
+(instancetype)defaultConfig{
    JYW_CarouselConfig *config=[[JYW_CarouselConfig alloc] init];
    config.autoPlaySecond=2.0f;
    config.restoreAutoPlaySecond=3.0f;
    config.itemSpacing=10;
    config.sectionInsetTop=10;
    config.sectionInsetLeft=40;
    config.backgroundColor=[UIColor blackColor];
    return config;
}
@end

static NSString *identifier=@"identifier";
@implementation JYW_Carousel
-(instancetype)initWithFrame:(CGRect)frame JYW_CarouselConfig:(JYW_CarouselConfig *)config{
    self=[super initWithFrame:frame];
    if(self){
        jyw_CarouselConfig=config;
        self.backgroundColor=jyw_CarouselConfig.backgroundColor;
        [self addSubview:self.collectionView];
        [self initUISwipeGestureRecognizer];
        [self initAutoplayTimer];
    }
    return self;
}
#pragma mark -添加自动播放时间控件
-(void)initAutoplayTimer{
    if(autoplayTimer!=nil)
    {
        [autoplayTimer invalidate];
        autoplayTimer=nil;
    }
    autoplayTimer=[NSTimer timerWithTimeInterval:jyw_CarouselConfig.autoPlaySecond target:self selector:@selector(autoplayTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:autoplayTimer forMode:NSRunLoopCommonModes];
}
-(void)autoplayTimer{
    if(imageIndex<jyw_CarouselConfig.imageArray.count-1){
        imageIndex++;
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x+self.flowLayout.itemSize.width+jyw_CarouselConfig.itemSpacing, 0) animated:YES];
    }
    else{
        imageIndex=0;
        [self.collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}
-(void)reloadAutoplayTime{
    [autoplayTimer invalidate];
     autoplayTimer=nil;
    autoplayTimer=[NSTimer timerWithTimeInterval:jyw_CarouselConfig.restoreAutoPlaySecond target:self selector:@selector(initAutoplayTimer) userInfo:nil repeats:NO];
     [[NSRunLoop currentRunLoop] addTimer:autoplayTimer forMode:NSRunLoopCommonModes];
}
#pragma mark -添加轻扫手势
-(void)initUISwipeGestureRecognizer{
    //UISwipeGestureRecognizer
    UISwipeGestureRecognizer *swipeGestureLeft=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureLeft:)];
    swipeGestureLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [swipeGestureLeft setNumberOfTouchesRequired:1];
    [self addGestureRecognizer:swipeGestureLeft];
    
    UISwipeGestureRecognizer *swipeGestureRight=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRight:)];
    swipeGestureRight.direction=UISwipeGestureRecognizerDirectionRight;
    [swipeGestureRight setNumberOfTouchesRequired:1];
    [self addGestureRecognizer:swipeGestureRight];
    /*
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
    [tapGestureRecognizer setNumberOfTapsRequired:1];
    [self addGestureRecognizer:tapGestureRecognizer];*/
}
/*
-(IBAction)tapGestureRecognizer:(UITapGestureRecognizer*)sender{
    [self reloadAutoplayTime];
}*/
-(IBAction)swipeGestureLeft:(UISwipeGestureRecognizer *)sender{
    if(imageIndex<jyw_CarouselConfig.imageArray.count-1){
        imageIndex++;
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x+self.flowLayout.itemSize.width+jyw_CarouselConfig.itemSpacing, 0) animated:YES];
    }
    [self reloadAutoplayTime];
}
-(IBAction)swipeGestureRight:(UISwipeGestureRecognizer *)sender{
    if(imageIndex>0){
        imageIndex--;
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x-(self.flowLayout.itemSize.width+jyw_CarouselConfig.itemSpacing), 0) animated:YES];
    }
    [self reloadAutoplayTime];
}
#pragma mark -collectionView deleget
//有多少的分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个分组里有多少个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return jyw_CarouselConfig.imageArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //创建item / 从缓存池中拿 Item
    JYW_CarouselCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.imageStr=jyw_CarouselConfig.imageArray[indexPath.item];
    /*
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImageView *image=[[UIImageView alloc] initWithFrame:cell.contentView.frame];
    image.image=[UIImage imageNamed:jyw_CarouselConfig.imageArray[indexPath.item]];
    [cell.contentView addSubview:image];*/
    return cell;
}
 - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     if([_delegate respondsToSelector:@selector(JYW_Carousel_ImageClick:)])
     {
         [_delegate JYW_Carousel_ImageClick:indexPath.item];
     }
     [collectionView deselectItemAtIndexPath:indexPath animated:YES];//取消选中
}
#pragma mark -懒加载
-(UICollectionView*)collectionView{
    if(_collectionView==nil){
        //自动网格布局
        _flowLayout = [[JYW_CarouselFlowLayout alloc ] initWithSize:CGSizeMake(self.frame.size.width-jyw_CarouselConfig.sectionInsetLeft*2, self.frame.size.height-jyw_CarouselConfig.sectionInsetTop*2)];
        _flowLayout.minimumLineSpacing=jyw_CarouselConfig.itemSpacing;
        _flowLayout.sectionInset=UIEdgeInsetsMake(jyw_CarouselConfig.sectionInsetTop, jyw_CarouselConfig.sectionInsetLeft, jyw_CarouselConfig.sectionInsetTop, jyw_CarouselConfig.sectionInsetLeft);
        
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:_flowLayout];
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.bounces=NO;//滚动到边缘，是否弹跳
        _collectionView.pagingEnabled=NO;
        _collectionView.scrollEnabled=NO;
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        
        //注册cell
        //[_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
        [_collectionView registerClass:[JYW_CarouselCollectionViewCell class] forCellWithReuseIdentifier:identifier];
        
    }
    return _collectionView;
}
@end
