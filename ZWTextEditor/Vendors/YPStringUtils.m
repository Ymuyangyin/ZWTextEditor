//
//  YPStringUtils.m
//  SGAY_iOS
//
//  Created by 杨杨鹏 on 2018/6/11.
//  Copyright © 2018年 杨杨鹏. All rights reserved.
//

#import "YPStringUtils.h"

@implementation YPStringUtils

+ (BOOL)isEmpty:(NSString *)string {
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

+ (BOOL)isNotEmpty:(NSString *)string {
    return ![self isEmpty:string];
}

+ (BOOL)isMobile:(NSString *)string {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^1\\d{10}$"];
    return [predicate evaluateWithObject:string];
}


+ (NSDictionary *)jsonStringToDictionary:(NSString *)string{
    if (string == nil) {
        return nil;
    }
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    return dic ;
        
}

+ (NSString *)imageUrlOSSStyle:(NSString *)imageUrl{
    if ([imageUrl hasSuffix:@"_std"]) {
        imageUrl = [imageUrl substringToIndex:(imageUrl.length - 4)];
    }else if ([imageUrl hasSuffix:@"_thumb"]){
        imageUrl = [imageUrl substringToIndex:(imageUrl.length - 6)];
    }
    return imageUrl;
}

//判断字符是否包含汉字
+ (BOOL)isHasChineseString:(NSString *)string{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:string];
}

//判断是否含有表情符号 yes-有 no-没有
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (0x2100 <= hs && hs <= 0x27ff){
                returnValue =YES;
            }else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue =YES;
            }else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue =YES;
            }else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue =YES;
            }else{
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    if (ls == 0x20e3) {
                        returnValue =YES;
                    }
                }
            }
            if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50 || hs == 0xd83e) {
                returnValue =YES;
            }
            
        }
    }];
    return returnValue;
}

//是否是系统自带九宫格输入 yes-是 no-不是
+ (BOOL)isNineKeyBoard:(NSString *)string {
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++){
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}

//判断第三方键盘中的表情
+ (BOOL)hasEmoji:(NSString*)string {
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

//去除表情
+ (NSString *)disableEmoji:(NSString *)text {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, [text length]) withTemplate:@""];
    return modifiedString;
}

+ (NSString *)stringByEmptyAppendingFirstString:(NSString *)firstString secondString:(NSString *)secondString{
    NSString *string;
    if ([self isNotEmpty:secondString]) {
        if ([self isNotEmpty:firstString]) {
            string = [firstString stringByAppendingString:secondString];
        }else{
            string = secondString;
        }
    }else{
        if ([self isNotEmpty:firstString]) {
            string = firstString;
        }else{
            string = @"";
        }
    }
    
    return string;
}

//小数截断
+ (NSString*)notRounding:(float)price afterPoint:(int)position{
    
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

//小写字母转大写字母
+ (NSString *)stringToUpper:(NSString *)str{
    for (NSInteger i = 0; i < str.length; i++) {
        if ([str characterAtIndex:i] >= 'a' & [str characterAtIndex:i] <= 'z') {
            char temp = [str characterAtIndex:i] - 32;
            NSRange range = NSMakeRange(i, 1);
            str = [str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}

@end
