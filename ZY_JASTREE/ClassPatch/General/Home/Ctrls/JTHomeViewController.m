//
//  JTHomeViewController.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/1.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTHomeViewController.h"

#import "GH_HomeShowDetailJTViewController.h"
#import "JTHomeViewTCell.h"
#import "JTHomeViewTop.h"

#import "JTExhibitionSelectListModel.h" //查询展览列表 模型

#import "JTBaseNavigationController.h"
#import "JTCodeLoginController.h"


#import "JTChooseTimeAndProvinceAlert.h"
#import "JTProvinceManagerModel.h"
#import "JTMessageViewController.h"
#import "JTWKWebProtocolController.h"
#import "GH_HomeCarouselCell.h"
#import "HZPhotoBrowser.h"
#import "JTBaseTabBarController.h"
#import "JJScrollTextLable.h"
#import "LMJHorizontalScrollText.h"
#import "WQLPaoMaView.h"
#import "YUHorseRaceLamp.h"
#import "GH_HomeTopCarouseView.h"


@interface JTHomeViewController () <UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@property (nonatomic, strong) JTHomeViewTop *Top;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) JTChooseTimeAndProvinceAlert *ChooseAlert;


/*********  记录请求参数   *********/
//展览发布起止时间
@property (nonatomic, assign) int dateTime;
//省
@property (nonatomic, copy) NSString *province;
//请求页标记
@property (nonatomic, assign) NSInteger pageNum;

// showType 1 显示左侧  2 显示右侧
@property (nonatomic, assign) NSInteger showType;

//保存请求的列表数据
@property (nonatomic, strong) JTExhibitionSelectListModel *ListModel;
//保存省份数据
@property (nonatomic, strong) NSMutableArray  *ProvinceArrM;

@property (nonatomic, strong) NSMutableArray<JTExhibitionSelectListList1Model *>  *ListArrM;

//关于我们加载网页
@property (nonatomic, copy)NSString * ShowH5Url;

//轮播图数组
@property (nonatomic, strong)NSMutableArray * carouseDataSourceArray;

@property (nonatomic, strong)NSString * noticeString;

@property (nonatomic, strong) JJScorllTextLable * lable ;

@property (nonatomic, strong)LMJHorizontalScrollText * scrollewLable;

@property (nonatomic, strong) SDCycleScrollView * cycle;

@property (nonatomic, strong)HZPhotoBrowser *browser;


@property (nonatomic, strong)UIImageView * imageViews;

@property (nonatomic, strong)YUHorseRaceLamp * paomav ;


@end

NSString *const JTHomeViewTCellId = @"JTHomeViewTCellId";
NSString * const JTHomeCarouseCellId = @"JTHomeCarouseCellId";

@implementation JTHomeViewController

- (NSMutableArray *)ProvinceArrM {
    if (!_ProvinceArrM) {
        _ProvinceArrM = [NSMutableArray array];
    }
    return _ProvinceArrM;
}

- (NSMutableArray *)ListArrM {
    if (!_ListArrM) {
        _ListArrM = [NSMutableArray array];
    }
    return _ListArrM;
}




- (JTChooseTimeAndProvinceAlert *)ChooseAlert {
    if (!_ChooseAlert) {
        _ChooseAlert = [JTChooseTimeAndProvinceAlert new];
    }
    return _ChooseAlert;
}


- (JTHomeViewTop *)Top {
    if (!_Top) {
        _Top = [JTHomeViewTop new];
        WEAKSELF;
        _Top.backInfo = ^(UIButton *btn) {
            [weakSelf TopButtonClickWithTag:btn];
        };
    }
    return _Top;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.delaysContentTouches = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[JTHomeViewTCell class] forCellReuseIdentifier:JTHomeViewTCellId];
         [_tableView registerClass:[GH_HomeCarouselCell class] forCellReuseIdentifier:JTHomeCarouseCellId];
        _tableView.tableFooterView = [[UIView alloc] init];
        UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 9)];
        _tableView.tableHeaderView = top;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.province = @"";
     self.navigationItem.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    [self GetProvinceData];
   
    [self setupRefresh];
    
    
    [self LoadHtmlUrlStr];
    [JGNotification addObserver:self
                       selector:@selector(needShowLogin)
                           name:JGNeedShowLoginCtrlNotification
                         object:nil];
    
    
    self.cycle =    [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, SJHeight, kDeviceWidth, kHeightScale(180))];
    
    self.cycle.delegate = self;
    [self.view addSubview:self.cycle];
    [self loadCarouse];
}


- (void)needShowLogin
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].keyWindow.rootViewController =  [[JTBaseNavigationController alloc] initWithRootViewController:[[JTCodeLoginController alloc] init]];
    });
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



//加载省区域
- (void)GetProvinceData {
    
    
    WEAKSELF;
    [ZYHttpManager HttpRequestDataWithApi:JTProvinceData Aarameters:@{} httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        
        NSArray *array = [JTProvinceManagerModel mj_objectArrayWithKeyValuesArray:data];
        
        [weakSelf.ProvinceArrM removeAllObjects];
        for (JTProvinceManagerModel *model in array) {
            [weakSelf.ProvinceArrM addObject:model.name];
        }
    } failure:^(NSString * _Nonnull message) {
        [JGToast showWithText:message];
    }];
    
    
}


- (void)setupRefresh {
  
    self.tableView.mj_header = [ZYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    
    
    self.tableView.mj_footer = [ZYRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


- (void)loadNewData {
    
//    [self loadCarouse];
  WEAKSELF;
    
   
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"dateTime"] = @(self.dateTime);
    parameters[@"province"] = self.province;
    parameters[@"pageNum"] = @(1);
    
    
   
    [ZYHttpManager HttpRequestDataWithApi:JTExhibitionSelectList Aarameters:parameters httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
       
//        JGLog(@"%@", data);
        [weakSelf.tableView.mj_header endRefreshing];
        
        weakSelf.ListModel = [JTExhibitionSelectListModel mj_objectWithKeyValues:data];
        
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
    parameters[@"dateTime"] = @(self.dateTime);
    parameters[@"province"] = self.province;
    parameters[@"pageNum"] = @(++self.pageNum);

    WEAKSELF;
    [ZYHttpManager HttpRequestDataWithApi:JTExhibitionSelectList Aarameters:parameters httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        [weakSelf.tableView.mj_footer endRefreshing];

        weakSelf.ListModel = [JTExhibitionSelectListModel mj_objectWithKeyValues:data];
        weakSelf.tableView.mj_footer.hidden = weakSelf.ListModel.isLastPage;

        [weakSelf.ListArrM addObjectsFromArray:weakSelf.ListModel.list];

        [weakSelf.tableView reloadData];
    } failure:^(NSString * _Nonnull message) {
        [JGToast showWithText:message];
         [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

- (void)loadCarouse{
    [ZYHttpManager HttpRequestDataWithApi:JTHomeSlidehowSelectBanner Aarameters:@{} httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        [self.carouseDataSourceArray removeAllObjects];
        
        for (NSDictionary * dic in data) {
            NSString * icon = dic[@"icon"];
            [self.carouseDataSourceArray addObject:icon];
        }
        
   self.cycle.imageURLStringsGroup = self.carouseDataSourceArray;
        
    } failure:^(NSString * _Nonnull message) {
        
    }];
    
    self.imageViews = [[UIImageView alloc]init];
    self.imageViews.frame =CGRectMake(15, self.cycle.bottom + kHeightScale(6), kWidthScale(24), kHeightScale(20));
    self.imageViews.image = [UIImage imageNamed:@"Home_Sounds"];
    [self.view addSubview:self.imageViews];
    
    self.paomav = [[YUHorseRaceLamp alloc]init];
    self.paomav.frame =CGRectMake(kWidthScale(49), self.cycle.bottom, self.view.bounds.size.width-69, 30);
  
    self.paomav.textColor =JGHexColor(@"061b28");
    NSMutableArray * array = [NSMutableArray new];
    NSMutableString * noticeString = [NSMutableString new];
    [ZYHttpManager HttpRequestDataWithApi:JTHomeSystemSelectNotice Aarameters:@{} httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        [array removeAllObjects];
        [self.lable removeFromSuperview];
        for (NSDictionary * dic in data) {
            NSString * st = dic[@"notice"];
            [array addObject:st];
        }
        for (int i = 0; i < array.count; i++) {
            NSString * string = array[i];
            [noticeString appendString:[NSString stringWithFormat:@"%@     ", string]];
        }
        self.noticeString = noticeString;
          self.paomav.text = self.noticeString;
        
        
        
        [self.view addSubview:self.paomav];
    } failure:^(NSString * _Nonnull message) {
        
    }];
    [self creatHeaderView];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
   
   self.browser = [[HZPhotoBrowser alloc] init];
   
            self.browser.currentImageIndex = (int)index;
            self.browser.imageArray = self.carouseDataSourceArray;
            [self.browser show];
}

- (void)configUI {
    
    //logo
    UIImageView * leftBarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SJHeight - 44, kWidthScale(98), 43)];
    leftBarImageView.image = [UIImage imageNamed:@"nav_logo"];
    
    UIBarButtonItem * leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBarImageView];
    self.navigationItem.leftBarButtonItem = leftBar;

    
    
    //消息
    UIButton * messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    messageButton.userInteractionEnabled = YES;
    [messageButton setImage:[UIImage imageNamed:@"Home_Nav_Message"] forState:UIControlStateNormal];
    [messageButton addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchDown];
    
//    [rightBarView addSubview:messageButton];
    //关于我们
    UIButton * aboutUsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutUsButton.userInteractionEnabled = YES;
    [aboutUsButton setImage:[UIImage imageNamed:@"Home_Nav_CustomeService"] forState:UIControlStateNormal];
    [aboutUsButton addTarget:self action:@selector(aboutUsClick) forControlEvents:UIControlEventTouchDown];
//    [rightBarView addSubview:aboutUsButton];
    
    
    
    UIBarButtonItem * messageBar = [[UIBarButtonItem alloc]initWithCustomView:messageButton];
   UIBarButtonItem *rightBarCu = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightBarCu.width = kWidthScale(25);
    UIBarButtonItem * aboutUsBar = [[UIBarButtonItem alloc]initWithCustomView:aboutUsButton];
    self.navigationItem.rightBarButtonItems = @[messageBar, rightBarCu,aboutUsBar];
    

    
    self.carouseDataSourceArray = [NSMutableArray new];
    
   
    
    
//    [_Top mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).mas_offset(15);
//        make.right.equalTo(self.view.mas_right).mas_offset(-15);
//        make.top.equalTo(self.view.mas_top).mas_offset(SJHeight);
//        make.height.equalTo(@(44));
//    }];
    
    
   
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).mas_offset(SJHeight + kHeightScale(245));
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    
    
    
}


//- (GH_HomeTopCarouseView *)carouseView{
//    if (!_carouseView) {
//        _carouseView = [[GH_HomeTopCarouseView alloc]init];
//    }
//    return _carouseView;
//}

- (HZPhotoBrowser *)browser{
    if (!_browser) {
        _browser = [[HZPhotoBrowser alloc] init];
    }
    return  _browser;
}

- (YUHorseRaceLamp *)paomav{
    if (!_paomav) {
        _paomav = [[YUHorseRaceLamp alloc]init];
    }
    return _paomav;
}

- (void)creatHeaderView{
   
    
  
//    self.carouseView.frame =  CGRectMake(0, SJHeight, kDeviceWidth, kHeightScale(180));
//    self.carouseView.dataSourceArray = self.carouseDataSourceArray;
//    [self.view addSubview:self.carouseView];
//    WEAKSELF;
//    self.carouseView.block = ^(NSInteger index, NSArray * _Nonnull array) {
//        if (weakSelf.browser) {
//
//        }else{
//        weakSelf.browser = [[HZPhotoBrowser alloc] init];
//
//        }
//        weakSelf.browser.currentImageIndex = (int)index;
//        weakSelf.browser.imageArray = array;
//        [weakSelf.browser show];
//    };
    

   
    
    self.Top.frame = CGRectMake(kWidthScale(15), self.paomav.bottom , kDeviceWidth - kWidthScale(30), kHeightScale(30));
    [self.view addSubview:self.Top];
    
}

#pragma mark -- 导航栏按钮
- (void)messageClick{
    JTMessageViewController * messageVC = [JTMessageViewController new];
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (void)aboutUsClick{
    JTWKWebProtocolController *VC = [[JTWKWebProtocolController alloc] init];
    VC.webViewUrl = self.ShowH5Url;
    VC.navigationItem.title = @"关于我们";
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - 顶部按钮点击 -
- (void)TopButtonClickWithTag:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    if (!btn.selected) {
        [self.ChooseAlert remove];
        return;
    }
    
    if (self.ChooseAlert) {
        [self.ChooseAlert remove];
    }
    
    JTChooseTimeAndProvinceAlert *alert = [JTChooseTimeAndProvinceAlert new];
    WEAKSELF;
    alert.backInfo = ^(NSString *data) {
        
        if (weakSelf.showType == 1) {
                        
            weakSelf.dateTime = [data intValue];
        }else {
            
            if ([data isEqualToString:@"全部"]) {
                 weakSelf.province = @"";
            }else {
                 weakSelf.province = data;
            }
            
            weakSelf.dateTime = 0;

        }
        
        [weakSelf loadNewData];
    };
    
    
    if (btn.tag == 10) { //时间筛选
        
        alert.showType = 1;
        alert.DataArrM = @[@"全部",@"最近一周", @"最近一个月" , @"最近三个月", @"最近一年" ];
    }else { //选择地区
        
        alert.showType = 2;
        alert.DataArrM = self.ProvinceArrM;
    }
    
    self.showType = alert.showType;
    self.ChooseAlert = alert;
    [alert show];
}






#pragma mark - UITableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
        
        return self.ListArrM.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    if (indexPath.section == 0) {
//        GH_HomeCarouselCell *cell = [tableView dequeueReusableCellWithIdentifier:JTHomeCarouseCellId ];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.dataSourceArray = self.carouseDataSourceArray;
//        cell.block = ^(NSInteger index, NSArray * _Nonnull array) {
//
//            HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
//            browser.currentImageIndex = (int)index;
//            browser.imageArray = array;
//            [browser show];
//        };
//        return cell;
//    }else{
    JTHomeViewTCell *cell = [tableView dequeueReusableCellWithIdentifier:JTHomeViewTCellId ];
    cell.Model = [self.ListArrM objectAtIndex:indexPath.row];
    return cell;
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    GH_HomeShowDetailJTViewController * vc = [GH_HomeShowDetailJTViewController new];
    vc.ID = [self.ListArrM objectAtIndex:indexPath.row].ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.section == 0) {
//        return kHeightScale(180);
//    }else{
        return [self cellHeightForIndexPath:indexPath cellContentViewWidth:kDeviceWidth tableView:tableView];
//    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
//        [_Top mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.left.equalTo(self.view.mas_left).mas_offset(15);
//                    make.right.equalTo(self.view.mas_right).mas_offset(-15);
//                    make.top.equalTo(self.view.mas_top).mas_offset(SJHeight);
//                    make.height.equalTo(@(44));
//                }];
//        _Top = [JTHomeViewTop new];
//        WEAKSELF;
//        _Top.backInfo = ^(UIButton *btn) {
//            [weakSelf TopButtonClickWithTag:btn];
//        };
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(15, 0, kDeviceWidth - kWidthScale(30), kHeightScale(84))];
        view.backgroundColor = [UIColor whiteColor];
       
        
    
//            self.lable = [[JJScorllTextLable alloc]initWithFrame:CGRectMake(imageViews.right + kWidthScale(10), 0, kDeviceWidth - 100, 30)];

        self.lable.text = self.noticeString;
        self.lable.style = JJTextCycleStyleAlways;
        self.lable.textColor = JGHexColor(@"061b28");
        self.lable.font = JGFont(kWidthScale(14));
//        [view addSubview:self.lable];
        
//        self.scrollewLable = [[LMJHorizontalScrollText alloc]initWithFrame:CGRectMake(kWidthScale(49), 0, kDeviceWidth - 100, 30)];
//        self.scrollewLable.backgroundColor = [UIColor redColor];
        self.scrollewLable = [[LMJHorizontalScrollText alloc]init];
//        self.scrollewLable.text = self.noticeString;
        self.scrollewLable.text = @"hell绿绿绿绿绿绿绿绿绿";
        self.scrollewLable.moveDirection = LMJTextScrollContinuous;
        self.scrollewLable.speed = 0.05;
        self.scrollewLable.moveMode = LMJTextScrollContinuous;
//        [view addSubview:self.scrollewLable];
        
        YUHorseRaceLamp * paomav = [[YUHorseRaceLamp alloc] initWithFrame:CGRectMake(kWidthScale(49), 0, self.view.bounds.size.width-69, 30)];
        paomav.text = self.noticeString;
        paomav.textColor =JGHexColor(@"061b28");
        
        [view addSubview:paomav];
        
      
//        [view addSubview:paoma];
        
        self.Top.frame = CGRectMake(kWidthScale(15), 30, kDeviceWidth - kWidthScale(30), kHeightScale(44));
        [view addSubview:self.Top];
        view.backgroundColor = [UIColor whiteColor];
        return nil;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section == 1) {
//        return kHeightScale(84);
//    }
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(15, 0, kDeviceWidth - kWidthScale(30), kHeightScale(0.01))];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 8.0f;
    }else{
        
        return 0.01f;
    }
}


-(void)dealloc {
    [JGNotification removeObserver:self];
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
