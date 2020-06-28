//
//  JYW_CarouselCollectionViewCell.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/27.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYW_CarouselCollectionViewCell : UICollectionViewCell
{
    IBOutlet UIImageView *imageView;
}
@property(nonatomic,strong) NSString *imageStr;

@end

NS_ASSUME_NONNULL_END
