//
//  ZBJImageUtils.h
//  objc
//
//  Created by zbj on 2020/10/30.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBJImageUtils : NSObject

/**
 子线程解码绘制图片，主线程直接显示
 */
+ (void)showImage:(UIImage *)image inView:(UIImageView *)imageView;
@end

NS_ASSUME_NONNULL_END
