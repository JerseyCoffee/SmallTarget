//
//  JSDTargetDetailVC.m
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDTargetDetailVC.h"

#import "JSDCalendarVC.h"

@interface JSDTargetDetailVC ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *scrollContentView;
@property (weak, nonatomic) IBOutlet UILabel *sayingLabel;
@property (weak, nonatomic) IBOutlet UIView *allFinishView;
@property (weak, nonatomic) IBOutlet UIView *monthFinishView;
@property (weak, nonatomic) IBOutlet UIView *calendarView;
@property (strong, nonatomic) JSDCalendarVC *calendarVC;

@end

@implementation JSDTargetDetailVC

#pragma mark - 1.View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.设置导航栏
    [self setupNavBar];
    //2.设置view
    [self setupView];
    //3.请求数据
    [self setupData];
    //4.设置通知
    [self setupNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// TODO: 用通知回调刷新;
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    
    self.title = @"目标详情";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor jsd_mainGrayColor];
    
    self.scrollView.backgroundColor = [UIColor jsd_mainGrayColor];
    self.scrollContentView.backgroundColor = [UIColor jsd_mainGrayColor];
    
    self.sayingLabel.font = [UIFont jsd_fontSize:19];
    self.sayingLabel.textColor = [UIColor jsd_mainBlackColor];
    
    self.allFinishView.backgroundColor = [UIColor whiteColor];
    self.allFinishView.layer.shadowColor = [UIColor colorWithRed:165/255.0 green:177/255.0 blue:201/255.0 alpha:0.3].CGColor;
    self.allFinishView.layer.shadowOffset = CGSizeMake(0,1);
    self.allFinishView.layer.shadowOpacity = 1;
    self.allFinishView.layer.shadowRadius = 6;
    self.allFinishView.layer.cornerRadius = 10;
    
    self.monthFinishView.backgroundColor = [UIColor whiteColor];
    self.monthFinishView.layer.shadowColor = [UIColor colorWithRed:165/255.0 green:177/255.0 blue:201/255.0 alpha:0.3].CGColor;
    self.monthFinishView.layer.shadowOffset = CGSizeMake(0,1);
    self.monthFinishView.layer.shadowOpacity = 1;
    self.monthFinishView.layer.shadowRadius = 6;
    self.monthFinishView.layer.cornerRadius = 10;
    
    [self addChildViewController:self.calendarVC];
    [self.calendarView addSubview:self.calendarVC.view];
    [self.calendarVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.calendarVC didMoveToParentViewController:self];
    
    self.calendarView.backgroundColor = [UIColor whiteColor];
    self.calendarView.layer.shadowColor = [UIColor colorWithRed:165/255.0 green:177/255.0 blue:201/255.0 alpha:0.3].CGColor;
    self.calendarView.layer.shadowOffset = CGSizeMake(0,1);
    self.calendarView.layer.shadowOpacity = 1;
    self.calendarView.layer.shadowRadius = 6;
    self.calendarView.layer.cornerRadius = 10;
    self.calendarView.layer.masksToBounds = YES;
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - 5.Event Response

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

- (JSDCalendarVC *)calendarVC {
    
    if (!_calendarVC) {
        _calendarVC = [[JSDCalendarVC alloc] init];
    }
    return _calendarVC;
}

@end

