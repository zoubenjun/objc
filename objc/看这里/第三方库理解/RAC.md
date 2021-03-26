#  ReactiveCocoa

## RACStream

## RACSignal

### 使用
```
RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
    [subscriber sendNext:@"..."];
    [subscriber sendNext:@"~~~"];
    [subscriber sendCompleted];
    [subscriber sendNext:@"???"];//sendCompleted后面的sendNext不执行
    return [RACDisposable disposableWithBlock:^{
        NSLog(@"signal dispose");
    }];
}];
[signal subscribeNext:^(id  _Nullable x) {
    NSLog(@"%@",x);
}];

...
...
RACSignal *concatSignal = [signal1 concat:signal2];//返回一个新信号，收到signal1完后signal2 sendNext发送的值
[concatSignal subscribeNext:^(id x) {
    NSLog(@"value = %@", x);
}];

RACSignal *zipSignal = [signal1 zipWith:signal2];//返回一个新信号，收到signal1和signal2的sendNext值的元组，如signal1发送1，2。signal2发送2，3，4，那么subscribeNext只会收到（1，2）和（2，3）signal2的4会被丢弃。
[zipSignal subscribeNext:^(id x) {
    NSLog(@"value = %@", x);
}];
```

## RACSubject


## RACCommand
> 管理 RACSignal 的创建与订阅的类。
> 可以多次订阅，都会收到消息。
### 初始化
```
- (id)initWithSignalBlock:(RACSignal * (^)(id input))signalBlock;
- (id)initWithEnabled:(RACSignal *)enabledSignal signalBlock:(RACSignal * (^)(id input))signalBlock;
eg:
- (RACCommand *)command {
    if (!_command) {
        _command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                if (input) {
                    [subscriber sendNext:@"..."];
                } else {
                    [subscriber sendNext:@"???"];
                }
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _command;
}
```
### 订阅
```
[self.command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
    NSLog(@"%@", x);
}];
```

### 执行
```
[self.command execute:nil];
[self.command execute:@1];//不会打印...,会返回错误信号 RACErrorSignal，默认不支持并发执行
[RACScheduler.mainThreadScheduler afterDelay:0.1
                                    schedule:^{
                                        [self.command execute:nil];
                                    }];
```

## RACTuple



