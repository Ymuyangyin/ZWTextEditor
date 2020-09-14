//
//  YPPhotoPicker.m
//  SGAY_iOS
//
//  Created by 杨杨鹏 on 2018/8/24.
//  Copyright © 2018年 杨杨鹏. All rights reserved.
//

#import "YPPhotoPicker.h"
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <MobileCoreServices/MobileCoreServices.h>


#import "UIImage+Tint.h"

#import "TZImagePickerController.h"


@interface YPPhotoPicker() <UIImagePickerControllerDelegate, UINavigationControllerDelegate,TZImagePickerControllerDelegate>{
    TZImagePickerController *tzImagePickerVc;
}

@property (strong, nonatomic) YPPhotoPickerCallback callback;

@end

@implementation YPPhotoPicker

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.maxImagesCount = 1;
    }
    return self;
}

- (void)startWithCallback:(YPPhotoPickerCallback)callback sender:(UIViewController *)sender{

    self.callback = callback;

    [self showPhotoLibrary:sender];
}

#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
    [picker dismissViewControllerAnimated:YES completion:nil];

}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    YPLog(@"%@",photos);
    if (photos.count > 0) {
        if (_callback) {
            _callback(photos,assets);
        }
    }
}

// Decide album show or not't
// 决定相册显示与否
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(PHFetchResult *)result {

    return YES;
}

// 决定asset显示与否
- (BOOL)isAssetCanSelect:(PHAsset *)asset {
 
    return YES;
}



#pragma mark -- 导航栏


- (void) showPhotoLibrary:(UIViewController *)sender{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == 2){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"未获得授权使用相册" message:@"请在iOS\"设置\"-\"隐私\"-\"照片\"中打开" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        
        [sender presentViewController:alert animated:YES completion:nil];
    }else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self showPhotoLibrary:sender];
        }];
    }else{
        [self pushTZImagePickerController:sender];
    }

}

#pragma mark - TZImagePickerController

/// 相册

- (void)pushTZImagePickerController:(UIViewController *)sender{
    if (self.maxImagesCount <= 0) {
        return;
    }

    tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImagesCount columnNumber:SCREEN_WIDTH <= 320 ? 3 : 4 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    tzImagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;

#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    tzImagePickerVc.isSelectOriginalPhoto = YES;

    tzImagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    tzImagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按
    
    tzImagePickerVc.autoDismiss = YES;

    tzImagePickerVc.allowPreview = YES; // 预览按钮

    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    tzImagePickerVc.navigationBar.barTintColor = [UIColor whiteColor];
    tzImagePickerVc.barItemTextColor = UIColorFromRGB(0x000000, 1);
    tzImagePickerVc.barItemTextFont = UISystemFont(16);
    tzImagePickerVc.oKButtonTitleColorDisabled = MAIN_COLOR;
    tzImagePickerVc.oKButtonTitleColorNormal = MAIN_COLOR;
//    imagePickerVc.navigationBar.translucent = NO;
    tzImagePickerVc.naviTitleColor = UIColorFromRGB(0x000000, 1);
    tzImagePickerVc.naviTitleFont = UISystemFont(19);
    tzImagePickerVc.iconThemeColor = MAIN_COLOR;
    tzImagePickerVc.showPhotoCannotSelectLayer = YES;
    tzImagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [tzImagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        [originalPhotoLabel setTextColor:MAIN_COLOR];
    }];
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    tzImagePickerVc.allowPickingVideo = NO;
    tzImagePickerVc.allowPickingImage = YES;
    tzImagePickerVc.allowPickingOriginalPhoto = YES;//原图
    tzImagePickerVc.allowPickingGif = NO;
    tzImagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频

    // 4. 照片排列按修改时间升序
    tzImagePickerVc.sortAscendingByModificationDate = YES;

    
    /// 5. 单选模式,maxImagesCount为1时才生效
    tzImagePickerVc.showSelectBtn = NO;
    tzImagePickerVc.allowCrop = NO;
    tzImagePickerVc.needCircleCrop = NO;
    // 设置竖屏下的裁剪尺寸
 
    tzImagePickerVc.cropRect = CGRectMake(0, (SCREEN_HEIGHT - SCREEN_WIDTH) / 2, SCREEN_WIDTH, SCREEN_WIDTH);
    
//    imagePickerVc.allowPreview = NO; -- 预览按钮
    // 自定义导航栏上的返回按钮
     [tzImagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
         [leftButton setImage:[UIImage imageNamed:@"nav_return"] forState:UIControlStateNormal];
         [leftButton setTitle:@"返回" forState:UIControlStateNormal];
         [leftButton setTitleColor:C282828_COLOR forState:UIControlStateNormal];
         leftButton.titleLabel.font = [UIFont systemFontOfSize:16];
         
//         leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, -45, 0, 0);
         leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
     }];
     tzImagePickerVc.delegate = self;

    // Deprecated, Use statusBarStyle
//    imagePickerVc.isStatusBarDefault = YES;
    tzImagePickerVc.statusBarStyle = UIStatusBarStyleDefault;

    // 设置是否显示图片序号
    tzImagePickerVc.showSelectedIndex = YES;

    // 设置首选语言 / Set preferred language
     tzImagePickerVc.preferredLanguage = @"zh-Hans";
    
#pragma mark - 到这里为止

    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [tzImagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {

//        [self imagePickerController:tzImagePickerVc didFinishPickingPhotos:photos sourceAssets:assets isSelectOriginalPhoto:isSelectOriginalPhoto infos:nil];
        
      //  NSLog(@"--------%@---%@==",assets,photos);
        
    }];
    tzImagePickerVc.pickerDelegate = self;
    [sender presentViewController:tzImagePickerVc animated:YES completion:nil];
}

@end

