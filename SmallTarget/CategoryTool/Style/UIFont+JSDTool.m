//
//  UIFont+JSDTool.m
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "UIFont+JSDTool.h"

static NSString* const kJSDFontName = @"Helvetica Neue";

@implementation UIFont (JSDTool)

+ (UIFont *)jsd_fontSize:(CGFloat)size {
    
    UIFont* font = [UIFont fontWithName:kJSDFontName size:size];
    
    return font;
}

@end
