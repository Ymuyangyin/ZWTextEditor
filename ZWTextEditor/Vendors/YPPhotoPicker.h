//
//  YPPhotoPicker.h
//  SGAY_iOS
//
//  Created by 杨杨鹏 on 2018/8/24.
//  Copyright © 2018年 杨杨鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Photos/Photos.h>


typedef void(^YPPhotoPickerCallback)(NSArray <UIImage *> *pickedImage, NSArray <PHAsset *> *assets);


@interface YPPhotoPicker : NSObject

@property (nonatomic, assign) NSInteger maxImagesCount;//最多选择  1--- 单选


- (void)startWithCallback:(YPPhotoPickerCallback)callback sender:(UIViewController *)sender;
@end
