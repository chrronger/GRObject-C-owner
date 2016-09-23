//
//  UIImage+Extension.h
//  GRObject-C-owner
//
//  Created by sen on 2016/9/23.
//  Copyright © 2016年 sen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/** 压缩 */
- (UIImage *)gr_scaleToSize:(CGSize)size;

/** 等比例压缩 */
- (UIImage *)gr_imageCompressForSize:(CGSize)size;

/**
 *  返回指定尺寸的图片
 */
- (UIImage *)gr_imageWithScaleSize:(CGSize)scaleSize;

/**
 *  返回拉伸后的图片,默认为从中点拉伸
 */
+ (UIImage *)gr_resizeImageWithName:(NSString *)imageName;

/**
 *  返回拉伸后的图片,指定拉伸位置
 */
+ (UIImage *)gr_resizeImageWithName:(NSString *)imageName edgeInsets:(UIEdgeInsets)edgeInset;

/**
 *  将方图片转换成圆图片
 */
+ (UIImage *)gr_circleImageWithOldImage:(UIImage *)oldImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (UIImage *)gr_generateCenterImageWithBgColor:(UIColor *)bgImageColor bgImageSize:(CGSize)bgImageSize centerImage:(UIImage *)centerImage;

+ (UIImage *)imageWithName:(NSString *)name;

+ (UIImage *)resizedImage:(NSString *)name;

+ (UIImage *)resizedImage:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

/* 裁剪圆形图片 */
+ (UIImage *)clipImage:(UIImage *)image;


@end
