//
//  ZBJThread.m
//  objc
//
//  Created by zbj on 2020/11/2.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "ZBJThread.h"

@interface ZBJThread()

@property (strong, nonatomic) NSThread *thread;
@property (assign, nonatomic, getter=isStopped) BOOL stopped;

@end

@implementation ZBJThread

- (instancetype)init {
    if (self = [super init]) {
        
        self.stopped = NO;
        
        __weak typeof(self) weakSelf = self;
        
        self.thread = [[NSThread alloc] initWithBlock:^{
            
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
            
            while (weakSelf && !weakSelf.isStopped) {

                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
        }];
        
        // 默认自动开启线程
        //        [self.thread start];
    }
    
    return self;
}

//开始运行
- (void)zbj_run {
    if (!self.thread) return;
    if (self.thread.isExecuting) return;
    self.stopped = NO;
    [self.thread start];
}

//执行任务
- (void)zbj_executeTask:(void(^)(void))task {
    if (!self.thread || !task) return;
    
    [self performSelector:@selector(p_zbj_executeTask:) onThread:self.thread withObject:task waitUntilDone:NO];
}

//停止
- (void)zbj_stop {
    if (!self.thread) return;
    
    [self performSelector:@selector(p_zbj_stop) onThread:self.thread withObject:nil waitUntilDone:YES];
}

- (void)dealloc {
    [self zbj_stop];
}


- (void)p_zbj_stop {
    self.stopped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.thread = nil;
}

- (void)p_zbj_executeTask:(void(^)(void))task {
    task();
}

@end
