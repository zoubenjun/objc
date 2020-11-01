//
//  ZBJGCD.m
//  objc
//
//  Created by zbj on 2020/11/1.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "ZBJGCD.h"

@implementation ZBJGCD

- (void)initGCDQueue {
    //串行队列
    dispatch_queue_t serialQueue;
    serialQueue = dispatch_queue_create("zbj.serialQueue", DISPATCH_QUEUE_SERIAL);
    
    //并发队列
    dispatch_queue_t concurrentQueue;
    concurrentQueue = dispatch_queue_create("zbj.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    //主队列，串行队列
    dispatch_queue_t mainQueue;
    mainQueue = dispatch_get_main_queue();
    
    //默认全局global queue,并行队列
    dispatch_queue_t globalQueue;
    globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);//dispatch_get_global_queue(0, 0);
}

//同步异步
- (void)zbj_sync {
    dispatch_queue_t myCustomQueue;
    myCustomQueue = dispatch_queue_create("zbj.serialQueue", DISPATCH_QUEUE_SERIAL);
    //异步执行
    dispatch_async(myCustomQueue, ^{
        NSLog(@"Do some work here.");
    });
    
    //同步执行
    dispatch_sync(myCustomQueue, ^{
        NSLog(@"Do some more work here.");
    });
    
    //挂起队列
    dispatch_suspend(myCustomQueue);
    
    //恢复队列
    dispatch_resume(myCustomQueue);
}

//信号量
- (void)zbj_semaphore {
    dispatch_queue_t myCustomQueue;
    myCustomQueue = dispatch_queue_create("zbj.serialQueue", DISPATCH_QUEUE_SERIAL);
    
    // 创建一个信号量
    dispatch_semaphore_t fd_sema = dispatch_semaphore_create(0);
    
    //异步执行
    dispatch_async(myCustomQueue, ^{
        NSLog(@"Do some work here.");
        dispatch_semaphore_signal(fd_sema);
    });
    
    // 等待一个空闲的文件描述符
    dispatch_semaphore_wait(fd_sema, DISPATCH_TIME_FOREVER);
}

//dispatch_group_t
- (void)zbj_group {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    // 添加队列到组中
    dispatch_group_async(group, queue, ^{
        // 一些异步操作
    });
    
    //如果在所有任务完成前超时了，该函数会返回一个非零值。
    //你可以对此返回值做条件判断以确定是否超出等待周期；
    //阻塞当前线程，直到组里面所有的任务都完成或者超时。
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    //异步,不阻塞当前线程
    dispatch_group_notify(group, queue, ^{
        
    });
}

//死锁，一个线程同步block再调用同步就会死锁
- (void)zbj_lock {
    dispatch_queue_t queue = dispatch_queue_create("zbj.serialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"1-----%@", [NSThread currentThread]);
        // 这里阻塞了
        dispatch_sync(queue, ^{
            NSLog(@"2-----%@", [NSThread currentThread]);
        });
    });
}

//单列
- (void)zbj_once {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 只执行1次的代码(这个函数本身是【线程安全】的)
    });
}

//延时
- (void)zbj_after {
    dispatch_queue_t queue = dispatch_queue_create("zbj.serialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC));
    
    //延迟将任务提交到队列中，不是延迟执行任务
    dispatch_after(time, queue, ^{
        // 此任务被延迟提交到队列中
    });
}

//重复执行
- (void)zbj_apply {
    dispatch_apply(10, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        // 执行10次代码，会开启多条线程来执行任务，执行顺序不确定
    });
}

//栅栏
- (void)zbj_barrier {
    //【不能】使用全局并发队列
    dispatch_queue_t queue = dispatch_queue_create("zbj.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"----1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----2-----%@", [NSThread currentThread]);
    });
    
    // 在它前面的任务执行结束后它才执行，在它后面的任务等它执行完成后才会执行
    dispatch_barrier_async(queue, ^{
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"----3-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----4-----%@", [NSThread currentThread]);
    });
}
@end
