//
//  JTMineViewController.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/1.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTMineViewController.h"
#import "JTWKWebProtocolController.h" //关于我们
#import "JTUserInfoViewController.h" //用户信息
#import "JTMessageViewController.h" //消息
#import "JTForgetOrFixPwdController.h" //修改密码
#import "JTMineViewTop.h"
#import "JTMineViewCenter.h"

#import "JTBaseNavigationController.h"
#import "JTCodeLoginController.h"


@interface JTMineViewController ()

@property (nonatomic, strong) JTMineViewTop *Top;
@property (nonatomic, strong) JTMineViewCenter *Center;

@property (nonatomic, strong) UIButton *LoginBtn;

@property (nonatomic, strong) UIButton *RightBarButton;
@property (nonatomic, strong) UILabel *MsgCountLbl;

//需要的H5链接
@property (nonatomic,copy) NSString *ShowH5Url;
@end

@implementation JTMineViewController

- (void)viewWillAppear:(BOOL)animated {
    
    self.navColor = [UIColor clearColor];
    [super viewWillAppear:animated];
    
    [self LoadMsgCountData];
}


- (UIButton *)RightBarButton {
    if (!_RightBarButton) {
        _RightBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
        _RightBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_RightBarButton setImage:JGImage(@"Mine_Msg") forState:UIControlStateNormal];
        [_RightBarButton addTarget:self action:@selector(MsgbtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _MsgCountLbl = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 8, 8 )];
        _MsgCountLbl.hidden = YES;
        _MsgCountLbl.backgroundColor = [UIColor redColor];
        _MsgCountLbl.clipsToBounds = YES;
        _MsgCountLbl.layer.cornerRadius = 4.0f;
        _MsgCountLbl.font = JGFont(12);
        [_RightBarButton addSubview:_MsgCountLbl];
    }
    return _RightBarButton;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"";
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.RightBarButton];

    [self LoadHtmlUrlStr];
}


#pragma mark - 加载注册协议连接 -
- (void)LoadHtmlUrlStr {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"parameterName"] = @"about_us";
    
    WEAKSELF;
    [ZYHttpManager LoadingHttpRequestDataWithApi:JTSystemSelectValue Aarameters:parameters httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        
        JGLog(@"%@", data);
        weakSelf.ShowH5Url = data;
        
    } failure:^(NSString * _Nonnull message) {
        [JGToast showWithText:message];
    }];
    
}


- (void)LoadMsgCountData {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"userId"] = @([USER_ID intValue]);
    
    WEAKSELF;
    [ZYHttpManager HttpRequestDataWithApi:JTMessageSelectUnread Aarameters:parameters httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        [weakSelf RightBarButton];
        weakSelf.MsgCountLbl.hidden = ([data intValue] == 0);
    } failure:^(NSString * _Nonnull message) {
        [JGToast showWithText:message];
    }];
}




#pragma mark - 消息按钮点击 -
- (void)MsgbtnClick {
    
    JTMessageViewController *VC = [JTMessageViewController new];
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)configUI {
    
    WEAKSELF;
    _Top = [JTMineViewTop new];
    _Top.backInfo = ^(NSString *data) {
        [weakSelf TopViewLookUserInfoClick];
    };
    
    _Center = [JTMineViewCenter new];
    _Center.backInfo = ^(NSIndexPath *IndexPath) {
        [weakSelf CenterViewClickWithIndexPath:IndexPath];
    };
    
    _LoginBtn = [UIButton new];
    _LoginBtn.titleLabel.font = JGFont(18);
    _LoginBtn.layer.cornerRadius = 7.0f;
    _LoginBtn.clipsToBounds = YES;
    [_LoginBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [_LoginBtn setTitleColor:JGHexColor(@"#E4393C") forState:UIControlStateNormal];
    [_LoginBtn setBackgroundImage:[UIImage imageWithColor:JGHexColor(@"#FFF3EF")] forState:UIControlStateNormal];
    [_LoginBtn addTarget:self action:@selector(LoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_Top];
    [self.view addSubview:_Center];
    [self.view addSubview:_LoginBtn];

    
    [_Top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@(280));
    }];
    
    
    [_Center mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_Top.mas_bottom).mas_offset(114);
        make.left.equalTo(self.view.mas_left).mas_offset(38);
        make.right.equalTo(self.view.mas_right).mas_offset(-38);
        make.height.equalTo(@(199));
    }];

    [_LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_Center.mas_bottom).mas_offset(47);
        make.width.centerX.equalTo(_Center);
        make.height.equalTo(@(47));
    }];
}

#pragma mark - 顶部视图 -
- (void)TopViewLookUserInfoClick {
    
    JTUserInfoViewController *VC = [[JTUserInfoViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 中间视图的点击
- (void)CenterViewClickWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) { //更改密码
        
        JTForgetOrFixPwdController *VC = [JTForgetOrFixPwdController new];
        VC.TypeIndex = 1;
        VC.PhoneStr = [JGCommonTools getUserDefaultsWithKey:@"phone"];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.row == 1) { //关于我们
        
        if (!self.ShowH5Url.length) {
            [self LoadHtmlUrlStr];
            return;
        }
        
        JTWKWebProtocolController *VC = [[JTWKWebProtocolController alloc] init];
        VC.webViewUrl = self.ShowH5Url;
        VC.navigationItem.title = @"关于我们";
        [self.navigationController pushViewController:VC animated:YES];
    }
}


#pragma mark - 退出登录 -
- (void)LoginBtnClick {
    
    UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [MBProgressHUD showMessage:@"正在退出"];
        [ZYHttpManager HttpRequestDataWithApi:OutLogin Aarameters:@{} httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
            [MBProgressHUD hideHUD];
            [UIApplication sharedApplication].keyWindow.rootViewController =  [[JTBaseNavigationController alloc] initWithRootViewController:[[JTCodeLoginController alloc] init]];
            [JGCommonTools saveToUserDefaults:@"" key:@"token"];
        } failure:^(NSString * _Nonnull message) {
            [MBProgressHUD hideHUD];
        }];
    }];
    
    [alter addAction:cancle];
    [alter addAction:sure];
    [self presentViewController:alter animated:YES completion:nil];
    

    
   
    
    
//    [MBProgressHUD showMessage:@"正在退出"];
//
//
//
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        [MBProgressHUD hideHUD];
//
//        [JGCommonTools saveToUserDefaults:@"" key:@"token"];
//
//        [UIApplication sharedApplication].keyWindow.rootViewController =  [[JTBaseNavigationController alloc] initWithRootViewController:[[JTCodeLoginController alloc] init]];
//    });
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
