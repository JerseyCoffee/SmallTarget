//
//  JSDTargetDetailVC.h
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString* const kTargetCalenderShow;
extern NSString* const kTargetCalenderHide;

@interface JSDTargetDetailVC : JSDBaseViewController

@property (strong, nonatomic) JSDTargetModel *model;

@end

NS_ASSUME_NONNULL_END
