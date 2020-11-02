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

@interface ViewController ()

@property (nonatomic, weak) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
//    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [btn1 setTitle:@"fire" forState:UIControlStateNormal];
//    [self.view addSubview:btn1];
//
//    [btn1 bk_addEventHandler:^(id sender) {
//        self->_timer = [ZBJWeakTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(test:) userInfo:@"111" repeats:YES];
//        NSLog(@"fire");
//    } forControlEvents:UIControlEventTouchUpInside];
//
//    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 50)];
//    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [btn2 setTitle:@"invalidate" forState:UIControlStateNormal];
//    [self.view addSubview:btn2];
//
//    [btn2 bk_addEventHandler:^(id sender) {
//        [self->_timer invalidate];
//        NSLog(@"dealloc");
//    } forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)test:(id)userInfo {
    NSLog(@"test %@",userInfo);
}

- (void)dealloc {
    [_timer invalidate];
    NSLog(@"dealloc");
}
@end
