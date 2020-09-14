//
//  ZSSRichTextEditor.h
//  ZW_IOS
//
//  Created by 杨杨鹏 on 2019/12/13.
//  Copyright © 2019 杨杨鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

/**
 *  The viewController used with ZSSRichTextEditor
 */

NS_ASSUME_NONNULL_BEGIN
@interface ZSSRichTextEditor : UIViewController

@property (nonatomic, copy) NSString *titles;
@property (nonatomic, copy) NSString *content;

- (void)getHTMLCallback:(void (^)(id _Nullable obj, NSError * _Nullable error))callback;
- (void)getTextCallback:(void (^)(id _Nullable obj, NSError * _Nullable error))callback;
- (void)getTitleCallback:(void (^)(id _Nullable obj, NSError * _Nullable error))callback;

NS_ASSUME_NONNULL_END
@end


