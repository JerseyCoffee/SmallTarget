//
//  JSDDevMacro.h
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//


#ifndef JSDDevMacro_h
#define JSDDevMacro_h

#pragma mark -- Fundation

#define JSDBundle [NSBundle mainBundle]

// Get dispatch_get_main_queue()
#define JSDMainThread (dispatch_get_main_queue())

// Get default dispatch_get_global_queue
#define JSDGlobalThread dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

// Radians convert to degress.
#define JSDRadiansToDegrees(radians) ((radians) * (180.0 / M_PI))

// Degrees convert to randians.
#define JSDDegreesToRadians(angle) ((angle) / 180.0 * M_PI)

// Fast to get iOS system version
#define JSDIOSVersion ([UIDevice currentDevice].systemVersion.floatValue)

#pragma mark - Load Image

// More easy way to load an image.
#define JSDImage(Name) ([UIImage imageNamed:Name])

// More easy to load an image from file.
#define JSDImageOfFile(Name) ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:Name ofType:@"png"]])

//weak对象，用于block，例：@weakify(self)
#ifndef    weakify
#if __has_feature(objc_arc)
#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")
#else
#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
_Pragma("clang diagnostic pop")
#endif
#endif
//strong对象，用于block，例：@strongify(self)
#ifndef    strongify
#if __has_feature(objc_arc)
#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")
#else
#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")
#endif
#endif

#endif /* JSDDevMacro_h */

