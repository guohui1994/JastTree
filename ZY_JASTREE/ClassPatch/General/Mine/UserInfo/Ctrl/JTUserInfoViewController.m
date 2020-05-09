//
//  JTUserInfoViewController.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/4.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTUserInfoViewController.h"
#import "JTUserPhoneController.h" //用户手机号

#import "JTUserInfoTop.h"
#import "JTUserInfoTCell.h"

@interface JTUserInfoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

NSString *const JTUserInfoTCellId = @"JTUserInfoTCellId";


@implementation JTUserInfoViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[JTUserInfoTCell class] forCellReuseIdentifier:JTUserInfoTCellId];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = JGHexColor(@"#F8F8F8");
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configUIs];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人信息";
    
}

- (void)configUIs {
    
    self.view.backgroundColor = JGHexColor(@"#F8F8F8");
    
    [self.view addSubview:self.tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).mas_offset(SJHeight + 10);
    }];
    
    
}



#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JTUserInfoTCell *cell = [tableView dequeueReusableCellWithIdentifier:JTUserInfoTCellId forIndexPath:indexPath];
    
    NSString *Phone =  [JGCommonTools getUserDefaultsWithKey:@"phone"];

    if (indexPath.row == 0) {
        
        cell.TitleLbl.text = @"昵称";
        NSString *nickName =  [JGCommonTools getUserDefaultsWithKey:@"nickName"];

        if (!nickName.length) {
            nickName = Phone;
        }
        
        cell.InfoLbl.text = nickName;
        cell.ArrowIcon.image = JGImage(@"1");
    }else if (indexPath.row == 1) {
        cell.TitleLbl.text = @"ID";
        NSString *user_id =  [JGCommonTools getUserDefaultsWithKey:@"user_id"];
        cell.InfoLbl.text = user_id;
        cell.ArrowIcon.image = JGImage(@"1");

    }else if (indexPath.row == 2) {
        cell.TitleLbl.text = @"手机号";
        cell.InfoLbl.text = Phone;
        cell.ArrowIcon.image = JGImage(@"Mine_Arrow");
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) { //更改手机号
        
        JTUserPhoneController *VC = [[JTUserPhoneController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JTUserInfoTop *top = [JTUserInfoTop new];
    
    return top;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 46.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 93.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
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
