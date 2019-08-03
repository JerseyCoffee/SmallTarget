//
//  JSDSelectedImageView.h
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSDSelectedImageView : UIView

@property (strong, nonatomic, nullable) UIButton *lastButton; //选中的按钮
- (void)setupLastButton:(NSInteger)imageIndex;

@end

NS_ASSUME_NONNULL_END
