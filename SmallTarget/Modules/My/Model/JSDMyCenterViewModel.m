//
//  JSDMyCenterViewModel.m
//  JerseyCoffee
//
//  Created by ada on 2019/7/25.
//  Copyright © 2019 jerseyCafe. All rights reserved.
//

#import "JSDMyCenterViewModel.h"

@implementation JSDMyCenterViewModel

- (NSArray<JSDMyCenterModel *> *)listArray {
    
    if (!_listArray) {
        NSArray *array = @[@{
                               @"imageName": @"about_us",
                               @"title": @"关于我们",
                               @"detail": @"",
                               @"route": @"JSDAboutUSVC",
                               },
                           @{
                               @"imageName": @"feedback",
                               @"title": @"意见反馈",
                               @"detail": @"",
                               @"route": @"JSDFeedBacksVC",
                               },
                           @{
                               @"imageName": @"grade",
                               @"title": @"评价鼓励",
                               @"detail": @"",
                               @"route": @"App",
                               @"subTitle": @""
                               },
                           ];
        _listArray = [JSDMyCenterModel mj_objectArrayWithKeyValuesArray:array];
    }
    return _listArray;
}

- (void)setupUserData {
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* userPath = [documentsDirectory stringByAppendingPathComponent:@"user"];
    if ([fileManager fileExistsAtPath:userPath]) {
    } else {
        [fileManager createFileAtPath:userPath contents:nil attributes:nil];
    }
    NSData* data = [NSData dataWithContentsOfFile:userPath];
    if (data) {
        NSArray* array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (array.count) {
            self.userData = [JSDUserModel mj_objectArrayWithKeyValuesArray:array].firstObject;
        } else {
            self.userData = [[JSDUserModel alloc] init];
        }
    } else {
        self.userData = [[JSDUserModel alloc] init];
    }
}

- (void)saveUserData {
    
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* userPath = [documentsDirectory stringByAppendingPathComponent:@"user"];
    NSArray* array = [JSDUserModel mj_keyValuesArrayWithObjectArray: @[self.userData]];
    NSData* data = array.mj_JSONData;
    [data writeToFile:userPath atomically:YES];

    //  通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kMyUserDataNotification object:nil];
}

- (JSDUserModel *)userData {
    
    if (!_userData) {
        [self setupUserData];
    }
    return _userData;
}

@end

@implementation JSDUserModel

- (NSString *)userName {
    
    if (!_userName) {
        _userName = @"SmallTarget";
    }
    return _userName;
}


@end

@implementation JSDMyCenterModel

@end
