//
//  SDCalendarVC.m
//  SmallTarget
//
//  Created by ada on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDCalendarVC.h"
#import <MDCCollectionViewCell.h>
#import "JSDTargetHeaderReusableView.h"
#import "JSDCalenderViewCell.h"
#import "JSDCalendarViewModel.h"
#import <JTCalendar.h>
#import <FSCalendar.h>

@interface JSDCalendarVC ()

@property (nonatomic, strong) JSDTargetHeaderReusableView* headerView;
@property (nonatomic, strong) NSArray* weekArray;
@property (nonatomic, strong) JSDCalendarViewModel* viewModel;

@end

@implementation JSDCalendarVC

static NSString * const reuseIdentifier = @"Cell";
static NSString * const headerReuseIdentifier = @"header";

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
    
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"JSDCalenderViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];

    [self.view addSubview:self.headerView];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(70);
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
    
    [self.viewModel update];
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 7;
    } else {
        return (self.viewModel.titleArray.count + self.viewModel.index); // 偏移设置
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JSDCalenderViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.titleLabel.text = self.weekArray[indexPath.item];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    } else {
        if (indexPath.row >= self.viewModel.index) {
            cell.titleLabel.text = self.viewModel.titleArray[indexPath.row - self.viewModel.index]; // 偏移取值
            if (self.viewModel.isShowCurrentMonth) {
                if (self.viewModel.dayIndex == indexPath.row) {
                    cell.contentView.backgroundColor = [UIColor jsd_mainBlueColor];
                } else {
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                }
            } else {
                cell.contentView.backgroundColor = [UIColor whiteColor];
            }
        } else {
            cell.titleLabel.text = nil;
        }
    }
//    cell.layer.cornerRadius = 16;
//    cell.layer.masksToBounds = YES;
    
    return cell;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//    UICollectionReusableView* headerView;
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerReuseIdentifier forIndexPath:indexPath];
//        headerView.backgroundColor = [UIColor whiteColor];
//    }
//
//    return headerView;
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((collectionView.jsd_width - (6 * 10) - 20) / 7, 32);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 10, 10, 10);
    } else {
        return UIEdgeInsetsMake(0, 10, 15, 10);
    }
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//
//    return CGSizeMake(collectionView.jsd_width, 50);
//}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
 return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 
 }
 */

#pragma mark - 5.Event Response

- (void)onTouchHeaderViewLeftButton:(UIButton *)sender {

    [self.viewModel lastMonthd];
    [self.collectionView reloadData];
    self.headerView.titleLabel.text = [NSString stringWithFormat:@"%ld 年 %ld 月", self.viewModel.year, self.viewModel.month];
    //TODO:
    if (self.viewModel.month == 8) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kTargetCalenderShow object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kTargetCalenderHide object:nil];
    }
}

- (void)onTouchHeaderViewRightButton:(UIButton *)sender {
    
    [self.viewModel nextMonthd];
    [self.collectionView reloadData];
    self.headerView.titleLabel.text = [NSString stringWithFormat:@"%ld 年 %ld 月", self.viewModel.year, self.viewModel.month];
    //
    if (self.viewModel.month == 8) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kTargetCalenderShow object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kTargetCalenderHide object:nil];
    }
}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

- (JSDTargetHeaderReusableView *)headerView {
    
    if (!_headerView) {
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"JSDTargetHeaderReusableView" owner:nil options:nil].lastObject;
        [_headerView.leftButton addTarget:self action:@selector(onTouchHeaderViewLeftButton:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.rightButton addTarget:self action:@selector(onTouchHeaderViewRightButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _headerView;
}

- (NSArray *)weekArray {
    
    if (!_weekArray) {
        _weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六",
                       ];
    }
    return _weekArray;
}

- (JSDCalendarViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [[JSDCalendarViewModel alloc] init];
    }
    return _viewModel;
}

@end
