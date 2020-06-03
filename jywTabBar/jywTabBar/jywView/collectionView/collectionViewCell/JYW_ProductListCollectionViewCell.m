//
//  JYW_ProductListCollectionViewCell.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/3.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_ProductListCollectionViewCell.h"

@implementation JYW_ProductListCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        imageView=[[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        titleLabel=[[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        tagsView=[[UIView alloc] init];
        [self.contentView addSubview:tagsView];
        sellingPriceLabel=[[UILabel alloc] init];
        [self.contentView addSubview:sellingPriceLabel];
        numberOfSalesLabel=[[UILabel alloc] init];
        [self.contentView addSubview:numberOfSalesLabel];
    }
    return self;
}
-(void)layoutSubviews{
    float controlY=0;
    imageView.frame=CGRectMake(0, controlY, self.frame.size.width, self.frame.size.width/0.618);
    controlY+=self.frame.size.width/0.618;
    
    titleLabel.frame=CGRectMake(0, controlY, self.frame.size.width, 20);
    titleLabel.font=[UIFont systemFontOfSize:14];
    controlY+=20;
    
    tagsView.frame=CGRectMake(0, controlY, self.frame.size.width, 20);
    controlY+=20;
    
    sellingPriceLabel.frame=CGRectMake(0, controlY, self.frame.size.width, 20);
    sellingPriceLabel.textColor=[UIColor redColor];
    sellingPriceLabel.font=[UIFont systemFontOfSize:14];
    
    numberOfSalesLabel.frame=CGRectMake(0, controlY, self.frame.size.width, 20);
    numberOfSalesLabel.textColor=[UIColor grayColor];
    numberOfSalesLabel.font=[UIFont systemFontOfSize:12];
    numberOfSalesLabel.textAlignment=NSTextAlignmentRight;
    controlY+=20;
    
}
-(void)setPm:(JYW_ProductModel *)pm{
    imageView.image=[UIImage imageNamed:pm.pImagePath];
    titleLabel.text=pm.title;
    float tagX=0;
    for(NSString *tagStr in pm.tags){
        CGSize size = [tagStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        UILabel *tagStrLabel =[[UILabel alloc] initWithFrame:CGRectMake(tagX, 0, size.width, 20)];
        tagStrLabel.text=tagStr;
        tagStrLabel.textColor=[UIColor whiteColor];
        tagStrLabel.font=[UIFont systemFontOfSize:12];
        tagStrLabel.backgroundColor=[UIColor redColor];
        [tagsView addSubview:tagStrLabel];
        tagX+=size.width+5;
    }
    sellingPriceLabel.text=[NSString stringWithFormat:@"￥%.2f",pm.sellingPrice];
    numberOfSalesLabel.text=[NSString stringWithFormat:@"已经卖出%d件",pm.numberOfSales];
}
@end
