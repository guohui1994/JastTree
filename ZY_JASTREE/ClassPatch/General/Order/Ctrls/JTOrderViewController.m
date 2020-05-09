//
//  JTOrderViewController.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/1.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTOrderViewController.h"
#import "GH_OrderListTopView.h"
#import "GH_OrderTableViewCell.h"
#import "GH_ShowDetailJTViewController.h"
#import "GH_OrderListModel.h"
@interface JTOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * table;
@property (nonatomic, strong)NSMutableArray * dataSourceArray;
@property (nonatomic, strong)GH_OrderListModel * ListModel;
@property (nonatomic, assign)int status;
@property (nonatomic, assign)int pageNum;
@end

@implementation JTOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTopView];
    self.status = -1;
    self.dataSourceArray = [NSMutableArray new];
    [self.view addSubview:self.table];
    [self.table.mj_header beginRefreshing];
    self.pageNum = 1;
}
- (void)creatTopView{
     GH_OrderListTopView * topView = [[GH_OrderListTopView alloc]init];
    topView.backgroundColor = JGHexColor(@"#F5F5F5");
    topView.sd_cornerRadius = @(kWidthScale(5));
    [self.view addSubview:topView];
    topView.sd_layout
    .leftSpaceToView(self.view, 15)
    .topSpaceToView(self.view, SJHeight)
    .rightSpaceToView(self.view, 15)
    .heightIs(kHeightScale(40));
    [topView creatUI];
    /*点击top视图的回调方法*/
    WEAKSELF;
    topView.block = ^(int index) {
        if (index == 1) {
            weakSelf.status = -1;
        }else if(index == 2){
            weakSelf.status = 0;
        }else if (index == 3){
            weakSelf.status = 2;
        }else{
            weakSelf.status = 3;
        }
        [weakSelf getData];
        [weakSelf.table.mj_header beginRefreshing];
    
    };
}


/*上拉刷新*/
- (void)getData{
    NSString * uderID = USER_ID;
    NSDictionary * dic = @{@"userId": @([uderID intValue]), @"state":@(self.status), @"pageNum": @(1)};
    
    WEAKSELF;
    [ZYHttpManager HttpRequestDataWithApi:JTOrderSelectUserOrderList Aarameters:dic httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
        weakSelf.ListModel = [GH_OrderListModel mj_objectWithKeyValues:data];
        
        if (weakSelf.ListModel.isLastPage) {
            weakSelf.table.mj_footer.hidden = YES;
        }
        
        [weakSelf.table reloadData];
        
    } failure:^(NSString * _Nonnull message) {
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
        [JGToast showWithText:message];
    }];
}

- (void)getMoreData{
    self.pageNum ++;
    NSString * uderID = USER_ID;
    NSDictionary * dic = @{@"userId": @([uderID intValue]), @"state":@(self.status), @"pageNum": @(self.pageNum)};
   
    WEAKSELF;
    [ZYHttpManager HttpRequestDataWithApi:JTOrderSelectUserOrderList Aarameters:dic httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
        
        weakSelf.ListModel = [GH_OrderListModel mj_objectWithKeyValues:data];
        if (weakSelf.ListModel.isLastPage) {
            weakSelf.table.mj_footer.hidden = YES;
        }
        [weakSelf.table reloadData];
        
    } failure:^(NSString * _Nonnull message) {
        [JGToast showWithText:message];
    }];
}

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeightScale(40) + SJHeight, kDeviceWidth, kDeviceHight - kHeightScale(40) - SJHeight - IphoneXTabbarH) style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table registerClass:[GH_OrderTableViewCell class] forCellReuseIdentifier:@"GH_OrderTableViewCell"];
        WEAKSELF;
        _table.mj_header = [ZYRefreshHeader headerWithRefreshingBlock:^{
            [weakSelf getData];
        }];
        _table.mj_footer = [ZYRefreshFooter footerWithRefreshingBlock:^{
            [weakSelf getMoreData];
        }];
    }
    return _table;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ListModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    GH_OrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_OrderTableViewCell"];
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    // 通过不同标识创建cell实例
    GH_OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[GH_OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.ListModel.list[indexPath.row];
    
    
    
    
    [cell.clickButton addTarget:self action:@selector(clickButtonSelecror:) forControlEvents:UIControlEventTouchDown];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:kDeviceWidth tableView:tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_ShowDetailJTViewController * showDetailVC = [GH_ShowDetailJTViewController new];
    GHOrderListListModel * model = self.ListModel.list[indexPath.row];
    showDetailVC.orderID = model.order_id;
    WEAKSELF;
    showDetailVC.changeBlock = ^{
        [weakSelf getData];
    };
    [self.navigationController pushViewController:showDetailVC animated:YES];
}

- (void)clickButtonSelecror:(UIButton *)sender{
    GH_OrderTableViewCell * cell = (GH_OrderTableViewCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.table indexPathForCell:cell];
    GHOrderListListModel * model = self.ListModel.list[indexPath.row];
    WEAKSELF;
   
    if (model.parentState == 3 || model.parentState == 4) {
        UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"确定删除" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [ZYHttpManager HttpRequestDataWithApi:JTOrderDeleteUserOrder Aarameters:@{@"orderId": @(model.order_id)} httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
//                [weakSelf.table reloadData];
//                [weakSelf.table.mj_header beginRefreshing];
                [weakSelf getData];
                [weakSelf.table.mj_header beginRefreshing];
            } failure:^(NSString * _Nonnull message) {
                [JGToast showWithText:message];
            }];
        }];
        [alter addAction:cancle];
        [alter addAction:sure];
        [self presentViewController:alter animated:YES completion:nil];
        
    }else{
        if (model.childState == 0) {
            UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"确定撤单" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [ZYHttpManager HttpRequestDataWithApi:JTOrderRevokeOrder Aarameters:@{@"orderId": @(model.order_id)} httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
//                    [weakSelf.table reloadData];
                    [weakSelf getData];
                    [weakSelf.table.mj_header beginRefreshing];
                } failure:^(NSString * _Nonnull message) {
                    [JGToast showWithText:message];
                }];
            }];
            [alter addAction:cancle];
            [alter addAction:sure];
            [self presentViewController:alter animated:YES completion:nil];
            
            
    }
    
    
}
}
@end
