//
//  SDCalendarVC.h
//  SmallTarget
//
//  Created by ada on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "MDCCollectionViewController.h"
#import "JSDTargetDetailVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSDCalendarVC : MDCCollectionViewController

@property (strong, nonatomic) JSDTargetModel *model;

@end

NS_ASSUME_NONNULL_END
