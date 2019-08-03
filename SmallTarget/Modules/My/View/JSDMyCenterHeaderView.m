//
//  JSDMyCenterHeaderView.m
//  SmallTarget
//
//  Created by Jersey on 2019/8/1.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDMyCenterHeaderView.h"

@interface JSDMyCenterHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet MDCButton *settingButton;


@end

@implementation JSDMyCenterHeaderView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.headImageView.backgroundColor = [UIColor jsd_mainBlueColor];
    self.headImageView.layer.cornerRadius = 34;
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.image = [UIImage imageNamed:@"user"];
    
    self.nameLabel.font = [UIFont jsd_fontSize:21];
    self.nameLabel.textColor = [UIColor jsd_mainBlackColor];
    self.nameLabel.text = @"Jersey Bro";
    
    [self.settingButton setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    
}

- (void)setModel:(JSDUserModel *)model {
    
    self.nameLabel.text = model.userName;
    
    if (JSDIsString(model.userImageView)) {
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        NSString* filePath = [NSString stringWithFormat:@"%@/%@.png", documentsDirectory, model.userImageView];
        self.headImageView.image = [UIImage imageWithContentsOfFile:filePath];
    } else {
        self.headImageView.image = [UIImage imageNamed:@"user"];
        NSLog(@"使用默认");
    }
}

@end
