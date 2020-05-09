//
//  JTCodeLoginController.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTCodeLoginController.h"
#import "JTPwdLoginController.h" //账号密码登录
#import "JTRegisterAccountController.h" //注册
#import "JTUserPhoneController.h" //绑定手机

#import "JTBaseNavigationController.h"
#import "JTBaseTabBarController.h"

#import "JTGradientBgButton.h"
#import "ZYSendMobileCodeBtn.h"
#import "JTLoginModel.h"  //登录模型


@interface JTCodeLoginController ()

@property (nonatomic,strong) UITextField *AccountTF;
@property (nonatomic,strong) UITextField *CodeTF;
@property (nonatomic,strong) ZYSendMobileCodeBtn *GetCodeBtn;

@property (nonatomic,strong) JTGradientBgButton *LoginBtn;


@end

@implementation JTCodeLoginController


- (void)viewWillAppear:(BOOL)animated {
    
    self.navColor = [UIColor clearColor];
    [super viewWillAppear:animated];
}


/*
 0 微信登录 1 QQ登录 2 手机验证码登录 3手机号密码登录 4 手机注册并登录
 
 微信与QQ登录时，如果返回对象的ID为-1
 则转跳请求手机验证码页面，后通过请求
 QQ微信第一次登录绑定手机号接口
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"登录";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"注册" target:self action:@selector(registerBtnClick)];
    
    
}

#pragma mark - 注册按钮点击 -
- (void)registerBtnClick {
    
    JTBaseNavigationController *VC =  [[JTBaseNavigationController alloc] initWithRootViewController:[[JTRegisterAccountController alloc] init]];
//    VC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //    [self.navigationController pushViewController:VC animated:YES];
    
    [self presentViewController:VC animated:YES completion:nil];
}


- (void)configUI {
    
    UIImageView *Icon =[UIImageView new];
    Icon.image = JGImage(@"LOGO");
    
    
    UILabel *accountLbl = [UILabel new];
    accountLbl.text = @"手机号";
    accountLbl.textColor = JG333Color;
    accountLbl.font = JGFont(15);
    
    
    _AccountTF = [UITextField new];
    _AccountTF.clearButtonMode =  UITextFieldViewModeAlways;
    _AccountTF.placeholder = @"请输入手机号";
    //    _AccountTF.text = [JGCommonTools getUserDefaultsWithKey:@"name"];
    [_AccountTF setValue:JGHexColor(@"#999999") forKeyPath:@"_placeholderLabel.textColor"];
    [_AccountTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    //    _AccountTF.keyboardType = UIKeyboardTypeNumberPad;
    [_AccountTF addTarget:self action:@selector(textFChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *AccountBL = [UIView new];
    AccountBL.backgroundColor = JGLineColor;
    
    
    UILabel *PasswordLbl = [UILabel new];
    PasswordLbl.text = @"验证码";
    PasswordLbl.textColor = JG333Color;
    PasswordLbl.font = JGFont(15);
    
    
    _CodeTF = [UITextField new];
    _CodeTF.placeholder = @"请输入验证码";
//    _CodeTF.clearButtonMode =  UITextFieldViewModeAlways;
    [_CodeTF setValue:JG999Color forKeyPath:@"_placeholderLabel.textColor"];
    [_CodeTF setValue:JGFont(15) forKeyPath:@"_placeholderLabel.font"];
//    _CodeTF.secureTextEntry = YES;
    [_CodeTF addTarget:self action:@selector(textFChange:) forControlEvents:UIControlEventEditingChanged];
    
    _GetCodeBtn = [ZYSendMobileCodeBtn new];
    WEAKSELF;
    _GetCodeBtn.countDownButtonBlock = ^{
        
        [weakSelf SendCodeBtnClick];
    };
    
    
    UIView *PasswordBL = [UIView new];
    PasswordBL.backgroundColor = JGLineColor;
    
    
   UIButton *otherLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [otherLogin setTitle:@"账号密码登录" forState:UIControlStateNormal];
    otherLogin.titleLabel.font = JGFont(14);
    otherLogin.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [otherLogin setTitleColor:JGHexColor(@"#4587F6") forState:UIControlStateNormal];
    [otherLogin addTarget:self action:@selector(otherLoginClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _LoginBtn = [JTGradientBgButton buttonWithType:UIButtonTypeCustom];
    //    _LoginBtn.enabled = (_AccountTF.text.length) && (_CodeTF.text.length);
    [_LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_LoginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *LeftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidthScale(103), 1)];
    [LeftLine addBorderDottedLinewithColor:JGHexColor(@"#A7A6A6")];
    
    UILabel *InfoLbl = [UILabel new];
    InfoLbl.text = @"极速登录";
    InfoLbl.textColor = JG666Color;
    InfoLbl.font = JGFont(15);
    
    
    UIView *RightLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidthScale(103), 1)];
    [RightLine addBorderDottedLinewithColor:JGHexColor(@"#A7A6A6")];
    
    UIButton *WXLogin = [UIButton new];
    [WXLogin setImage:JGImage(@"Login_WeChat") forState:UIControlStateNormal];
    [WXLogin addTarget:self action:@selector(WXLoginClick) forControlEvents:UIControlEventTouchUpInside];;
    
    
    UIButton *QQLogin = [UIButton new];
    [QQLogin setImage:JGImage(@"Login_QQ") forState:UIControlStateNormal];
    [QQLogin addTarget:self action:@selector(QQLoginClick) forControlEvents:UIControlEventTouchUpInside];;

    
    
    [self.view addSubview:Icon];
    [self.view addSubview:accountLbl];
    [self.view addSubview:_AccountTF];
    [self.view addSubview:AccountBL];
    
    [self.view addSubview:PasswordLbl];
    [self.view addSubview:_CodeTF];
    [self.view addSubview:_GetCodeBtn];
    [self.view addSubview:PasswordBL];

    [self.view addSubview:otherLogin];
    [self.view addSubview:_LoginBtn];
    
    
    [self.view addSubview:LeftLine];
    [self.view addSubview:InfoLbl];
    [self.view addSubview:RightLine];
    [self.view addSubview:WXLogin];
    [self.view addSubview:QQLogin];
    
    [Icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).mas_offset(79);
    }];
    
    [accountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(AccountBL.mas_left);
        make.centerY.equalTo(_AccountTF.mas_centerY);
        make.width.equalTo(@(80));
    }];
    
    [_AccountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountLbl.mas_right);
        make.right.equalTo(AccountBL.mas_right);
        make.top.equalTo(self.view.mas_top).mas_offset(97 + SJHeight);
        make.height.equalTo(@(52));
    }];
    
    if (kDeviceWidth == 320 && kDeviceHight == 1136 / 2) {
        [AccountBL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).mas_offset(44);
            make.right.equalTo(self.view.mas_right).mas_offset(-24);
            make.top.equalTo(_AccountTF.mas_bottom);
            make.height.equalTo(@(1));
        }];
    }else{
        [AccountBL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).mas_offset(44);
            make.right.equalTo(self.view.mas_right).mas_offset(-44);
            make.top.equalTo(_AccountTF.mas_bottom);
            make.height.equalTo(@(1));
        }];
        
    }
    
    
    
    [PasswordLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(AccountBL.mas_left);
        make.centerY.equalTo(_CodeTF.mas_centerY);
        make.width.equalTo(accountLbl.mas_width);
    }];
    if (kDeviceWidth == 320 && kDeviceHight == 1136 / 2) {
        [_CodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_AccountTF.mas_left);
            make.top.equalTo(AccountBL.mas_bottom).mas_offset(6);
            make.height.equalTo(@(52));
            //        make.right.equalTo(_GetCodeBtn.mas_left);
        }];
    }else{
        [_CodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_AccountTF.mas_left);
            make.top.equalTo(AccountBL.mas_bottom).mas_offset(6);
            make.height.equalTo(@(52));
            make.right.equalTo(_GetCodeBtn.mas_left);
        }];
    }
//    [_CodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_AccountTF.mas_left);
//        make.top.equalTo(AccountBL.mas_bottom).mas_offset(6);
//        make.height.equalTo(@(52));
////        make.right.equalTo(_GetCodeBtn.mas_left);
//    }];
    
    [_GetCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).mas_offset(-10);
        make.top.bottom.equalTo(_CodeTF);
//        make.width.equalTo(@(70));
    }];
    
    [PasswordBL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(AccountBL);
        make.top.equalTo(_CodeTF.mas_bottom);
        make.height.equalTo(@(1));
    }];
    
    [otherLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(PasswordBL);
        make.height.equalTo(@(45));
        make.width.equalTo(@(200));
    }];
    
    
    [_LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(AccountBL);
        make.top.equalTo(PasswordBL.mas_bottom).mas_offset(77);
        make.height.equalTo(@(47));
    }];
    
    [LeftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(InfoLbl.mas_centerY);
        make.right.equalTo(InfoLbl.mas_left).mas_offset(-12);
        make.height.equalTo(@(1));
        make.width.equalTo(@(kWidthScale(103)));;
    }];
    
    [InfoLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(_LoginBtn.mas_bottom).mas_offset(70);
    }];
    
    [RightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(LeftLine);
        make.left.equalTo(InfoLbl.mas_right).mas_offset(12);
    }];
    
    [WXLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).mas_offset(-40);
        make.top.equalTo(InfoLbl.mas_bottom).mas_offset(40);
        make.width.height.equalTo(@(40));
    }];
    
    [QQLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(WXLogin);
        make.centerX.equalTo(self.view.mas_centerX).mas_offset(40);
    }];
}

- (void)textFChange:(UITextField *)textField {
    
    //    _LoginBtn.enabled = (_AccountTF.text.length) && (_CodeTF.text.length);
}


/**
 开始获取验证码
 */
- (void)SendCodeBtnClick {
    
    JGLog(@"开始获取验证码");
    
    
    NSString *PhoneStr = [NSString pureStrWithOriginStr:_AccountTF.text];
    
    //    [self.SendCodeBtn sentCodeBtnClick];
    
    if (!PhoneStr.length) {
        //        [self.SendCodeBtn reSetCodeBtn];
        [JGToast showWithText:@"请输入手机号"];
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"phone"] = PhoneStr;
    parameters[@"type"] = @(2);

    WEAKSELF;
    [ZYHttpManager HttpRequestDataWithApi:JTUserGetCode Aarameters:parameters httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        
//        JGLog(@"%@", data);
        [weakSelf.GetCodeBtn sentCodeBtnClick];

    } failure:^(NSString * _Nonnull message) {
        [JGToast showWithText:message];
    }];
}



#pragma mark - 登录 按钮点击 -
- (void)loginBtnClick {
    
    NSString *PhoneStr = [NSString pureStrWithOriginStr:_AccountTF.text];
    NSString *CodeStr = [NSString pureStrWithOriginStr:_CodeTF.text];
    
    if (!PhoneStr.length) {
        [JGToast showWithText:@"请输入手机号"];
        return;
    }
    
    if (!CodeStr.length) {
        [JGToast showWithText:@"请输入验证码"];
        return;
    }
    
    [self.view endEditing:YES];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"phone"] = PhoneStr;
    parameters[@"code"] = CodeStr;
    parameters[@"type"] = @(2);
    
    [ZYHttpManager LoadingHttpRequestDataWithApi:JTUserLogin Aarameters:parameters httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        
        JGLog(@"%@", data);
        //数据模型化
        JTLoginModel *model = [JTLoginModel mj_objectWithKeyValues:data];
        //直接转存
        [model saveUserInfo];
        //切换window跟控制器
        [UIApplication sharedApplication].keyWindow.rootViewController = [[JTBaseTabBarController alloc] init];
    } failure:^(NSString * _Nonnull message) {
        [JGToast showWithText:message];
    }];
}



#pragma mark - 账号密码 按钮点击 -
- (void)otherLoginClick {

    JTBaseNavigationController *VC =  [[JTBaseNavigationController alloc] initWithRootViewController:[[JTPwdLoginController alloc] init]];
//    VC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:VC animated:YES completion:nil];
}


- (void)WXLoginClick {

     WEAKSELF;
    [[JTWeChatOrQQLoginTool shared] WX_LoginSuccess:^(JTLoginModel * _Nonnull Model) {
        [weakSelf TiirdLoginWithModel:Model];
    } Failure:^(NSString * _Nonnull message) {
    }];
}


- (void)QQLoginClick {
    
    WEAKSELF;
    [[JTWeChatOrQQLoginTool shared] QQ_LoginSuccess:^(JTLoginModel * _Nonnull Model) {
        [weakSelf TiirdLoginWithModel:Model];
    } Failure:^(NSString * _Nonnull message) {
    }];
}

//微信与QQ登录时，如果返回对象的ID为-1
//则转跳请求手机验证码页面，后通过请求
//QQ微信第一次登录绑定手机号接口
- (void)TiirdLoginWithModel:(JTLoginModel *)model {
    
    if ([model.user_id intValue] != -1) {
        
        //直接转存
        [model saveUserInfo];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = [[JTBaseTabBarController alloc] init];
    }else {
        
        JTUserPhoneController *VC = [[JTUserPhoneController alloc] init];
        VC.Model = model;
        [self.navigationController pushViewController:VC animated:YES];
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
