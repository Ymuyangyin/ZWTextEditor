//
//  UIControl+ZWButtonExtension.h
//  ZW_IOS
//
//  Created by 杨杨鹏 on 2019/12/13.
//  Copyright © 2019 杨杨鹏. All rights reserved.
//

#import "UIControl+ZWButtonExtension.h"
#import <objc/runtime.h>

@implementation UIControl (ZWButtonExtension)

static const char* orderTagBy ="orderTagBy";
- (void)setOrderTag:(NSString *)orderTag{
        objc_setAssociatedObject(self, orderTagBy, orderTag, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)orderTag{
    return objc_getAssociatedObject(self, orderTagBy);
}

@end
