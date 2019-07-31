//
//  UIButton+JSDTool.h
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (JSDTool)

/**
*  设置背景颜色
*
*  @param backgroundColor 背景颜色
*  @param state           状态
*/
- (void)jsd_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
