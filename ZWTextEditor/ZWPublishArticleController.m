//
//  ZWPublishArticleController.m
//  ZWTextEditor
//
//  Created by 杨杨鹏 on 2020/9/14.
//  Copyright © 2020 杨杨鹏. All rights reserved.
//

#import "ZWPublishArticleController.h"
#define UIColorFromRGB(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

@interface ZWPublishArticleController ()

@property (nonatomic, copy) NSString *draftId;

@property (nonatomic, strong) UIButton *publishBtn;

@end

@implementation ZWPublishArticleController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
//    设置默认标题
//    self.titles = @"标题";
//    设置默认内容
//    self.content = @"内容";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void) setupNav{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"icon_nav_return"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onPopSelf) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
   
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    
    UIButton *previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    previewBtn.frame = CGRectMake(0, 0, 24, 44);
    previewBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 0);
    [previewBtn setImage:[UIImage imageNamed:@"icon_publish_nav"] forState:UIControlStateNormal];
    [previewBtn addTarget:self action:@selector(onPublishClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.publishBtn.frame = CGRectMake(42, 8, 56, 28);
    [self.publishBtn.titleLabel setFont:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium]];
    [self.publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.publishBtn setBackgroundColor:UIColorFromRGB(0xe5e5e5, 1)];
    [self.publishBtn setTitleColor:UIColorFromRGB(0x999999, 1) forState:UIControlStateNormal];
    [self.publishBtn addTarget:self action:@selector(onNextClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *rightView = [[UIView alloc] init];
    rightView.frame = CGRectMake(0, 0, 100, 44);
    [rightView addSubview:previewBtn];
    [rightView addSubview:self.publishBtn];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:rightItem,nil];
    
}

#pragma mark -
//下一步
- (void)onNextClick{
    [self getWebViewEditor:^(NSString *title, NSString *content, NSString *html) {
        if ([self isEmpty:title]) {
           NSLog(@"请输入标题");
           return;
        }
        if (title.length > 25) {
            NSLog(@"标题不能超过25字");
            return;
        }
        if ([self isEmpty:html]) {
            NSLog(@"请输入文章内容");
            return;
        }
        
        
    }];
}

#pragma mark -- 预览
- (void)onPublishClick{
    [self getWebViewEditor:^(NSString *title, NSString *content, NSString *html) {
        if ([self isEmpty:title]) {
           NSLog(@"请输入标题");
           return;
        }
        if (title.length > 25) {
            NSLog(@"标题不能超过25字");
            return;
        }
        if ([self isEmpty:html]) {
            NSLog(@"请输入文章内容");
            return;
        }
    }];
}

#pragma mark -- 父类方法-标题字数变化
- (void) titleDidChangeEvents:(NSString *)title{
    if (title.length > 25 || title.length == 0) {
        [self.publishBtn setBackgroundColor:UIColorFromRGB(0xe5e5e5, 1)];
        self.publishBtn.enabled = NO;
    }else{
        [self.publishBtn setBackgroundColor:UIColorFromRGB(0xffda3e, 1)];
        self.publishBtn.enabled = YES;
    }
}

#pragma mark -- 父类方法-正文字数变化
- (void) contentDidChangeEvents:(NSString *)content{
    if (content.length >= 300) {
        [self.publishBtn setBackgroundColor:UIColorFromRGB(0xffda3e, 1)];
    }else{
        [self.publishBtn setBackgroundColor:UIColorFromRGB(0xe5e5e5, 1)];
    }
}

#pragma mark -- 返回
- (void)onPopSelf{
    [self getWebViewEditor:^(NSString *title, NSString *content, NSString *html) {
        if ([self isEmpty:title] && [self isEmpty:html]) {
            NSLog(@"不保存");
        }else{
            NSLog(@"保存到草稿箱");
        }
    }];
}


#pragma mark -- 返回

- (void)popViewSelf{
    if (self.navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -- 获取 title content html
- (void) getWebViewEditor:(void (^)(NSString *title,NSString *content,NSString *html))callback{
    static NSString *title;
    static NSString *content;
    static NSString *html;
    [self getTitleCallback:^(id  _Nullable obj, NSError * _Nullable error) {
        title = obj;
        [self getTextCallback:^(id  _Nullable obj, NSError * _Nullable error) {
            content = obj;
            [self getHTMLCallback:^(id  _Nullable obj, NSError * _Nullable error) {
                html = [[obj stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                if ([html isEqualToString:@"<p><br></p>"] || [self isEmpty:html]) {
                    html = @"";
                }else{
                    html = obj;
                }
                if (callback) {
                    callback(title,content,html);
                }
            }];
        }];
    }];
}

#pragma mark ---
- (BOOL)isEmpty:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]]) {
        if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
            return YES;
        }else if (string.length == 0){
            return YES;
        }
    }
    return NO;
}


@end
