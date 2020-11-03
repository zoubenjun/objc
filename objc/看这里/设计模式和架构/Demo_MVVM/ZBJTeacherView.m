//
//  ZBJTeacherView.m
//  objc
//
//  Created by zbj on 2020/11/3.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "ZBJTeacherView.h"
#import "NSObject+FBKVOController.h"

@implementation ZBJTeacherView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.frame = CGRectMake(0, 0, 100, 50);
        [self addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        UILabel *ageLabel = [[UILabel alloc] init];
        ageLabel.frame = CGRectMake(0, 50, 100, 50);
        [self addSubview:ageLabel];
        _ageLabel = ageLabel;
        
        UILabel *courseLabel = [[UILabel alloc] init];
        courseLabel.frame = CGRectMake(0, 100, 200, 50);
        [self addSubview:courseLabel];
        _courseLabel = courseLabel;
    }
    return self;
}

- (void)setViewModel:(ZBJTeacherViewModel *)viewModel {
    _viewModel = viewModel;
    
    __weak typeof (self) weakSelf = self;
    [self.KVOController observe:viewModel keyPath:@"name" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        weakSelf.nameLabel.text = [NSString stringWithFormat:@"name:%@",change[NSKeyValueChangeNewKey]];
    }];
    [self.KVOController observe:viewModel keyPath:@"age" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        weakSelf.ageLabel.text = [NSString stringWithFormat:@"age:%@",change[NSKeyValueChangeNewKey]];
    }];
    [self.KVOController observe:viewModel keyPath:@"course" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        weakSelf.courseLabel.text = [NSString stringWithFormat:@"course:%@",change[NSKeyValueChangeNewKey]];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewDidClick:)]) {
        [self.delegate viewDidClick:self];
    }
}

@end
