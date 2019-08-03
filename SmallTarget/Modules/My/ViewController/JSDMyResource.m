//
//  JSDMyResource.m
//  SmallTarget
//
//  Created by ada on 2019/8/3.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDMyResource.h"

@interface JSDMyResource ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *imageTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameTitleLabel;
@property (weak, nonatomic) IBOutlet MDCTextField *nameTextField;
@property (strong, nonatomic) MDCTextInputControllerUnderline *nameTextController;
@property (weak, nonatomic) IBOutlet MDCButton *savaButton;
@property (weak, nonatomic) IBOutlet UIButton *selectedImageButton;
@property (assign, nonatomic) BOOL havaPhoto;

@end

@implementation JSDMyResource

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
    
    self.title = @"个人资料";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor jsd_mainGrayColor];
    
    self.imageTitleLabel.textColor = [UIColor jsd_subTitleColor];
    self.imageTitleLabel.font = [UIFont jsd_fontSize:16];
    
    self.nameTitleLabel.textColor = [UIColor jsd_mainBlackColor];
    self.nameTitleLabel.font = [UIFont jsd_fontSize:19];
    
    [self nameTextController];
    
    [self.savaButton setTitleFont:[UIFont jsd_fontSize:20] forState:UIControlStateNormal];
    [self.savaButton setTintColor:[UIColor whiteColor]];
    [self.savaButton setBackgroundColor:[UIColor jsd_mainBlueColor]];
    [self.savaButton addTarget:self action:@selector(onTouchSave:) forControlEvents:UIControlEventTouchUpInside];
    
    self.imageView.layer.cornerRadius = 35;
    self.imageView.layer.masksToBounds = YES;
    
    [self.selectedImageButton addTarget:self action:@selector(onTouchSelectedImage:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
    self.nameTextField.text = self.model.userName;
    
    if (self.model.userImageView) {
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        NSString* filePath = [NSString stringWithFormat:@"%@/%@.png", documentsDirectory, self.model.userImageView];
        self.imageView.image = [UIImage imageWithContentsOfFile:filePath];
        
    } else {
        self.imageView.image = [UIImage imageNamed:@"user"];
    }
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - 5.Event Response

- (void)onTouchSave:(id)sender {
    BOOL havaTitle = JSDIsString(self.nameTextField.text);
    if (havaTitle) {
        
        JSDMyCenterViewModel* viewmodel = [[JSDMyCenterViewModel alloc] init];
        viewmodel.userData.userName = self.nameTextField.text;
        
        if (self.havaPhoto) {
            
            NSDate* date = [NSDate date];
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSString* dateString = [formatter stringFromDate:date];
            
            viewmodel.userData.userImageView = [NSString stringWithFormat:@"%@%@", kJSDPhotoImageFiles, dateString];
            [JSDPhotoManage savaImageView:self.imageView fileName: dateString];
        }
        [viewmodel saveUserData];
        [self.navigationController popViewControllerAnimated:YES];
        MDCSnackbarManager* manager = [MDCSnackbarManager defaultManager];
        MDCSnackbarMessage* message = [MDCSnackbarMessage messageWithText:@"个人资料修改成功"];
        [manager showMessage:message];
        
    } else {
        MDCSnackbarManager* manager = [MDCSnackbarManager defaultManager];
        MDCSnackbarMessage* message = [MDCSnackbarMessage messageWithText:@"请输入昵称"];
        [manager showMessage:message];
    }
}

- (void)onTouchSelectedImage:(UIButton*)sender {
    
    [JSDPhotoManage presentWithViewController:self sourceType:JSDImagePickerSourceTypePhotoLibrary finishPicking:^(UIImage * _Nonnull image) {
        if (image) {
            self.havaPhoto = YES;
            self.imageView.contentMode = UIViewContentModeScaleToFill;
            self.imageView.image = image;
        } else {
        }
    }];
}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

- (MDCTextInputControllerUnderline *)nameTextController {
    
    if (!_nameTextController) {
        _nameTextController = [[MDCTextInputControllerUnderline alloc] initWithTextInput: self.nameTextField];
        _nameTextController.normalColor = ColorWithFROMRGB(0xdddddd, 1);
        _nameTextController.activeColor = [UIColor blueColor];
        _nameTextController.borderFillColor = [UIColor whiteColor];
        _nameTextController.placeholderText = @"请输入新的昵称";
    }
    return _nameTextController;
}

@end
