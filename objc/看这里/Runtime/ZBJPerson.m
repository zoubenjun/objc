//
//  ZBJPerson.m
//  objc
//
//  Created by zoubenjun on 2021/4/26.
//  Copyright © 2021 zoubenjun. All rights reserved.
//

#import "ZBJPerson.h"

@interface ZBJPerson()

@property(nonatomic, strong) NSNumber *weight;

@end

@implementation ZBJPerson

- (void)logName {
    NSLog(@"name:%@",_name);
}

- (void)logSomething {
    NSLog(@"something");
}

- (void)hi {
    NSLog(@"hi");
}

@end
