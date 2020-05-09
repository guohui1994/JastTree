//
//  JTRegisterAccountController.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTRegisterAccountController.h"
#import "JTWKWebProtocolController.h"//注册协议
#import "JTRegisterAgreementBtn.h"
#import "ZYSendMobileCodeBtn.h"
#import "JTGradientBgButton.h"


#import "JTBaseTabBarController.h"

#import "JTLoginModel.h"  //登录模型

@interface JTRegisterAccountController ()

@property (nonatomic,strong) UITextField *AccountTF;
@property (nonatomic,strong) UITextField *CodeTF;
@property (nonatomic,strong) ZYSendMobileCodeBtn *GetCodeBtn;

@property (nonatomic,strong) UITextField *PwdTF;
@property (nonatomic,strong) UITextField *SurePwdTF;

@property (nonatomic,strong) JTRegisterAgreementBtn *AgreementBtn;
@property (nonatomic,strong) UIButton *ProtocalBtn;
@property (nonatomic,strong) UIButton *RegisterBtn;

//需要的H5链接
@property (nonatomic,copy) NSString *ShowH5Url;

@end

@implementation JTRegisterAccountController

- (void)viewWillAppear:(BOOL)animated {
    
    self.navColor = [UIColor clearColor];
    [super viewWillAppear:animated];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"注册";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"登录" target:self action:@selector(registerBtnClick)];
    
    [self LoadHtmlUrlStr];
}


#pragma mark - 加载注册协议连接 -
- (void)LoadHtmlUrlStr {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"parameterName"] = @"user_registration_service_agreement";
    
    WEAKSELF;
    [ZYHttpManager LoadingHttpRequestDataWithApi:JTSystemSelectValue Aarameters:parameters httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        
        JGLog(@"%@", data);
        weakSelf.ShowH5Url = data;
        
    } failure:^(NSString * _Nonnull message) {
        [JGToast showWithText:message];
    }];
    
}




- (void)registerBtnClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)configUI {
    
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
//    [_AccountTF addTarget:self action:@selector(textFChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *AccountBL = [UIView new];
    AccountBL.backgroundColor = JGLineColor;
    
    
    UILabel *codeLbl = [UILabel new];
    codeLbl.text = @"验证码";
    codeLbl.textColor = JG333Color;
    codeLbl.font = JGFont(15);
    
    
    _CodeTF = [UITextField new];
    _CodeTF.placeholder = @"请输入验证码";
//    _CodeTF.clearButtonMode =  UITextFieldViewModeAlways;
    _CodeTF.text = [JGCommonTools getUserDefaultsWithKey:@"password"];
    [_CodeTF setValue:JG999Color forKeyPath:@"_placeholderLabel.textColor"];
    [_CodeTF setValue:JGFont(15) forKeyPath:@"_placeholderLabel.font"];
//    [_CodeTF addTarget:self action:@selector(textFChange:) forControlEvents:UIControlEventEditingChanged];
    
    _GetCodeBtn = [ZYSendMobileCodeBtn new];
    WEAKSELF;
    _GetCodeBtn.countDownButtonBlock = ^{
        
        [weakSelf SendCodeBtnClick];
    };
    
    
    UIView *CodeBL = [UIView new];
    CodeBL.backgroundColor = JGLineColor;
    
    
    
    UILabel *PwdLbl = [UILabel new];
    PwdLbl.text = @"密码";
    PwdLbl.textColor = JG333Color;
    PwdLbl.font = JGFont(15);
    
    
    _PwdTF = [UITextField new];
    _PwdTF.clearButtonMode =  UITextFieldViewModeAlways;
    _PwdTF.placeholder = @"请输入密码";
    //    _AccountTF.text = [JGCommonTools getUserDefaultsWithKey:@"name"];
    [_PwdTF setValue:JGHexColor(@"#999999") forKeyPath:@"_placeholderLabel.textColor"];
    [_PwdTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    //    _AccountTF.keyboardType = UIKeyboardTypeNumberPad;
    //    [_AccountTF addTarget:self action:@selector(textFChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *PwdBL = [UIView new];
    PwdBL.backgroundColor = JGLineColor;
  
    UILabel *SurePwdLbl = [UILabel new];
    SurePwdLbl.text = @"确认密码";
    SurePwdLbl.textColor = JG333Color;
    SurePwdLbl.font = JGFont(15);
    
    
    _SurePwdTF = [UITextField new];
    _SurePwdTF.clearButtonMode =  UITextFieldViewModeAlways;
    _SurePwdTF.placeholder = @"请确认密码";
    //    _AccountTF.text = [JGCommonTools getUserDefaultsWithKey:@"name"];
    [_SurePwdTF setValue:JGHexColor(@"#999999") forKeyPath:@"_placeholderLabel.textColor"];
    [_SurePwdTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    //    _AccountTF.keyboardType = UIKeyboardTypeNumberPad;
    //    [_AccountTF addTarget:self action:@selector(textFChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *SurePwdBL = [UIView new];
    SurePwdBL.backgroundColor = JGLineColor;
    
    
    
    
    _AgreementBtn = [JTRegisterAgreementBtn new];
    [_AgreementBtn addTarget:self action:@selector(AgreementBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    _ProtocalBtn = [UIButton new];
    _ProtocalBtn.titleLabel.font = JGFont(13);
    _ProtocalBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_ProtocalBtn setTitleColor:JGHexColor(@"#FD7655") forState:UIControlStateNormal];
    [_ProtocalBtn setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [_ProtocalBtn addTarget:self action:@selector(ProtocalBtnClick) forControlEvents:UIControlEventTouchUpInside];

    
    _RegisterBtn = [JTGradientBgButton buttonWithType:UIButtonTypeCustom];
    //    _LoginBtn.enabled = (_AccountTF.text.length) && (_PasswordTF.text.length);
    [_RegisterBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [_RegisterBtn addTarget:self action:@selector(RegisterClick) forControlEvents:UIControlEventTouchUpInside];
    
   
    
    [self.view addSubview:accountLbl];
    [self.view addSubview:_AccountTF];
    [self.view addSubview:AccountBL];
    
    [self.view addSubview:codeLbl];
    [self.view addSubview:_CodeTF];
    [self.view addSubview:_GetCodeBtn];
    [self.view addSubview:CodeBL];

    [self.view addSubview:PwdLbl];
    [self.view addSubview:_PwdTF];
    [self.view addSubview:PwdBL];
    
    [self.view addSubview:SurePwdLbl];
    [self.view addSubview:_SurePwdTF];
    [self.view addSubview:SurePwdBL];
    
    [self.view addSubview:_AgreementBtn];
    [self.view addSubview:_ProtocalBtn];
    [self.view addSubview:_RegisterBtn];
    
    
    [accountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(AccountBL.mas_left);
        make.centerY.equalTo(_AccountTF.mas_centerY);
        make.width.equalTo(@(80));
    }];
    
    [_AccountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountLbl.mas_right);
        make.right.equalTo(AccountBL.mas_right);
        make.top.equalTo(self.view.mas_top).mas_offset(57 + SJHeight);
        make.height.equalTo(@(52));
    }];
//    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size))
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
    
    
    
    [codeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
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
    [_GetCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(AccountBL.mas_right);
        make.top.bottom.equalTo(_CodeTF);
        make.width.equalTo(@(80));
    }];
    
    [CodeBL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(AccountBL);
        make.top.equalTo(_CodeTF.mas_bottom);
        make.height.equalTo(@(1));
    }];
    
    
    [PwdLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(AccountBL.mas_left);
        make.centerY.equalTo(_PwdTF.mas_centerY);
        make.width.equalTo(accountLbl.mas_width);
    }];
    
    [_PwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_AccountTF);
        make.top.equalTo(CodeBL.mas_bottom).mas_offset(6);
    }];
    
    [PwdBL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(AccountBL);
        make.top.equalTo(_PwdTF.mas_bottom);
        make.height.equalTo(@(1));
    }];
    
    [SurePwdLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(AccountBL.mas_left);
        make.centerY.equalTo(_SurePwdTF.mas_centerY);
        make.width.equalTo(accountLbl.mas_width);
    }];
    
    
    [_SurePwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_AccountTF);
        make.top.equalTo(PwdBL.mas_bottom).mas_offset(6);
    }];
    
    [SurePwdBL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(AccountBL);
        make.top.equalTo(_SurePwdTF.mas_bottom);
        make.height.equalTo(@(1));
    }];
    
    [_AgreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(SurePwdBL);
        make.height.equalTo(@(45));
        make.width.equalTo(@(115));
    }];
    
    [_ProtocalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(_AgreementBtn);
        make.left.equalTo(_AgreementBtn.mas_right).mas_offset(-5);
    }];
    
    [_RegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(AccountBL);
        make.top.equalTo(SurePwdBL.mas_bottom).mas_offset(77);
        make.height.equalTo(@(47));
    }];
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



#pragma mark - 立即注册 -
- (void)RegisterClick {
    
    [self.view endEditing:YES];

    
    NSString *PhoneStr = [NSString pureStrWithOriginStr:_AccountTF.text];
    NSString *CodeStr = [NSString pureStrWithOriginStr:_CodeTF.text];
    NSString *PwdStr = [NSString pureStrWithOriginStr:_PwdTF.text];
    NSString *SurePwdStr = [NSString pureStrWithOriginStr:_SurePwdTF.text];
    
    if (!PhoneStr.length) {
        [JGToast showWithText:@"请输入手机号"];
        return;
    }
    
    if (!CodeStr.length) {
        [JGToast showWithText:@"请输入验证码"];
        return;
    }
    
    if (!PwdStr.length) {
        [JGToast showWithText:@"请输入密码"];
        return;
    }
    
    if (!SurePwdStr.length) {
        [JGToast showWithText:@"请输入确认密码"];
        return;
    }
    
    if (![PwdStr isEqualToString:SurePwdStr]) {
        [JGToast showWithText:@"两次输入密码不同，请重新输入"];
        _PwdTF.text = @"";
        _SurePwdTF.text = @"";
        return;
    }
    if (!_AgreementBtn.selected) {
        [JGToast showWithText:@"请勾选用户协议"];
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"phone"] = PhoneStr;
    parameters[@"code"] = CodeStr;
    parameters[@"password"] = PwdStr;
    parameters[@"type"] = @(4);
    
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

#pragma mark - 用户协议 -
- (void)ProtocalBtnClick {

    if (!self.ShowH5Url.length) {
        [self LoadHtmlUrlStr];
        return;
    }
    
    JTWKWebProtocolController *VC = [[JTWKWebProtocolController alloc] init];
    VC.webViewUrl = self.ShowH5Url;
    VC.navigationItem.title = @"用户协议";
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - 用户是否协议选中按钮 -
- (void)AgreementBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
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
