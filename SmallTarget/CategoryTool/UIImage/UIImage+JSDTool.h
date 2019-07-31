//
//  UIImage+JSDTool.h
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (JSDTool)

+ (instancetype)jsd_imageNamePNG:(NSString *)namePNG;
+ (UIImage *)jsd_getImageWithColor:(UIColor *)color withSize:(CGSize)size;
+ (UIImage *)jsd_getImageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
