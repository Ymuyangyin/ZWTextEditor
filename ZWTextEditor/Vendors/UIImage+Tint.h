//
//  UIImage+Tint.h
//  SGAY_iOS
//
//  Created by 杨杨鹏 on 2018/7/17.
//  Copyright © 2018年 杨杨鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tint)
/**
 适用 --- 无渐变的纯色图的图   保留了原色的透明度，丢失所有的灰度信息
 */

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;

/**
  适用 --- 所有    保留颜色和周围的光和透明度
 */

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

/**
 压缩图片
 */

- (NSData *)compressWithMaxLength:(NSUInteger)maxLength;

+ (UIImage *)fixOrientation:(UIImage *)aImage;

+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;


/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param size 图片
 *  @param radius 圆角
 *  @return 生成的图片
 */
+ (UIImage *) GetImageWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius;

/**
 旋转图片
 OS UIImage 图像旋转
 vImg：待旋转的图
 vAngle：旋转角度
 vIsExpand：是否扩展，如果不扩展，那么图像大小不变，但被截掉一部分
 */

+ (UIImage *)rotateImageWithAngle:(UIImage*)vImg Angle:(CGFloat)vAngle IsExpand:(BOOL)vIsExpand;

/**
 压缩图片
 
 YES --  800   NO -- 1280
 
 */

- (UIImage *)compressImageSession:(BOOL)compress;

/**
 绘制图片
 
 @param color 背景色
 @param size 大小
 @param text 文字
 @param textAttributes 字体设置
 @param isCircular 是否圆形
 @return 图片
 */
+ (UIImage *)yp_imageWithColor:(UIColor *)color
                          size:(CGSize)size
                          text:(NSString *)text
                textAttributes:(NSDictionary *)textAttributes
                      circular:(BOOL)isCircular;

+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;

@end
