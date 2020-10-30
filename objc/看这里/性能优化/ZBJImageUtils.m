//
//  ZBJImageUtils.m
//  objc
//
//  Created by zbj on 2020/10/30.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import "ZBJImageUtils.h"

@implementation ZBJImageUtils
+ (void)showImage:(UIImage *)image inView:(UIImageView *)imageView {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CGImageRef cgImage = [image CGImage];
        
        CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(cgImage) & kCGBitmapAlphaInfoMask;
        BOOL hasAlpha = NO;
        if (alphaInfo == kCGImageAlphaPremultipliedLast ||
            alphaInfo == kCGImageAlphaPremultipliedFirst ||
            alphaInfo == kCGImageAlphaLast ||
            alphaInfo == kCGImageAlphaFirst ) {
            hasAlpha = YES;
        }
        CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Host;
        bitmapInfo |= hasAlpha ? kCGImageAlphaPremultipliedFirst : kCGImageAlphaNoneSkipFirst;
        
        size_t width = CGImageGetWidth(cgImage);
        size_t height = CGImageGetHeight(cgImage);

        CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, CGColorSpaceCreateDeviceRGB(), bitmapInfo);
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), cgImage);
        cgImage = CGBitmapContextCreateImage(context);
        
        UIImage *img = [UIImage imageWithCGImage:cgImage];
        
        CGContextRelease(context);
        CGImageRelease(cgImage);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = img;
        });
    });
}
@end
