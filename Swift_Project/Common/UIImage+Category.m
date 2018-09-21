//
//  UIImage+Category.m
//  Swift_Project
//
//  Created by HongpengYu on 2018/5/25.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)

+ (UIImage *)imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock {
    if (!drawBlock) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    drawBlock(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
