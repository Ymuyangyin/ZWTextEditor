//
//  AppMacro.h
//  ZWTextEditor
//
//  Created by 杨杨鹏 on 2020/9/14.
//  Copyright © 2020 杨杨鹏. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

// 字体大小
#define UISystemFont(F) [UIFont systemFontOfSize:F]
#define UIBoldSystemFont(F) [UIFont boldSystemFontOfSize:F]
#define UIMediumSystemFont(F) [UIFont systemFontOfSize:F weight:UIFontWeightMedium]
#define UIHeavySystemFont(F) [UIFont systemFontOfSize:F weight:UIFontWeightHeavy]
#define UISystemFontAndName(F,Str) [UIFont fontWithName:[NSString stringWithFormat:@"PingFangSC-%@",Str] size:F]
#define UISystemMediumFont(F) [UIFont fontWithName:[NSString stringWithFormat:@"PingFangSC-Medium"] size:F]
#define UIPFSCMediumFont(F) [UIFont fontWithName:[NSString stringWithFormat:@"PingFangSC-Medium"] size:F]
#define UIPFSCBoldFont(F) [UIFont fontWithName:[NSString stringWithFormat:@"PingFangSC-Bold"] size:F]
#define UIPFSCRegularFont(F) [UIFont fontWithName:[NSString stringWithFormat:@"PingFangSC-Regular"] size:F]

// 屏幕宽度
#ifndef SCREEN_BOUNDS
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#endif
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


//iPhoneX

#define ISiPhoneX (SCREEN_WIDTH >= 375.0f && SCREEN_HEIGHT >= 812.0f)

#define ISiPhone5s (SCREEN_WIDTH == 320.0f && SCREEN_HEIGHT == 568.0f)

//64
#define KNavHeight (ISiPhoneX ? 88.f : 64.f)
#define KTabHeight (ISiPhoneX ? (49.f + 34.f) : 49.f)
#define KNav_HEIGHT (ISiPhoneX ? 24.f : 0.f)
#define KTab_HEIGHT (ISiPhoneX ? 34.f : 0.f)

//NSLog
#ifdef DEBUG
#define YPLog(s,...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String] )
#else
#define YPLog(s,...)
#endif

//弱引用
#define WeakSelf(type)  __weak typeof(type) weak##type = type;

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define UIColorFromRGB(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

//颜色值
#define MAIN_COLOR UIColorFromRGB(0xffda3e, 1)
#define C282828_COLOR UIColorFromRGB(0xc282828, 1)


#endif /* AppMacro_h */
