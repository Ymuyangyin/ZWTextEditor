//
//  UIButton+ImageAndTitle.h
//  SGAY_iOS
//
//  Created by 杨杨鹏 on 2018/6/15.
//  Copyright © 2018年 杨杨鹏. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIButton (ImageAndTitle)

- (void)setImageWithThumbFileId:(NSString *)thumbFileId placeholderImage:(UIImage *)image;

- (void)setImageWithThumbFileId:(NSString *)thumbFileId placeholderImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius;


/**
 *  缩放图片（主要是针对大图显示不完全，就先缩放）
 *  times : 倍数
 */
- (void)zoomImage:(CGFloat)times;

/**
 *  图片、文字居中
 *
 */
- (void)setImageAndTitleCenter;

/**
 *  上下居中，图片在上，文字在下
 *  space : 图文间距
 */
- (void)setImageUp:(CGFloat)space;
//- (void)setImageUp2:(CGFloat)space;

/**
 *  上下居中，图片在上，文字在下
 *  默认间距为 6.0
 */
- (void)setImageUp;

/**
 *  上下居中，图片在下，文字在上
 *  space : 图文间距
 */
- (void)setImageDown:(CGFloat)space;

/**
 *  上下居中，图片在下，文字在上
 *  默认间距为 6.0
 */
- (void)setImageDown;

/**
 *  左右居中，图片在左，文字在右
 *  space : 图文间距
 */
- (void)setImageLeft:(CGFloat)space;

/**
 *  左右居中，图片在左，文字在右
 *  space : 图文间距
 */
- (void)setImageLeft:(CGFloat)space imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets;

/**
 *  左右居中，图片在左，文字在右
 *  默认间距为 6.0
 */
- (void)setImageLeft;

/**
 *  上下居中，图片在右，文字在左
 *  space : 图文间距
 */
- (void)setImageRight:(CGFloat)space;

/**
 *  上下居中，图片在右，文字在左
 *  space : 图文间距
 *  imageSize : 图片大小
 */
- (void)setImageRight:(CGFloat)space imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets;

/**
 *  上下居中，图片在右，文字在左
 *  默认间距为 6.0
 */
- (void)setImageRight;

/**
 *  文字居中，图片在左
 *  space : 图文间距
 */
- (void)setTitleCenterAndImageLeft:(CGFloat)space;

/**
 *  文字居中，图片在左
 *  默认间距为 6.0
 */
- (void)setTitleCenterAndImageLeft;

/**
 *  文字居中，图片在右
 *  space : 图文间距
 */
- (void)setTitleCenterAndImageRight:(CGFloat)space;

/**
 *  文字居中，图片在右
 *  默认间距为 6.0
 */
- (void)setTitleCenterAndImageRight;


@end
