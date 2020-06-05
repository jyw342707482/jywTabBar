//
//  JYW_VideoModel.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/5.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYW_VideoModel : NSObject
@property(nonatomic,readwrite)NSString *title;//标题
@property(nonatomic,readwrite)float fileSize;//文件大小，单位MB
@property(nonatomic,readwrite)long videoDuration;//视频长度，单位秒
@property(nonatomic,readwrite)NSString *videoDurationStr;//视频长度，00:00:00
@property(nonatomic,readwrite)float playRate;//播放速率
@property(nonatomic,readwrite)NSURL *filePath;//文件地址
-(instancetype)initWithTitle:(NSString*)t fileSize:(float)fs videoDuration:(int)vd playRate:(float)pr filePath:(NSURL*)fp;
@end

NS_ASSUME_NONNULL_END
