//
//  JSDMyCenterVC.m
//  JerseyCoffee
//
//  Created by Jersey on 2019/7/23.
//  Copyright © 2019 jerseyCafe. All rights reserved.
//

#import "JSDMyCenterVC.h"

#import "JSDMyCenterViewModel.h"
#import "JSDCollectionViewCell.h"
#import "JSDMyCenterHeaderView.h"
#import "JSDSettingVC.h"
#import "JSDAboutUSVC.h"
#import "JSDMyResource.h"

NSString *const kMyUserDataNotification = @"MyUserDataNotification";

@interface JSDMyCenterVC ()

@property (strong, nonatomic) JSDMyCenterViewModel *viewModel;
@property (nonatomic, strong) JSDMyCenterHeaderView* headerView;

@end

@implementation JSDMyCenterVC

static NSString * const reuseIdentifier = @"Cell";

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

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    
    self.navigationItem.title = @"个人中心";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"JSDCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.backgroundColor = [UIColor jsd_mainGrayColor];
    
    [self.view addSubview:self.headerView];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(112);
        if (@available(iOS 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        }else{
            make.top.mas_equalTo(22);
        }
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.headerView.mas_bottom);
    }];
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
    //设置头部
    [self.headerView setModel: self.viewModel.userData];
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.viewModel.listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    JSDMyCenterModel* model = self.viewModel.listArray[indexPath.item];
    cell.model = model;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    JSDMyCenterModel* model = self.viewModel.listArray[indexPath.item];
    if ([model.route isEqualToString:@"App"]) {
        //TODO: 评分与推荐
        NSString* appId = kJSDAppleID;
        NSString *urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8&action=write-review", appId];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
    } else if ([model.route isEqualToString:@"tuijian"]) {
        NSString* appId = kJSDAppleID;
        NSString *urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8&action", appId];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
    }
    else {
        UIViewController* historyVC = [NSClassFromString(model.route) new];
        [self.navigationController pushViewController:historyVC animated:YES];
    }
}

#pragma mark <UICollectionViewLayoutDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((ScreenWidth - 20), 60);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(21, 10, 20, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

#pragma mark <UICollectionViewDelegate>


#pragma mark - 5.Event Response

- (void)onTouchHeaderView:(id)sender {
    
//    JSDSettingVC* settingVC = [[JSDSettingVC alloc] init];
    JSDMyResource* myresourceVC = [[JSDMyResource alloc] init];
    myresourceVC.model = self.viewModel.userData;
    
    [self.navigationController pushViewController:myresourceVC animated:YES];
}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myUserDataNotification:) name:kMyUserDataNotification object:nil];
}

- (void)myUserDataNotification:(NSNotification*)notification {
    
    [self.viewModel setupUserData];
    
    [self.headerView setModel: self.viewModel.userData];
}

#pragma mark - 7.GET & SET

- (JSDMyCenterViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [[JSDMyCenterViewModel alloc] init];
    }
    return _viewModel;
}

- (JSDMyCenterHeaderView *)headerView {
    
    if (!_headerView) {
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"JSDMyCenterHeaderView" owner:nil options:nil].lastObject;
        [_headerView.tapButton addTarget:self action:@selector(onTouchHeaderView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}

@end
