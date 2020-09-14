//
//  ZSSRichTextEditor.h
//  ZW_IOS
//
//  Created by 杨杨鹏 on 2019/12/13.
//  Copyright © 2019 杨杨鹏. All rights reserved.
//

#import "ZSSRichTextEditor.h"
#import <JavaScriptCore/JavaScriptCore.h>

#import "ZWEditorBar.h"
#import "ZWEditorStyleBar.h"

#import "WKWebView+ZWWKWebViewExtension.h"
#import "WKWebView+ZWHackishAccessoryHiding.h"
#import "NSString+ZWVJUUID.h"

#import "YPPhotoPicker.h"
#import "ZWUploadFileModel.h"


#define WG_SafeAreaTopHeight ((SCREEN_HEIGHT == 812.0 || SCREEN_HEIGHT == 896.0 )? 88 : 64)
#define IS_IPhoneX_All ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)


@interface ZSSRichTextEditor ()<ZWEditorBarDelegate,ZWEditorStyleBarDelegate,WKNavigationDelegate,WKUIDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,WKScriptMessageHandler>

@property (nonatomic,strong) ZWEditorBar *toolBarView;
@property (nonatomic,strong) ZWEditorStyleBar *styleBar;
@property (nonatomic, strong) YPPhotoPicker *photoPicker;
@property (nonatomic,strong) NSMutableArray <ZWUploadFileModel *> *uploadArr;

@property (nonatomic,assign) CGFloat keboardHeight;

@property (nonatomic,strong) WKWebView *webView;


@end

@implementation ZSSRichTextEditor
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if (@available(iOS 11.0, *)) {
//        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }else{
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    //防止导航出现色差
    self.navigationController.navigationBar.translucent = NO;
    //防止偏移
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //添加webview
    [self configBaseWebView];
    
    //添加工具条
    [self configToolBar];
    
    //键盘高度处理
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)configBaseWebView{
    //添加WebView加载HTML
    [self.view addSubview:self.webView];

    NSString * htmlCont = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"RichEditor.html" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [self.webView loadHTMLString:htmlCont baseURL:baseURL];
    
}
- (void)getTitleCallback:(void (^)(id _Nullable obj, NSError * _Nullable error))callback{
    if ([self isUploadResult]) {
        [self.view showMessage:@"图片未上传成功"];
        return;
    }
    [self.webView titleTextHandleCallback:^(id  _Nullable obj, NSError * _Nullable error) {
        YPLog(@"title ==  %@",obj);
        if (callback) {
            callback(obj,error);
        }
    }];
    
}
- (void)getTextCallback:(void (^)(id _Nullable obj, NSError * _Nullable error))callback{
    if ([self isUploadResult]) {
        [self.view showMessage:@"图片未上传成功"];
        return;
    }
    [self.webView contentTextHandleCallback:^(id  _Nullable obj, NSError * _Nullable error) {
        YPLog(@"content ==  %@",obj);
        if (callback) {
            callback(obj,error);
        }
    }];
}
- (void)getHTMLCallback:(void (^)(id _Nullable obj, NSError * _Nullable error))callback{
    if ([self isUploadResult]) {
        [self.view showMessage:@"图片未上传成功"];
        return;
    }
    [self.webView contentHtmlTextHandleCallback:^(id  _Nullable obj, NSError * _Nullable error) {
        YPLog(@"html ==  %@",obj);
        if (callback) {
            callback(obj,error);
        }
    }];
}
- (void)configToolBar{
    
    if (self.toolBarView == nil) {
        self.toolBarView = [ZWEditorBar editorBar];
        CGFloat toolBarH = 50;

        self.toolBarView.frame = CGRectMake(0,SCREEN_HEIGHT - toolBarH - WG_SafeAreaTopHeight, SCREEN_WIDTH, toolBarH);
        self.toolBarView.backgroundColor = [UIColor whiteColor];
    }
    
    //添加工具条
    self.toolBarView.delegate = self;
    [self.view addSubview:self.toolBarView];

}




#pragma mark -- WKWebViewDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
- (void)webView:(WKWebView*)webView decidePolicyForNavigationAction:(WKNavigationAction*)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler{
    NSString *urlString = navigationAction.request.URL.absoluteString;
    
    YPLog(@"decidePolicyForNavigationAction = %@",urlString);
    [self.webView updatePlaceHolderStatu];
    [self fontBarUpdateWithString:urlString];
    [self handleWithString:urlString];
    
    WeakSelf(self);
    [webView getCaretYPositionPositionHandleCallback:^(id  _Nullable obj, NSError * _Nullable error) {
        CGFloat currentPos = [obj floatValue];
        if (currentPos  > SCREEN_HEIGHT - weakself.keboardHeight - 49) {
            [weakself.webView autoScrollTop:currentPos+weakself.toolBarView.yp_height];
        }
    }];

    decisionHandler(WKNavigationActionPolicyAllow); // 必须实现 加载
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if ([YPStringUtils isNotEmpty:self.titles]) {
        [webView setupTitle:self.titles];
    }
    if ([YPStringUtils isNotEmpty:self.content]) {
        [webView setupContent:self.content];
        [webView placeHolderWithHidden:YES];
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
}
#pragma mark -- 当前css
- (void)fontBarUpdateWithString:(NSString *)urlString{
    if ([urlString rangeOfString:@"re-state-content://"].location != NSNotFound) {
        NSString *className = [urlString stringByReplacingOccurrencesOfString:@"re-state-content://" withString:@""];
        
        [self.styleBar updateFontBarWithButtonName:className];
        
        if ([[className componentsSeparatedByString:@","] containsObject:@"blockquote"]) {
//            [self.webView placeHolderWithHidden:YES];
        }
    }
}
#pragma mark -- 输入
- (void)handleEvent:(NSString *)urlString{
    BOOL isEditorTitle = [urlString hasPrefix:@"re-state-title://"] || [urlString hasPrefix:@"re-title-callback"];
    self.styleBar.hidden = isEditorTitle;
    self.toolBarView.hidden = isEditorTitle;
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
    YPLog(@"name  = %@",message.name);
    //在这里截取H5调用的本地方法
    if ([message.name isEqualToString:@"titleChange"]){
        [self titleDidChangeEvents:[self removeQuotesFromHTML:[message.body objectForKey:@"body"]]];
    }else if ([message.name isEqualToString:@"contentChange"]){
        [self contentDidChangeEvents:[self removeQuotesFromHTML:[message.body objectForKey:@"body"]]];
    }
}

#pragma mark-- 标题监听
- (void)titleDidChangeEvents:(NSString *)title{
    
}
#pragma mark -- 正文监听
- (void)contentDidChangeEvents:(NSString *)content{
    
}

- (NSString *)removeQuotesFromHTML:(NSString *)html {
    html = [html stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    html = [html stringByReplacingOccurrencesOfString:@"“" withString:@"&quot;"];
    html = [html stringByReplacingOccurrencesOfString:@"”" withString:@"&quot;"];
    html = [html stringByReplacingOccurrencesOfString:@"\r"  withString:@"\\r"];
    html = [html stringByReplacingOccurrencesOfString:@"\n"  withString:@"\\n"];
    return html;
}

#pragma mark -- 图片操作
- (BOOL)handleWithString:(NSString *)urlString{
    if ([urlString hasPrefix:@"protocol://iOS?code=uploadResult&data="]){
        //获取当前
          NSRange range = [urlString rangeOfString:@"protocol://iOS?code=uploadResult&data="];
      
        NSString *dictString = [urlString substringFromIndex:range.length];
        
        YPLog(@"截取后：%@",dictString);
        NSDictionary *dict = [ZWUploadFileModel jsonObject:[dictString stringByRemovingPercentEncoding]];
        if(dict[@"imgId"]) {
            YPLog(@"click = %@",dict[@"imgId"]);
//            ZWUploadFileModel *imgM = [self fileModelWithKey:dict[@"imgId"]];
//            if(imgM.state == ZWUploadFileStateError){
//                [self actionSheetWitType:1 handleFileM:imgM];
//            }else if(imgM.state == ZWUploadFileStateSuccess){
//                [self actionSheetWitType:2 handleFileM:imgM];
//            }
        }
        return NO;
    }
    return YES;
}

- (void)actionSheetWitType:(NSInteger)type handleFileM:(ZWUploadFileModel *)fileM{
    
    NSString *btnTitle = type == 1?@"重新上传":@"删除";
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:@"操作提示" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (type == 1) {
            //移除失败样式
            [self.webView removeBtnErrorKey:fileM.key isHide:TRUE];
            //重传
            WeakSelf(self);
//            [ZWOSSImageUploader asyncEditorUploadImageArray:@[fileM] complete:^(NSString * _Nonnull key, float percent, NSString *url,BOOL isFirst, NSError * _Nullable error) {
//                ZWUploadFileModel *fileModel = [weakself fileModelWithKey:key];
//                if (isFirst) {
//                    WeakSelf(self);
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self.webView insetImageKey:fileModel.key progress:percent];
//                    });
//                   [self.webView getCaretYPositionPositionHandleCallback:^(id  _Nullable obj, NSError * _Nullable error) {
//                       CGFloat currentPos = [obj floatValue];
//                       if (currentPos  > SCREEN_HEIGHT - weakself.keboardHeight - 49) {
//                           [weakself.webView autoScrollTop:currentPos+weakself.toolBarView.yp_height];
//                       }
//                   }];
//                }
//
//                if (percent == 0 || error){
//                    fileModel.state = ZWUploadFileStateError;
//                    [weakself.webView uploadErrorKey:fileModel.key];
//                }else if (url){
//                    fileModel.state = ZWUploadFileStateSuccess;
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self.webView insetSuccessImageKey:fileModel.key imgUrl:url];
//                    });
//                }else{
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self.webView insetImageKey:fileModel.key progress:percent];
//                    });
//                }
//            }];
        }else{
            //删除
            [self.webView deleteImageKey:fileM.key];
            
            [self.uploadArr enumerateObjectsUsingBlock:^(ZWUploadFileModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([fileM.key isEqualToString:obj.key]) {
                    [self.uploadArr removeObject:fileM];
                    *stop = YES;
                }
            }];
        }
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addAction:okAction];
    [alertVc addAction:cancelAction];
    
    [self presentViewController:alertVc animated:YES completion:^{
        [self.webView setupContentDisable:TRUE];
    }];
}

#pragma mark -editorbarDelegate
- (void)editorBar:(ZWEditorBar *)editorBar didClickIndex:(NSInteger)buttonIndex{
    if (buttonIndex != 0 && self.toolBarView.transform.ty >= 0  ) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.webView contentBecomeFirstResponder];
        });
    }
    switch (buttonIndex) {
        case 0:{//键盘
            if (self.toolBarView.transform.ty < 0) {
                [self.webView hiddenKeyboard];
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.webView contentBecomeFirstResponder];
                });
            }
        }
            break;
        case 1:{//字体
            self.styleBar.type = ZWEditorStyleBarFont;
            for(UIView* window in [UIApplication sharedApplication].windows){
                if([window isKindOfClass:NSClassFromString(@"UIRemoteKeyboardWindow")]){
                    [window addSubview:self.styleBar];
                }
            }
        }
            break;
            
        case 2:{//缩进
            self.styleBar.type = ZWEditorStyleBarJustify;
            for(UIView* window in [UIApplication sharedApplication].windows){
                if([window isKindOfClass:NSClassFromString(@"UIRemoteKeyboardWindow")]){
                    [window addSubview:self.styleBar];
                }
            }
        }
            break;
       
        case 3:{//图片
            [self insertImageFromDevice];
        }
            break;
        case 4:{//插入
            self.styleBar.type = ZWEditorStyleBarInsert;
            for(UIView* window in [UIApplication sharedApplication].windows){
                if([window isKindOfClass:NSClassFromString(@"UIRemoteKeyboardWindow")]){
                    [window addSubview:self.styleBar];
                }
            }
        }
            break;
        case 5:{//后退
            [self.webView undo];
        }
            break;
        case 6:{//前进
            [self.webView redo];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - ZWEditorStyleBarDelegate
- (void)editorStyleBarType:(ZWEditorStyleBarType)type didClickBtn:(UIButton *)button{
    switch (type) {
        case ZWEditorStyleBarFont:{
            [self.toolBarView viewWithTag:200].hidden = YES;

            switch (button.tag - 500) {
                case 0:{//粗体
                    [self.webView bold];
                }
                    break;
                case 1:{//正文 16 14-2 18-4
//                    [self.editorView setFontSize:@"3"];
//                    [self.editorView setFontWeight:@"normal"];
                    [self.webView heading5];
                }
                    break;
                case 2:{//标题1
                    [self.webView heading1];
                }
                    break;
                case 3:{//标题2
                    [self.webView heading2];
                }
                    break;
                case 4:{//标题3
                    [self.webView heading3];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case ZWEditorStyleBarJustify:{
            [self.toolBarView viewWithTag:201].hidden = YES;

            switch (button.tag - 600) {
                case 0:{//左对齐
                    [self.webView justifyLeft];
                }
                    break;
                case 1:{//居中对齐
                    [self.webView justifyCenter];
                }
                    break;
                case 2:{//右对齐
                    [self.webView justifyRight];
                }
                    break;
                case 3:{//有序
                    [self.webView orderlist];
                }
                    break;
                case 4:{//无序
                    [self.webView unorderlist];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case ZWEditorStyleBarInsert:{
            [self.toolBarView viewWithTag:202].hidden = YES;

            switch (button.tag - 700) {
                case 0:{//分隔符
                    [self.webView setHorizontalRule];
                }
                    break;
                case 1:{//引用
                    [self.webView setBlockquote];
                }
                    break;
                case 2:{//超链接
                    [self insertLink];
                }
                    break;
                default:
                    break;
            }
        }
            break;
    
        default:
            break;
    }
    self.toolBarView.fontButton.selected = NO;
    self.toolBarView.justifyButton.selected = NO;
    self.toolBarView.insertButton.selected = NO;
}

- (void)removeSelectNomarl{
    [self.styleBar removeFromSuperview];
}

#pragma mark - ZWEditorStyleBarDelegate
- (void)editorStyleBarResetNormalType:(ZWEditorStyleBarType)type didClickBtn:(UIButton *)button{
    if (type == ZWEditorStyleBarFont && button.tag == 500) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.webView bold];
        });
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.webView heading5];
        });
    }
    switch (type) {
        case ZWEditorStyleBarFont:
            [self.toolBarView viewWithTag:200].hidden = YES;
            break;
        case ZWEditorStyleBarJustify:
            [self.toolBarView viewWithTag:201].hidden = YES;
            break;
        case ZWEditorStyleBarInsert:
            [self.toolBarView viewWithTag:202].hidden = YES;
            break;
        default:
            break;
    }
    self.toolBarView.fontButton.selected = NO;
    self.toolBarView.justifyButton.selected = NO;
    self.toolBarView.insertButton.selected = NO;
}



#pragma mark - 插入链接
- (void)insertLink {
    WeakSelf(self);
    [self.webView getSelectStringHandleCallback:^(id  _Nullable obj, NSError * _Nullable error) {
        if (error == nil) {
            NSString *selectionStr = obj;
            if (selectionStr.length > 0) {
                
                [self.webView getSelectionHandleCallback:^(id  _Nullable obj, NSError * _Nullable error) {
                   
                    if (error == nil) {
                        NSString *tagStr = obj;
                        if ([tagStr isEqualToString:@"A"]) {
                            [self.webView clearLink];
                        }else{
                            [self alertEditorTextFieldSender:self content:selectionStr callback:^(NSString *content, NSString *url) {
                                if ([YPStringUtils isEmpty:url]) {
                                    [weakself.view showMessage:@"链接地址不能为空"];
                                    return;
                                }
                                [self.webView insertLinkUrl:url content:content];
                                [self.webView contentBecomeFirstResponder];
                            }];
                        }
                    }
                }];
            }else{
                if (!self.toolBarView.keyboardButton.selected){
                    [self.webView contentBecomeFirstResponder];
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self alertEditorTextFieldSender:self content:nil callback:^(NSString *content, NSString *url) {
                        if ([YPStringUtils isEmpty:url]) {
                            [weakself.view showMessage:@"链接地址不能为空"];
                            return;
                        }
                        [self.webView insertLinkUrl:url content:content];
                        [self.webView contentBecomeFirstResponder];
                    }];
                });
            }
        }
    }];
}

#pragma mark - 插入图片
- (void)insertImageFromDevice {
    WeakSelf(self);
    self.photoPicker.maxImagesCount = 9;
    [self.photoPicker startWithCallback:^(NSArray<UIImage *> *pickedImage, NSArray<PHAsset *> *assets) {
        if (pickedImage.count == 0) {
            return ;
        }
        for (UIImage *image in pickedImage) {
            ZWUploadFileModel *fileModel = [[ZWUploadFileModel alloc] init];
            fileModel.fileData = UIImageJPEGRepresentation(image, 0.8f);
            fileModel.image = image;
            fileModel.key = fileModel.uuid;
            [weakself.uploadArr addObject:fileModel];
            [weakself.webView insetImage:fileModel.fileData key:fileModel.key];
        }
//        [ZWOSSImageUploader asyncEditorUploadImageArray:weakself.uploadArr complete:^(NSString * _Nonnull key, float percent, NSString *url,BOOL isFirst, NSError * _Nullable error) {
//            ZWUploadFileModel *fileModel = [weakself fileModelWithKey:key];
//            if (isFirst) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.webView insetImageKey:fileModel.key progress:percent];
//                });
//               
//            }
//            if (error){
//                fileModel.state = ZWUploadFileStateError;
//                [weakself.webView uploadErrorKey:fileModel.key];
//            }else if (url){
//                fileModel.state = ZWUploadFileStateSuccess;
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.webView insetSuccessImageKey:fileModel.key imgUrl:url];
//                });
//            }else if (percent > 0 && percent < 1){
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.webView insetImageKey:fileModel.key progress:percent];
//                });
//            }
//        }];
    } sender:self];
}

#pragma mark --返回对应的模型
- (ZWUploadFileModel *)fileModelWithKey:(NSString *)key{
    if(self.uploadArr.count<=0) return nil;
    ZWUploadFileModel *upfileM;
    for (ZWUploadFileModel *fileM in self.uploadArr) {
        if([fileM.key isEqualToString:key]){
            upfileM = fileM;
            break;
        }
    }
    return upfileM;
}
#pragma mark --判断是否有上传失败的图片
- (BOOL)isUploadResult{
    if (self.uploadArr <= 0) {
        return NO;
    }
    BOOL result = NO;
    for (ZWUploadFileModel *fileM in self.uploadArr) {
        if (fileM.state != ZWUploadFileStateSuccess) {
            result = YES;
            break;
        }
    }
    return result;
}

#pragma mark --删除图片的对应模型
- (void)removePicture:(ZWUploadFileModel *)upFile{
    [self.uploadArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZWUploadFileModel *fileM = obj;
        if ([fileM.key isEqualToString:upFile.key]) {
            [self.uploadArr removeObject:fileM];
        }
    }];
}

- (void)dealloc{
    YPLog(@"%@ dealloc",self);
    [self clearOutPut];
    [[NSNotificationCenter defaultCenter]removeObserver:self];;
}
- (void)clearOutPut{
    if (_webView) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    }
    @try {
        [self.toolBarView removeObserver:self forKeyPath:@"transform"];
    } @catch (NSException *exception){
        YPLog(@"Exception: %@", exception);
    } @finally {
        // Added to show finally works as well
    }
//    [_timer invalidate];
//    _timer = nil;
//    _ctx = nil;
}
#pragma mark --键盘
- (void)keyBoardWillChangeFrame:(NSNotification*)notification{
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keboardHeight = frame.size.height;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    CGFloat toolBarHeight = self.toolBarView.frame.size.height;
    if (frame.origin.y == SCREEN_HEIGHT) {
        [UIView animateWithDuration:duration animations:^{
            self.toolBarView.transform =  CGAffineTransformIdentity;

            self.toolBarView.keyboardButton.selected = NO;
            [self.toolBarView.keyboardButton setImage:[UIImage imageNamed:@"editor_jianpan_up"] forState:UIControlStateNormal];
            [self.webView setYp_height:SCREEN_HEIGHT - 50];
        }];
    }else{
        [UIView animateWithDuration:duration animations:^{
            self.toolBarView.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);

            self.toolBarView.keyboardButton.selected = NO;
            [self.toolBarView.keyboardButton setImage:[UIImage imageNamed:@"editor_jianpan_down"] forState:UIControlStateNormal];
            [self.webView setYp_height:SCREEN_HEIGHT - frame.size.height - 50 - KTabHeight];
            self.styleBar.frame = CGRectMake(0, frame.origin.y, self.view.frame.size.width, self.keboardHeight);
        }];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"URL"] ){
        
        NSString *urlString = self.webView.URL.absoluteString;
        NSLog(@"URL------%@",urlString);
        if ([urlString containsString:@"re-state"]) {
            [self handleEvent:urlString];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - 懒加载
- (WKWebView *)webView{
    if (_webView == nil) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        WKUserContentController *userCon = [[WKUserContentController alloc]init];
        config.userContentController = userCon;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50) configuration:config];
        [userCon addScriptMessageHandler:self name:@"titleChange"];
        [userCon addScriptMessageHandler:self name:@"contentChange"];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        [_webView removeInputAccessoryViewFromWKWebView:_webView];
        [_webView allowDisplayingKeyboardWithoutUserAction];
        _webView.scrollView.bounces = NO;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.bounces = NO;
        _webView.hidesInputAccessoryView = YES;
        [_webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];

    }
    return _webView;
}
- (ZWEditorStyleBar *)styleBar{
    if (!_styleBar) {
        _styleBar = [[ZWEditorStyleBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.toolBarView.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.toolBarView.frame)) delegate:self];
    }
    return _styleBar;
}

#pragma mark 图片选择器

- (YPPhotoPicker *)photoPicker{
    if (!_photoPicker) {
        _photoPicker = [[YPPhotoPicker alloc]init];
    }
    return _photoPicker;
}
- (NSMutableArray <ZWUploadFileModel *> *)uploadArr{
    if (_uploadArr == nil) {
        _uploadArr = [NSMutableArray array];
    }
    return _uploadArr;
}

- (void)alertEditorTextFieldSender:(UIViewController *)sender content:(NSString *)content callback:(void (^)(NSString *content,NSString *url))callback{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"插入链接" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *contentTextField = [alert.textFields objectAtIndex:0];
        UITextField *urlTextField = [alert.textFields objectAtIndex:1];
        if (callback) {
            callback(contentTextField.text,urlTextField.text);
        }
    }];
    [okAction setValue:MAIN_COLOR forKey:@"titleTextColor"];
    [alert addAction:okAction];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"链接文字";
        if (content) {
            textField.text = content;
        }
        textField.clearButtonMode = UITextFieldViewModeAlways;
        textField.secureTextEntry = NO;
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"链接URL";
        textField.rightViewMode = UITextFieldViewModeAlways;
        textField.clearButtonMode = UITextFieldViewModeAlways;
    }];
    
    [sender presentViewController:alert animated:YES completion:nil];
}

@end
