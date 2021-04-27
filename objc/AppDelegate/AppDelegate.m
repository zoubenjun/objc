//
//  AppDelegate.m
//  objc
//
//  Created by zbj on 2020/10/30.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "AppDelegate.h"
//#import "ZBJGCD.h"
//#import "ZBJNSOperation.h"
#import "ZBJRuntimeExample.h"
#import "ZBJThreadTest.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [ZBJGCD zbj_barrier];
//    [ZBJNSOperation zbj_addDependency];
//    [ZBJNSOperation zbj_completion];
    
//    [ZBJRuntimeExample getIvars];
//    [ZBJRuntimeExample getProperties];
//
    ZBJRuntimeExample *runtime = [ZBJRuntimeExample new];
//    [runtime updatePrivateIvar];
//    [runtime associatedObject];
//    [runtime addMethod];
//    [runtime exchangeImplementations];
    [runtime performSelector:@selector(hi)];
    
    ZBJThreadTest *thread = [ZBJThreadTest new];
    [thread test];
    
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
