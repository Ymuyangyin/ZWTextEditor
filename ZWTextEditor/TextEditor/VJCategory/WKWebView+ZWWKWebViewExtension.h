//
//  WKWebView+ZWWKWebViewExtension.h
//  ZW_IOS
//
//  Created by 杨杨鹏 on 2019/12/13.
//  Copyright © 2019 杨杨鹏. All rights reserved.
//

#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface WKWebView (ZWWKWebViewExtension)
//标题
- (void)titleTextHandleCallback:(void (^)(id _Nullable obj, NSError *
                                          _Nullable error))callback;
//设置标题
- (void)setupTitle:(NSString *)title;
- (void)setTitleTips:(NSString *)titleTips;
//纯文本
- (void)contentTextHandleCallback:(void (^)(id _Nullable obj, NSError *
                                            _Nullable error))callback;
//HTML格式文本
- (void)contentHtmlTextHandleCallback:(void (^)(id _Nullable obj,
                                                NSError * _Nullable error))callback;
//设置内容
- (void)setupContent:(NSString *)content;
//内容占位符
- (void)updatePlaceHolderStatu;
- (void)placeHolderWithHidden:(BOOL)isHidden;
//下划线
- (void)setHorizontalRule;
//撤销
- (void)undo;
- (void)redo;
//加粗
- (void)bold;
//下划线
- (void)underline;
//斜体
- (void)italic;
//左对齐
- (void)justifyLeft;
//居中对齐
- (void)justifyCenter;
//右对齐
- (void)justifyRight;
- (void)indent;
- (void)outdent;
//有序列表
- (void)orderlist;
//无序列表
- (void)unorderlist;
//引用
- (void)setBlockquote;

- (void)removeFormat;
//字体
- (void)heading1;
- (void)heading2;
- (void)heading3;
- (void)heading4;
- (void)heading5;

- (void)normalFontSize;
- (void)setFontSize:(NSString *)size;
//插入链接地址
- (void)insertLinkUrl:(NSString *)url content:(NSString*)content;
//插入图片url
- (void)insertImageUrl:(NSString *)imageUrl alt:(NSString *)alt;
//获取选中内容标签值
- (void)getSelectionHandleCallback:(void (^)(id _Nullable obj, NSError *
                                                   _Nullable error))callback;
//获取webView选中内容
- (void)getSelectStringHandleCallback:(void (^)(id _Nullable obj, NSError *
                                                      _Nullable error))callback;
- (void)removeAllRange;
//清除超链接
- (void)clearLink;
/**
 *  内容最大字数限制   Id article_content
 @param maxNumber 最大字数限制
 */
- (void)setupMaxNumContent:(NSInteger)maxNumber;
//获取IMG标签
-(NSArray*)getImgTags:(NSString *)htmlText;

//光标修正
- (void)getCaretYPositionPositionHandleCallback:(void (^)(id _Nullable obj, NSError *
                                                  _Nullable error))callback;
- (void)autoScrollTop:(CGFloat)offsetY;

- (void)getContentOffsetHeight:(void (^)(id _Nullable obj, NSError *_Nullable error))callback;
//图片数组
- (void)getImageArray:(void (^)(id _Nullable url, NSError *_Nullable error))callback;

//键盘相关
- (void)titleBecomeFirstResponder;
- (void)contentBecomeFirstResponder;
- (void)hiddenKeyboard;

// padding
- (void)setPadding:(UIEdgeInsets)edge;
// 图片点击
- (void)setClickImage:(void (^)(id _Nullable obj, NSError * _Nullable error))callback;


- (void)setContentHeight:(float)contentHeight;
/***
 *  上传图片操作
 */
//插入本地图片
- (void)insetImage:(NSData *)imageData key:(NSString *)key;
//上传中
- (void)insetImageKey:(NSString *)imageKey progress:(CGFloat)progress;
//图片上传成功
- (void)insetSuccessImageKey:(NSString *)imageKey imgUrl:(NSString *)imgUrl;
//删除图片
- (void)deleteImageKey:(NSString *)key;
// 上传失败
- (void)uploadErrorKey:(NSString *)key;
- (void)removeBtnErrorKey:(NSString *)key isHide:(BOOL)isHide;

//当页面编辑区域点击失效 可尝试执行此函数解决
//设置编辑器内容是否可编辑(解决弹出键盘问题)
- (void)setupContentDisable:(BOOL)disable;


///***
// * 视频
// */
//- (void)isShowVideo:(NSInteger)show;
////插入视频封面
//- (void)insetVideoCoverImage:(NSData *)imageData timeString:(NSString *)timeString imageSize:(CGSize)imgSize;
////删除视频文件封面图
//- (void)deleteVideoImg;
//- (void)updateVideoCoverImage:(NSData *)imageData imageSize:(CGSize)imgSize;
//
//
///***
// * 视频
// */
//- (void)isShowAudio:(NSInteger)show;
//- (void)insetAudioURL:(NSString *)audioURL;
//- (NSString *)createAudioHtml:(NSString *)audioURL;
////音频样式调整
//- (void)uploadAudioStatu:(NSInteger)statu percent:(NSInteger)percent;


//获取HTML所有
//- (NSString *)innerHTML;
@end




@interface WKWebView (WGHideAccessoryView)
//隐藏webview输入键盘toolbar
@property (nonatomic, assign) BOOL hidesInputAccessoryView;
@end

NS_ASSUME_NONNULL_END
