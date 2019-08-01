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



@end

@implementation JSDTargetHeaderReusableView


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.leftButton setImage:[UIImage jsd_imageNamePNG:@"left"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage jsd_imageNamePNG:@"right"] forState:UIControlStateNormal];
    
    self.titleLabel.font = [UIFont jsd_fontSize:17];
    self.titleLabel.textColor = [UIColor jsd_mainBlackColor];
    self.titleLabel.text = @"2019 年 8 月";
    NSCalendar* calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:[NSDate date]];
    self.currentMonth = comps.month;
    
}



@end
