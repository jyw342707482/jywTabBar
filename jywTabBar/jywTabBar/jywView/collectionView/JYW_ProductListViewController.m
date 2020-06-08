//
//  JYW_ProductListViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/3.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_ProductListViewController.h"
#import "JYW_ProductListViewModel.h"
#import "JYW_ProductListCollectionViewCell.h"
//static NSString * identifier = @"cxCellID";
@interface JYW_ProductListViewController ()
{
    NSMutableArray *pListArray;
    JYW_ProductListViewModel *jyw_productListViewModel;
    
    NSMutableDictionary *identifierDictionary;
}
@end

@implementation JYW_ProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pageSettings];
}
-(BOOL)shouldAutorotate{
    return YES;
}
-(void)pageSettings{
    self.title=@"产品列表";
    
    jyw_productListViewModel=[[JYW_ProductListViewModel alloc] init];
    pListArray=[jyw_productListViewModel getProductListDataWithArray:[jyw_productListViewModel getPageData]];
    
    //自动网格布局
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc ] init];
    
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 40) / 2;
    //设置单元格大小
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth / 0.618+65);
     
    //最小行间距(默认为10)
    flowLayout.minimumLineSpacing = 10;

    //最小item间距（默认为10）
    flowLayout.minimumInteritemSpacing = 10;

    //设置senction的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    //设置UICollectionView的滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;

    //sectionHeader的大小,如果是竖向滚动，只需设置Y值。如果是横向，只需设置X值。
    //flowLayout.headerReferenceSize = CGSizeMake(0,0);
    //flowLayout.footerReferenceSize = CGSizeMake(0,0);
    // 设置分区的头视图和尾视图 是否始终固定在屏幕上边和下边
    //flowLayout.sectionFootersPinToVisibleBounds = YES;
    
    //网格布局
    productListView.collectionViewLayout=flowLayout;

    //注册cell
    //[productListView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    identifierDictionary=[[NSMutableDictionary alloc] init];
}
//有多少的分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个分组里有多少个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return pListArray.count;
}
/*
//集合视图单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 40) / 2;
    CGSize returnSize;
    switch (indexPath.item) {
        case 0:
            returnSize=CGSizeMake(itemWidth, itemWidth / 0.618+65);
            break;
        case 1:
            returnSize=CGSizeMake(itemWidth, itemWidth / 0.618+80);
            break;
        case 2:
            returnSize=CGSizeMake(itemWidth, itemWidth / 0.618+90);
            break;
        case 3:
            returnSize=CGSizeMake(itemWidth, itemWidth / 0.618+120);
            break;
        case 4:
            returnSize=CGSizeMake(itemWidth, itemWidth / 0.618+65);
            break;
        default:
            returnSize=CGSizeMake(itemWidth, itemWidth / 0.618+65);
            break;
    }
    return returnSize;
}

//头部大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(0,100);
}
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    // 每次先从字典中根据IndexPath取出唯一标识符
    NSString *identifier = [identifierDictionary objectForKey:[NSString stringWithFormat:@"%ld", indexPath.item]];
    //item是否是刚刚注册
    BOOL registered=NO;
    // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"item%ld", indexPath.item];
        [identifierDictionary setValue:identifier forKey:[NSString stringWithFormat:@"%ld", indexPath.item]];
        // 注册Cell
        [productListView registerClass:[JYW_ProductListCollectionViewCell class]  forCellWithReuseIdentifier:identifier];
        //
        registered=YES;
    }
    
    
    //根据identifier从缓冲池里去出cell
    JYW_ProductListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if(registered)
    {
        cell.backgroundColor = [UIColor whiteColor];
        JYW_ProductModel *jywPM=pListArray[indexPath.item];
        cell.pm=jywPM;
    }
    //[cell.contentView addSubview:jywPLCVC];
    /*
    //添加手势
    titleLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * titleLabel_tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabel_click:)];
    [titleLabel addGestureRecognizer:titleLabel_tapGesture];
    [titleLabel_tapGesture setNumberOfTapsRequired:1];*/
    return cell;
}
-(IBAction)titleLabel_click:(UITapGestureRecognizer *)sender{
    JYW_ProductListViewController *jywPLVVC=[[JYW_ProductListViewController alloc] init];
    [self.navigationController pushViewController:jywPLVVC animated:YES];
}
@end
