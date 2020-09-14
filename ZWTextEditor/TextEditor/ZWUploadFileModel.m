



//
//  ZWUploadFileModel.m
//  ZW_IOS
//
//  Created by 杨杨鹏 on 2019/12/13.
//  Copyright © 2019 杨杨鹏. All rights reserved.
//

#import "ZWUploadFileModel.h"

@implementation ZWUploadFileModel

- (NSString *)uuid{
    CFUUIDRef uuidRef = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, uuidRef);
    NSString *uuid = (__bridge NSString *)uuidString;
    CFRelease(uuidString);
    CFRelease(uuidRef);
    
    return uuid;
}

+ (id)jsonObject:(NSString *)jsonString
{
    NSError *error = nil;
    if (jsonString == NO) {
        //        YKLog(@"string is invalid");
        return nil;
    }
    id result = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                                options:NSJSONReadingMutableContainers
                                                  error:&error];
    if (error || [NSJSONSerialization isValidJSONObject:result] == NO)
    {
        return nil;
    }
    
    return result;
}

@end
