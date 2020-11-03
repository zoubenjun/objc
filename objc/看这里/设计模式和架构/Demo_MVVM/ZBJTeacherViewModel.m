//
//  ZBJTeacherViewModel.m
//  objc
//
//  Created by zbj on 2020/11/3.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "ZBJTeacherViewModel.h"

#import "ZBJTeacherModel.h"
#import "ZBJTeacherView.h"

@interface ZBJTeacherViewModel()<ZBJTeacherViewDelegate>

@property(nonatomic, weak) UIViewController *viewController;
@property(nonatomic, strong) ZBJTeacherView *teacherView;
@property(nonatomic, strong) ZBJTeacherModel *teacherModel;

@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) int age;
@property(nonatomic, copy) NSString *course;

@end

@implementation ZBJTeacherViewModel

- (instancetype)initWithViewController:(UIViewController *)viewController {
    if (self = [super init]) {
        
        self.viewController = viewController;
        
        [self zbj_loadView];
        [self zbj_loadModel];

    }
    return self;
}

- (void)zbj_loadModel {
    _teacherModel = [[ZBJTeacherModel alloc] init];
    _teacherModel.name = @"zbj";
    _teacherModel.age = 20;
    _teacherModel.course = @"English";
    
    self.name = _teacherModel.name;
    self.age = _teacherModel.age;
    self.course = _teacherModel.course;
}

- (void)zbj_loadView {
    self.teacherView = [[ZBJTeacherView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.teacherView.delegate = self;
    self.teacherView.viewModel = self;
    [self.viewController.view addSubview:self.teacherView];
}

#pragma mark ————— ZBJPersonViewDelegate —————
- (void)viewDidClick:(ZBJTeacherView *)teacherView {
    NSLog(@"view did clicked");
    self.teacherModel.age += 1;
    self.age = self.teacherModel.age;
}

@end
