//
//  ZBJRuntimeExample.h
//  objc
//
//  Created by zoubenjun on 2021/4/26.
//  Copyright © 2021 zoubenjun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBJRuntimeExample : NSObject

+ (void)getIvars;
+ (void)getProperties;
- (void)updatePrivateIvar;
- (void)associatedObject;
- (void)addMethod;
- (void)exchangeImplementations;

@end

NS_ASSUME_NONNULL_END
