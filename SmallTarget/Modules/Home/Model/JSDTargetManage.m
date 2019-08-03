//
//  JSDTargetManage.m
//  SmallTarget
//
//  Created by Jersey on 2019/8/2.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDTargetManage.h"
#import "JSDTargetViewModel.h"

NSString* const kJSDTargetFilesPath = @"JSDTarget";

@implementation JSDTargetManage

+ (instancetype)sharedInstance {
    
    static JSDTargetManage *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)addTargetModel:(JSDTargetModel *)model {
    
    [self.viewModel.listArray addObject:model];
    
    [self savaData];
}

- (void)removeTargetModel:(JSDTargetModel *)model {
    
    [self.viewModel.listArray removeObject:model];
    
    [self savaData];
}

- (void)editTargetModel:(JSDTargetModel *)model {
    
    for (NSInteger i = 0; i < self.viewModel.listArray.count; i++) {
        JSDTargetModel* model = self.viewModel.listArray[i];
        if ([model.title isEqualToString:model.title]) { //暂时以 Title 作为 ID
            [self.viewModel.listArray replaceObjectAtIndex:i withObject:model];
            break;
        }
    }
    
    [self savaData];
}

- (void)finishTargetModel:(JSDTargetModel *)model {
    
    for (NSInteger i = 0; self.viewModel.listArray.count; i++) {
        JSDTargetModel* targetModel = self.viewModel.listArray[i];
        if ([targetModel.title isEqualToString:model.title]) {
            targetModel.monthNumber++;
            targetModel.totalNumber++;
            [targetModel.finishrecordS.firstObject setValue:@(YES) forKey:self.yearMonthDay];
            break;
        }
    }
    
    [self savaData];
}

- (void)cancelFnishTargetModel:(JSDTargetModel *)model {
    
    for (NSInteger i = 0; self.viewModel.listArray.count; i++) {
        JSDTargetModel* targetModel = self.viewModel.listArray[i];
        if ([targetModel.title isEqualToString:model.title]) {
            targetModel.monthNumber--;
            targetModel.totalNumber--;
            [targetModel.finishrecordS.firstObject setValue:@(NO) forKey:self.yearMonthDay];
            break;
        }
    }
    
    
    [self savaData];
}

- (BOOL)checkContainsTargetTitle:(NSString *)title {
    
    BOOL iscontains = NO;
    for (NSInteger i = 0; i < self.viewModel.listArray.count; i++) {
        JSDTargetModel* targetModel = self.viewModel.listArray[i];
        if ([targetModel.title isEqualToString: title]) {
            targetModel.finishStatus = !targetModel.finishStatus;
            iscontains = YES;
            break;
        }
    }
    return iscontains;
}



- (void)savaData {
    
    NSFileManager* fileManage = [NSFileManager defaultManager];
    NSString* document = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* targetPath = [document stringByAppendingPathComponent: kJSDTargetFilesPath];
    if ([fileManage fileExistsAtPath:targetPath]) {
    } else {
        BOOL suceed =  [fileManage createFileAtPath:targetPath contents:nil attributes:nil];
        NSLog(@"状态%d", suceed);
    }
    NSArray* array = [JSDTargetModel mj_keyValuesArrayWithObjectArray:self.viewModel.listArray];
    NSData* data = array.mj_JSONData;
    [data writeToFile:targetPath atomically:YES];
    
    //设置
    [self.viewModel setupCurrentDaylistArray];
    [[NSNotificationCenter defaultCenter] postNotificationName:kTargetListChangeNotification object:nil];
}


- (JSDTargetViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [[JSDTargetViewModel alloc] init];
        [_viewModel setupCurrentDaylistArray];
    }
    return _viewModel;
}

#pragma

- (NSString *)yearMonthDay {
    
    if (!_yearMonthDay) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        _yearMonthDay = [formatter stringFromDate:[NSDate date]];
    }
    return _yearMonthDay;
}

- (BOOL)checkoutFinishStatus:(JSDTargetModel*)model {
    
    BOOL isFinish;
    if ([[model.finishrecordS.firstObject allKeys] containsObject:self.yearMonthDay]) {
        
        NSNumber* isFinishNumber = [model.finishrecordS.firstObject objectForKey:self.yearMonthDay];
        isFinish = isFinishNumber.boolValue;
    } else {
        isFinish = NO;
    }
    
    return isFinish;
}

- (BOOL)checkoutFinishStatus:(JSDTargetModel*)model yearMonthDay:(NSString *)yearMonthDay {
    
    BOOL isFinish;
    if ([[model.finishrecordS.firstObject allKeys] containsObject: yearMonthDay]) {
        
        NSNumber* isFinishNumber = [model.finishrecordS.firstObject objectForKey:yearMonthDay];
        isFinish = isFinishNumber.boolValue;
    } else {
        isFinish = NO;
    }
    
    return isFinish;
    
}

@end
