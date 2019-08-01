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
                               @"route": @"",
                               @"subTitle": @""
                               },
                           @{
                               @"imageName": @"recommend",
                               @"title": @"推荐给好友",
                               @"detail": @"",
                               @"route": @"",
                               @"subTitle": @""
                               },
                          
                           
                           ];
        _listArray = [JSDMyCenterModel mj_objectArrayWithKeyValuesArray:array];
    }
    return _listArray;
}

@end


@implementation JSDMyCenterModel

@end
