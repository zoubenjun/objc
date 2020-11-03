//
//  ZBJTeacherViewController.m
//  objc
//
//  Created by zbj on 2020/11/3.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "ZBJTeacherViewController.h"
#import "ZBJTeacherViewModel.h"

@interface ZBJTeacherViewController ()

@property(nonatomic, strong) ZBJTeacherViewModel *teacherViewModel;

@end

@implementation ZBJTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _teacherViewModel = [[ZBJTeacherViewModel alloc] initWithViewController:self];

}

@end
