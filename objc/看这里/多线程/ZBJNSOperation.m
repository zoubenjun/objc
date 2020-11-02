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
    
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    // 调用start方法,在当前线程执行，因为只有线程数量大于1才会开启子线程
    [op start];
}

- (void)run {
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
