//
//  AppDelegate.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/5/26.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "AppDelegate.h"
#import "JYW_TabBarViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (iOS13) {
    
    }
    else
    {
        self.window=[[UIWindow alloc] initWithFrame:[UIScreen alloc].bounds];
        self.window.rootViewController=[[JYW_TabBarViewController alloc] init];
        [self.window makeKeyWindow];
    }
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
