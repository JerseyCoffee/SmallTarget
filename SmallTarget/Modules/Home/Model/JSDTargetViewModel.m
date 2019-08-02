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
        NSString* targetPath = [NSHomeDirectory() stringByAppendingPathComponent: kJSDTargetFilesPath];
        if ([fileManager fileExistsAtPath:targetPath]) {
            NSData* data = [NSData dataWithContentsOfFile:targetPath];
            NSArray* array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (array.count) {
                _listArray = [JSDTargetModel mj_objectArrayWithKeyValuesArray:array];
            } else {
                _listArray = [[NSMutableArray alloc] init];
            }
        } else {
            _listArray = NSMutableArray.new;
        }
    }
    return _listArray;
}


@end

@implementation JSDTargetModel



@end
