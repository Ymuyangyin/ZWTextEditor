//
//  NSString+ZWVJUUID.h
//  ZW_IOS
//
//  Created by 杨杨鹏 on 2019/12/13.
//  Copyright © 2019 杨杨鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZWVJUUID)

+ (NSString *)uuid;
- (id)jsonObject;

@end

NS_ASSUME_NONNULL_END
