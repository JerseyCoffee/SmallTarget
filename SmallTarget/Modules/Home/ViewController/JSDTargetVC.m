//
//  JSDTargetVC.m
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDTargetVC.h"
#import "JSDCalenderHeaderView.h"
#import "JSDtargetCell.h"
#import "JSDTargetDetailVC.h"

static NSString* const kJSDTargetCell = @"cell";

@interface JSDTargetVC () <JSDCalenderHeaderViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) JSDCalenderHeaderView* headerView;
@property (nonatomic, strong) UITableView* tableView;

@end

@implementation JSDTargetVC

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
    
    self.title = @"打卡";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor jsd_mainGrayColor];
    
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(72);
    }];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.headerView.mas_bottom);
    }];
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJSDTargetCell];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kJSDTargetCell];
    }
    
//    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", indexPath.row];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JSDTargetDetailVC* targetDetailVC = [[JSDTargetDetailVC alloc] init];
    
    [self.navigationController pushViewController:targetDetailVC animated:YES];
}

#pragma mark -- JSDCalenderHeaderViewDelegate

- (void)onTouchCalenderHeaderViewIndex:(NSInteger)index {
    
    NSLog(@"切换日期");
}

#pragma mark - 5.Event Response

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

- (JSDCalenderHeaderView *)headerView {
    
    if (!_headerView) {
        _headerView = [[JSDCalenderHeaderView alloc] init];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//        [_tableView registerNib:[UINib nibWithNibName:@"JSDTargetCell" bundle:[NSBundle mainBundle] forCellReuseIdentifier: kJSDTargetCell]];
        [_tableView registerNib:[UINib nibWithNibName:@"JSDTargetCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kJSDTargetCell];
         _tableView.backgroundColor = [UIColor jsd_mainGrayColor];
         _tableView.delegate = self;
         _tableView.dataSource = self;
         _tableView.tableFooterView = [[UIView alloc] init];
         }
         return _tableView;
     }

@end

