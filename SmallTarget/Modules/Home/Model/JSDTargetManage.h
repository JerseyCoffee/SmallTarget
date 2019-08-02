//
//  JSDTargetManage.h
//  SmallTarget
//
//  Created by Jersey on 2019/8/2.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDBaseModel.h"

extern NSString* _Nonnull const kJSDTargetFilesPath;

NS_ASSUME_NONNULL_BEGIN

@interface JSDTargetManage : JSDBaseModel

- (void)addTargetModel:(JSDTargetModel* )model;
- (void)removeTargetModel:(JSDTargetModel *)model;

@property (nonatomic, strong) JSDTargetViewModel* viewModel;

@end

NS_ASSUME_NONNULL_END
