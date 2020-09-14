//
//  NSString+ZWVJUUID.h
//  ZW_IOS
//
//  Created by 杨杨鹏 on 2019/12/13.
//  Copyright © 2019 杨杨鹏. All rights reserved.
//

#import "NSString+ZWVJUUID.h"

@implementation NSString (ZWVJUUID)

+ (NSString *)uuid {
    CFUUIDRef uuidRef = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, uuidRef);
    NSString *uuid = (__bridge NSString *)uuidString;
    CFRelease(uuidString);
    CFRelease(uuidRef);
    
    return uuid;
}

-(id)jsonObject{
    NSError *error = nil;
    if (!self) {
        return nil;
    }
    id result = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                                                options:NSJSONReadingMutableContainers
                                                  error:&error];
    if (error || [NSJSONSerialization isValidJSONObject:result] == NO){
        return nil;
    }
    return result;
}
-(NSString*)stringByAppendingUrlComponent:(NSString*)string{
    NSString* urlhost = [self toTrim];
    if([string isBeginWith:@"/"]){
        if([urlhost isEndWith:@"/"]){
            urlhost = [urlhost substringToIndex:urlhost.length - 1];
        }
    }else{
        if([urlhost isEndWith:@"/"] == NO){
            urlhost = [urlhost stringByAppendingString:@"/"];
        }
    }
    return [urlhost stringByAppendingString:string];
}
-(BOOL)isBeginWith:(NSString *)string{
    return ([self hasPrefix:string]) ? YES : NO;
}
-(BOOL)isEndWith:(NSString *)string{
    return ([self hasSuffix:string]) ? YES : NO;
}
-(NSString*)toTrim{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

@end
