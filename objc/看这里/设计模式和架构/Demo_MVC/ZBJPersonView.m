//
//  ZBJPersonView.m
//  objc
//
//  Created by zbj on 2020/11/3.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "ZBJPersonView.h"

@implementation ZBJPersonView

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
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewDidClick:)]) {
        [self.delegate viewDidClick:self];
    }
}

@end
