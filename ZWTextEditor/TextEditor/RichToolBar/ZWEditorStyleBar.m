




//
//  ZWEditorStyleBar.m
//  ZW_IOS
//
//  Created by 杨杨鹏 on 2019/11/28.
//  Copyright © 2019 杨杨鹏. All rights reserved.
//

#import "ZWEditorStyleBar.h"

#import "Masonry.h"
#import "UIControl+ZWButtonExtension.h"

@interface ZWEditorStyleBar ()
@property (nonatomic, strong) UIView *fontView;
@property (nonatomic, strong) UIView *justifyView;
@property (nonatomic, strong) UIView *insertView;

@property (nonatomic,strong) UIButton *boldBtn;
@property (nonatomic,strong) UIButton *contentBtn;
@property (nonatomic,strong) UIButton *titleBtn1;
@property (nonatomic,strong) UIButton *titleBtn2;
@property (nonatomic,strong) UIButton *titleBtn3;

@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *centerBtn;
@property (nonatomic,strong) UIButton *rightBtn;
@property (nonatomic,strong) UIButton *orderBtn;
@property (nonatomic,strong) UIButton *unorderBtn;

@property (nonatomic,strong) UIButton *horizontalRuleBtn;
@property (nonatomic,strong) UIButton *blockquoteBtn;
@property (nonatomic,strong) UIButton *urlBtn;

@property (nonatomic,strong) NSMutableArray *btnArray;

@property (nonatomic,weak) id<ZWEditorStyleBarDelegate> delegate;


@end

@implementation ZWEditorStyleBar

- (instancetype)initWithFrame:(CGRect)frame delegate:(nonnull id<ZWEditorStyleBarDelegate>)delegate{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        self.backgroundColor = UIColorFromRGB(0xf9f9f9, 1);
        self.btnArray = [NSMutableArray array];
        [self setupWithView];
    }
    return self;
}

- (void)setType:(ZWEditorStyleBarType)type{
    [self removeFromSuperview];
    _type = type;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    switch (type) {
        case ZWEditorStyleBarFont:
            self.fontView.frame = self.bounds;
            [self addSubview:self.fontView];
            break;
        case ZWEditorStyleBarJustify:
            self.justifyView.frame = self.bounds;
            [self addSubview:self.justifyView];
            break;
        case ZWEditorStyleBarInsert:
            self.insertView.frame = self.bounds;
            [self addSubview:self.insertView];
            break;
        default:
            break;
    }
}

#pragma mark -- 点击事件
- (void)onButtonClick:(UIButton *)button{
     switch (self.type) {
        case ZWEditorStyleBarFont:{
            for (int i = 0; i < 5; i ++) {
                if (i == button.tag - 500) {
                    button.selected = !button.selected;
                }else{
                    ((UIButton *)[self.fontView viewWithTag:i + 500]).selected = NO;
                }
            }
            
            if (!self.boldBtn.selected && !self.contentBtn.selected && !self.titleBtn1.selected && !self.titleBtn2.selected && !self.titleBtn3.selected) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(editorStyleBarResetNormalType:didClickBtn:)]) {
                    [self.delegate editorStyleBarResetNormalType:self.type didClickBtn:button];
                }
            }else if ([self.delegate respondsToSelector:@selector(editorStyleBarType:didClickBtn:)]) {
                [self.delegate editorStyleBarType:self.type didClickBtn:button];
            }
        }
            break;
            
        case ZWEditorStyleBarJustify:{
            for (int i = 0; i < 5; i ++) {
                if (i == button.tag - 600) {
                    button.selected = !button.selected;
                }else{
                    ((UIButton *)[self.justifyView viewWithTag:i + 600]).selected = NO;
                }
            }
            
            if (!self.leftBtn.selected && !self.centerBtn.selected && !self.rightBtn.selected && !self.orderBtn.selected && !self.unorderBtn.selected) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(editorStyleBarResetNormalType:didClickBtn:)]) {
                    [self.delegate editorStyleBarResetNormalType:self.type didClickBtn:button];
                }
            }else if ([self.delegate respondsToSelector:@selector(editorStyleBarType:didClickBtn:)]) {
                [self.delegate editorStyleBarType:self.type didClickBtn:button];
            }
        }
            break;
            
        case ZWEditorStyleBarInsert:{
            if (self.blockquoteBtn == button) {
                
                button.selected = !button.selected;
                self.horizontalRuleBtn.selected = NO;
                self.urlBtn.selected = NO;
                
                if (!self.horizontalRuleBtn.selected && !self.blockquoteBtn.selected && !self.urlBtn.selected) {
                    if (self.delegate && [self.delegate respondsToSelector:@selector(editorStyleBarResetNormalType:didClickBtn:)]) {
                        [self.delegate editorStyleBarResetNormalType:self.type didClickBtn:button];
                    }
                }else{
                    if ([self.delegate respondsToSelector:@selector(editorStyleBarType:didClickBtn:)]) {
                        [self.delegate editorStyleBarType:self.type didClickBtn:button];
                    }
                }
            }else{
                self.blockquoteBtn.selected = NO;
                if ([self.delegate respondsToSelector:@selector(editorStyleBarType:didClickBtn:)]) {
                    [self.delegate editorStyleBarType:self.type didClickBtn:button];
                }
            }
        }
            break;
        
        default:
            break;
    }
    [self removeFromSuperview];
}


#pragma mark --
- (UIButton *)creatButtonWithImageName:(NSString *)imageName title:(NSString *)title tage:(NSInteger)tage{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn setTitle:title forState:UIControlStateNormal];
    
    if ([YPStringUtils isNotEmpty:imageName]) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setImage:[[UIImage imageNamed:imageName] imageWithGradientTintColor:MAIN_COLOR] forState:UIControlStateSelected];
    }else{
        [btn setImage:nil forState:UIControlStateNormal];
        [btn setImage:nil forState:UIControlStateSelected];
    }
    
    [btn setTitleColor:C282828_COLOR forState:UIControlStateNormal];
    [btn setTitleColor:MAIN_COLOR forState:UIControlStateSelected];

    [btn addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.tag = tage;
    btn.backgroundColor = [UIColor whiteColor];
    return btn;
}

- (void)setupWithView{
    self.fontView = [[UIView alloc] initWithFrame:self.bounds];
    self.justifyView = [[UIView alloc] initWithFrame:self.bounds];
    self.insertView = [[UIView alloc] initWithFrame:self.bounds];
    
    self.fontView.userInteractionEnabled = YES;
    self.justifyView.userInteractionEnabled = YES;
    self.insertView.userInteractionEnabled = YES;
    
    self.boldBtn = [self creatButtonWithImageName:@"editor_jiacu" title:@"" tage:500];
    self.contentBtn = [self creatButtonWithImageName:@"" title:@"正文" tage:501];
    self.titleBtn1 = [self creatButtonWithImageName:@"" title:@"标题1" tage:502];
    self.titleBtn2 = [self creatButtonWithImageName:@"" title:@"标题2" tage:503];
    self.titleBtn3 = [self creatButtonWithImageName:@"" title:@"标题3" tage:504];
    self.boldBtn.orderTag = @"bold";
    self.contentBtn.orderTag = @"h5";
    self.titleBtn1.orderTag = @"h1";
    self.titleBtn2.orderTag = @"h2";
    self.titleBtn3.orderTag = @"h3";

    
    [self.fontView addSubview:self.boldBtn];
    [self.fontView addSubview:self.contentBtn];
    [self.fontView addSubview:self.titleBtn1];
    [self.fontView addSubview:self.titleBtn2];
    [self.fontView addSubview:self.titleBtn3];
    
    for (UIButton *btn in self.fontView.subviews) {
        [self.btnArray addObject:btn];
    }
        
    [self.boldBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fontView.mas_top).offset(20);
        make.left.equalTo(self.fontView.mas_left).offset(25);
        make.height.offset(40);
        make.width.offset(((SCREEN_WIDTH - 70) / 5) * 2);
    }];
        
    [self.contentBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fontView.mas_top).offset(20);
        make.height.offset(40);
        make.right.equalTo(self.fontView.mas_right).offset(-25);
        make.left.equalTo(self.boldBtn.mas_right).offset(20);
    }];
    
    [self.titleBtn1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.boldBtn.mas_bottom).offset(13);
        make.height.offset(40);
        make.right.equalTo(self.fontView.mas_right).offset(-25);
        make.left.equalTo(self.fontView.mas_left).offset(25);
    }];
    
    [self.titleBtn2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleBtn1.mas_bottom).offset(13);
        make.height.offset(40);
        make.right.equalTo(self.fontView.mas_right).offset(-25);
        make.left.equalTo(self.fontView.mas_left).offset(25);
    }];
    
    [self.titleBtn3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleBtn2.mas_bottom).offset(13);
        make.height.offset(40);
        make.right.equalTo(self.fontView.mas_right).offset(-25);
        make.left.equalTo(self.fontView.mas_left).offset(25);
    }];
    
    
    self.leftBtn = [self creatButtonWithImageName:@"editor_duiqi_zuo" title:@"" tage:600];
    self.centerBtn = [self creatButtonWithImageName:@"editor_duiqi_zhong" title:@"" tage:601];
    self.rightBtn = [self creatButtonWithImageName:@"editor_duiqi_you" title:@"" tage:602];
    self.orderBtn = [self creatButtonWithImageName:@"editor_youxuliebiao" title:@"" tage:603];
    self.unorderBtn = [self creatButtonWithImageName:@"editor_wuxuliebiao" title:@"" tage:604];
    
    [self.justifyView addSubview:self.leftBtn];
    [self.justifyView addSubview:self.centerBtn];
    [self.justifyView addSubview:self.rightBtn];
    [self.justifyView addSubview:self.orderBtn];
    [self.justifyView addSubview:self.unorderBtn];
    self.leftBtn.orderTag = @"justifyLeft";
    self.centerBtn.orderTag = @"justifyCenter";
    self.rightBtn.orderTag = @"justifyRight";
//    self.orderBtn.orderTag = @"orderedList";
//    self.unorderBtn.orderTag = @"unorderedList";
    
    for (UIButton *btn in self.justifyView.subviews) {
        [self.btnArray addObject:btn];
    }
    
    CGFloat width = (SCREEN_WIDTH - 70) / 5;
    [self.leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.justifyView.mas_top).offset(20);
        make.left.equalTo(self.justifyView.mas_left).offset(25);
        make.height.offset(40);
        make.width.offset(width);
    }];
    
    [self.centerBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.justifyView.mas_top).offset(20);
        make.left.equalTo(self.leftBtn.mas_right).offset(0.5);
        make.height.offset(40);
        make.width.offset(width);
    }];
    
    [self.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.justifyView.mas_top).offset(20);
        make.left.equalTo(self.centerBtn.mas_right).offset(0.5);
        make.height.offset(40);
        make.width.offset(width);
    }];
    
    [self.orderBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.justifyView.mas_top).offset(20);
        make.right.equalTo(self.unorderBtn.mas_left).offset(-0.5);
        make.height.offset(40);
        make.width.offset(width);
    }];
    
    [self.unorderBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.justifyView.mas_top).offset(20);
        make.right.equalTo(self.justifyView.mas_right).offset(-25);
        make.height.offset(40);
        make.width.offset(width);
    }];
    
    
    self.horizontalRuleBtn = [self creatButtonWithImageName:@"editor_fenge" title:@"分隔符" tage:700];
    self.blockquoteBtn = [self creatButtonWithImageName:@"editor_yinyong" title:@"引用" tage:701];
    self.urlBtn = [self creatButtonWithImageName:@"editor_lianjie" title:@"超链接" tage:702];
    
    [self.insertView addSubview:self.horizontalRuleBtn];
    [self.insertView addSubview:self.blockquoteBtn];
    [self.insertView addSubview:self.urlBtn];
    self.blockquoteBtn.orderTag = @"blockquote";

    for (UIButton *btn in self.insertView.subviews) {
        [self.btnArray addObject:btn];
    }

    [self.horizontalRuleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.insertView.mas_top).offset(20);
        make.left.equalTo(self.insertView.mas_left).offset(25);
        make.right.equalTo(self.insertView.mas_right).offset(-25);
        make.height.offset(40);
    }];
    
    [self.blockquoteBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.horizontalRuleBtn.mas_bottom).offset(13);
        make.left.equalTo(self.insertView.mas_left).offset(25);
        make.height.offset(40);
        make.right.equalTo(self.insertView.mas_right).offset(-25);
    }];
    
    [self.urlBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.blockquoteBtn.mas_bottom).offset(13);
        make.left.equalTo(self.insertView.mas_left).offset(25);
        make.height.offset(40);
        make.right.equalTo(self.insertView.mas_right).offset(-25);
    }];

    [self.horizontalRuleBtn setImageLeft:15];
    [self.blockquoteBtn setImageLeft:15];
    [self.urlBtn setImageLeft:15];

}

- (void)updateFontBarWithButtonName:(NSString *)name{
    NSArray *itemNames = [name componentsSeparatedByString:@","];
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSString *orderTag in itemNames) {
            for (UIButton *btn in self.btnArray) {
                if (![tempArr containsObject:btn] && btn.orderTag.length > 0) {
                    if ([btn.orderTag isEqualToString:orderTag]) {
                        btn.selected = YES;
                        [tempArr addObject:btn];
                    }else{
                        btn.selected = NO;
                    }
                }
            }
    }
    
//    if ([name containsString:@"h1"] ||
//        [name containsString:@"h2"] ||
//        [name containsString:@"justifyCenter"] ||
//        [name containsString:@"justifyRight"] ||
//        [name containsString:@"insertOrderedList"] ||
//        [name containsString:@"insertUnorderedList"] ||
//        [name containsString:@"blockquote"]) {
//        self.contentBtn.selected = NO;
//    }else{
//        self.contentBtn.selected = YES;
//    }
    
}

@end

