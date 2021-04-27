//
//  ZBJThreadTest.m
//  objc
//
//  Created by zoubenjun on 2021/4/26.
//  Copyright © 2021 zoubenjun. All rights reserved.
//

#import "ZBJThreadTest.h"
#import <pthread.h>

@interface ZBJThreadTest()

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSLock *lock;

@end

@implementation ZBJThreadTest

@synthesize count = _count;

- (instancetype)init {
    if (self = [super init]) {
        self.count = 0;
        _lock = [[NSLock alloc] init];
    }
    return self;
}

- (void)test {
    dispatch_queue_t queue1 = dispatch_queue_create("zbj.concurrentQueue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("zbj.concurrentQueue2", DISPATCH_QUEUE_CONCURRENT);

    for (int i = 0; i < 10000; i ++) {
        dispatch_async(queue1, ^{
//            [self changeValue:1];
            [self add];
        });
    }
    for (int i = 0; i < 10000; i ++) {
        dispatch_async(queue2, ^{
//            [self changeValue:-1];
            [self des];
        });
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"count == %ld",self.count);
    });
}

//- (void)changeValue:(int)value {
//    [_lock lock];
//    self.count = self.count + value;
//    NSLog(@"%ld", self.count);
//    [_lock unlock];
//}

- (void)add {
    [_lock lock];
    self.count++;
    [_lock unlock];
}
- (void)des {
    [_lock lock];
    self.count--;
    [_lock unlock];
}

@end
