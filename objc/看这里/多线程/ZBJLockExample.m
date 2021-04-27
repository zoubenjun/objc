//
//  ZBJLockExample.m
//  objc
//
//  Created by zoubenjun on 2021/4/27.
//  Copyright © 2021 zoubenjun. All rights reserved.
//

#import "ZBJLockExample.h"
#import <libkern/OSAtomic.h>
#import <os/lock.h>
#import <pthread.h>

@implementation ZBJLockExample

//OSSpinLock在10.0以后使用os_unfair_lock代替
- (void)OSSpinLock {
    //需要#import <libkern/OSAtomic.h>
    OSSpinLock lock = OS_SPINLOCK_INIT;
    OSSpinLockLock(&lock);
    NSLog(@"%s",__func__);
    OSSpinLockUnlock(&lock);
}

- (void)os_unfair_lock {
    //#import <os/lock.h>
    os_unfair_lock lock = OS_UNFAIR_LOCK_INIT;
    os_unfair_lock_lock(&lock);
    NSLog(@"%s",__func__);
    os_unfair_lock_unlock(&lock);
}

- (void)pthread_mutex {
    //需要#import <pthread.h>
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
//    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);//递归锁
    pthread_mutex_t lock;
    // 初始化锁
    pthread_mutex_init(&lock, &attr);
    // 销毁属性
    pthread_mutexattr_destroy(&attr);
    pthread_mutex_lock(&lock);
    NSLog(@"%s",__func__);
    pthread_mutex_unlock(&lock);
}

- (void)NSLock {
    NSLock *lock = [[NSLock alloc] init];
    [lock lock];
    NSLog(@"%s",__func__);
    [lock unlock];
}

- (void)NSRecursiveLock {
    NSRecursiveLock *lock = [[NSRecursiveLock alloc] init];
    [lock lock];
    NSLog(@"%s",__func__);
    [lock unlock];
}

- (void)NSConditionLock {
    NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:1];
    [lock lock];
    NSLog(@"%s",__func__);
    [lock unlockWithCondition:2];
    [lock lockWhenCondition:2];
    NSLog(@"%s",__func__);
    [lock unlockWithCondition:2];
}

- (void)dispatch_semaphore_t {
    dispatch_semaphore_t lock = dispatch_semaphore_create(0);
    NSLog(@"%s",__func__);
    dispatch_semaphore_signal(lock);
    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
}

- (void)synchronized {
    @synchronized ([self class]) {
        NSLog(@"%s",__func__);
    }
}

- (void)atomic {
}

- (void)pthread_rwlock {
    //需要#import <pthread.h>
    //初始化锁
    pthread_rwlock_t lock;
    pthread_rwlock_init(&lock, NULL);

    //读加锁
    pthread_rwlock_rdlock(&lock);
    //读尝试加锁
    pthread_rwlock_trywrlock(&lock);

    //写加锁
    pthread_rwlock_wrlock(&lock);
    //写尝试加锁
    pthread_rwlock_trywrlock(&lock);

    //解锁
    pthread_rwlock_unlock(&lock);
    //销毁
    pthread_rwlock_destroy(&lock);
}

@end
