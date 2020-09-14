//
//  YPStringUtils.h
//  SGAY_iOS
//
//  Created by 杨杨鹏 on 2018/6/11.
//  Copyright © 2018年 杨杨鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPStringUtils : NSObject

+ (BOOL)isEmpty:(NSString *)string;

+ (BOOL)isNotEmpty:(NSString *)string;

+ (BOOL)isMobile:(NSString *)string;


/// 图片 oss样式转换
+ (NSString *)imageUrlOSSStyle:(NSString *)imageUrl;


//json转字典
+ (NSDictionary *)jsonStringToDictionary:(NSString *)string;

//判断是否含有表情符号 yes-有 no-没有
+ (BOOL)stringContainsEmoji:(NSString *)string;

//是否是系统自带九宫格输入 yes-是 no-不是
+ (BOOL)isNineKeyBoard:(NSString *)string;

//判断第三方键盘中的表情
+ (BOOL)hasEmoji:(NSString*)string;

//去除表情
+ (NSString *)disableEmoji:(NSString *)text;


/**
 //判断字符是否包含汉字
 */
+ (BOOL)isHasChineseString:(NSString *)string;

/**
 拼接字符串，判断是否为空

 @param firstString  字符串
 @return 拼接的字符v串
 */
+ (NSString *)stringByEmptyAppendingFirstString:(NSString *)firstString secondString:(NSString *)secondString;


/**
 小数截断

 @param price 小数
 @param position 小数后保留的位数
 */
+ (NSString*)notRounding:(float)price afterPoint:(int)position;


/**
 小写字母转大写字母
 */
+ (NSString *)stringToUpper:(NSString *)str;
@end
