//
//  ZWUploadFileModel.h
//  ZW_IOS
//
//  Created by 杨杨鹏 on 2019/12/13.
//  Copyright © 2019 杨杨鹏. All rights reserved.
//

typedef enum : NSUInteger {
    ZWUploadFileStateProgress,//上传中
    ZWUploadFileStateError,//上传失败
    ZWUploadFileStateSuccess,//上传成功
} ZWUploadFileState;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZWUploadFileModel : NSObject

@property (nonatomic,assign) ZWUploadFileState state;
@property (nonatomic,copy) NSString *host;
@property (nonatomic, strong) NSString *key;
//一般由服务器返回
@property (nonatomic, strong) NSString *token;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSData *fileData;

- (NSString *)uuid;
+ (id)jsonObject:(NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END
