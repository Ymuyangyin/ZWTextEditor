//
//  ZWEditorBar.m
//  ZW_IOS
//
//  Created by 杨杨鹏 on 2019/11/28.
//  Copyright © 2019 杨杨鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

//底部编辑栏高度
#define KWEditorBar_Height 44

@class ZWEditorBar;
@protocol ZWEditorBarDelegate<NSObject>
- (void)editorBar:(ZWEditorBar *)editorBar didClickIndex:(NSInteger)buttonIndex;

- (void)removeSelectNomarl;
@end
@interface ZWEditorBar : UIView

@property (weak, nonatomic) IBOutlet UIButton *keyboardButton;

@property (weak, nonatomic) IBOutlet UIButton *fontButton;

@property (weak, nonatomic) IBOutlet UIButton *justifyButton;

@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@property (weak, nonatomic) IBOutlet UIButton *insertButton;

@property (weak, nonatomic) IBOutlet UIButton *undoButton;

@property (weak, nonatomic) IBOutlet UIButton *redoButton;



+ (instancetype)editorBar;

@property (nonatomic,weak) id<ZWEditorBarDelegate> delegate;


@end
