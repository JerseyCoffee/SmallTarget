//
//  JSDCalenderViewCell.m
//  SmallTarget
//
//  Created by Jersey on 2019/8/1.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDCalenderViewCell.h"

@interface JSDCalenderViewCell ()



@end

@implementation JSDCalenderViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titleLabel.font = [UIFont jsd_fontSize:16];
    self.titleLabel.textColor = [UIColor jsd_mainBlackColor];
    self.titleLabel.text = @"一";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.shouldHideSeparator = YES;
    
}

@end
