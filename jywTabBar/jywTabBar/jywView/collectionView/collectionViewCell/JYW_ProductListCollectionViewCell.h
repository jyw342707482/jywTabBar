//
//  JYW_ProductListCollectionViewCell.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/3.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYW_ProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JYW_ProductListCollectionViewCell : UICollectionViewCell
{
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIView *tagsView;
    IBOutlet UILabel *sellingPriceLabel;
    IBOutlet UILabel *numberOfSalesLabel;
}
@property(nonatomic,readwrite)JYW_ProductModel *pm;
@end

NS_ASSUME_NONNULL_END
