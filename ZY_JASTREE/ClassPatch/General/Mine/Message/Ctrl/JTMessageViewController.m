//
//  JTMessageViewController.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/4.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTMessageViewController.h"
#import "JTMessageTCell.h"
#import "JTMessageDetailViewController.h" //消息详情
#import "JTMessageListModel.h"


@interface JTMessageViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

//保存请求的列表数据
@property (nonatomic, strong) JTMessageListModel *ListModel;

@property (nonatomic, strong) NSMutableArray<JTMessageListListModel *> *ListArrM;


//请求页标记
@property (nonatomic, assign) NSInteger pageNum;



@end

NSString * const JTMessageTCellId = @"JTMessageTCellId";

@implementation JTMessageViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[JTMessageTCell class] forCellReuseIdentifier:JTMessageTCellId];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 10)];
        _tableView.backgroundColor = JGHexColor(@"#F8F8F8");
    }
    return _tableView;
}

- (NSMutableArray *)ListArrM {
    if (!_ListArrM) {
        _ListArrM = [NSMutableArray array];
    }
    return _ListArrM;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadNewData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息";
    
    [self setupRefresh];
    
}






- (void)configUI {
    
    [self.view addSubview:self.tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).mas_offset(SJHeight);
        make.left.right.bottom.equalTo(self.view);
    }];    
}





- (void)setupRefresh {
    
    self.tableView.mj_header = [ZYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    
    
    self.tableView.mj_footer = [ZYRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


- (void)loadNewData {
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"userId"] = @([USER_ID intValue]);
    parameters[@"pageNum"] = @(1);
    
    
    WEAKSELF;
    [ZYHttpManager HttpRequestDataWithApi:JTMessageSelectList Aarameters:parameters httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        
//        JGLog(@"%@", data);
        [weakSelf.tableView.mj_header endRefreshing];
        
        weakSelf.ListModel = [JTMessageListModel mj_objectWithKeyValues:data];

        [weakSelf.ListArrM removeAllObjects];
        [weakSelf.ListArrM addObjectsFromArray:weakSelf.ListModel.list];

        weakSelf.tableView.mj_footer.hidden = weakSelf.ListModel.isLastPage;

        [weakSelf.tableView reloadData];
        
    } failure:^(NSString * _Nonnull message) {
        [weakSelf.tableView.mj_header endRefreshing];
        [JGToast showWithText:message];
    }];
}


- (void)loadMoreData {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"userId"] = @([USER_ID intValue]);
    parameters[@"pageNum"] = @(++self.pageNum);
    
    WEAKSELF;
    [ZYHttpManager HttpRequestDataWithApi:JTMessageSelectList Aarameters:parameters httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        [weakSelf.tableView.mj_footer endRefreshing];
        
        weakSelf.ListModel = [JTMessageListModel mj_objectWithKeyValues:data];
        weakSelf.tableView.mj_footer.hidden = weakSelf.ListModel.isLastPage;
        
        [weakSelf.ListArrM addObjectsFromArray:weakSelf.ListModel.list];
        
        [weakSelf.tableView reloadData];
    } failure:^(NSString * _Nonnull message) {
        [JGToast showWithText:message];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}






#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ListArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JTMessageTCell *cell = [tableView dequeueReusableCellWithIdentifier:JTMessageTCellId forIndexPath:indexPath];
    cell.Model = [self.ListArrM objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JTMessageDetailViewController *VC = [[JTMessageDetailViewController alloc] init];
    VC.Model = [self.ListArrM objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
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
