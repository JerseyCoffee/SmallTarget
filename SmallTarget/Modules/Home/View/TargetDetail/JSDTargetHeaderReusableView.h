//
//  JSDTargetHeaderReusableView.h
//  SmallTarget
//
//  Created by Jersey on 2019/8/1.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSDTargetHeaderReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) NSInteger currentMonth;

@end

NS_ASSUME_NONNULL_END
