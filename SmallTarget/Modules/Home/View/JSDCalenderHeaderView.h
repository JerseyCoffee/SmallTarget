//
//  JSDCalenderHeaderView.h
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JSDCalenderHeaderViewDelegate <NSObject>

- (void)onTouchCalenderHeaderViewIndex:(NSInteger)index;

@end

@interface JSDCalenderHeaderView : UIView

@property (nonatomic, weak) id<JSDCalenderHeaderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
