//
//  ZBJTestViewController.h
//  objc
//
//  Created by zbj on 2020/11/12.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ablock)(NSString *str);

@interface ZBJTestViewController : UIViewController
@property (nonatomic, copy) ablock block;
@end

NS_ASSUME_NONNULL_END
