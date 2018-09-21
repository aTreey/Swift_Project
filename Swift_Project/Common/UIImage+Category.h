//
//  UIImage+Category.h
//  Swift_Project
//
//  Created by HongpengYu on 2018/5/25.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
+ (UIImage *)imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock;

@end
