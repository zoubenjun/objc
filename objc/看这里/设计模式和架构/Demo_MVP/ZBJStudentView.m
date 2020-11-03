//
//  ZBJStudentView.m
//  objc
//
//  Created by zbj on 2020/11/3.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "ZBJStudentView.h"

@implementation ZBJStudentView

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
        
        UILabel *noLabel = [[UILabel alloc] init];
        noLabel.frame = CGRectMake(0, 100, 100, 50);
        [self addSubview:noLabel];
        _noLabel = noLabel;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewDidClick:)]) {
        [self.delegate viewDidClick:self];
    }
}

@end
