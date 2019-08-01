//
//  JSDCalendarViewModel.h
//  SmallTarget
//
//  Created by Jersey on 2019/8/1.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FSCalendar.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSDCalendarViewModel : NSObject

@property (nonatomic, assign) NSInteger currentDay; // 今天在第几个下标;
@property (nonatomic, strong) NSCalendar* calendar;

//- (NSInteger)getCurrentMonthForDays;
//- (NSDate *)getAMonthframDate:(NSDate*)date months:(NSInteger)number;
//- (void)getNextNMonthForDays:(NSDate * )date;
//- (void)getFirstDayWeekForMonth:(NSDate*)date;

@property (nonatomic, strong) NSCalendar* gregorian;
@property (nonatomic, strong) NSArray* titleArray;       // 当天的 Title;
@property (nonatomic, assign) NSInteger index;           // 1号应该从开始;
@property (nonatomic, assign) NSInteger year;            // 年
@property (nonatomic, assign) NSInteger month;           // 月
@property (nonatomic, assign) NSInteger day;             // 日
@property (nonatomic, assign) NSInteger dayIndex;
@property (nonatomic, strong) NSDate* currentDate;
@property (nonatomic, strong) NSDate* showDate;
@property (nonatomic, assign) BOOL isShowCurrentMonth;


- (void)update;     //刷新
- (void)lastMonthd; //上个月
- (void)nextMonthd; //下个月


#pragma mark -- TargetCalendar

@property (assign, nonatomic) NSInteger targetDay; //几号
@property (assign, nonatomic) NSInteger targetWeekDay; //星期几
@property (assign, nonatomic) NSInteger targetMonth; // 月份
@property (strong, nonatomic) NSArray* targetDays; //最近 7 天号数
@property (strong, nonatomic) NSArray* targetWeekDays; //最近 7 天星期几
@property (strong, nonatomic) NSDictionary *targetWeekDaysDic; //映射

- (void)updateTarget;

@end

NS_ASSUME_NONNULL_END
