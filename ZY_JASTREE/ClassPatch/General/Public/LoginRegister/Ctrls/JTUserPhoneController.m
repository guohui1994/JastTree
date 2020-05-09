//
//  JTUserPhoneController.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/4.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTUserPhoneController.h"
#import "JTGradientBgButton.h"
#import "ZYSendMobileCodeBtn.h"

#import "JTBaseTabBarController.h"



@interface JTUserPhoneController ()

@property (nonatomic,strong) UITextField *AccountTF;
@property (nonatomic,strong) UITextField *CodeTF;
@property (nonatomic,strong) ZYSendMobileCodeBtn *GetCodeBtn;
@property (nonatomic,strong) JTGradientBgButton *SaveBtn;

@end

@implementation JTUserPhoneController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      self.navigationItem.title = @"我的手机号";
    
    if (self.Model.type.length) {
        self.navigationItem.title = @"绑定手机号";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    }
}



- (void)configUI {
    
    UIView *TopLine =[[UIView alloc] initWithFrame:CGRectMake(0, SJHeight, kDeviceWidth, 20)];
    TopLine.backgroundColor = JGHexColor(@"#F8F8F8");
    [self.view addSubview:TopLine];
    
    
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
    
    _CodeTF.text = [JGCommonTools getUserDefaultsWithKey:@"password"];
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
    
   
    
    _SaveBtn = [JTGradientBgButton buttonWithType:UIButtonTypeCustom];
    //    _SaveBtn.enabled = (_AccountTF.text.length) && (_CodeTF.text.length);
    NSString *BtnTitle = self.Model.type.length ? @"绑定" : @"保存";
    [_SaveBtn setTitle:BtnTitle forState:UIControlStateNormal];
    [_SaveBtn addTarget:self action:@selector(SaveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:accountLbl];
    [self.view addSubview:_AccountTF];
    [self.view addSubview:AccountBL];
    
    [self.view addSubview:PasswordLbl];
    [self.view addSubview:_CodeTF];
    [self.view addSubview:_GetCodeBtn];
    [self.view addSubview:PasswordBL];
    
    [self.view addSubview:_SaveBtn];


    [accountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(AccountBL.mas_left);
        make.centerY.equalTo(_AccountTF.mas_centerY);
        make.width.equalTo(@(80));
    }];
    
    [_AccountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountLbl.mas_right);
        make.right.equalTo(AccountBL.mas_right);
        make.top.equalTo(self.view.mas_top).mas_offset(20 + SJHeight);
        make.height.equalTo(@(45));
    }];
    
    [AccountBL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).mas_offset(44);
        make.right.equalTo(self.view.mas_right).mas_offset(-44);
        make.top.equalTo(_AccountTF.mas_bottom);
        make.height.equalTo(@(1));
    }];
    
    [PasswordLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(AccountBL.mas_left);
        make.centerY.equalTo(_CodeTF.mas_centerY);
        make.width.equalTo(accountLbl.mas_width);
    }];
    
    [_CodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_AccountTF.mas_left);
        make.top.equalTo(AccountBL.mas_bottom).mas_offset(6);
        make.height.equalTo(@(45));
        make.right.equalTo(_GetCodeBtn.mas_left);
    }];
    
    [_GetCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).mas_offset(-20);
        make.top.bottom.equalTo(_CodeTF);
        make.width.equalTo(@(70));
    }];
    
    [PasswordBL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(AccountBL);
        make.top.equalTo(_CodeTF.mas_bottom);
        make.height.equalTo(@(1));
    }];
    

    
    [_SaveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(AccountBL);
        make.top.equalTo(PasswordBL.mas_bottom).mas_offset(55);
        make.height.equalTo(@(47));
    }];
    
  
}

- (void)textFChange:(UITextField *)textField {
    
    //    _SaveBtn.enabled = (_AccountTF.text.length) && (_CodeTF.text.length);
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
    
    if (self.Model) {
        
        if ([self.Model.type isEqualToString:@"wx"]) {
            parameters[@"type"] = @(0);
        }else {
            parameters[@"type"] = @(1);
        }
    }else {
        
        parameters[@"type"] = @(4);
    }
    
    
    
    
    WEAKSELF;
    [ZYHttpManager HttpRequestDataWithApi:JTUserGetCode Aarameters:parameters httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        //        JGLog(@"%@", data);
        [weakSelf.GetCodeBtn sentCodeBtnClick];
        
    } failure:^(NSString * _Nonnull message) {
        [JGToast showWithText:message];
    }];
}



#pragma mark - 保存 按钮点击 -
- (void)SaveBtnClick {
    
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
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"phone"] = PhoneStr;
    parameters[@"code"] = CodeStr;

    WEAKSELF;
    
    if (self.Model.type.length) {
        
        parameters[@"type"] = self.Model.type;
        parameters[@"data"] = self.Model.data;

        [ZYHttpManager LoadingHttpRequestDataWithApi:JTUserFirstLogin Aarameters:parameters httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
            
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

    }else {
                
        [ZYHttpManager LoadingHttpRequestDataWithApi:JTUserChangeIphone Aarameters:parameters httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
            
            JGLog(@"%@", data);

//            [JGCommonTools setValue:PhoneStr forKey:@"phone"];
            [JGCommonTools saveToUserDefaults:PhoneStr key:@"phone"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString * _Nonnull message) {
            [JGToast showWithText:message];
        }];
        
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
