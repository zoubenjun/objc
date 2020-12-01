//
//  ZBJTestViewController.m
//  objc
//
//  Created by zbj on 2020/11/12.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "ZBJTestViewController.h"
#import "UIControl+BlocksKit.h"
#import "ZBJPersonViewController.h"

@interface ZBJTestViewController ()

@end

@implementation ZBJTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //    [self zbj_frame];
//    [self zbj_bounds];
    [self zbj_back];
    [self zbj_mvc];
    
    NSLog(@"viewDidLoad");

}


- (void)loadView {
    [super loadView];
    
    NSLog(@"loadView");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"viewDidDisappear");
}

- (void)dealloc {
    
    NSLog(@"dealloc");
}

- (void)zbj_back {
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 50)];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"back" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    __weak typeof (self) weakSelf = self;
    
    [btn1 bk_addEventHandler:^(id sender) {
        __strong typeof (weakSelf) strongSelf = weakSelf;

        if (strongSelf.block) {
            strongSelf.block(@"123");
            strongSelf.block(@"123456");
            strongSelf.block(@"123456789");
        }
        
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)zbj_mvc {
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"mvc" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    __weak typeof (self) weakSelf = self;
    
    [btn1 bk_addEventHandler:^(id sender) {
        ZBJPersonViewController *vc = [[ZBJPersonViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [weakSelf presentViewController:vc animated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)zbj_frame {
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    greenView.backgroundColor = [UIColor greenColor];
    [redView addSubview:greenView];
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(25, 25, 50, 50)];
    blueView.backgroundColor = [UIColor blueColor];
    [greenView addSubview:blueView];    
}

- (void)zbj_bounds {
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    redView.bounds = CGRectMake(0, 0, 300, 300);
    
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    greenView.backgroundColor = [UIColor greenColor];
    [redView addSubview:greenView];
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(25, 25, 50, 50)];
    blueView.backgroundColor = [UIColor blueColor];
    [greenView addSubview:blueView];
}

@end
