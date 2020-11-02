//
//  ZBJNSOperation.h
//  objc
//
//  Created by zbj on 2020/11/1.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBJNSOperation : NSObject

+ (void)zbj_addDependency;
+ (void)zbj_completion;

@end

NS_ASSUME_NONNULL_END
