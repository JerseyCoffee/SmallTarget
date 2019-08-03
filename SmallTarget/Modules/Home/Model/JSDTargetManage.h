//
//  JSDTargetManage.h
//  SmallTarget
//
//  Created by Jersey on 2019/8/2.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDBaseModel.h"

#import "JSDTargetViewModel.h"

extern NSString* _Nonnull const kJSDTargetFilesPath;

NS_ASSUME_NONNULL_BEGIN

@interface JSDTargetManage : JSDBaseModel

+ (instancetype)sharedInstance;
- (void)addTargetModel:(JSDTargetModel* )model;
- (void)removeTargetModel:(JSDTargetModel *)model;
- (void)editTargetModel:(JSDTargetModel *)model;
- (void)finishTargetModel:(JSDTargetModel* )model;
- (void)cancelFnishTargetModel:(JSDTargetModel *)model;
- (BOOL)checkoutFinishStatus:(JSDTargetModel*)model;
- (BOOL)checkoutFinishStatus:(JSDTargetModel*)model yearMonthDay:(NSString *)yearMonthDay;

- (BOOL)checkContainsTargetTitle:(NSString *)title;

@property (nonatomic, strong) JSDTargetViewModel* viewModel;

@property (copy, nonatomic) NSString *yearMonthDay; //年-月-日

@end

NS_ASSUME_NONNULL_END
