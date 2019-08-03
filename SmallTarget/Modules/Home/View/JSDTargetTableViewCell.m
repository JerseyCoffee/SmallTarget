//
//  JSDTargetTableViewCell.m
//  SmallTarget
//
//  Created by Jersey on 2019/8/1.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDTargetTableViewCell.h"

@interface JSDTargetTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *targetImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;

@end

@implementation JSDTargetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titleLabel.font = [UIFont jsd_fontSize:18];
    self.titleLabel.textColor = [UIColor jsd_mainBlackColor];
    
    self.subtitleLabel.font = [UIFont jsd_fontSize:12];
    self.subtitleLabel.textColor = [UIColor jsd_colorWithHexString:@"#999999"];
    
    [self.finishButton addTarget:self action:@selector(onTouchButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setFrame:(CGRect)frame{
    
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    
    [super setFrame:frame];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.layer.shadowColor = [UIColor colorWithRed:165/255.0 green:177/255.0 blue:201/255.0 alpha:0.3].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,1);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 6;
    self.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(JSDTargetModel *)model {
    
    _model = model;
    
    self.targetImageView.image = [UIImage imageNamed:model.imageView];
    self.titleLabel.text = model.title;
    self.subtitleLabel.text = model.encourage;
    NSString* imageName = model.finishStatus ? @"target_finish_complete": @"target_finish_normal";
    [self.finishButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
}

- (void)onTouchButton:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onTouchFinishModel:)]) {
        [self.delegate onTouchFinishModel:self.model];
    }
}

@end
