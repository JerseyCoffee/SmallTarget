//
//  JSDCalendersubView.m
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDCalendersubView.h"

@interface JSDCalendersubView ()



@end

@implementation JSDCalendersubView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self configuration];
    }
    return self;
}

- (void)configuration {
    
    self.weekLabel = [[UILabel alloc] init];
    [self.weekLabel setFont:[UIFont jsd_fontSize:12]];
    [self.weekLabel setTextColor:[UIColor jsd_colorWithHexString:@"#9CA5C4"]];
    self.weekLabel.text = @"日";
    
    self.calenderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.calenderButton.titleLabel setFont:[UIFont jsd_fontSize:13]];
    [self.calenderButton setTitleColor:[UIColor jsd_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
//    self.calenderButton.userInteractionEnabled = NO;
    
    [self addSubview:self.weekLabel];
    [self addSubview:self.calenderButton];
    //TODO: 可能是 StackView 导致
    [self.weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-12);
    }];

    [self.calenderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(-5);
        make.width.height.mas_equalTo(32);
    }];
    
    [self.calenderButton setTitle:@"28" forState:UIControlStateNormal];
}

- (void)isShow {
    
    self.calenderButton.backgroundColor = [UIColor jsd_colorWithHexString:@"#F5B853"];
    self.calenderButton.layer.cornerRadius = 16;
    self.calenderButton.layer.masksToBounds = YES;
    [self.calenderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
//    [self.weekLabel sizeToFit];
//    [self.calenderButton sizeToFit];
//    [self.weekLabel setcenterX: self.jsd_width / 2];
//    [self.weekLabel jsd_setbottom: -8];
//    
//    [self.calenderButton setcenterX: self.jsd_width / 2];
//    
//    [self.calenderButton jsd_settop: 10];
    
}

@end
