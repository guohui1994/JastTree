//
//  GH_HomeShowDetailJTViewController.m
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/7/11.
//  Copyright © 2019 JG. All rights reserved.
//

#import "GH_HomeShowDetailJTViewController.h"
#import "GH_ShowDetailJTTableViewCell.h"
#import "GH_ShowDetailMessageJTTableViewCell.h"
#import "GHHomeDetailsModel.h"
#import "HZPhotoBrowser.h"
@interface GH_HomeShowDetailJTViewController ()<UITableViewDelegate, UITableViewDataSource>{
    UIButton * cancleButton;
    CAGradientLayer * gradientLayer;
}
@property (nonatomic, strong)UITableView * table;
@property (nonatomic, strong)GHHomeDetailsModel * showDetailModel;
@property (nonatomic, strong)NSMutableArray * messageArray;
@property (nonatomic, copy)NSString * quteMoneyString;//输入报价
@end

@implementation GH_HomeShowDetailJTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"展会名称";
    self.messageArray = [NSMutableArray new];
    [self getData];
}

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, SJHeight, kDeviceWidth, kDeviceHight - SJHeight ) style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor whiteColor];
        [_table registerClass:[GH_ShowDetailJTTableViewCell class] forCellReuseIdentifier:@"GH_ShowDetailJTTableViewCell"];
        [_table registerClass:[GH_ShowDetailMessageJTTableViewCell class] forCellReuseIdentifier:@"GH_ShowDetailMessageJTTableViewCell"];
        _table.tableFooterView = [self tableFooterView];
    }
    return _table;
}

- (void)getData{
    WEAKSELF;
    [ZYHttpManager LoadingHttpRequestDataWithApi:JTExhibitionSelectExhibitionDetails Aarameters:@{@"id":@(self.ID)}httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
//        [JGModelFileTool BeginCreateModelFileWithFileName:@"GH_HomeDetails" andData:data];
        NSLog(@"%@", data);
          weakSelf.showDetailModel = [GHHomeDetailsModel mj_objectWithKeyValues:data];
        [weakSelf addDetaiMessage];
        
        [weakSelf.view addSubview:weakSelf.table];
        [weakSelf.table reloadData];
    } failure:^(NSString * _Nonnull message) {
        [JGToast showWithText:message];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.messageArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    WEAKSELF;
    if (indexPath.section == 1) {
        GH_ShowDetailMessageJTTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_ShowDetailMessageJTTableViewCell"];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.messageDic = self.messageArray[indexPath.row];
        return cell;
    }else{
//        GH_ShowDetailJTTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_ShowDetailJTTableViewCell"];
//         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld",indexPath.section];
        // 通过不同标识创建cell实例
        GH_ShowDetailJTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[GH_ShowDetailJTTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.isShowQuteLable = NO;
        cell.isShowTimeButton = NO;
        
        if (indexPath.section == 0) {
            cell.photoArray = self.showDetailModel.exhibitionRendering;
            cell.titleString = @"效果图";
        }else{
             cell.titleString = @"进馆资料";
            cell.photoArray = self.showDetailModel.entryInformation;
          
            if (self.showDetailModel.state == 0) {
                  cell.isShowTextField = YES;
            }else{
                cell.isShowTextField = NO;
                cell.isShowQuteLable = YES;
                cell.quteMoney = [NSString stringWithFormat:@"%.2f", self.showDetailModel.quote];
            }
            cell.qouteMoneyBlock = ^(NSString * _Nonnull qouteMoney) {
                weakSelf.quteMoneyString = qouteMoney;
            };
           
        }
        cell.blocks = ^(int index, NSArray * _Nonnull array) {
            //启动图片浏览器
            HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
            browser.isFullWidthForLandScape = YES;
            browser.isNeedLandscape = YES;
            browser.currentImageIndex = index;
            browser.imageArray = array;
            [browser show];
        };
        
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return  [self sectionHeaderViewWithSection];
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:kDeviceWidth tableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 80;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//        if (section == 3) {
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 10)];
            view.backgroundColor = JGHexColor(@"#F8F8F8");
            return view;
//        }
//    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
        if (section == 0) {
            return 0.1;
        }
    return 10;
}

- (UIView *)sectionHeaderViewWithSection{
    UIView * backGroundview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 80)];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 10)];
    view.backgroundColor = JGHexColor(@"#F8F8F8");
    [backGroundview addSubview:view];
    
    UILabel * titleLable = [UILabel new];
    [backGroundview addSubview:titleLable];
    titleLable.text = @"展会信息";
    titleLable.textColor = JGHexColor(@"#3A4044");
    titleLable.font = JGFont(kWidthScale(16));
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.sd_layout
    .leftEqualToView(backGroundview)
    .topSpaceToView(view, kHeightScale(17))
    .widthIs(kDeviceWidth)
    .heightIs(kHeightScale(16));
    
    
    
    UILabel * shortLineView = [UILabel new];
    shortLineView.sd_cornerRadius = @(2);
    shortLineView.backgroundColor = JGHexColor(@"#FE8D33");
    [backGroundview addSubview:shortLineView];
    shortLineView.sd_layout
    .centerXEqualToView(backGroundview)
    .topSpaceToView(titleLable, kHeightScale(19))
    .widthIs(kWidthScale(21))
    .heightIs(kHeightScale(3));
    
    
    UILabel * lineView = [UILabel new];
    lineView.sd_cornerRadius = @(2);
    lineView.backgroundColor = JGHexColor(@"#FFB478");
    [backGroundview addSubview:lineView];
    lineView.sd_layout
    .centerXEqualToView(backGroundview)
    .topSpaceToView(titleLable, kHeightScale(22.5))
    .widthIs(kWidthScale(330))
    .heightIs(1);
    
    return backGroundview;
}

- (UIView *)tableFooterView{
    UIView * footerView = [UIView new];
    footerView.frame = CGRectMake(0, 0, kDeviceWidth, kHeightScale(102));
    
    cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.sd_cornerRadius = @(7);
     [footerView addSubview:cancleButton];
    if (self.showDetailModel.state == 0) {
        cancleButton.enabled = YES;
        gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)JGHexColor(@"#FE8E33").CGColor,(__bridge id)JGHexColor(@"#FB6D35").CGColor];
        gradientLayer.locations = @[@0.0, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = CGRectMake(0, 0,  kWidthScale(288),  kHeightScale(47));
        [cancleButton setTitle:@"提交" forState:UIControlStateNormal];
        [cancleButton.layer addSublayer:gradientLayer];
    }else{
         [cancleButton setBackgroundColor:JGHexColor(@"#C4C4C4")];
        cancleButton.enabled = NO;
         [cancleButton setTitle:@"已提交" forState:UIControlStateNormal];
    }
    
    

    
    [cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchDown];
    cancleButton.sd_layout
    .centerXIs(footerView.centerX)
    .centerYIs(footerView.centerY)
    .widthIs(kWidthScale(288))
    .heightIs(kHeightScale(47));
    return footerView;
}


- (void)clickButton:(UIButton *)sender{
    NSLog(@"%@", USER_ID);
    WEAKSELF;
    [ZYHttpManager LoadingHttpRequestDataWithApi:JTOrderQuotedPrice Aarameters:@{@"exhibitionId": @(self.showDetailModel.order_id), @"userId":@([USER_ID integerValue]), @"quoted":self.quteMoneyString} httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        [JGToast showWithText:message];
        [gradientLayer removeFromSuperlayer];
         [cancleButton setBackgroundColor:JGHexColor(@"#C4C4C4")];
        cancleButton.enabled = NO;
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString * _Nonnull message) {
        [JGToast showWithText:message];
    }];
}
///*把展会信息添加到数组里面*/
- (void)addDetaiMessage{

    [self.messageArray addObject:@{@"name":@"展会编号", @"value": [NSString stringWithFormat:@"%ld", (long)self.showDetailModel.order_id]}];
    [self.messageArray addObject:@{@"name":@"展会名称", @"value": self.showDetailModel.name}];

    [self.messageArray addObject:@{@"name":@"布展日期", @"value": self.showDetailModel.arrangement}];
    [self.messageArray addObject:@{@"name":@"撤展日期", @"value":  self.showDetailModel.scattered}];
    [self.messageArray addObject:@{@"name":@"展会面积", @"value": [NSString stringWithFormat:@"%ld ㎡", (long)self.showDetailModel.exhibitionArea]}];
    [self.messageArray addObject:@{@"name":@"联系人", @"value": self.showDetailModel.stylist}];
    [self.messageArray addObject:@{@"name":@"客户名称", @"value": self.showDetailModel.customerName}];
    [self.messageArray addObject:@{@"name":@"联系电话", @"value": self.showDetailModel.customerPhone}];
    [self.messageArray addObject:@{@"name":@"展位号", @"value": [NSString stringWithFormat:@"%@", self.showDetailModel.boothNumber]}];
    [self.messageArray addObject:@{@"name":@"展会地点", @"value": [NSString stringWithFormat:@"%@%@%@%@", self.showDetailModel.province, self.showDetailModel.city, self.showDetailModel.area, self.showDetailModel.exhibitionSite]}];
    if (self.showDetailModel.otherRequirements.length == 0) {
        
    }else{
    [self.messageArray addObject:@{@"name": @"其他要求", @"value":self.showDetailModel.otherRequirements}];
    }
    if (self.showDetailModel.addedOne.value.length != 0) {
        [self.messageArray addObject:@{@"name":self.showDetailModel.addedOne.name, @"value": self.showDetailModel.addedOne.value}];
    }else{
        
    }
    if (self.showDetailModel.addedTwo.value.length != 0) {
        [self.messageArray addObject:@{@"name":self.showDetailModel.addedTwo.name, @"value": self.showDetailModel.addedTwo.value}];
    }else{

    }
    if (self.showDetailModel.addedThree.value.length != 0) {
        [self.messageArray addObject:@{@"name":self.showDetailModel.addedThree.name, @"value": self.showDetailModel.addedThree.value}];
    }else{

    }

    if (self.showDetailModel.addedFour.value.length != 0) {
        [self.messageArray addObject:@{@"name":self.showDetailModel.addedFour.name, @"value": self.showDetailModel.addedFour.value}];
    }else{

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
