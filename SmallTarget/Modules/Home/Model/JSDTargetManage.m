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

- (void)addTargetModel:(JSDTargetModel *)model {
    
    [self.viewModel.listArray addObject:model];
    NSFileManager* fileManage = [NSFileManager defaultManager];
    NSString* targetPath = [NSHomeDirectory() stringByAppendingPathComponent: kJSDTargetFilesPath];
    if ([fileManage fileExistsAtPath:targetPath]) {
    } else {
        BOOL suceed =  [fileManage createFileAtPath:targetPath contents:nil attributes:nil];
        NSLog(@"状态%d", suceed);
    }
    NSArray* array = [JSDTargetModel mj_keyValuesArrayWithObjectArray:self.viewModel.listArray];
    NSData* data = array.mj_JSONData;
    [data writeToFile:targetPath atomically:YES];
    
}

- (void)removeTargetModel:(JSDTargetModel *)model {
    
    
}


- (JSDTargetViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [[JSDTargetViewModel alloc] init];
    }
    return _viewModel;
}

@end
