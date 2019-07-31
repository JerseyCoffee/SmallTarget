//
//  JSDStackView.m
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDStackView.h"

@implementation JSDStackView

- (instancetype)initWithCoder:(NSCoder *)coder {
    
    self = [super initWithCoder:coder];
    if (self) {
        [self configuration];
    }
    return self;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self configuration];
    }
    return self;
}

- (void)configuration {
    
    self.axis = UILayoutConstraintAxisHorizontal;
    self.distribution = UIStackViewDistributionFillEqually;
    self.alignment = UIStackViewAlignmentCenter;
    self.spacing = 5;
}

@end
