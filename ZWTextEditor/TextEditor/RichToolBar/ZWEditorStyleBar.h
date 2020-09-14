//
//  ZWEditorStyleBar.h
//  ZW_IOS
//
//  Created by 杨杨鹏 on 2019/11/28.
//  Copyright © 2019 杨杨鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum:NSInteger{
    ZWEditorStyleBarInsert,//链接
    ZWEditorStyleBarFont,//字体
    ZWEditorStyleBarJustify,//对其方式
}ZWEditorStyleBarType;

@protocol ZWEditorStyleBarDelegate;

@protocol ZWEditorStyleBarDelegate <NSObject>

- (void)editorStyleBarType:(ZWEditorStyleBarType)type didClickBtn:(UIButton *)button;

- (void)editorStyleBarResetNormalType:(ZWEditorStyleBarType)type didClickBtn:(UIButton *)button;

@end

@interface ZWEditorStyleBar : UIView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<ZWEditorStyleBarDelegate>)delegate;

@property (nonatomic, assign) ZWEditorStyleBarType type;

- (void)updateFontBarWithButtonName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
