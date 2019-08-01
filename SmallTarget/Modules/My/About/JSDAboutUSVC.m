//
//  JSDAboutUSVC.m
//  JerseyCoffee
//
//  Created by Jersey on 2019/7/26.
//  Copyright © 2019 jerseyCafe. All rights reserved.
//

#import "JSDAboutUSVC.h"

#import <MDCCollectionViewTextCell.h>
#import "JSDAbountViewModel.h"

//TODO:
NSString* const kJSDAppleID = @"1474780395";

@interface JSDAboutUSVC ()

@property (nonatomic, strong) JSDAbountViewModel* viewModel;

@end

@implementation JSDAboutUSVC

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

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    
    self.navigationItem.title = @"关于我们";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor jsd_mainGrayColor];
    
    self.styler.cellStyle = MDCCollectionViewCellStyleCard;
    self.collectionView.backgroundColor = [UIColor jsd_mainGrayColor];
    [self.collectionView registerClass:[MDCCollectionViewTextCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.viewModel.listArray.count;;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MDCCollectionViewTextCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    JSDAbountModel* model = self.viewModel.listArray[indexPath.item];
    cell.detailTextLabel.numberOfLines = 0;
    
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.detail;
    
//    cell.contentView.layer.cornerRadius = 5;
//    cell.contentView.layer.masksToBounds = YES;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    
    JSDAbountModel* model = self.viewModel.listArray[indexPath.item];
    
    if (indexPath.row == 0) {
        // 关闭邮件发送视图
        MDCSnackbarManager* manager = [MDCSnackbarManager defaultManager];
        MDCSnackbarMessage* message = [MDCSnackbarMessage messageWithText: @"官网已复制到剪切板"];
        UIPasteboard* pasterboard = [[UIPasteboard alloc] init];
        pasterboard.string = model.detail;
        [manager showMessage:message];

    } else if (indexPath.row == 2) {
        NSString* appId = kJSDAppleID;
        NSString *urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8&action=write-review", appId];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize size = [super collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    
    return CGSizeMake(size.width, 100);
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//
//    return 15;
//}

#pragma mark <UICollectionViewDelegate>

#pragma mark <UICollectionViewLayoutDelegate>

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return CGSizeMake((ScreenWidth - 50) / 2, 100);
//}
//
////设置每个item的UIEdgeInsets
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(10, 15, 10, 15);
//}
//
////设置每个item水平间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10;
//}
//
////设置每个item垂直间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 15;
//}

#pragma mark - 5.Event Response

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

- (JSDAbountViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [[JSDAbountViewModel alloc] init];
    }
    return _viewModel;
}

@end

