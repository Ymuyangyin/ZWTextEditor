

//
//  UIViewController+SGAY.m
//  SGAY_iOS
//
//  Created by 杨杨鹏 on 2018/6/14.
//  Copyright © 2018年 杨杨鹏. All rights reserved.
//

#import "UIView+YP.h"
#import <CoreGraphics/CoreGraphics.h>



@implementation UIView(YP)

- (UIViewController *)viewController {
    UIResponder *responder = self.nextResponder;
    
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            break;
        }
        responder = [responder nextResponder];
    }
    
    return (UIViewController *)responder;
}

- (UIViewController *)superViewController{
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

//- (void)actionNeedLoginCallback:(void (^)(void))successCallback failure:(void (^)(void))failureCallback {
//    if (HAS_LOGGED_IN) {
//        if (successCallback) {
//            successCallback();
//        }
//    } else {
//        [ZWLoginRootController showWithSender:self.viewController callback:^(BOOL success) {
//            if (success && successCallback) {
//                successCallback();
//            }
//            if (!success && failureCallback) {
//                failureCallback();
//            }
//        }];
//    }
//}
//
//
//
//#pragma mark -- SGAYShowMessageViewDelegate
//- (void)showErrorMessage:(NSString *)message {
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.viewController.navigationController.view animated:YES];
//
//        // Set the custom view mode to show any view.
//        hud.mode = MBProgressHUDModeCustomView;
//        // Set an image view with a checkmark.
//        UIImage *image = [UIImage imageNamed:@"toast_icon_error"];
//        hud.customView = [[UIImageView alloc] initWithImage:image];
//        hud.label.font = UISystemMediumFont(15);
//        hud.label.textColor = [UIColor whiteColor];
//        hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
//        hud.margin = 20;
//        // Looks a bit nicer if we make it square.
//        //    hud.square = NO;
//        hud.bezelView.backgroundColor = UIColorFromRGB(0x000000, 0.75);
//        hud.margin = 10;
//        // Optional label text.
//        hud.label.text = message;
//        hud.userInteractionEnabled = NO;
//
//        [hud hideAnimated:YES afterDelay:2.f];
//    });
//}
//
//- (void)showSuccessMessage:(NSString *)message {
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.viewController.navigationController.view animated:YES];
//
//        // Set the custom view mode to show any view.
//        hud.mode = MBProgressHUDModeCustomView;
//        // Set an image view with a checkmark.
//        UIImage *image = [UIImage imageNamed:@"toast_icon_finish"];
//        hud.customView = [[UIImageView alloc] initWithImage:image];
//        hud.label.font = UISystemMediumFont(15);
//        hud.label.textColor = [UIColor whiteColor];
//        hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
//        hud.margin = 20;
//        // Looks a bit nicer if we make it square.
//        hud.square = NO;
//        hud.bezelView.backgroundColor = UIColorFromRGB(0x000000, 0.75);
//        hud.margin = 10;
//        // Optional label text.
//        hud.label.text = message;
//        hud.userInteractionEnabled = NO;
//
//        [hud hideAnimated:YES afterDelay:2.f];
//    });
//}
//
//- (void)showInfoMessage:(NSString *)message {
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.viewController.navigationController.view animated:YES];
//
//        // Set the custom view mode to show any view.
//        hud.mode = MBProgressHUDModeCustomView;
//        // Set an image view with a checkmark.
//        UIImage *image = [UIImage imageNamed:@"toast_icon_hint"];
//        hud.customView = [[UIImageView alloc] initWithImage:image];
//        hud.label.font = UISystemMediumFont(15);
//        hud.label.textColor = [UIColor whiteColor];
//        hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
//        hud.margin = 20;
//        // Looks a bit nicer if we make it square.
//        hud.square = NO;
//        hud.bezelView.backgroundColor = UIColorFromRGB(0x000000, 0.75);
//        hud.margin = 10;
//        // Optional label text.
//        hud.label.text = message;
//        hud.userInteractionEnabled = NO;
//
//        [hud hideAnimated:YES afterDelay:2.f];
//    });
//}
//
//- (void)showKeyWindowMessage:(NSString *)message{
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//
//        // Set the text mode to show only text.
//        hud.mode = MBProgressHUDModeText;
//        hud.label.text = message;
//        hud.label.textColor = [UIColor whiteColor];
//        hud.label.numberOfLines = 0;
//
//        // Move to bottm center.
//        hud.label.font = UISystemMediumFont(15);
//        hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
//        hud.bezelView.backgroundColor = UIColorFromRGB(0x000000, 0.75);
//        hud.square = NO;
//        hud.margin = 10;
//        hud.userInteractionEnabled = NO;
//
//        //    hud.bezelView.backgroundColor = HUD_COLOR;
//        [hud hideAnimated:YES afterDelay:2.f];
//    });
//}
//
//- (void)showMessage:(NSString *)message{
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        if ([YPStringUtils isEmpty:message]) {
//            return;
//        }
//
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superViewController.view animated:YES];
//
//        // Set the text mode to show only text.
//        hud.mode = MBProgressHUDModeText;
//        hud.label.text = message;
//        hud.label.textColor = [UIColor whiteColor];
//        hud.label.numberOfLines = 0;
//
//        // Move to bottm center.
//        hud.label.font = UISystemMediumFont(15);
//        hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
//        hud.bezelView.backgroundColor = UIColorFromRGB(0x000000, 0.75);
//        hud.square = NO;
//        hud.margin = 10;
//        hud.userInteractionEnabled = NO;
//
//        //    hud.bezelView.backgroundColor = HUD_COLOR;
//        [hud hideAnimated:YES afterDelay:2.f];
//    });
//}
//
//- (void)showMessage:(NSString *)message offset:(CGFloat)offset{
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        if ([YPStringUtils isEmpty:message]) {
//            return;
//        }
//
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superViewController.view animated:YES];
//
//        // Set the text mode to show only text.
//        hud.mode = MBProgressHUDModeText;
//        hud.label.text = message;
//        hud.label.textColor = [UIColor whiteColor];
//        hud.label.numberOfLines = 0;
//
//        // Move to bottm center.
//        hud.label.font = UISystemMediumFont(15);
//        hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
//        hud.bezelView.backgroundColor = UIColorFromRGB(0x000000, 0.75);
//        hud.square = NO;
//        hud.margin = 10;
//        hud.userInteractionEnabled = NO;
//        hud.offset = CGPointMake(0, offset);
//
//        //    hud.bezelView.backgroundColor = HUD_COLOR;
//        [hud hideAnimated:YES afterDelay:2.f];
//    });
//}
//
//- (void)showMessage:(NSString *)message afterDelay:(NSTimeInterval)afterDelay{
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        if ([YPStringUtils isEmpty:message]) {
//            return;
//        }
//
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superViewController.view animated:YES];
//
//        // Set the text mode to show only text.
//        hud.mode = MBProgressHUDModeText;
//        hud.label.text = message;
//        hud.label.textColor = [UIColor whiteColor];
//        hud.label.numberOfLines = 0;
//
//        // Move to bottm center.
//        hud.label.font = UISystemMediumFont(15);
//        hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
//        hud.bezelView.backgroundColor = UIColorFromRGB(0x000000, 0.75);
//        hud.square = NO;
//        hud.margin = 10;
//        hud.userInteractionEnabled = NO;
//
//        //    hud.bezelView.backgroundColor = HUD_COLOR;
//        [hud hideAnimated:YES afterDelay:afterDelay];
//    });
//}
//
//- (void) showWithLoadingTitile:(NSString *)title{
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
//        hud.contentColor = MAIN_COLOR;
//        hud.label.font = UISystemMediumFont(15);
//        hud.label.textColor = [UIColor whiteColor];
//
//        // Set the label text.
//        hud.label.text = title;
//        hud.bezelView.backgroundColor = UIColorFromRGB(0x000000, 0.75);
//        hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
//
//        [hud hideAnimated:YES];
//    });
//}
//
//- (void) showWithLoading{
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.viewController.navigationController.view animated:YES];
//        hud.contentColor = MAIN_COLOR;
//        hud.label.font = UISystemMediumFont(15);
//        hud.label.textColor = [UIColor whiteColor];
//
//
//        // Set the label text.
//        hud.bezelView.backgroundColor = UIColorFromRGB(0x000000, 0.75);
//        hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
//        [hud hideAnimated:YES];
//    });
//}
//
//- (void)dismissMessage{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [MBProgressHUD hideHUDForView:self.viewController.navigationController.view animated:YES];
//    });
//}
//
//- (void)showViewBottomMessage:(NSString *)message{
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.viewController.navigationController.view animated:YES];
//
//        // Set the custom view mode to show any view.
//        hud.mode = MBProgressHUDModeText;
//        // Set an image view with a checkmark.
//        hud.label.font = UISystemMediumFont(11);
//        hud.label.textColor = UIColorFromRGB(0xffffff, 0.9);
//        hud.label.numberOfLines = 0;
//        hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
//        // Looks a bit nicer if we make it square.
//        hud.square = NO;
//        hud.margin = 10;
//        hud.bezelView.backgroundColor = UIColorFromRGB(0x000000, 0.75);
//        // Optional label text.
//        hud.label.text = message;
//        hud.userInteractionEnabled = NO;
//
//
//        [hud hideAnimated:YES afterDelay:2.f];
//    });
//
//}
//
//
//@end
//
//// ---------------------------------------------------------------------------------------------------------------
//
//
//@implementation UIView(Fillet)
//- (void)yp_addCorner:(CGFloat)radius{
//    [self yp_addCorner:radius borderWidth:1 borderColor:[UIColor blackColor] backGroundColor:[UIColor clearColor]];
//}
//
//- (void)yp_addCorner:(CGFloat)radius
//         borderWidth:(CGFloat)borderWidth
//         borderColor:(UIColor *)borderColor
//     backGroundColor:(UIColor*)bgColor{
//
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[self yp_drawRectWithRoundedCorner:radius borderWidth:borderWidth borderColor:borderColor backGroundColor:bgColor]];
//    [self insertSubview:imageView atIndex:0];
//}
//
//- (void)yp_addCorner:(CGFloat)radius
//         borderWidth:(CGFloat)borderWidth
//         borderColor:(UIColor *)borderColor
//     backGroundColor:(UIColor*)bgColor
//          edgeInsets:(UIEdgeInsets)edgeInsets{
//
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[self yp_drawRectWithRoundedCorner:radius borderWidth:borderWidth borderColor:borderColor backGroundColor:bgColor]];
//    imageView.frame = CGRectMake(edgeInsets.left, edgeInsets.top, self.bounds.size.width - edgeInsets.left - edgeInsets.right, self.bounds.size.height - edgeInsets.top - edgeInsets.bottom);
//    [self insertSubview:imageView atIndex:0];
//}
//
//- (UIImage *)yp_drawRectWithRoundedCorner:(CGFloat)radius
//                              borderWidth:(CGFloat)borderWidth
//                              borderColor:(UIColor *)borderColor
//                          backGroundColor:(UIColor*)bgColor{
//    CGSize size = self.bounds.size;
//    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
//    CGContextRef contextRef =  UIGraphicsGetCurrentContext();
//
//    CGContextSetLineWidth(contextRef, borderWidth);
//    CGContextSetStrokeColorWithColor(contextRef, borderColor.CGColor);
//    CGContextSetFillColorWithColor(contextRef, bgColor.CGColor);
//
//    CGFloat halfBorderWidth = borderWidth / 2.0;
//    CGFloat width = size.width;
//    CGFloat height = size.height;
//
//    CGContextMoveToPoint(contextRef, width - halfBorderWidth, radius + halfBorderWidth);
//    CGContextAddArcToPoint(contextRef, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius);  // 右下角角度
//    CGContextAddArcToPoint(contextRef, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius); // 左下角角度
//    CGContextAddArcToPoint(contextRef, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius); // 左上角
//    CGContextAddArcToPoint(contextRef, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius); // 右上角
//    CGContextDrawPath(contextRef, kCGPathFillStroke);
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}
//
//- (void)setViewFillet:(UIColor *)color radius:(CGFloat)cornerRadius{
//    CGFloat width = self.frame.size.width;
//    CGFloat height = self.frame.size.height;
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.frame = CGRectMake(0, 0, width, height);
//    CAShapeLayer *borderLayer = [CAShapeLayer layer];
//    borderLayer.frame = CGRectMake(0, 0, width, height);
//    borderLayer.lineWidth = 1.f;
//    if (color) {
//        borderLayer.strokeColor = color.CGColor;
//    }else{
//        borderLayer.strokeColor = [UIColor clearColor].CGColor;
//    }
//    borderLayer.fillColor = [UIColor clearColor].CGColor;
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, height) cornerRadius:cornerRadius];
//    maskLayer.path = bezierPath.CGPath;
//    borderLayer.path = bezierPath.CGPath;
//    if ([self isKindOfClass:[UITableViewCell class]]) {
//        //        [(UITableViewCell *)self.contentView.layer insertSublayer:borderLayer atIndex:0];
//        UITableViewCell *cell = (UITableViewCell *)self;
//        [cell.contentView.layer insertSublayer:borderLayer atIndex:0];
//    }else if ([self isKindOfClass:[UICollectionViewCell class]]){
//        UICollectionViewCell *cell = (UICollectionViewCell *)self;
//        [cell.contentView.layer insertSublayer:borderLayer atIndex:0];
//    }else{
//        [self.layer insertSublayer:borderLayer atIndex:0];
//    }
//    [self.layer setMask:maskLayer];
//
//}
//
//- (void)setViewMSListFillet:(UIColor *)color cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth{
//    self.clipsToBounds = YES;
//    self.layer.cornerRadius = cornerRadius;
//    self.layer.borderWidth = borderWidth;
//    self.layer.borderColor = color.CGColor;
//    self.layer.shouldRasterize = YES;
//    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
//}
//
//- (void)setViewMSFillet:(UIColor *)color cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth{
//    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = cornerRadius;
//    self.layer.borderWidth = borderWidth;
//    self.layer.borderColor = color.CGColor;
//    self.layer.shouldRasterize = YES;
//    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
//}
//
//- (void)setViewFilletSize:(CGSize)size roundingCorners:(UIRectCorner )roundingCorners{
//
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:roundingCorners cornerRadii:size];
//
//    CAShapeLayer *maskLayer = [[CAShapeLayer  alloc]  init];
//
//    maskLayer.frame = self.bounds;
//
//    maskLayer.path = maskPath.CGPath;
//
//    self.layer.mask = maskLayer;
//
//}
//
//
//- (void)setBorderWithCornerRadius:(CGFloat)cornerRadius
//                      borderWidth:(CGFloat)borderWidth
//                      borderColor:(UIColor *)borderColor
//                             type:(UIRectCorner)corners {
//
//    //    UIRectCorner type = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
//
//    //1. 加一个layer 显示形状
//    CGRect rect = CGRectMake(borderWidth/2.0, borderWidth/2.0,
//                             CGRectGetWidth(self.frame)-borderWidth, CGRectGetHeight(self.frame)-borderWidth);
//    CGSize radii = CGSizeMake(cornerRadius, borderWidth);
//
//    //create path
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
//
//    //create shape layer
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.strokeColor = borderColor.CGColor;
//    shapeLayer.fillColor = [UIColor clearColor].CGColor;
//
//    shapeLayer.lineWidth = borderWidth;
//    shapeLayer.lineJoin = kCALineJoinRound;
//    shapeLayer.lineCap = kCALineCapRound;
//    shapeLayer.path = path.CGPath;
//
//    [self.layer addSublayer:shapeLayer];
//
//
//
//
//    //2. 加一个layer 按形状 把外面的减去
//    CGRect clipRect = CGRectMake(0, 0,
//                                 CGRectGetWidth(self.frame)-1, CGRectGetHeight(self.frame)-1);
//    CGSize clipRadii = CGSizeMake(cornerRadius, borderWidth);
//    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:clipRect byRoundingCorners:corners cornerRadii:clipRadii];
//
//    CAShapeLayer *clipLayer = [CAShapeLayer layer];
//    clipLayer.strokeColor = borderColor.CGColor;
//    shapeLayer.fillColor = [UIColor clearColor].CGColor;
//
//    clipLayer.lineWidth = 1;
//    clipLayer.lineJoin = kCALineJoinRound;
//    clipLayer.lineCap = kCALineCapRound;
//    clipLayer.path = clipPath.CGPath;
//
//    self.layer.mask = clipLayer;
//}
//
//
//
//- (void)setViewCornerRadius:(CGFloat)cornerRadius color:(UIColor *)color shadowOpacity:(CGFloat)shadowOpacity shadowOffset:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius shadowColor:(UIColor *)shadowColor{
//
//    self.layer.cornerRadius = cornerRadius;
//    self.layer.borderColor = color.CGColor;
//    self.layer.shadowColor = shadowColor.CGColor;
//    self.layer.shadowRadius = shadowRadius;
//    self.layer.shadowOffset = shadowOffset;
//    self.layer.shadowOpacity = shadowOpacity;
//
//}
//
//- (void)setViewBottedlineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor{
//    CAShapeLayer *border = [CAShapeLayer layer];
//
//    border.strokeColor = lineColor.CGColor;
//
//    border.fillColor = nil;
//
//    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
//
//    border.frame = self.bounds;
//
//    border.lineWidth = lineWidth;
//
//    border.lineCap = @"square";
//    //设置线宽和线间距
//    border.lineDashPattern = @[@4, @5];
//
//    [self.layer addSublayer:border];
//}
//
//- (void)setViewBottedlineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor borderWidth:(CGFloat)borderWidth{
//
//    UIBezierPath *maskPath=[[UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(borderWidth, borderWidth)] bezierPathByReversingPath];
//    CAShapeLayer *border = [CAShapeLayer layer];
//    // 线条颜色
//    border.strokeColor = lineColor.CGColor;
//    border.masksToBounds = YES;
//
//    border.fillColor = nil;
//    border.path = maskPath.CGPath;
//    border.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
//
//    border.lineWidth = lineWidth;
//    border.lineCap = @"square";
//    // 第一个是 线条长度 第二个是间距 nil时为实线
//    border.lineDashPattern = @[@4, @5];
//    [self.layer addSublayer:border];
//}
//
///**
// *  通过 CAShapeLayer 方式绘制虚线
// *
// *  param lineView:       需要绘制成虚线的view
// *  param lineLength:     虚线的宽度
// *  param lineSpacing:    虚线的间距
// *  param lineColor:      虚线的颜色
// *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
// **/
//- (void)setViewDrawLineOfDashByCAShapeLayerLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor{
//
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(0, 0)];
//    [path addLineToPoint:CGPointMake(SCREEN_WIDTH, 0)];
//
//    CAShapeLayer *border = [CAShapeLayer layer];
//    // 线条颜色
//    border.strokeColor = lineColor.CGColor;
//    //    border.masksToBounds = YES;
//
//    border.fillColor = nil;
//    border.path = path.CGPath;
//    border.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
//
//    border.lineWidth = self.frame.size.height;
//    border.lineCap = @"square";
//    // 第一个是 线条长度 第二个是间距 nil时为实线
//    border.lineDashPattern = @[@(lineLength), @(lineLength)];
//    [self.layer addSublayer:border];
//}
//
///**
// 普通的截图
// 该API仅可以在未使用layer和OpenGL渲染的视图上使用
//
// @return 截取的图片
// */
//- (UIImage *)nomalSnapshotImage
//{
//    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
//    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return snapshotImage;
//}
//
///**
// 针对有用过OpenGL渲染过的视图截图
//
// @return 截取的图片
// */
//- (UIImage *)openglSnapshotImage
//{
//    CGSize size = self.bounds.size;
//    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
//    CGRect rect = self.frame;
//    [self drawViewHierarchyInRect:rect afterScreenUpdates:YES];
//    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return snapshotImage;
//}

@end


// ---------------------------------------------------------------------------------------------------------------

@implementation UIView (Frame)

- (CGFloat)yp_height{
    return self.frame.size.height;
    
}

- (CGFloat)yp_width{
    return self.frame.size.width;
    
}


- (void)setYp_height:(CGFloat)yp_height {
    CGRect frame = self.frame;
    frame.size.height = yp_height;
    self.frame = frame;
}
- (void)setYp_width:(CGFloat)yp_width{
    CGRect frame = self.frame;
    frame.size.width = yp_width;
    self.frame = frame;
}

- (CGFloat)yp_x
{
    return self.frame.origin.x;
}

- (void)setYp_x:(CGFloat)yp_x {
    CGRect frame = self.frame;
    frame.origin.x = yp_x;
    self.frame = frame;
}


- (CGFloat)yp_y
{
    return self.frame.origin.y;
}


- (void)setYp_y:(CGFloat)yp_y {
    CGRect frame = self.frame;
    frame.origin.y = yp_y;
    self.frame = frame;
}


- (void)setYp_centerX:(CGFloat)yp_centerX {
    CGPoint center = self.center;
    center.x = yp_centerX;
    self.center = center;
}

- (CGFloat)yp_centerX
{
    return self.center.x;
}


- (void)setYp_centerY:(CGFloat)yp_centerY {
    CGPoint center = self.center;
    center.y = yp_centerY;
    self.center = center;
}

- (CGFloat)yp_centerY
{
    return self.center.y;
}

@end
