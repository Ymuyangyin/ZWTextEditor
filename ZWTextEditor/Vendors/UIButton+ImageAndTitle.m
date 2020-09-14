
//
//  UIButton+ImageAndTitle.m
//  SGAY_iOS
//
//  Created by 杨杨鹏 on 2018/6/15.
//  Copyright © 2018年 杨杨鹏. All rights reserved.
//

#import "UIButton+ImageAndTitle.h"

//#import "UIView+YP.h"
//#import <YYWebImage/YYWebImage.h>

#define DEFULT_SPACE    6.0f

@implementation UIButton (ImageAndTitle)


- (void)setImageWithThumbFileId:(NSString *)thumbFileId placeholderImage:(UIImage *)image{
//    [self yy_setImageWithURL:[NSURL URLWithString:[thumbFileId stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] forState:UIControlStateNormal placeholder:image options:YYWebImageOptionProgressive completion:nil];
}

- (void)setImageWithThumbFileId:(NSString *)thumbFileId placeholderImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius{
//    UIImageView *imageView = [UIImageView new];
//    [imageView yy_setImageWithURL:[NSURL URLWithString:[thumbFileId stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholder:[image yy_imageByRoundCornerRadius:cornerRadius] options:YYWebImageOptionProgressive progress:nil transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
//        UIImage *btnImage = [image yy_imageByRoundCornerRadius:cornerRadius];
//        [self setImage:btnImage forState:UIControlStateNormal];
//    }];
}

- (void)zoomImage:(CGFloat)times
{
    UIImage *image = self.imageView.image;
    if (image != nil) {
        [self setImage:[self scaleImage:image toScale:times] forState:UIControlStateNormal];
    }
}

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (void)setImageAndTitleCenter
{
    CGSize titleSize = self.titleLabel.frame.size;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, -titleSize.width);
    
    CGSize imageSize = self.imageView.frame.size;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, 0.0, 0.0);
}

//- (void)setImageUp:(CGFloat)space
//{
//
//    CGSize imageSize = self.imageView.frame.size;
//
//    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + space / 2), 0.0);
//
//    CGSize titleSize = self.titleLabel.frame.size;
//    CGFloat left =  self.imageView.frame.origin.x + imageSize.width / 2;
//    self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + space / 2), left, 0.0, 0);
//
//    NSLog(@"%@   %@   %@",NSStringFromCGRect(self.imageView.frame),NSStringFromCGRect(self.titleLabel.frame),NSStringFromCGRect(self.frame));
//}

- (void)setImageUp:(CGFloat)space
{

    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;

    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + space);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);

}


- (void)setImageUp
{
    [self setImageUp:DEFULT_SPACE];
}

- (void)setImageDown:(CGFloat)space
{
    CGSize imageSize = self.imageView.frame.size;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, (imageSize.height + space / 2), 0.0);
    
    CGSize titleSize = self.titleLabel.frame.size;
    
    self.imageEdgeInsets = UIEdgeInsetsMake((titleSize.height + space / 2), 0.0, 0.0, -titleSize.width);
}

- (void)setImageDown
{
    [self setImageDown:DEFULT_SPACE];
}

- (void)setImageLeft:(CGFloat)space
{
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, -space / 2);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, -space / 2, 0.0, 0.0);
}

- (void)setImageLeft:(CGFloat)space imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets{
        
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, -space / 2);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(imageEdgeInsets.top, -space / 2, imageEdgeInsets.bottom, 0.0);
}

- (void)setImageLeft
{
    [self setImageLeft:DEFULT_SPACE];
}

- (void)setImageRight:(CGFloat)space
{
    CGSize imageSize = self.imageView.frame.size;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -(imageSize.width * 2 + space / 2), 0.0, 0.0);
    
    CGSize titleSize = self.titleLabel.frame.size;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, -(titleSize.width * 2 + space / 2));
}

- (void)setImageRight:(CGFloat)space imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets{
    CGSize imageSize = self.imageView.frame.size;

    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -(imageSize.width * 2 + space / 2), 0.0, 0.0);
    
    CGSize titleSize = self.titleLabel.frame.size;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(imageEdgeInsets.top, 0.0, imageEdgeInsets.bottom, -(titleSize.width * 2 + space / 2));
}

- (void)setImageRight
{
    [self setImageRight:DEFULT_SPACE];
}

- (void)setTitleCenterAndImageLeft:(CGFloat)space
{
    CGSize imageSize = self.imageView.frame.size;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, 0.0, 0.0);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, -(space + imageSize.width), 0.0, 0.0);
}

- (void)setTitleCenterAndImageLeft
{
    [self setTitleCenterAndImageLeft:DEFULT_SPACE];
}

- (void)setTitleCenterAndImageRight:(CGFloat)space
{
    CGSize imageSize = self.imageView.frame.size;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, 0.0, 0.0);
    
    CGSize titleSize = self.titleLabel.frame.size;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, -(space + 22 * titleSize.width + imageSize.width));
}

- (void)setTitleCenterAndImageRight
{
    [self setTitleCenterAndImageRight:DEFULT_SPACE];
}
@end
