//
//  JYW_CollectionViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/27.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_CollectionViewController.h"
#import "JYW_ProductListViewController.h"

static NSString * identifier = @"cxCellID";
static NSString * headIdentifier = @"cxHeadID";
@interface JYW_CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *collectionDSArray;
}
@end

@implementation JYW_CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pageSettings];
}

//页面设置
-(void)pageSettings{
    //设置导航标题
    self.title=@"UICollectionView";
    collectionDSArray=@[@"产品展示1",@"产品展示2",@"产品展示3"];
    //自动网格布局
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc ] init];
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 40) / 2;
    //设置单元格大小
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth / 0.618);

    //最小行间距(默认为10)
    flowLayout.minimumLineSpacing = 10;

    //最小item间距（默认为10）
    flowLayout.minimumInteritemSpacing = 10;

    //设置senction的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    //设置UICollectionView的滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;

    //sectionHeader的大小,如果是竖向滚动，只需设置Y值。如果是横向，只需设置X值。
    flowLayout.headerReferenceSize = CGSizeMake(0,50);
    
    //网格布局
    collView.collectionViewLayout=flowLayout;

    //注册cell
    [collView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    //注册header
    [collView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier];
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    //kind有两种 一种时header 一种事footer
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier forIndexPath:indexPath];
        header.backgroundColor = [UIColor yellowColor];
        return header;
    }
    return nil;
}
//有多少的分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个分组里有多少个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return collectionDSArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //根据identifier从缓冲池里去出cell
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:cell.contentView.frame];
    titleLabel.text=collectionDSArray[indexPath.item];
    titleLabel.numberOfLines=0;
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.tag=indexPath.item;
    [cell.contentView addSubview:titleLabel];
    //添加手势
    titleLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * titleLabel_tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabel_click:)];
    [titleLabel addGestureRecognizer:titleLabel_tapGesture];
    [titleLabel_tapGesture setNumberOfTapsRequired:1];
    return cell;
}
-(IBAction)titleLabel_click:(UITapGestureRecognizer *)sender{
    JYW_ProductListViewController *jywPLVVC=[[JYW_ProductListViewController alloc] init];
    [self.navigationController pushViewController:jywPLVVC animated:YES];
}
@end
