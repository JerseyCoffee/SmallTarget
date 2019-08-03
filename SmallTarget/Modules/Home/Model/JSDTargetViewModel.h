//
//  JSDTargetViewModel.h
//  SmallTarget
//
//  Created by Jersey on 2019/8/2.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDBaseModel.h"
#import "JSDCalendarViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class JSDTargetModel;
@interface JSDTargetViewModel : JSDBaseModel

@property (nonatomic, strong) NSMutableArray<JSDTargetModel* >* listArray;
@property (nonatomic, strong) NSMutableArray<JSDTargetModel* >* currentDaylistArray;
- (void)setupCurrentDaylistArray;

@property (strong, nonatomic) JSDCalendarViewModel *calendarManger;

@end

@interface JSDTargetModel : JSDBaseModel

@property (nonatomic, copy) NSString* title;// 标题
@property (nonatomic, copy) NSString* imageView;// 图标
@property (nonatomic, assign) NSInteger imageIndex;// 图标

@property (nonatomic, strong) NSMutableArray<NSString* >* finishWeekDays;// 打卡时间 星期几
@property (nonatomic, strong) NSMutableArray<NSString* >* notificationTimes;// 提醒时间
@property (nonatomic, copy) NSString* encourage;// 鼓励语
@property (nonatomic, assign) BOOL finishStatus;// status, 是否已打开
@property (nonatomic, assign) BOOL notificationStatus;// notification, 是否开启通知

@property (assign, nonatomic) NSInteger monthNumber; //月累计打卡次数
@property (assign, nonatomic) NSInteger totalNumber; //总共累计

@end

NS_ASSUME_NONNULL_END
