//
//  JSDFeedBacksVC.m
//  JerseyCoffee
//
//  Created by Jersey on 2019/7/26.
//  Copyright © 2019 jerseyCafe. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "JSDFeedBacksVC.h"

static NSString* const kFeedBackSussessTip = @"非常感谢您使用助记, 我们会认真查看您反馈的信息, 并且去尝试改进!";
static NSString* const kFeedBackTip = @"非常感谢您的使用助记, 欢迎您给我们提供任何建议!";
static NSString* const kFeedBackEmail = @"zexi0625@gmail.com";
static NSString* const kFeedBackEmailTitle = @"App 使用反馈";
static NSString* const kFeedBackEmailSubTitle = @"Hi. Jersey \n 我在使用 App 过程有发现了问题.";

static NSString* const kFeedBackErrorTipTitle = @"温馨提示";
static NSString* const kFeedBackErrorTipSubTitle = @"请打开\"(邮件App)\"设置你的邮箱账号";


@interface JSDFeedBacksVC () <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UILabel* tipLabel;
@property (nonatomic, strong) MDCRaisedButton* senderEmail;
@property (nonatomic, copy) NSString* emailText;

@end

@implementation JSDFeedBacksVC

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
    self.navigationItem.title = @"意见反馈";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor jsd_grayColor];
    
    [self.view addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
    
    self.senderEmail = [[MDCRaisedButton alloc] init];
    [self.senderEmail setTitle:@"发送邮件" forState:UIControlStateNormal];
    [self.senderEmail addTarget:self action:@selector(onTouchSendEmail:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.senderEmail];
    [self.senderEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.tipLabel.mas_bottom).mas_equalTo(30);
    }];
    
    //判断用户是否已设置邮件账户
    if ([MFMailComposeViewController canSendMail]) {
        [self setupEmailAction]; // 调用发送邮件的代码
    }else{
        //给出提示,设备未开启邮件服务
        UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:kFeedBackErrorTipTitle message:kFeedBackErrorTipSubTitle delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alerView show];
    }
}

-(void)setupEmailAction{
    // 创建邮件发送界面
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    // 设置邮件代理
    [mailCompose setMailComposeDelegate:self];
    // 设置收件人
    [mailCompose setToRecipients:@[kFeedBackEmail]];
    // 设置邮件主题
    [mailCompose setSubject:kFeedBackEmailTitle];
    //设置邮件的正文内容
    NSString *emailContent = kFeedBackEmailSubTitle;
    // 是否为HTML格式
    [mailCompose setMessageBody:emailContent isHTML:NO];
    
    [self presentViewController:mailCompose animated:YES completion:nil];
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - MFMailComposeViewControllerDelegate的代理方法：

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail send canceled: 用户取消编辑");
            [self dismissViewControllerAnimated:YES completion: ^{
            }];
            break;
        case MFMailComposeResultSaved:
            [self dismissViewControllerAnimated:YES completion: ^{
            }];
            break;
        case MFMailComposeResultSent: {
            NSLog(@"Mail sent: 用户点击发送");
            // 关闭邮件发送视图
            MDCSnackbarManager* manager = [MDCSnackbarManager defaultManager];
            MDCSnackbarMessage* message = [MDCSnackbarMessage messageWithText: kFeedBackSussessTip];
            [self dismissViewControllerAnimated:YES completion: ^{
                [manager showMessage:message];
            }];
            break;
        }
        case MFMailComposeResultFailed:
            NSLog(@"Mail send errored: %@ : 用户尝试保存或发送邮件失败", [error localizedDescription]);
            break;
    }

}

#pragma mark - 5.Event Response

- (void)onTouchSendEmail:(id) sender {
    
    //判断用户是否已设置邮件账户
    if ([MFMailComposeViewController canSendMail]) {
        [self setupEmailAction]; // 调用发送邮件的代码
    }else{
        //给出提示,设备未开启邮件服务
        UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:kFeedBackErrorTipTitle message:kFeedBackErrorTipSubTitle delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alerView show];
    }
}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:20];
        _tipLabel.numberOfLines = 0;
        _tipLabel.text = kFeedBackTip;
    }
    return _tipLabel;
}

@end
