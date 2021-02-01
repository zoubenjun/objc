//
//  ZBJWeakTimer.m
//  objc
//
//  Created by zbj on 2020/11/2.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "ZBJWeakTimer.h"

@interface ZBJWeakTimerTarget : NSObject

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer* timer;

@end

@implementation ZBJWeakTimerTarget

- (void)fire:(NSTimer *)timer {
    if (self.target) {
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:timer.userInfo afterDelay:0.0f];
//#pragma clang diagnostic pop
    } else {
        [self.timer invalidate];
    }
}

@end

@implementation ZBJWeakTimer

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                     target:(id)aTarget
                                   selector:(SEL)aSelector
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats {
    ZBJWeakTimerTarget* timerTarget = [[ZBJWeakTimerTarget alloc] init];
    timerTarget.target = aTarget;
    timerTarget.selector = aSelector;
//    timerTarget.timer = [NSTimer scheduledTimerWithTimeInterval:interval
//                                                         target:timerTarget
//                                                       selector:@selector(fire:)
//                                                       userInfo:userInfo
//                                                        repeats:repeats];
    
    //加入到NSRunLoopCommonModes，在view滑动的时候还会继续，而上面的方式创建的timer在滑动是会暂停运行
    timerTarget.timer = [NSTimer timerWithTimeInterval:interval target:timerTarget selector:@selector(fire:) userInfo:userInfo repeats:repeats];
    [[NSRunLoop currentRunLoop] addTimer:timerTarget.timer forMode:NSRunLoopCommonModes];
    
    return timerTarget.timer;
}

@end
