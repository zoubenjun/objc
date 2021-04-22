//
//  ZBJTeacherViewController.m
//  objc
//
//  Created by zbj on 2020/11/3.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "ZBJTeacherViewController.h"
#import "ZBJTeacherViewModel.h"
#import "ZBJTeacherView.h"

@interface ZBJTeacherViewController ()

@property(nonatomic, strong) ZBJTeacherViewModel *teacherViewModel;
@property(nonatomic, strong) ZBJTeacherView *teacherView;

@end

@implementation ZBJTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self zbj_loadView];
    
    _teacherViewModel = [[ZBJTeacherViewModel alloc] init];
}

- (void)zbj_loadView {
    self.teacherView = [[ZBJTeacherView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.teacherView.delegate = self;
    self.teacherView.viewModel = self;
    [self.view addSubview:self.teacherView];
}

@end
