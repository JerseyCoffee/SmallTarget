//
//  JSDTargetViewModel.h
//  SmallTarget
//
//  Created by Jersey on 2019/8/2.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class JSDTargetModel;
@interface JSDTargetViewModel : JSDBaseModel

@property (nonatomic, strong) NSMutableArray<JSDTargetModel* >* listArray;

@end

@interface JSDTargetModel : JSDBaseModel

@property (nonatomic, copy) NSString* title;// 标题
@property (nonatomic, copy) NSString* imageView;// 图标
@property (nonatomic, copy) NSMutableArray* finishWeekDays;// 打卡时间 星期几
@property (nonatomic, copy) NSMutableArray* notificationTimes;// 提醒时间
@property (nonatomic, copy) NSString* encourage;// 鼓励语
@property (nonatomic, assign) BOOL finishStatus;// status, 是否已打开
@property (nonatomic, assign) BOOL notificationStatus;// notification, 是否开启通知

@end

NS_ASSUME_NONNULL_END
