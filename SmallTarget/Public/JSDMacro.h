//
//  JSDMacro.h
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#ifndef JSDMacro_h
#define JSDMacro_h


#pragma mark -- NSLog
//只在Debug模式下执行NSLog
#ifndef __OPTIMIZE__
//#define NSLog(fmt, ...) NSLog((@"\n[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt"\n\n"), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
//#define NSLog(fmt, ...) NSLog((@"%s" fmt), __FUNCTION__, ##__VA_ARGS__)
//#define NSLog(...) {}
#else
#define NSLog(...) {}
#endif

#pragma mark -- IPHONE Device

//获得屏幕的宽高
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
//iPhoneX / iPhoneXS
#define  IsIphoneX_XS     (ScreenWidth == 375.f && ScreenHeight == 812.f ? YES : NO)
//iPhoneXR / iPhoneXSMax
#define  IsIphoneXR_XSMax    (ScreenWidth == 414.f && ScreenHeight == 896.f ? YES : NO)
//异性全面屏
#define  IsFullScreen    (isIphoneX_XS || isIphoneXR_XSMax)

// Status bar height.
#define StatusBarHeight     (isFullScreen ? 44.f : 20.f)

// Navigation bar height.
#define NavigationBarHeight  (StatusBarAndNavigationBarHeight - StatusBarHeight)

// Tabbar height.
#define TabbarHeight         (isFullScreen ? (49.f+34.f) : 49.f)

// Tabbar safe bottom margin.
#define TabbarSafeBottomMargin         (isFullScreen ? 34.f : 0.f)

// Status bar & navigation bar height.
#define StatusBarAndNavigationBarHeight  (isFullScreen ? 88.f : 64.f)

#pragma mark -- UI

#define IOS11        ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 11.0)
//屏幕属性宏
#define Screen_Width ([UIScreen mainScreen].bounds.size.width)
#define Screen_Height ([UIScreen mainScreen].bounds.size.height)
// Get the screen's bounds.
#define Screen_Bounds ([UIScreen mainScreen].bounds)
//self.view属性宏
#define View_Width (self.view.bounds.size.width)
#define View_Height (self.view.bounds.size.height)
#define IphoneScale [UIScreen mainScreen].scale

//颜色
//格式 0xdae8a6, 0.5
#define ColorWithFROMRGB(rgbValue, al)                        \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0    \
blue:((float)(rgbValue & 0xFF)) / 255.0             \
alpha:al]

//RGB颜色
#define ColorWithRGB(r,g,b) ([UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.f])
//RGBA
#define ColorRGBAWithRGBA(r, g, b, a) ([UIColor colorWithRed:(r) / 255.0  \
green:(g) / 255.0  \
blue :(b) / 255.0  \
alpha:(a)])

// get Window
#define JSDAppWindow [UIApplication sharedApplication].delegate.window

// More fast way to get app delegate
#define JSDAPPDElEGATE [[UIApplication  sharedApplication] delegate]

#pragma mark - Load Font

// Generate font with size
#define JSDFontWithSize(size) [UIFont systemFontOfSize:size]

// Generate bold font with size.
#define JSDBoldFontWithSize(size) [UIFont boldSystemFontOfSize:size]

#pragma mark - System Singletons

// More easy way to get user default object.
#define JSDUserDefaults [NSUserDefaults standardUserDefaults]

// More easy way to get NSNotificationCenter object.
#define JSDNotificationCenter  [NSNotificationCenter defaultCenter]

// More easy way to get [NSFileManager defaultManager]
#define JSDFileManager [NSFileManager defaultManager]

// More easy way to post a notification from notification center.
#define JSDPostNotificationWithName(notificationName) \
[kNotificationCenter postNotificationName:notificationName object:nil userInfo:nil]

// More easy way to post a notification with user info from notification center.
#define JSDPostNotificationWithNameAndUserInfo(notificationName, userInfo) \
[kNotificationCenter postNotificationName:notificationName object:nil userInfo:userInfo]

#pragma mark - Judge

// Judge whether it is an empty string.
#define JSDIsEmptyString(s) (s == nil || [s isKindOfClass:[NSNull class]] || ([s isKindOfClass:[NSString class]] && s.length == 0))

#define JSDIsString(s) !((s == nil || [s isKindOfClass:[NSNull class]] || ([s isKindOfClass:[NSString class]] && s.length == 0)))

// Judge whether it is a nil or null object.
#define JSDIsEmptyObject(obj) (obj == nil || [obj isKindOfClass:[NSNull class]])

// Judge whether it is a vaid dictionary.
#define JSDIsDictionary(objDict) (objDict != nil && [objDict isKindOfClass:[NSDictionary class]])

// Judge whether it is a valid array.
#define JSDIsArray(objArray) (objArray != nil && [objArray isKindOfClass:[NSArray class]])

#define JSDIsClearString(s)  ([s isEqualToString:@""] && s.length == 0)


#endif /* JSDMacro_h */
