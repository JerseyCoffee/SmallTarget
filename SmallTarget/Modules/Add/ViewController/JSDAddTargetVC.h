//
//  JSDTargetVC.h
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDBaseViewController.h"

#import "JSDTargetManage.h"
#import "JSDTargetViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSDAddTargetVC : JSDBaseViewController

@property (strong, nonatomic, nullable) JSDTargetModel *model;
@property (assign, nonatomic) BOOL edit;

@end

NS_ASSUME_NONNULL_END
