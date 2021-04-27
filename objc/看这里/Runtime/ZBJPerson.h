//
//  ZBJPerson.h
//  objc
//
//  Created by zoubenjun on 2021/4/26.
//  Copyright © 2021 zoubenjun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBJPerson : NSObject

@property (nonatomic, copy) NSString *name;

- (void)logName;
- (void)logSomething;

@end

NS_ASSUME_NONNULL_END
