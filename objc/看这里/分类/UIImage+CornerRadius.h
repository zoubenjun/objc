//
//  UIImage+CornerRadius.h
//  objc
//
//  Created by zoubenjun on 2020/12/1.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CornerRadius)

/// 对图片添加圆角
/// @param radius 这里是UIImage的圆角，如果UIImage大小和UIImageView大小不一致。请根据比列修改，UIImage大小200*200，UIImageView大小50*50，需要设置的圆角为8，那么这里需要设置为8*200/50, 即32
- (UIImage *)zbj_imageWithCornerRadius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
