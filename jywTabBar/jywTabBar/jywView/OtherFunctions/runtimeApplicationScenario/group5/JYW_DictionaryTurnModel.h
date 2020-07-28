//
//  JYW_DictionaryTurnModel.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/22.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <Foundation/Foundation.h>
//转载：https://www.jianshu.com/p/f6c8914014a3
NS_ASSUME_NONNULL_BEGIN

@interface JYW_DictionaryTurnModel : NSObject
@property (nonatomic,assign)int dtmId;
@property (nonatomic,copy) NSString *dtmName;
@property (nonatomic,copy) NSString *dtmRemark;
@end

@interface JYW_DictionaryTurnModel1 : NSObject
@property (nonatomic,assign)int dtmId;
@property (nonatomic,copy) NSString *dtmName;
@property (nonatomic,copy) NSString *dtmRemark;
@property (nonatomic,strong) NSArray *dtmArray;
@end

@interface JYW_DictionaryTurnModel2 : NSObject
@property (nonatomic,assign)int dtmId;
@property (nonatomic,copy) NSString *dtmName;
@property (nonatomic,copy) NSString *dtmRemark;
@property (nonatomic,strong) NSDictionary *dtmDictionary;
@end
NS_ASSUME_NONNULL_END
