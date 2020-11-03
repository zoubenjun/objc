//
//  ZBJStudentPresenter.m
//  objc
//
//  Created by zbj on 2020/11/3.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "ZBJStudentPresenter.h"
#import "ZBJStudentModel.h"
#import "ZBJStudentView.h"

@interface ZBJStudentPresenter()<ZBJStudentViewDelegate>

@property(nonatomic, weak) UIViewController *viewController;
@property(nonatomic, strong) ZBJStudentView *studentView;
@property(nonatomic, strong) ZBJStudentModel *studentModel;

@end

@implementation ZBJStudentPresenter

- (instancetype)initWithViewController:(UIViewController *)viewController {
    if (self = [super init]) {
        
        self.viewController = viewController;
        [self zbj_loadModel];
        [self zbj_loadView];
        
        self.studentView.nameLabel.text = [NSString stringWithFormat:@"name:%@",self.studentModel.name];
        self.studentView.ageLabel.text = [NSString stringWithFormat:@"age:%d",self.studentModel.age];
        self.studentView.noLabel.text = [NSString stringWithFormat:@"no:%d",self.studentModel.no];

    }
    return self;
}

- (void)zbj_loadModel {
    _studentModel = [[ZBJStudentModel alloc] init];
    _studentModel.name = @"zbj";
    _studentModel.age = 20;
    _studentModel.no = 1;
}

- (void)zbj_loadView {
    _studentView = [[ZBJStudentView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    _studentView.delegate = self;
    [self.viewController.view addSubview:_studentView];
}

#pragma mark ————— ZBJPersonViewDelegate —————
- (void)viewDidClick:(ZBJStudentView *)studentView {
    NSLog(@"view did clicked");
    self.studentModel.age += 1;
    self.studentView.ageLabel.text = [NSString stringWithFormat:@"age:%d",self.studentModel.age];
}

@end
