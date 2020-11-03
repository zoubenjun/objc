//
//  ZBJStudentViewController.m
//  objc
//
//  Created by zbj on 2020/11/3.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "ZBJStudentViewController.h"
#import "ZBJStudentPresenter.h"

@interface ZBJStudentViewController ()

@property(nonatomic, strong) ZBJStudentPresenter *presenter;

@end

@implementation ZBJStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _presenter = [[ZBJStudentPresenter alloc] initWithViewController:self];
}

@end
