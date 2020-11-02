//
//  ZBJThread.h
//  objc
//
//  Created by zbj on 2020/11/2.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBJThread : NSObject

//开始运行
- (void)zbj_run;

//执行任务
- (void)zbj_executeTask:(void(^)(void))task;

//停止
- (void)zbj_stop;

@end

NS_ASSUME_NONNULL_END
