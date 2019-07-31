//
//  UIColor+JSDTool.h
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (JSDTool)

+ (UIColor *)jsd_colorWithHexString:(NSString *)color; //颜色字符串转换为颜色

+ (UIColor *)jsd_grayColor;
+ (UIColor *)jsd_tealcolor;
+ (UIColor *)jsd_skyBluecolor;
+ (UIColor *)jsd_mainBlueColor;

#pragma mark -Text Color

+ (UIColor *)jsd_mainTextColor;
+ (UIColor *)jsd_minorTextColor;
+ (UIColor *)jsd_detailTextColor;

#pragma mark - Title Color

+ (UIColor *)jsd_mainBlackColor;
+ (UIColor *)jsd_subTitleColor;

+ (UIColor *)jsd_mainGrayColor;

+ (CAGradientLayer *)jsd_setGradualChangeView:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;

@end

NS_ASSUME_NONNULL_END
