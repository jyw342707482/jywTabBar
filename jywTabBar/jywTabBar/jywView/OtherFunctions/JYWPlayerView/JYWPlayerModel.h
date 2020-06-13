//
//  JYWPlayerModel.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/6/11.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//委托代理
@protocol JYWPlayerModel_Delegate <NSObject>
//播放时长格式类型更改
-(void)playTimeType_ValueChange:(NSString*)valueStr;
//播放总时长更改
-(void)playTime_ValueChange:(NSString*)valueStr;
@end
@interface JYWPlayerModel : NSObject
@property (nonatomic,readwrite) NSURL *filePath;//文件地址
@property (nonatomic,readwrite) NSString *title;//标题
@property (nonatomic,readwrite) Float64 playTime;//播放总时长

-(instancetype)initWithTitle:(NSString *)titleStr FilePath:(NSString *)filePathStr;
@property (nonatomic,weak)id<JYWPlayerModel_Delegate>delegate;//声明
//修改总播放时长
-(void)editPlayTime:(long)t;
//返回本地文件路径
-(NSURL*)getLocalURLWithFilePath:(NSString *)path;
//返回网络地址
-(NSURL*)getWebURLWithFilePath:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
