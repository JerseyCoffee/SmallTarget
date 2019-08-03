//
//  JSDTargetViewModel.m
//  SmallTarget
//
//  Created by Jersey on 2019/8/2.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDTargetViewModel.h"



@implementation JSDTargetViewModel

- (NSMutableArray<JSDTargetModel *> *)listArray {
    
    if (!_listArray) {
        NSFileManager* fileManager = [NSFileManager defaultManager];
        NSString* document = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString* targetPath = [document stringByAppendingPathComponent: kJSDTargetFilesPath];
        if ([fileManager fileExistsAtPath:targetPath]) {
            NSData* data = [NSData dataWithContentsOfFile:targetPath];
            NSArray* array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (array.count) {
                _listArray = [JSDTargetModel mj_objectArrayWithKeyValuesArray:array];
            } else {
                _listArray = [[NSMutableArray alloc] init];
            }
        } else { // 首次启动默认使用数据
            NSString* targetPath = [[NSBundle mainBundle] pathForResource:@"JerseyData" ofType:@"json"];
            NSData* data = [NSData dataWithContentsOfFile:targetPath];
            NSArray* array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            _listArray = [JSDTargetModel mj_objectArrayWithKeyValuesArray:array];
        }
    }
    return _listArray;
}

- (NSMutableArray<JSDTargetModel *> *)currentDaylistArray {
    
    if (!_currentDaylistArray) {
        _currentDaylistArray = self.listArray.copy;
    }
    return _currentDaylistArray;
}

- (void)setupCurrentDaylistArray {
    
    if (self.listArray.count) {
        
        NSMutableArray* tempArray = NSMutableArray.new;
        for (NSInteger i = 0; i < self.listArray.count; i++) {
            JSDTargetModel* model = self.listArray[i];
            if ([model.finishWeekDays containsObject:@(self.calendarManger.targetWeekDay).stringValue]) {
                [tempArray addObject:model];
            }
        }
        self.currentDaylistArray = tempArray.mutableCopy;
    } else {
        self.currentDaylistArray = nil;
    }
}

- (JSDCalendarViewModel *)calendarManger {
    
    if (!_calendarManger) {
        _calendarManger = [[JSDCalendarViewModel alloc] init];
        [_calendarManger updateTarget];
    }
    return _calendarManger;
}

@end

@implementation JSDTargetModel



@end
