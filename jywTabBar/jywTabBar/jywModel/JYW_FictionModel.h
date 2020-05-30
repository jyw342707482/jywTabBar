//
//  JYW_FictionModel.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/27.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYW_FictionModel : NSObject
@property(nonatomic,readwrite)int fId;
@property(nonatomic,readwrite)NSString *title;//标题
@property(nonatomic,readwrite)float fileSize;//文件大小
@property(nonatomic,readwrite)int playingTime;//播放时长

@property(nonatomic,readwrite)int playingState;//播放状态0未播放，1已播放，未播完，2已播完
@property(nonatomic,readwrite)int playedTime;//已经播放时长
@property(nonatomic,readwrite)int downloadState;//下载状态，0未下载，1下载中，2下载完成

-(instancetype)initWithTitle:(NSString*)t fileSize:(float)fs playingTime:(int)pt playingState:(int)ps playedTime:(int)pdt downloadState:(int)ds fId:(int)ID;
@end

NS_ASSUME_NONNULL_END
