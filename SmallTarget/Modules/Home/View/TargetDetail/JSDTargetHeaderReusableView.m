//
//  JSDTargetHeaderReusableView.m
//  SmallTarget
//
//  Created by Jersey on 2019/8/1.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDTargetHeaderReusableView.h"

@interface JSDTargetHeaderReusableView ()

@property (weak, nonatomic) IBOutlet UIView *headerContentView;
@property (weak, nonatomic) IBOutlet UIView *separateView;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation JSDTargetHeaderReusableView


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.titleLabel.font = []
   
}

@end
