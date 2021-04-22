//
//  ZBJNSOperation.m
//  objc
//
//  Created by zbj on 2020/11/1.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "ZBJNSOperation.h"

@implementation ZBJNSOperation

//NSInvocationOperation
- (void)zbj_invocation {
    
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(zbj_run) object:nil];
    // 调用start方法,在当前线程执行，因为只有线程数量大于1才会开启子线程
    [op start];
}

- (void)zbj_run {
    NSLog(@"------%@", [NSThread currentThread]);
}

//NSBlockOperation
- (void)zbj_block {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        // 这个任务是在【主线程】
        NSLog(@"下载1------%@", [NSThread currentThread]);
    }];
    
    // 添加额外的任务(在子线程执行)
    [op addExecutionBlock:^{
        NSLog(@"下载2------%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"下载3------%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"下载4------%@", [NSThread currentThread]);
    }];
    
    //因为不知一个线程，所以会开启子线程处理
    [op start];
}

//设置依赖关系
+ (void)zbj_addDependency {
    // 直接创建
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //    queue.maxConcurrentOperationCount = 1; //如果这只为1，相当于串行队列，如果大于1相当于并行队列，都是FIFO
    //    queue.suspended = !queue.suspended; //暂停后还未执行的任务将不会被执行，但是已经开始的任务会继续执行
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download1----%@", [NSThread  currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download2----%@", [NSThread  currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download3----%@", [NSThread  currentThread]);
    }];
    
    // 设置依赖后再添加到队列
    // 当op1和op2都执行完才执行op3，但是op1和op2谁先执行完不确定
    [op3 addDependency:op1];
    [op3 addDependency:op2];
    
    // 【不能】循环依赖
    //    [op3 addDependency:op1];
    //    [op1 addDependency:op3];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    
    //取消队列中的所有任务，会将队列中的任务全部移除。只能取消还未执行的任务，已经开始的任务不能取消
    //    [queue cancelAllOperations];
    
}

//completionBlock
+ (void)zbj_completion {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download----%@", [NSThread  currentThread]);
    }];
    
    // 任务执行完毕就会执行这个block
    op.completionBlock = ^{
        // 也是在子线程中执行
        NSLog(@"op执行完毕后执行---%@", [NSThread currentThread]);
    };
    
    [op start];
}

//线程间通信
- (void)zbj_queue {
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    
    [queue1 addOperationWithBlock:^{
        NSLog(@"op执行完毕后执行---%@", [NSThread currentThread]);
        [queue2 addOperationWithBlock:^{
            NSLog(@"op执行完毕后执行---%@", [NSThread currentThread]);
        }];
    }];
}

@end



@interface ZBJCustomSyncOperation : NSOperation

@end

@implementation ZBJCustomSyncOperation
/*自定义main方法执行你的任务*/
- (void)main {
    //捕获异常
    @try {
        //在这里我们要创建自己的释放池，因为这里我们拿不到主线程的释放池
        @autoreleasepool {
            BOOL isDone = NO;
            //正确的响应取消事件
            while(![self isCancelled] && !isDone)
            {
                //在这里执行自己的任务操作
                NSLog(@"执行自定义非并发NSOperation");
                NSThread *thread = [NSThread currentThread];
                NSLog(@"%@",thread);
                
                //任务执行完成后将isDone设为YES
                isDone = YES;
            }
        }
    }
    @catch (NSException *exception) {
    }
}
@end


/*
 *自定义并发的NSOperation需要以下步骤：
 1.start方法：该方法必须实现，
 2.main:该方法可选，如果你在start方法中定义了你的任务，则这个方法就可以不实现，但通常为了代码逻辑清晰，通常会在该方法中定义自己的任务
 3.isExecuting  isFinished 主要作用是在线程状态改变时，产生适当的KVO通知
 4.isConcurrent :必须覆盖并返回YES;
 */
@interface ZBJCustomAsyncOperation : NSOperation {
    BOOL _executing;
    BOOL _finished;
}

@end

@implementation ZBJCustomAsyncOperation

- (id)init {
    if (self = [super init]) {
        _executing = NO;
        _finished = NO;
    }
    return self;
}
- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return _executing;
}

- (BOOL)isFinished {
    return _finished;
}

- (void)start {
    //第一步就要检测是否被取消了，如果取消了，要实现相应的KVO
    if ([self isCancelled]) {
        [self willChangeValueForKey:@"isFinished"];
        _finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    //如果没被取消，开始执行任务
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    _executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)main {
    @try {
        @autoreleasepool {
            //在这里定义自己的并发任务
            NSLog(@"自定义并发操作NSOperation");
            
            //doSomething
            
            NSThread *thread = [NSThread currentThread];
            NSLog(@"%@",thread);
            //任务执行完成后要实现相应的KVO
            [self willChangeValueForKey:@"isFinished"];
            [self willChangeValueForKey:@"isExecuting"];
            _executing = NO;
            _finished = YES;
            [self didChangeValueForKey:@"isExecuting"];
            [self didChangeValueForKey:@"isFinished"];
        }
    }
    @catch (NSException *exception) {
    }
}


@end
