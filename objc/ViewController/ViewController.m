//
//  ViewController.m
//  objc
//
//  Created by zbj on 2020/10/30.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "ViewController.h"
//#import "UIControl+BlocksKit.h"
//#import "ZBJWeakTimer.h"
//#import "ZBJThread.h"

@interface ViewController ()

//@property (nonatomic, strong) NSTimer *timer;
//@property (nonatomic, strong) ZBJThread *thread;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self zbj_testWeakTimer];
//    [self zbj_testThread];
    
}

//- (void)zbj_testWeakTimer {
//    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
//    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [btn1 setTitle:@"fire" forState:UIControlStateNormal];
//    [self.view addSubview:btn1];
//
//    __weak typeof (self) weakSelf = self;
//
//    [btn1 bk_addEventHandler:^(id sender) {
//        weakSelf.timer = [ZBJWeakTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(test:) userInfo:@"111" repeats:YES];
//        NSLog(@"fire");
//    } forControlEvents:UIControlEventTouchUpInside];
//
//    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 50)];
//    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [btn2 setTitle:@"invalidate" forState:UIControlStateNormal];
//    [self.view addSubview:btn2];
//
//    [btn2 bk_addEventHandler:^(id sender) {
//        [weakSelf.timer invalidate];
//        NSLog(@"dealloc");
//    } forControlEvents:UIControlEventTouchUpInside];
//}
//
//- (void)zbj_testThread {
//    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
//    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [btn1 setTitle:@"btn" forState:UIControlStateNormal];
//    [self.view addSubview:btn1];
//
//    __weak typeof (self) weakSelf = self;
//    [btn1 bk_addEventHandler:^(id sender) {
//        NSLog(@"btn click");
//        [weakSelf.thread zbj_executeTask:^{
//            NSLog(@"do something.......");
//        }];
//    } forControlEvents:UIControlEventTouchUpInside];
//
//    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 50)];
//    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [btn2 setTitle:@"stop" forState:UIControlStateNormal];
//    [self.view addSubview:btn2];
//
//    [btn2 bk_addEventHandler:^(id sender) {
//        [weakSelf.thread zbj_stop];
//        NSLog(@"thread stop");
//    } forControlEvents:UIControlEventTouchUpInside];
//
//    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 200, 50)];
//    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [btn3 setTitle:@"run" forState:UIControlStateNormal];
//    [self.view addSubview:btn3];
//
//    [btn3 bk_addEventHandler:^(id sender) {
//        weakSelf.thread = [[ZBJThread alloc] init];
//        [weakSelf.thread zbj_run];
//        NSLog(@"thread run");
//    } forControlEvents:UIControlEventTouchUpInside];
//}
//
//- (void)test:(id)userInfo {
//    NSLog(@"test %@",userInfo);
//}
//
//- (void)dealloc {
//    [_timer invalidate];
//    [_thread zbj_stop];
//
//    NSLog(@"dealloc");
//}

@end
