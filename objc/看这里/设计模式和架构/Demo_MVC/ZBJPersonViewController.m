//
//  ZBJPersonViewController.m
//  objc
//
//  Created by zbj on 2020/11/3.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "ZBJPersonViewController.h"
#import "ZBJPersonModel.h"
#import "ZBJPersonView.h"
#import "UIControl+BlocksKit.h"

@interface ZBJPersonViewController ()<ZBJPersonViewDelegate>
@property(nonatomic, strong) ZBJPersonView *personView;
@property(nonatomic, strong) ZBJPersonModel *personModel;
@end

@implementation ZBJPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self zbj_loadView];
    [self zbj_loadModel];
    
    self.personView.nameLabel.text = [NSString stringWithFormat:@"name:%@",self.personModel.name];
    self.personView.ageLabel.text = [NSString stringWithFormat:@"age:%d",self.personModel.age];
    
    [self zbj_back];
}

- (void)dealloc {
    
    NSLog(@"ZBJPersonViewController dealloc");
}

- (void)zbj_back {
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 200, 50)];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"back" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    __weak typeof (self) weakSelf = self;
    
    [btn1 bk_addEventHandler:^(id sender) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)zbj_loadModel {
    _personModel = [[ZBJPersonModel alloc] init];
    _personModel.name = @"zbj";
    _personModel.age = 20;
}

- (void)zbj_loadView {
    _personView = [[ZBJPersonView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    _personView.delegate = self;
    [self.view addSubview:_personView];
}

#pragma mark ————— ZBJPersonViewDelegate —————
- (void)viewDidClick:(ZBJPersonView *)personView {
    NSLog(@"view did clicked");
    self.personModel.age += 1;
    self.personView.ageLabel.text = [NSString stringWithFormat:@"age:%d",self.personModel.age];
}

@end
