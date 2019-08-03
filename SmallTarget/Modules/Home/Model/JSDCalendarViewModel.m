//
//  JSDCalendarViewModel.m
//  SmallTarget
//
//  Created by Jersey on 2019/8/1.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDCalendarViewModel.h"

@implementation JSDCalendarViewModel

- (NSInteger)getCurrentMonthForDays
{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSRange range = [currentCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    NSLog(@"nsrange = %@----- %ld",NSStringFromRange(range),range.location);
    
    return numberOfDaysInMonth;
}

/*
 *  date :当前时间
 *  number:当前月之后几个个月的1号date
 */

-(NSDate *)getAMonthframDate:(NSDate*)date months:(NSInteger)number {

    NSCalendarUnit dayInfoUnits  = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [_calendar components: dayInfoUnits fromDate:date];
    components.day = 1;
    if (number!=0) {
        components.month += number;
    }
    NSDate* nextDate =[_calendar dateFromComponents:components];
    
    return nextDate;
}
/*
 * 获取某个月一共多少天
 * date 要获取的月份的date
 */
-(void)getNextNMonthForDays:(NSDate * )date
{
    NSInteger monthNum =[[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    
    NSMutableArray* tempArray = NSMutableArray.new;
    for (NSInteger i = 0;i < monthNum ; i++) {
        [tempArray addObject:@(i + 1).stringValue];
    }
    self.currentDay = monthNum;
    self.titleArray = tempArray;
}

/**
 *  获取某个月的1号是星期几
 *  date 目标月的date
 **/
- (void)getFirstDayWeekForMonth:(NSDate*)date
{
    //    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法 NSCalendarIdentifierGregorian,NSGregorianCalendar
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    NSDateComponents *comps = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:date];
    NSLog(@"comps是这个样子的:%@",comps);
    NSInteger weekday = [comps weekday];
    weekday--;
    NSLog(@"[comps weekday] = %ld",(long)weekday);
//    if (weekday == 7) {
//        return 0;
//    } else return weekday;
    if (weekday == 7) {
        self.index = 0;
    } else {
        self.index = weekday;
    }
}

- (NSCalendar *)calendar {
    
    if (!_calendar) {
       _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];// 指定日历的算法
    }
    return _calendar;
}



#pragma mark --- TODO: 上面方法不用

- (NSCalendar *)gregorian {
    
    if (!_gregorian) {
        _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];// 指定日历的算法
    }
    return _gregorian;
}

- (NSDate *)currentDate {
    
    if (!_currentDate) {
        _currentDate = [NSDate date];
    }
    return _currentDate;
}

- (NSDate *)showDate {
    
    if (!_showDate) {
        _showDate = self.currentDate;
    }
    return _showDate;
}

- (void)update {
    
//    self.showDate = [self.gregorian dateWithEra:1 year:2019 month:8 day:5 hour:0 minute:0 second:0 nanosecond:0];
    NSInteger year = [self.gregorian component:NSCalendarUnitYear fromDate:self.showDate];
    NSInteger month = [self.gregorian component:NSCalendarUnitMonth fromDate:self.showDate];
    NSInteger day = [self.gregorian component:NSCalendarUnitDay fromDate:self.showDate];
    NSInteger weekDay = [self.gregorian component:NSCalendarUnitWeekday fromDate:self.showDate];
    // 1 代表星期天 7 代表星期天   天:0 1 2 3 4 5 6  2 —> 1;  // 下标向左移动一位即可;
    NSLog(@"星期:%ld", weekDay);
    self.index = --weekDay;
    self.year = year;
    self.month = month;
    self.day = day;
    self.dayIndex = day + self.index - 1; 
    
    NSInteger monthNum = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self.showDate].length;
    
    NSMutableArray* tempArray = NSMutableArray.new;
    for (NSInteger i = 0;i < monthNum ; i++) {
        [tempArray addObject:@(i + 1).stringValue];
    }
    self.titleArray = tempArray;
    
    NSInteger currentYear = [self.gregorian component:NSCalendarUnitYear fromDate:self.currentDate];
    NSInteger currentMonth = [self.gregorian component:NSCalendarUnitMonth fromDate:self.currentDate];
    if (currentYear == year && currentMonth == month) {
        self.isShowCurrentMonth = YES;
    } else
    {
        self.isShowCurrentMonth = NO;
    }
    
}

- (void)lastMonthd {
    
    self.showDate = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:self.showDate options:0];
    [self update];
}
- (void)nextMonthd {
    
    self.showDate = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:self.showDate options:0];
    [self update];
}

- (NSString *)yearMonthDay {
    
    if (!_yearMonthDay) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        _yearMonthDay = [formatter stringFromDate:self.currentDate];
    }
    return _yearMonthDay;
}

#pragma mark -- TargetCalendar

- (void)updateTarget {
    
    NSDateComponents* compoents = [self.gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:self.currentDate];
    
    self.targetDay = compoents.day; //号
    self.targetWeekDay = --compoents.weekday; //星期几
    self.targetMonth = compoents.month; // 月份
    // 根据今天是星期几来取, 最近 7 天;
    
    NSMutableArray* tempWeekDayArray = NSMutableArray.new;
    NSMutableArray* tempDayArray = NSMutableArray.new;
    for (NSInteger i = -3; i < 0; i++) {
        NSDate* date =  [self.gregorian dateByAddingUnit:NSCalendarUnitWeekday value:i toDate:self.currentDate options:0];
        NSDateComponents* compoents = [self.gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:date];
        [tempWeekDayArray addObject:@(--compoents.weekday).stringValue];
        [tempDayArray addObject:@(compoents.day).stringValue];
    }
    [tempWeekDayArray addObject:@(self.targetWeekDay).stringValue];
    [tempDayArray addObject:@(self.targetDay).stringValue];
    for (NSInteger i = 1; i < 4; i++) {
        NSDate* date =  [self.gregorian dateByAddingUnit:NSCalendarUnitWeekday value:i toDate:self.currentDate options:0];
        NSDateComponents* compoents = [self.gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:date];
        [tempWeekDayArray addObject:@(--compoents.weekday).stringValue];
        [tempDayArray addObject:@(compoents.day).stringValue];
    }
    
    self.targetWeekDays = tempWeekDayArray.copy;
    self.targetDays = tempDayArray.copy;
    
    NSLog(@"几号%ld--星期几%ld---%@---星期数组%@---号数%@", self.targetDay, self.targetWeekDay, compoents, self.targetWeekDays, self.targetDays);
    
}

- (NSDictionary *)targetWeekDaysDic {
    
    if (!_targetWeekDaysDic) {
        _targetWeekDaysDic = @{
                               @"0": @"日",
                               @"1": @"一",
                               @"2": @"二",
                               @"3": @"三",
                               @"4": @"四",
                               @"5": @"五",
                               @"6": @"六",
                               };
    }
    return _targetWeekDaysDic;
}

@end
