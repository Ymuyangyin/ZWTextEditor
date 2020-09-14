//
//  UIViewController+SGAY.h
//  SGAY_iOS
//
//  Created by 杨杨鹏 on 2018/6/14.
//  Copyright © 2018年 杨杨鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(YP)

@property (readonly, nonatomic) UIViewController *viewController;

@property (readonly, nonatomic) UIViewController *superViewController;

- (void)showKeyWindowMessage:(NSString *)message;
- (void)showSuccessMessage:(NSString *)message;
- (void)showErrorMessage:(NSString *)message;
- (void)showInfoMessage:(NSString *)message;

- (void)showMessage:(NSString *)message;//纯文字

- (void)showMessage:(NSString *)message offset:(CGFloat)offset;

- (void)showMessage:(NSString *)message afterDelay:(NSTimeInterval)afterDelay;

- (void)showViewBottomMessage:(NSString *)message;//纯文字

- (void)showWithLoading; //loading

- (void)showWithLoadingTitile:(NSString *)title;

- (void)dismissMessage;//HUD消失

- (void)actionNeedLoginCallback:(nullable void(^)(void))successCallback failure:(nullable void(^)(void))failureCallback;

@end

// ---------------------------------------------------------------------------------------------------------------

@interface UIView (Fillet)

/**
 Core Graphics  绘制圆角  防止离屏渲染
 
 @param radius 圆角宽度
 */
- (void)yp_addCorner:(CGFloat)radius;

/**
 Core Graphics  绘制圆角  防止离屏渲染
 
 @param radius 圆角宽度
 @param borderWidth 圆角线宽度
 @param borderColor 线颜色
 @param bgColor 背景色
 */
- (void)yp_addCorner:(CGFloat)radius
         borderWidth:(CGFloat)borderWidth
         borderColor:(UIColor *)borderColor
     backGroundColor:(UIColor*)bgColor;
/**
 Core Graphics  绘制圆角  防止离屏渲染
 
 @param radius 圆角宽度
 @param borderWidth 圆角线宽度
 @param borderColor 线颜色
 @param bgColor 背景色
 @param edgeInsets 间距
 */
- (void)yp_addCorner:(CGFloat)radius
         borderWidth:(CGFloat)borderWidth
         borderColor:(UIColor *)borderColor
     backGroundColor:(UIColor*)bgColor
          edgeInsets:(UIEdgeInsets)edgeInsets;


//
- (void)setViewFillet:(UIColor *)color radius:(CGFloat)cornerRadius;

/**
 四个圆角 --  列表 防止离屏渲染 masksToBounds
 */
- (void)setViewMSListFillet:(UIColor *)color cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth;

/**
 四个圆角
 */
- (void)setViewMSFillet:(UIColor *)color cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth;

/**
 某个圆角
 */
- (void)setViewFilletSize:(CGSize)size roundingCorners:(UIRectCorner )roundingCorners;

/**
 某个圆角
 */
- (void)setBorderWithCornerRadius:(CGFloat)cornerRadius
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                             type:(UIRectCorner)corners;

/**
 设置圆角 -- 阴影
 */

- (void) setViewCornerRadius:(CGFloat)cornerRadius color:(UIColor *)color shadowOpacity:(CGFloat)shadowOpacity shadowOffset:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius shadowColor:(UIColor *)shadowColor;

/**
 虚线边框
 */
- (void)setViewBottedlineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;

/**
 虚线圆角边框
 */
- (void)setViewBottedlineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor borderWidth:(CGFloat)borderWidth;

/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 **/
- (void)setViewDrawLineOfDashByCAShapeLayerLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
/**
 普通的截图
 该API仅可以在未使用layer和OpenGL渲染的视图上使用
 
 @return 截取的图片
 */
- (UIImage *)nomalSnapshotImage;

/**
 针对有用过OpenGL渲染过的视图截图
 
 @return 截取的图片
 */
- (UIImage *)openglSnapshotImage;

@end


// ---------------------------------------------------------------------------------------------------------------


@interface UIView (Frame)

@property (nonatomic, assign) CGFloat yp_centerX;
@property (nonatomic, assign) CGFloat yp_centerY;

@property (nonatomic, assign) CGFloat yp_x;
@property (nonatomic, assign) CGFloat yp_y;
@property (nonatomic, assign) CGFloat yp_width;
@property (nonatomic, assign) CGFloat yp_height;

@end
