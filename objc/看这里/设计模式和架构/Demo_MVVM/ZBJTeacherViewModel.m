//
//  ZBJTeacherViewModel.m
//  objc
//
//  Created by zbj on 2020/11/3.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "ZBJTeacherViewModel.h"
#import "ZBJTeacherView.h"
#import "ZBJTeacherModel.h"

@interface ZBJTeacherViewModel()<ZBJTeacherViewDelegate>

@property(nonatomic, strong) ZBJTeacherModel *teacherModel;

@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) int age;
@property(nonatomic, copy) NSString *course;

@end

@implementation ZBJTeacherViewModel

- (instancetype)init {
    if (self = [super init]) {
                
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

#pragma mark ————— ZBJPersonViewDelegate —————
- (void)viewDidClick:(ZBJTeacherView *)teacherView {
    NSLog(@"view did clicked");
    self.teacherModel.age += 1;
    self.age = self.teacherModel.age;
}

@end
