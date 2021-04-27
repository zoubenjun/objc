//
//  ZBJRuntimeExample.m
//  objc
//
//  Created by zoubenjun on 2021/4/26.
//  Copyright © 2021 zoubenjun. All rights reserved.
//

#import "ZBJRuntimeExample.h"
#import <objc/runtime.h>
#import "ZBJPerson.h"

@interface ZBJRuntimeExample()

@property(nonatomic, strong) ZBJPerson *person;
@property (nonatomic, copy) NSString *name;

@end

@implementation ZBJRuntimeExample

- (instancetype)init {
    self = [super init];
    if (self) {
        _person = [ZBJPerson new];
    }
    return self;
}

+ (void)getProperties {
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([ZBJPerson class], &count);
    for (int i = 0; i<count; i++) {
        // 取出属性
        objc_property_t property = properties[i];
        // 打印属性名字
        NSLog(@"%s %s", property_getName(property), property_getAttributes(property));
    }
    free(properties);
}

+ (void)getIvars {
    unsigned int count = 0;
    // 拷贝出所有的成员变量列表
    Ivar *ivars = class_copyIvarList([ZBJPerson class], &count);
    for (int i = 0; i<count; i++) {
        // 取出成员变量
        // Ivar ivar = *(ivars + i);
        Ivar ivar = ivars[i];
        // 打印成员变量名字
        NSLog(@"%s %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
    // 释放
    free(ivars);
}

- (void)updatePrivateIvar {
    unsigned int count = 0;
    // 动态获取类中的所有属性(包括私有)
    Ivar *ivar = class_copyIvarList(_person.class, &count);
    NSLog(@"weight:%@", [_person valueForKey:@"_weight"]);
    // 遍历属性找到对应字段
    for (int i = 0; i < count; i ++) {
        Ivar tempIvar = ivar[i];
        const char *varChar = ivar_getName(tempIvar);
        NSString *varString = [NSString stringWithUTF8String:varChar];
        if ([varString isEqualToString:@"_weight"]) {
            // 修改对应的字段值
            object_setIvar(_person, tempIvar, @55);
            break;
        }
    }
    NSLog(@"weight:%@", [_person valueForKey:@"_weight"]);
    [_person setValue:@60 forKey:@"_weight"];
    NSLog(@"weight:%@", [_person valueForKey:@"_weight"]);
}


/// 这个场景更适合分类添加属性
- (void)associatedObject {
    NSLog(@"%@",objc_getAssociatedObject(_person, @"birthday"));
    objc_setAssociatedObject(_person, @"birthday", @"2000-01-01", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSLog(@"%@",objc_getAssociatedObject(_person, @"birthday"));
}

- (void)addMethod {
    /*
     动态添加 coding 方法
     (IMP)codingOC 意思是 codingOC 的地址指针;
     "v@:" 意思是，v 代表无返回值 void，如果是 i 则代表 int；@代表 id sel; : 代表 SEL _cmd;
     “v@:@@” 意思是，两个参数的没有返回值。
     */
    class_addMethod([_person class], @selector(log), (IMP)logAll, "v@:");
    // 调用 coding 方法响应事件
    if ([_person respondsToSelector:@selector(log)]) {
        [_person performSelector:@selector(log)];
        NSLog(@"添加方法成功");
    } else {
        NSLog(@"添加方法失败");
    }
}

// 编写 codingOC 的实现
void logAll(id self,SEL _cmd) {
    [ZBJRuntimeExample getIvars];
}

- (void)logName {
//    NSLog(@"my name is :%@", _person.name);//会crash
//    NSLog(@"my name is :%@", self.name);//输出结果 my name is :xxx
    NSLog(@"my name is :%@", [self valueForKey:@"_name"]);
//    [self logSomething];//直接报错，无法编译通过
    [self performSelector:@selector(logSomething)];
}

- (void)exchangeImplementations {
    _person.name = @"xxx";
    self.name = @"123";
    Method oriMethod = class_getInstanceMethod(_person.class, @selector(logName));
    Method curMethod = class_getInstanceMethod(self.class, @selector(logName));
    method_exchangeImplementations(oriMethod, curMethod);
    [_person logName];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(hi)) {
        NSLog(@"%s", __func__);
//        class_addMethod(self, sel, (IMP)hello, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

void hello(id self, SEL _cmd) {
    NSLog(@"%s", __func__);
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    if (sel == @selector(hi)) {
        NSLog(@"%s", __func__);
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)sel {
    if (sel ==  @selector(hi)) {
        NSLog(@"%s", __func__);
        return self.person;
    }
    return [super forwardingTargetForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    NSLog(@"%s", __func__);
    SEL sel = invocation.selector;
//    Class1 *class1 = [Class1 new];
//    Class2 *class2 = [Class2 new];
//    if([class1 respondsToSelector:sel]) {
//        [invocation invokeWithTarget:class1];
//    }
//    if ([class2 respondsToSelector:sel]) {
//        [invocation invokeWithTarget:class2];
//    }
    if ([self.person respondsToSelector:sel]) {
        [invocation invokeWithTarget:self.person];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"%s", __func__);
    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    if (!methodSignature) {
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return methodSignature;
}

@end
