//
//  UIColor+JSDTool.m
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "UIColor+JSDTool.h"

@implementation UIColor (JSDTool)

+ (UIColor *)jsd_mainGrayColor {
    
    return [UIColor jsd_colorWithHexString:@"#f5f4f9"];
}

+ (UIColor *)jsd_grayColor {
    
    return [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
}

+ (UIColor *)jsd_tealcolor {
    
    return [UIColor jsd_colorWithHexString:@"#1AAA8C"];
}

+ (UIColor *)jsd_skyBluecolor {
    
    return [UIColor jsd_colorWithHexString:@"#1296db"];
}

+ (UIColor *)jsd_mainBlueColor {
    
    return [UIColor jsd_colorWithHexString:@"#2EA2F5"];
}

#pragma mark -- Text Color

+ (UIColor *)jsd_mainTextColor {
    
    return [UIColor colorWithRed:30/255.0 green:23/255.0 blue:13/255.0 alpha:1.0];
}

+ (UIColor *)jsd_minorTextColor {
    
    return [UIColor colorWithRed:113/255.0 green:120/255.0 blue:130/255.0 alpha:1.0];
}

+ (UIColor *)jsd_detailTextColor {
    
    return [UIColor colorWithRed:113/255.0 green:120/255.0 blue:130/255.0 alpha:1.0];
}

#pragma mark - Title Color

+ (UIColor *)jsd_mainBlackColor {
    
    return [UIColor jsd_colorWithHexString:@"#333333"];
}

+ (UIColor *)jsd_subTitleColor {
    
    return [UIColor jsd_colorWithHexString:@"#999999"];
}

//绘制渐变色颜色的方法
+ (CAGradientLayer *)jsd_setGradualChangeView:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr{
    
    // CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    //  https://juejin.im/post/5a30f53e51882554b8378b0b
    //    gradientLayer.colors = @[(__bridge id)[UIColor bfx_colorWithHexString:fromHexColorStr].CGColor,(__bridge id)[UIColor bfx_colorWithHexString:toHexColorStr].CGColor];
    gradientLayer.colors = @[(__bridge id)[UIColor whiteColor].CGColor, (__bridge id)[UIColor blackColor].CGColor];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    
    //    gradientLayer.startPoint = CGPointMake(0, 0);
    //    gradientLayer.endPoint = CGPointMake(1, 1);
    
    //    gradientLayer.startPoint = CGPointMake(0, 1);
    //    gradientLayer.endPoint = CGPointMake(1, 1);
    //
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    //    gradientLayer.startPoint = CGPointMake(0, 0);
    //    gradientLayer.endPoint = CGPointMake(1, 0);
    
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0.0,@1.0];
    
    return gradientLayer;
}

+ (UIColor *)jsd_colorWithHexString:(NSString *)color {
    
    //需要先判断color是否为空或null
    if (color == nil || color == NULL) {
        return [UIColor clearColor];;
    }
    if ([color isKindOfClass:[NSNull class]]) {
        return [UIColor clearColor];;
    }
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0) green:((float) g / 255.0) blue:((float) b / 255.0) alpha:1.0];
    
}


@end
