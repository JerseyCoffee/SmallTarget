//
//  JSDAbountViewModel.m
//  JerseyCoffee
//
//  Created by Jersey on 2019/7/26.
//  Copyright © 2019 jerseyCafe. All rights reserved.
//

#import "JSDAbountViewModel.h"

@implementation JSDAbountViewModel

//TODO:
- (NSArray<JSDAbountModel *> *)listArray {
    
    if (!_listArray) {
        NSArray* array = @[@{@"title": @"官网",
                             @"detail": @"https://www.jianshu.com/p/ceda10b4552e",
                             
                               },
                           @{@"title": @"App 版本",
                             @"detail": @"V1.0.0",
                             
                             },
                           @{@"title": @"App 评分",
                             @"detail": @"非常感谢你使用我们App, 如果您喜欢咖啡知识Note,点击即可前往评论页进行评论!",
                             
                             },
                           ];
        _listArray = [JSDAbountModel mj_objectArrayWithKeyValuesArray:array];
        
    }
    return _listArray;
}

@end

@implementation JSDAbountModel

@end
