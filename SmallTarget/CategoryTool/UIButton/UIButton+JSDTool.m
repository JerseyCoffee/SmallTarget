//
//  UIButton+JSDTool.m
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "UIButton+JSDTool.h"

@implementation UIButton (JSDTool)

- (void)jsd_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    
    [self setBackgroundImage: [UIImage jsd_getImageWithColor:backgroundColor withSize:self.frame.size] forState:state];
}

@end

