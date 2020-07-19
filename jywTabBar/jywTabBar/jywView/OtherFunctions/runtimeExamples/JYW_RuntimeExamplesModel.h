//
//  JYW_RuntimeExamplesModel.h
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/15.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JYW_RuntimeExamplesModel_delegate <NSObject>
-(void)checkOK;
@end
@interface JYW_RuntimeExamplesModel : NSObject
@property NSString *value1;
@property NSString *value2;
+(void)alertMessage:(NSString *)message;
-(void)alertMessage1:(NSString *)message;
@property(weak)id<JYW_RuntimeExamplesModel_delegate> delegate;
@end

NS_ASSUME_NONNULL_END
