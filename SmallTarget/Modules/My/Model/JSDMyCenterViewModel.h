//
//  JSDMyCenterViewModel.h
//  JerseyCoffee
//
//  Created by ada on 2019/7/25.
//  Copyright © 2019 jerseyCafe. All rights reserved.
//

#import "JSDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class JSDMyCenterModel;

@interface JSDMyCenterViewModel : JSDBaseModel

@property (strong, nonatomic) NSArray<JSDMyCenterModel* > *listArray;

@end

@interface JSDMyCenterModel : JSDBaseModel

@property (copy, nonatomic) NSString *imageName;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *detail;
@property (copy, nonatomic) NSString *route;
@property (copy, nonatomic) NSString *subTitle;

@end

NS_ASSUME_NONNULL_END
