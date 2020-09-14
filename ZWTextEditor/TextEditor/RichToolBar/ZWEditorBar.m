//
//  ZWEditorBar.m
//  ZW_IOS
//
//  Created by 杨杨鹏 on 2019/11/28.
//  Copyright © 2019 杨杨鹏. All rights reserved.
//

#import "ZWEditorBar.h"
#define COLOR(r,g,b,a) ([UIColor colorWithRed:(float)r/255.f green:(float)g/255.f blue:(float)b/255.f alpha:a])
@interface ZWEditorBar()
@property (nonatomic,strong) CALayer *topline;
@end
@implementation ZWEditorBar

- (CALayer *)topline{
    if (_topline) {
        CALayer *border = [CALayer layer];
        border.backgroundColor = COLOR(216,216,216,1).CGColor;
        
        border.frame = CGRectMake(14, 0, self.frame.size.width, 1);

    }
    return _topline;
}


+ (instancetype)editorBar{
    return [[NSBundle mainBundle] loadNibNamed:[self description] owner:nil options:nil][0];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    

}

//键盘
- (IBAction)clickKeyboard:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        button.enabled = YES;
    });
    if ([self.delegate respondsToSelector:@selector(editorBar:didClickIndex:)]) {
        [self.delegate editorBar:self didClickIndex:0];
    }
}

//字体
- (IBAction)clickfont:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        button.enabled = YES;
    });
    button.selected = !button.selected;
    ((UIButton *)[self viewWithTag:501]).selected = NO;
    ((UIButton *)[self viewWithTag:502]).selected = NO;
    if (button.selected) {
        if ([self.delegate respondsToSelector:@selector(editorBar:didClickIndex:)]) {
            [self.delegate editorBar:self didClickIndex:1];
        }
        [self viewWithTag:200].hidden = NO;
        [self viewWithTag:201].hidden = YES;
        [self viewWithTag:202].hidden = YES;
    }else{
        if ([self.delegate respondsToSelector:@selector(removeSelectNomarl)]) {
            [self.delegate removeSelectNomarl];
        }
        [self viewWithTag:200].hidden = YES;
        [self viewWithTag:201].hidden = YES;
        [self viewWithTag:202].hidden = YES;
    }
}

//缩进
- (IBAction)clickJustify:(id)sender{
    UIButton *button = (UIButton *)sender;
    button.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        button.enabled = YES;
    });
    button.selected = !button.selected;
    ((UIButton *)[self viewWithTag:500]).selected = NO;
    ((UIButton *)[self viewWithTag:502]).selected = NO;
    if (button.selected) {
        if ([self.delegate respondsToSelector:@selector(editorBar:didClickIndex:)]) {
            [self.delegate editorBar:self didClickIndex:2];
        }
        [self viewWithTag:200].hidden = YES;
        [self viewWithTag:201].hidden = NO;
        [self viewWithTag:202].hidden = YES;
    }else{
        if ([self.delegate respondsToSelector:@selector(removeSelectNomarl)]) {
            [self.delegate removeSelectNomarl];
        }
        [self viewWithTag:200].hidden = YES;
        [self viewWithTag:201].hidden = YES;
        [self viewWithTag:202].hidden = YES;
    }
}

//图片
- (IBAction)clickImg:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        button.enabled = YES;
    });
    if ([self.delegate respondsToSelector:@selector(editorBar:didClickIndex:)]) {
        [self.delegate editorBar:self didClickIndex:3];
    }
}

//插入
- (IBAction)clickInsert:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    button.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        button.enabled = YES;
    });
    ((UIButton *)[self viewWithTag:500]).selected = NO;
    ((UIButton *)[self viewWithTag:501]).selected = NO;

    if (button.selected) {
        if ([self.delegate respondsToSelector:@selector(editorBar:didClickIndex:)]) {
            [self.delegate editorBar:self didClickIndex:4];
        }
        [self viewWithTag:200].hidden = YES;
        [self viewWithTag:201].hidden = YES;
        [self viewWithTag:202].hidden = NO;
    }else{
        if ([self.delegate respondsToSelector:@selector(removeSelectNomarl)]) {
            [self.delegate removeSelectNomarl];
        }
        [self viewWithTag:200].hidden = YES;
        [self viewWithTag:201].hidden = YES;
        [self viewWithTag:202].hidden = YES;
    }
}

//后退
- (IBAction)clickRedo:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        button.enabled = YES;
    });
    if ([self.delegate respondsToSelector:@selector(editorBar:didClickIndex:)]) {
        
        [self.delegate editorBar:self didClickIndex:5];
    }
}

//前进
- (IBAction)clickUndo:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        button.enabled = YES;
    });
    if ([self.delegate respondsToSelector:@selector(editorBar:didClickIndex:)]) {
        [self.delegate editorBar:self didClickIndex:6];
    }
}
@end
