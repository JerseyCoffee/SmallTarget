//
//  JSDTargetTableViewCell.h
//  SmallTarget
//
//  Created by Jersey on 2019/8/1.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "MGSwipeTableCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol JSDTargetTableViewCellDelegate <NSObject>

- (void)onTouchFinishModel:(JSDTargetModel *)model;

@end

@interface JSDTargetTableViewCell : MGSwipeTableCell

@property (strong, nonatomic) JSDTargetModel *model;

@property (weak, nonatomic) id<JSDTargetTableViewCellDelegate> delegate;

@property (copy, nonatomic) NSString *yearMonthDay; //年-月-日

@end

NS_ASSUME_NONNULL_END
