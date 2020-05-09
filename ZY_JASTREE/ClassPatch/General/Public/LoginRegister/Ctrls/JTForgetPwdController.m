//
//  JTForgetPwdController.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTForgetPwdController.h"
#import "JTGradientBgButton.h"


@interface JTForgetPwdController ()
@property (nonatomic,strong) UITextField *AccountTF;
@property (nonatomic,strong) UITextField *CodeTF;
@property (nonatomic,strong) UITextField *PwdTF;
@property (nonatomic,strong) UITextField *SurePwdTF;


@property (nonatomic,strong) UIButton *SaveBtn;
@end

@implementation JTForgetPwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"忘记密码";
    
}


- (void)configUI {
    
    UIView *TopLine = [[UIView alloc] initWithFrame:CGRectMake(0, SJHeight, kDeviceWidth, 10)];
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
    //    [_AccountTF addTarget:self action:@selector(textFChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *AccountBL = [UIView new];
    AccountBL.backgroundColor = JGLineColor;
    
    
    UILabel *codeLbl = [UILabel new];
    codeLbl.text = @"验证码";
    codeLbl.textColor = JG333Color;
    codeLbl.font = JGFont(15);
    
    
    _CodeTF = [UITextField new];
    _CodeTF.placeholder = @"请输入验证码";
    _CodeTF.clearButtonMode =  UITextFieldViewModeAlways;
    _CodeTF.text = [JGCommonTools getUserDefaultsWithKey:@"password"];
    [_CodeTF setValue:JG999Color forKeyPath:@"_placeholderLabel.textColor"];
    [_CodeTF setValue:JGFont(15) forKeyPath:@"_placeholderLabel.font"];
    //    [_CodeTF addTarget:self action:@selector(textFChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *GetCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    GetCodeBtn.backgroundColor = [UIColor yellowColor];
    
    
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
    
    
    
    
    
    _SaveBtn = [JTGradientBgButton buttonWithType:UIButtonTypeCustom];
    //    _LoginBtn.enabled = (_AccountTF.text.length) && (_PasswordTF.text.length);
    [_SaveBtn setTitle:@"保存" forState:UIControlStateNormal];
    //    [_RegisterBtn addTarget:self action:@selector(RegisterClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:accountLbl];
    [self.view addSubview:_AccountTF];
    [self.view addSubview:AccountBL];
    
    [self.view addSubview:codeLbl];
    [self.view addSubview:_CodeTF];
    [self.view addSubview:GetCodeBtn];
    [self.view addSubview:CodeBL];
    
    [self.view addSubview:PwdLbl];
    [self.view addSubview:_PwdTF];
    [self.view addSubview:PwdBL];
    
    [self.view addSubview:SurePwdLbl];
    [self.view addSubview:_SurePwdTF];
    [self.view addSubview:SurePwdBL];
    
    [self.view addSubview:_SaveBtn];
    
    
    [accountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(AccountBL.mas_left);
        make.centerY.equalTo(_AccountTF.mas_centerY);
        make.width.equalTo(@(80));
    }];
    
    [_AccountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountLbl.mas_right);
        make.right.equalTo(AccountBL.mas_right);
        make.top.equalTo(self.view.mas_top).mas_offset(85 + SJHeight);
        make.height.equalTo(@(52));
    }];
    
    [AccountBL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).mas_offset(44);
        make.right.equalTo(self.view.mas_right).mas_offset(-44);
        make.top.equalTo(_AccountTF.mas_bottom);
        make.height.equalTo(@(1));
    }];
    
    [codeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(AccountBL.mas_left);
        make.centerY.equalTo(_CodeTF.mas_centerY);
        make.width.equalTo(accountLbl.mas_width);
    }];
    
    [_CodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_AccountTF.mas_left);
        make.top.equalTo(AccountBL.mas_bottom).mas_offset(6);
        make.height.equalTo(@(52));
        make.right.equalTo(GetCodeBtn.mas_left);
    }];
    
    [GetCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.equalTo(CodeBL.mas_bottom);
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
        make.top.equalTo(PwdBL.mas_bottom);
    }];
    
    [SurePwdBL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(AccountBL);
        make.top.equalTo(_SurePwdTF.mas_bottom);
        make.height.equalTo(@(1));
    }];

    
    [_SaveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(AccountBL);
        make.top.equalTo(SurePwdBL.mas_bottom).mas_offset(77);
        make.height.equalTo(@(47));
    }];
}


#pragma mark - 保存 -
- (void)SaveBtnClick {
    
    JGLogFunc
    
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
