//
//  JSDCalenderHeaderView.m
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDCalenderHeaderView.h"
#import "JSDStackView.h"
#import "JSDCalendersubView.h"
#import "JSDTargetDetailVC.h"

@interface JSDCalenderHeaderView ()

@property (nonatomic, strong) JSDStackView* stackView;
@property (nonatomic, strong) UIButton* stackButton;

@end

@implementation JSDCalenderHeaderView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    self.stackView = [[JSDStackView alloc] init];
    
    [self addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
//    self.stackButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self addSubview:self.stackButton];
//
//    [self.stackButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(0);
//    }];
    
    [self.stackButton addTarget:self action:@selector(onTouchStackView:) forControlEvents:UIControlEventTouchUpInside];
    
    for (NSInteger i = 0; i < 7; i++) {
        JSDCalendersubView* subView = [[JSDCalendersubView alloc] init];
        if (i == 3) {
            [subView isShow];
        }
        [self.stackView addArrangedSubview:subView];
        subView.calenderButton.tag = i;
        subView.calenderButton.userInteractionEnabled = YES;
        [subView.calenderButton addTarget:self action:@selector(onTouchStackButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)onTouchStackView:(id)sender {
    
    
}

- (void)onTouchStackButton:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onTouchCalenderHeaderViewIndex:)]) {
        [self.delegate onTouchCalenderHeaderViewIndex:sender.tag];
        //TODO: 实现方式不优雅
        for (NSInteger i = 0; i < 7; i++) {
            JSDCalendersubView* subView = self.stackView.subviews[i];
            if (sender.tag == i) {
                [subView isShow];
            }
        }
    }
}

@end
