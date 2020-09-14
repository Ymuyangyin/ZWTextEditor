//
//  WKWebView+ZWHackishAccessoryHiding.h
//  ZW_IOS
//
//  Created by 杨杨鹏 on 2019/12/13.
//  Copyright © 2019 杨杨鹏. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (ZWHackishAccessoryHiding)

- (void)removeInputAccessoryViewFromWKWebView:(WKWebView *)webView;

-(void)allowDisplayingKeyboardWithoutUserAction;

@end

NS_ASSUME_NONNULL_END
