//
//  JYW_CarouselFlowLayout.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/27.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_CarouselFlowLayout.h"

@implementation JYW_CarouselFlowLayout

-(instancetype)initWithSize:(CGSize)size{
    self=[super init];
    if(self){
        //设置单元格大小
        self.itemSize = size;
        //最小行间距(默认为10)
        self.minimumLineSpacing = 10;
        //最小item间距（默认为10）
        //self.minimumInteritemSpacing = 0.0f;
        //设置senction的内边距
        self.sectionInset = UIEdgeInsetsMake(10, 40, 10, 40);
        //设置UICollectionView的滑动方向
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        
        //self.sizeScale = 0.7;
    }
    return self;
}

//边界改变是否触发布局更新
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

//返回指定矩形中所有单元格和视图的布局属性。
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    //可见frame
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.frame.size;
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:array.count];
    for(UICollectionViewLayoutAttributes *attributes in array)
    {
        UICollectionViewLayoutAttributes *newAttributes = [attributes copy];
        [allAttributes addObject:newAttributes];
        if(CGRectIntersectsRect(newAttributes.frame, visibleRect))
        {
            CGFloat distance = CGRectGetMidX(visibleRect) - newAttributes.center.x;
            CGFloat scale = ABS(distance)/(self.collectionView.frame.size.width/2);
            CGFloat adverseScale = ABS(1-scale);
            //CGFloat trueScale = (1-self.sizeScale)*adverseScale + self.sizeScale;
            CGFloat trueScale = (1-0.7)*adverseScale + 0.7;
            newAttributes.transform3D = CATransform3DMakeScale(trueScale, trueScale, 1.0);
            newAttributes.zIndex = 1;

        }
        
    }
    return allAttributes;
    return [super layoutAttributesForElementsInRect:rect];
}

//返回在动画布局更新或更改后要使用的偏移值。
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    return proposedContentOffset;
}
@end
