//
//  JSDCollectionViewCell.h
//  JerseyCoffee
//
//  Created by ada on 2019/7/25.
//  Copyright © 2019 jerseyCafe. All rights reserved.
//

#import "MDCCollectionViewTextCell.h"

#import "JSDMyCenterViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JSDCollectionViewCell : MDCCollectionViewTextCell

@property (strong, nonatomic) JSDMyCenterModel *model;

@end

NS_ASSUME_NONNULL_END
