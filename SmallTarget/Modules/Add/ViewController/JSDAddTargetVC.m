//
//  JSDTargetVC.m
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDAddTargetVC.h"
#import "JSDStackView.h"
#import "JSDSelectedImageView.h"
#import <BRPickerView.h>
#import <UIViewController+KeyboardAnimation.h>
#import "JSDTargetViewModel.h"
#import "JSDTargetManage.h"

@interface JSDAddTargetVC ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;
@property (weak, nonatomic) IBOutlet UILabel *targetTitleLabel;
@property (weak, nonatomic) IBOutlet MDCTextField *targetTextField;
@property (strong, nonatomic) MDCTextInputControllerUnderline *targetTextFieldController;
@property (weak, nonatomic) IBOutlet UILabel *selectedTargetTitleLabel;

@property (weak, nonatomic) IBOutlet JSDSelectedImageView *selectedImageView;

@property (weak, nonatomic) IBOutlet UILabel *finishTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishSubtitleLabel;
@property (weak, nonatomic) IBOutlet JSDStackView *selectedFinishView;

@property (weak, nonatomic) IBOutlet UILabel *tipTimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipSubtitleLabel;
@property (weak, nonatomic) IBOutlet MDCButton *addTimerButton;
@property (weak, nonatomic) IBOutlet MDCFloatingButton *showTipTimerButton;

@property (weak, nonatomic) IBOutlet UILabel *sayingTitleLabel;
@property (weak, nonatomic) IBOutlet MDCTextField *sayingTextField;
@property (strong, nonatomic) MDCTextInputControllerUnderline *sayingTextFieldController;

@property (weak, nonatomic) IBOutlet MDCButton *addTargetButton;

@property (nonatomic, strong) JSDTargetModel* model;
@property (nonatomic, strong) NSMutableArray* selectedFinishArr;
@property (nonatomic, strong) JSDTargetManage* manage;

@end

@implementation JSDAddTargetVC

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
    
    self.tabBarController.tabBar.hidden = YES;
    
//    [self an_unsubscribeKeyboard];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear: animated];
    
//    [self an_unsubscribeKeyboard];
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    
    self.title = @"添加目标";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(didTapBack:)];
    UIImage *backImage = [UIImage imageNamed:@"back"];
    backButton.image = backImage;
    backButton.tintColor = [UIColor jsd_colorWithHexString:@"#333333"];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollContentView.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTouchTap:)];
    [self.scrollContentView addGestureRecognizer:tap];
    
    self.targetTitleLabel.font = [UIFont jsd_fontSize: 19];
    self.targetTitleLabel.textColor = [UIColor jsd_mainBlackColor];
    self.targetTitleLabel.text = @"目标名称";
    
    [self targetTextFieldController];
    
    self.selectedTargetTitleLabel.font = [UIFont jsd_fontSize:19];
    self.selectedTargetTitleLabel.textColor = [UIColor jsd_mainBlackColor];
    self.selectedTargetTitleLabel.text = @"挑选图标";
    
    self.finishTitleLabel.font = [UIFont jsd_fontSize:19];
    self.finishTitleLabel.textColor = [UIColor jsd_mainBlackColor];
    self.finishTitleLabel.text = @"打开时间";
    
    self.finishSubtitleLabel.font = [UIFont jsd_fontSize:16];
    self.finishSubtitleLabel.textColor = [UIColor jsd_subTitleColor];
    self.finishSubtitleLabel.text = @"/一周中的什么时候";
    
    NSArray* titles = @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"];
    CGFloat width = (ScreenWidth - 30 - (6 * 5)) / 7;
    for (NSInteger i = 0; i < 7; i++) {
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn addTarget:self action:@selector(onTouchFinishTimer:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont jsd_fontSize:13]];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor jsd_colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [btn jsd_setBackgroundColor:[UIColor jsd_colorWithHexString:@"#E2E2E2"] forState:UIControlStateNormal];
        [btn jsd_setBackgroundColor:[UIColor jsd_mainBlueColor] forState:UIControlStateSelected];
        [self.selectedFinishView addArrangedSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(btn.mas_width);
        }];
        btn.layer.cornerRadius = width / 2;
        btn.layer.masksToBounds = YES;
    }
    
    self.tipTimerLabel.font = [UIFont jsd_fontSize:19];
    self.tipTimerLabel.textColor = [UIColor jsd_mainBlackColor];
    self.tipTimerLabel.text = @"设置提醒时间";
    
    self.tipSubtitleLabel.font = [UIFont jsd_fontSize:16];
    self.tipSubtitleLabel.textColor = [UIColor jsd_mainBlackColor];
    self.tipSubtitleLabel.text = @"指定时间前未完成目标，小目标会提醒你";
    
    self.addTimerButton.backgroundColor = [UIColor jsd_colorWithHexString:@"#E2E2E2"];
    self.addTimerButton.layer.cornerRadius = 25;
    [self.addTimerButton setImage:[UIImage imageNamed:@"add_timer"] forState:UIControlStateNormal];
    self.addTimerButton.layer.masksToBounds = YES;
    [self.addTimerButton addTarget:self action:@selector(onTouchSetupTimer:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.showTipTimerButton setTitleFont:[UIFont jsd_fontSize:14] forState:UIControlStateNormal];
    [self.showTipTimerButton setTintColor:[UIColor jsd_mainBlueColor]];
    [self.showTipTimerButton setBackgroundColor:[UIColor jsd_colorWithHexString:@"#D5ECFD"]];
    [self.showTipTimerButton setTitle:@"10:50" forState:UIControlStateNormal];
    [self.showTipTimerButton setImage:[UIImage imageNamed:@"close_timer"] forState:UIControlStateNormal];
//    self.showTipTimerButton.contentMode
    [self.showTipTimerButton setImageTintColor:[UIColor jsd_colorWithHexString:@"#f5b853"] forState:UIControlStateNormal];
    self.showTipTimerButton.hidden = YES;
//    self.showTipTimerButton.imageLocation = MDCFloatingButtonImageLocationTrailing;
//    self.showTipTimerButton.imageTitleSpace = 20;
    
    self.sayingTitleLabel.font = [UIFont jsd_fontSize:19];
    self.sayingTitleLabel.textColor = [UIColor jsd_mainBlackColor];
    self.sayingTitleLabel.text = @"写一句话来激励自己";
    
    [self sayingTextFieldController];
    
    [self.addTargetButton setBackgroundColor:[UIColor jsd_mainBlueColor]];
    [self.addTargetButton setTitleFont:[UIFont jsd_fontSize:17] forState:UIControlStateNormal];
    [self.addTargetButton setTintColor:[UIColor whiteColor]];
    [self.addTargetButton setTitle:@"确定添加目标" forState:UIControlStateNormal];
//    [self.addTimerButton addTarget:self action:@selector(onTouchConfirmAdd:) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"anniu ???%@", self.addTimerButton);
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - 5.Event Response

// 选择打卡时间;
- (void)onTouchFinishTimer:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;
    if (sender.selected) {
        if (![self.selectedFinishArr containsObject:@(sender.tag).stringValue]) {
            [self.selectedFinishArr addObject:@(sender.tag).stringValue];
        }
    } else {
        if ([self.selectedFinishArr containsObject:@(sender.tag).stringValue]) {
            [self.selectedFinishArr removeObject:@(sender.tag).stringValue];
        }
    }
}
// 点击返回
- (void)didTapBack:(id)sender {
    
    self.tabBarController.selectedIndex = 0;
    
    self.tabBarController.tabBar.hidden = NO;
}
// 点击收回键盘
- (void)onTouchTap:(id)sender {
    
    [self.scrollContentView endEditing: YES];
}

// 添加设置通知时间
- (void)onTouchSetupTimer:(MDCButton *)sender {
    
    [BRDatePickerView showDatePickerWithTitle:@"设置通知时间" dateType:BRDatePickerModeHM defaultSelValue:@"08:00" resultBlock:^(NSString *selectValue) {
        
        NSLog(@"选中时间%@", selectValue);
        self.showTipTimerButton.hidden = NO;
        [self.showTipTimerButton setTitle:selectValue forState:UIControlStateNormal];
    }];
}

- (IBAction)onTouchConfirmAddButton:(MDCButton *)sender {
    
    BOOL havaTitle = JSDIsString(self.targetTextField.text);
    if (havaTitle) {
        [self savaTargetData];
    } else {
        MDCSnackbarManager* manager = [MDCSnackbarManager defaultManager];
        MDCSnackbarMessage* message = [MDCSnackbarMessage messageWithText:@"请添加标题"];
        [manager showMessage:message];
    }
}

- (void)savaTargetData {
    
    self.model.title = self.targetTextField.text;
    self.model.encourage = self.sayingTextField.text;
    if (self.selectedImageView.lastButton) {
        self.model.imageView = [NSString stringWithFormat:@"target_%ld_selected", self.selectedImageView.lastButton.tag];
    } else {
        self.model.imageView = @"target_0_selected";
    }
    //保存打开时间.
    if (!self.selectedFinishArr.count) {
        self.model.finishWeekDays = @[@"0"].mutableCopy;
    } else {
        self.model.finishWeekDays = self.selectedFinishArr;
    }
    
    [self.manage addTargetModel:self.model];
    
    JSDTargetViewModel* viewModel = [[JSDTargetViewModel alloc] init];
    
    NSLog(@"%@", viewModel.listArray);
}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

- (MDCTextInputControllerUnderline *)targetTextFieldController {
    
    if (!_targetTextFieldController) {
        _targetTextFieldController = [[MDCTextInputControllerUnderline alloc] initWithTextInput: self.targetTextField];
        _targetTextFieldController.normalColor = ColorWithFROMRGB(0xdddddd, 1);
        _targetTextFieldController.activeColor = [UIColor blueColor];
        _targetTextFieldController.borderFillColor = [UIColor jsd_colorWithHexString:@"#F5F5F5"];
        _targetTextFieldController.placeholderText = @"输入你要坚持的目标吧";
    }
    return _targetTextFieldController;
}

- (MDCTextInputControllerUnderline *)sayingTextFieldController {
    
    if (!_sayingTextFieldController) {
        _sayingTextFieldController = [[MDCTextInputControllerUnderline alloc] initWithTextInput: self.sayingTextField];
        _sayingTextFieldController.normalColor = ColorWithFROMRGB(0xdddddd, 1);
        _sayingTextFieldController.activeColor = [UIColor blueColor];
        _sayingTextFieldController.borderFillColor = [UIColor jsd_colorWithHexString:@"#F5F5F5"];
        _sayingTextFieldController.placeholderText = @"坚持就是胜利";
    }
    return _sayingTextFieldController;
}

- (JSDTargetModel *)model {
    
    if (!_model) {
        _model = [[JSDTargetModel alloc] init];
    }
    return _model;
}

- (NSMutableArray *)selectedFinishArr {
    
    if (!_selectedFinishArr) {
        _selectedFinishArr = NSMutableArray.new;
    }
    return _selectedFinishArr;
}

- (JSDTargetManage *)manage {
    
    if (!_manage) {
        _manage = [[JSDTargetManage alloc] init];
    }
    return _manage;
}

@end

