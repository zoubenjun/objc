//
//  ZBJTestViewController.m
//  objc
//
//  Created by zbj on 2020/11/12.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "ZBJTestViewController.h"

@interface ZBJTestViewController ()

@end

@implementation ZBJTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //    [self zbj_frame];
    [self zbj_bounds];
}

- (void)zbj_frame {
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
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
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
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
