//
//  JYW_CarouselCollectionViewCell.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/27.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_CarouselCollectionViewCell.h"

@implementation JYW_CarouselCollectionViewCell
-(void)setImageStr:(NSString *)imageStr{
    _imageStr=imageStr;
    if(imageView==nil){
        imageView=[[UIImageView alloc] initWithFrame:self.contentView.frame];
        imageView.layer.masksToBounds=YES;
        imageView.layer.cornerRadius=5.0f;
        [self.contentView addSubview:imageView];
    }
    imageView.image=[UIImage imageNamed:_imageStr];
}
@end
