//
//  JYW_AVPlayerModel.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/6.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYW_AVPlayerModel : NSObject
{
    NSURL *filePath;//文件地址
    NSString *title;//标题
    NSString *playTime;//播放时长（playTimeType类型0：00:00:00，1：00:00，2：00）
    int playTimeType;//播放时长格式类型0,1,2，对应playTime播放时长
    
}
-(instancetype)initWithTitle:(NSString *)titleStr FilePath:(NSString *)filePathStr;
//获取总播放时长
-(NSString*)getPlayTime;
//修改总播放时长
-(void)setPlayTime:(long)t;
//获取总播放时长格式类型
-(int)getPlayTimeType;
//获取标题
-(NSString*)getTitle;
//获取地址
-(NSURL*)getFilePath;
@end

NS_ASSUME_NONNULL_END
