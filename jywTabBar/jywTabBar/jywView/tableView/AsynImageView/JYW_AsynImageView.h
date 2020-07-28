//
//  JYW_AsynImageView.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/27.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//异步加载网络图片
//转载：afnetworking:https://www.jianshu.com/p/34dbfaf0f995
@interface JYW_AsynImageView : UIImageView
{
    NSURLConnection *connection;
    NSMutableData *loadData;
}
//图片对应的缓存在沙河中的路径
@property (nonatomic, retain) NSString *fileName;
  
//指定默认未加载时，显示的默认图片
@property (nonatomic, retain) UIImage *placeholderImage;
//请求网络图片的URL
@property (nonatomic, retain) NSString *imageURL;


@end

NS_ASSUME_NONNULL_END
