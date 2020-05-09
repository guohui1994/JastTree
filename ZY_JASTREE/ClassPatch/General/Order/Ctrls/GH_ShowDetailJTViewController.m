//
//  GH_ShowDetailJTViewController.m
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "GH_ShowDetailJTViewController.h"
#import "GH_ShowDetailJTTableViewCell.h"
#import "GH_ShowDetailMessageJTTableViewCell.h"
#import "GH_ShowDetailAddPicJTTableViewCell.h"
#import <Photos/Photos.h>
#import "WPhotoViewController.h"
#import "GH_ApprenseJTTableViewCell.h"
#import "GHShowDetailsModelModel.h"
#import "HZPhotoBrowser.h"
#import <AliyunOSSiOS/AliyunOSSiOS.h>
#import "DateTimePickerView.h"
@interface GH_ShowDetailJTViewController ()<UITableViewDelegate, UITableViewDataSource, DateTimePickerViewDelegate>{
    
        OSSClient * client;
    UIButton * cancleButton;
    CAGradientLayer * gradientLayer;
    
}
@property (nonatomic, strong)UITableView * table;
@property (nonatomic, strong)NSArray * titleArray;//第一区标题
@property (nonatomic, strong)GH_ShowDetailAddPicJTTableViewCell * cell;

@property (nonatomic, assign)NSIndexPath * indexpath;
@property (nonatomic, strong)GHShowDetailsModelModel * showDetailModel;
@property (nonatomic, strong)NSMutableArray * messageArray;//展会信息
@property (nonatomic, strong)NSMutableArray * materialProductionArray;//物料数组
@property (nonatomic, strong)NSMutableArray * buildPicArray;//搭建图片最后一个数组;
@property (nonatomic, strong)NSDictionary * OSSDic;//阿里云上传凭证数据
@property (nonatomic, strong)NSMutableArray * picUrlArray;//上传物料信息之后的地址数组
@property (nonatomic, strong)NSMutableArray * drawingArray;//上传搭建图之后的图片地址数组
@property (nonatomic, assign)NSInteger materiaPicCount;//物料图的网络图片个数
@property (nonatomic, assign)NSInteger buildUrlPicCount;//搭建图的网络图片的个数
@property (nonatomic, copy)NSString * timeString;//最晚完成时间
@property (nonatomic, copy)NSString * apprienceString;//评价内容
@end

@implementation GH_ShowDetailJTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"展会名称";

   
    /*s可变数组初始化*/
    self.materialProductionArray = [NSMutableArray new];
    self.buildPicArray = [NSMutableArray new];
    self.picUrlArray = [NSMutableArray new];
    self.drawingArray = [NSMutableArray new];
    self.messageArray = [NSMutableArray new];
    /*网络请求*/
    [self getData];

}
/*table懒加载*/
- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, SJHeight, kDeviceWidth, kDeviceHight - SJHeight ) style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor whiteColor];
        [_table registerClass:[GH_ShowDetailJTTableViewCell class] forCellReuseIdentifier:@"GH_ShowDetailJTTableViewCell"];
        [_table registerClass:[GH_ShowDetailMessageJTTableViewCell class] forCellReuseIdentifier:@"GH_ShowDetailMessageJTTableViewCell"];
        [_table registerClass:[GH_ShowDetailAddPicJTTableViewCell class] forCellReuseIdentifier:@"GH_ShowDetailAddPicJTTableViewCell"];
        [_table registerClass:[GH_ApprenseJTTableViewCell class] forCellReuseIdentifier:@"GH_ApprenseJTTableViewCell"];
        _table.tableFooterView = [self tableFooterView];
    }
    return _table;
}


/**
 数据请求
 */
- (void)getData{
    WEAKSELF;
    [ZYHttpManager HttpRequestDataWithApi:JTOrderDetails Aarameters:@{@"orderId":@(self.orderID)} httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {

        /*生成数据model*/
        weakSelf.showDetailModel = [GHShowDetailsModelModel mj_objectWithKeyValues:data];
       //把展会信息添加到数组里面
        [weakSelf addDetaiMessage];
        /*目的---当上传图片的时候需要知道数组里面有几个网络图片, 几个本地相册的图片, t因为cell上面的图片加载方式不一样所以要进行判断*/
        //新建数组把物料图片添加到数组里
        for (NSString * picUrl in weakSelf.showDetailModel.materialProduction) {
            [weakSelf.materialProductionArray addObject:picUrl];
        }
        GHShowDetailsConstructListModel * model = self.showDetailModel.constructList[self.showDetailModel.constructList.count - 1];
        if (self.showDetailModel.childState == 6 || self.showDetailModel.childState == 7) {
            for (NSString * url in model.construct) {
                [self.buildPicArray addObject:url];
            }
        }else{
            
        }
        weakSelf.materiaPicCount = weakSelf.showDetailModel.materialProduction.count;
        GHShowDetailsConstructListModel * models = self.showDetailModel.constructList.lastObject;
        weakSelf.buildUrlPicCount = models.construct.count;
        
        //获取最晚完成时间
        if (weakSelf.showDetailModel.lastFinshTime) {
            
            weakSelf.timeString = [JGCommonTools timeWithTimeIntervalString:weakSelf.showDetailModel.lastFinshTime dateFormatter:@"yyyy-MM-dd"];
        }else{
            weakSelf.timeString = @"选择时间";
        }
        //评价内容
        weakSelf.apprienceString = weakSelf.showDetailModel.userEvaluation;
        //添加table
        [weakSelf.view addSubview:weakSelf.table];
        [weakSelf.table reloadData];
    } failure:^(NSString * _Nonnull message) {
    }];
}
#pragma mark  TableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    /*根据类型返回不同的区*/
    if (self.showDetailModel.childState == 0 || self.showDetailModel.childState == 1 || self.showDetailModel.childState == 2 || self.showDetailModel.childState == 3 || self.showDetailModel.childState == 4 || self.showDetailModel.childState == 5) {
        return 3;
    }else if (self.showDetailModel.childState == 6 || self.showDetailModel.childState == 7 || self.showDetailModel.childState == 8 || self.showDetailModel.childState == 9){
        return 6;
    }else{
        return 7;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.messageArray.count;
    }else if (section == 5){
        if (self.showDetailModel.childState == 8) {
            return self.showDetailModel.constructList.count + 1;
        }else if(self.showDetailModel.childState == 6 || self.showDetailModel.childState == 7){
            if (self.showDetailModel.constructList.count == 0) {
                return self.showDetailModel.constructList.count + 1;
            }else{
                return self.showDetailModel.constructList.count;
            }
        }else{
            return self.showDetailModel.constructList.count;
        }
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
//    if (self.showDetailModel.childState == 0 || self.showDetailModel.childState == 1 || self.showDetailModel.childState == 2 || self.showDetailModel.childState == 3 || self.showDetailModel.childState == 4 || self.showDetailModel.childState == 5) {
//
//    }
    WEAKSELF;
    if (indexPath.section == 0 || indexPath.section == 2 || indexPath.section == 3) {
//        GH_ShowDetailJTTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_ShowDetailJTTableViewCell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.section];
        // 通过不同标识创建cell实例
        GH_ShowDetailJTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[GH_ShowDetailJTTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.showDetailModel.childState == 0 || self.showDetailModel.childState == 1 || self.showDetailModel.childState == 2 || self.showDetailModel.childState == 3 || self.showDetailModel.childState == 4 || self.showDetailModel.childState == 5) {
            if (indexPath.section == 0 ) {
                cell.isShowQuteLable = NO;
                cell.titleString = @"效果图";
                cell.photoArray = self.showDetailModel.exhibitionRendering;
            }else
                //            if (indexPath.section == 2){
                //            cell.isShowQuteLable = NO;
                //            cell.titleString = @"施工图";
                //            cell.photoArray = self.showDetailModel.constructionDrawing;
                //        }else
            {
                if (self.showDetailModel.childState == 0 || self.showDetailModel.childState == 3 || self.showDetailModel.childState == 4) {
                    cell.isShowQuteLable = YES;
                    cell.quteMoney = [NSString stringWithFormat:@"%.2f", self.showDetailModel.quote];
                }else{
                    cell.isShowQuteLable = NO;
                }
                if (self.showDetailModel.childState == 1 || self.showDetailModel.childState == 2 || self.showDetailModel.childState == 5) {
                    cell.isShowTimeButton = YES;
                    
                    if (self.showDetailModel.childState == 1) {
                        [cell.selectTimeButton addTarget:self action:@selector(selectTimeButtonClick:) forControlEvents:UIControlEventTouchDown];
                    }else{
                        cell.selectTimeButton.enabled = NO;
                    }
                }else{
                    cell.isShowTimeButton = NO;
                }
                cell.timeString = self.timeString;
                cell.titleString = @"进馆资料";
                cell.photoArray = self.showDetailModel.entryInformation;
            }
            /*点击图片显示原图的回调*/
            cell.blocks = ^(int index, NSArray * _Nonnull array) {
                //启动图片浏览器
                HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
                browser.currentImageIndex = index;
                browser.imageArray = array;
                [browser show];
            };
        }else{
            if (indexPath.section == 0 ) {
                cell.isShowQuteLable = NO;
                cell.titleString = @"效果图";
                cell.photoArray = self.showDetailModel.exhibitionRendering;
            }else
                            if (indexPath.section == 2){
                            cell.isShowQuteLable = NO;
                            cell.titleString = @"施工图";
                            cell.photoArray = self.showDetailModel.constructionDrawing;
                        }else
            {
                if (self.showDetailModel.childState == 0 || self.showDetailModel.childState == 3 || self.showDetailModel.childState == 4) {
                    cell.isShowQuteLable = YES;
                    cell.quteMoney = [NSString stringWithFormat:@"%.2f", self.showDetailModel.quote];
                }else{
                    cell.isShowQuteLable = NO;
                }
                if (self.showDetailModel.childState == 1 || self.showDetailModel.childState == 2 || self.showDetailModel.childState == 5) {
                    cell.isShowTimeButton = YES;
                    
                    if (self.showDetailModel.childState == 1) {
                        [cell.selectTimeButton addTarget:self action:@selector(selectTimeButtonClick:) forControlEvents:UIControlEventTouchDown];
                    }else{
                        cell.selectTimeButton.enabled = NO;
                    }
                }else{
                    cell.isShowTimeButton = NO;
                }
                cell.timeString = self.timeString;
                cell.titleString = @"进馆资料";
                cell.photoArray = self.showDetailModel.entryInformation;
            }
            /*点击图片显示原图的回调*/
            cell.blocks = ^(int index, NSArray * _Nonnull array) {
                //启动图片浏览器
                HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
                browser.currentImageIndex = index;
                browser.imageArray = array;
                [browser show];
            };
        }
        
        
       
        return cell;
    }else if (indexPath.section == 1){
        /*把第一区的数据全部放到数组里面依次显示, 把数据封装成字典格式name-----名称   value ------数据内容*/
        GH_ShowDetailMessageJTTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_ShowDetailMessageJTTableViewCell"];
//        cell.titleString = self.titleArray[indexPath.row];
        cell.messageDic = self.messageArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 4 || indexPath.section == 5){
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section, indexPath.row];
        // 通过不同标识创建cell实例
        GH_ShowDetailAddPicJTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[GH_ShowDetailAddPicJTTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.showDetailModel.childState == 6 || self.showDetailModel.childState == 7 || self.showDetailModel.childState == 8) {
            cell.isShowAddButton = YES;
            
        }else{
            cell.isShowAddButton = NO;
            cell.isShowDeleteButton = NO;
        }
        
        if (indexPath.section == 4) {
            if (self.showDetailModel.childState == 6 || self.showDetailModel.childState == 7 || self.showDetailModel.childState == 8) {
                cell.isShowDeleteButton = YES;
            }else{
                cell.isShowDeleteButton = NO;
            }
                cell.netWorkImageUrlCount = weakSelf.materiaPicCount;
            
            cell.photoArry =self.materialProductionArray;
            cell.isShowDay = NO;
            cell.blocks = ^(int index, NSArray * _Nonnull array) {
                //启动图片浏览器
                HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
                browser.isFullWidthForLandScape = YES;
                browser.isNeedLandscape = YES;
                browser.currentImageIndex = index;
                browser.imageArray = array;
                [browser show];
            };
            
            
            //删除物料图片
            cell.deleteBlcok = ^(int index, NSArray * _Nonnull array) {
//                NSString * picUrl = ;
                if ([weakSelf.materialProductionArray[index] isKindOfClass:[NSString class]]) {
                    [ZYHttpManager LoadingHttpRequestDataWithApi:JTOrederDeleteMateriel Aarameters:@{@"orderId":@(weakSelf.showDetailModel.order_id), @"materiel": weakSelf.materialProductionArray[index]} httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
                         [weakSelf.materialProductionArray removeObjectAtIndex:index];
                        weakSelf.materiaPicCount --;
                         [weakSelf.table reloadData];
                    } failure:^(NSString * _Nonnull message) {
                        [JGToast showWithText:message];
                    }];
                    
                    
                }else{
                    [weakSelf.materialProductionArray removeObjectAtIndex:index];
                     [weakSelf.table reloadData];
                }
                
                
            };
        }else{
            cell.isShowDay = YES;
            cell.day = indexPath.row + 1;
            
            if (self.showDetailModel.childState == 9 || self.showDetailModel.childState == 10 || self.showDetailModel.childState == 11 || self.showDetailModel.childState == 12) {
                GHShowDetailsConstructListModel * model = self.showDetailModel.constructList[indexPath.row];
                cell.netWorkImageUrlCount = model.construct.count;
                cell.isShowAddButton = NO;
                cell.isShowDeleteButton = NO;
                cell.photoArry = model.construct;
            }
            
            
            if (self.showDetailModel.childState == 6 || self.showDetailModel.childState == 7) {
                if (self.showDetailModel.constructList.count == 0) {
                    cell.isShowAddButton = YES;
                    cell.isShowDeleteButton = YES;
                   
                    cell.photoArry = self.buildPicArray;
                    cell.deleteBlcok = ^(int index, NSArray * _Nonnull array) {
                        /*搭建图的删除方法, 判断是否是网络图片如果是就请求接口直接删除, 如果 不是就直接从数组删除*/
                        if ([weakSelf.buildPicArray[index] isKindOfClass:[NSString class]]) {
                            [ZYHttpManager LoadingHttpRequestDataWithApi:JTOrderConstructDeleteDrawing Aarameters:@{@"orderId":@(weakSelf.showDetailModel.order_id), @"drawing": weakSelf.buildPicArray[index]} httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
                                [weakSelf.buildPicArray removeObjectAtIndex:index];
                                weakSelf.buildUrlPicCount --;
                                 [weakSelf.table reloadData];
                            } failure:^(NSString * _Nonnull message) {
                                [JGToast showWithText:message];
                            }];
                            
                        }else{
                            [weakSelf.buildPicArray removeObjectAtIndex:index];
                             [weakSelf.table reloadData];
                        }
                    };
                }else{
                if (indexPath.row == self.showDetailModel.constructList.count - 1) {
                    cell.isShowAddButton = YES;
                    cell.isShowDeleteButton = YES;
                     cell.netWorkImageUrlCount = weakSelf.buildUrlPicCount;
                    cell.photoArry = self.buildPicArray;
                    cell.deleteBlcok = ^(int index, NSArray * _Nonnull array) {
                        if ([weakSelf.buildPicArray[index] isKindOfClass:[NSString class]]) {
                            [ZYHttpManager LoadingHttpRequestDataWithApi:JTOrderConstructDeleteDrawing Aarameters:@{@"orderId":@(weakSelf.showDetailModel.order_id), @"drawing": weakSelf.buildPicArray[index]} httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
                                [weakSelf.buildPicArray removeObjectAtIndex:index];
                              
                                weakSelf.buildUrlPicCount --;
                                  [weakSelf.table reloadData];
                            } failure:^(NSString * _Nonnull message) {
                                [JGToast showWithText:message];
                            }];
                            
                        }else{
                            [weakSelf.buildPicArray removeObjectAtIndex:index];
                            [weakSelf.table reloadData];
                        }
                      
                    };

                }else{
                    GHShowDetailsConstructListModel * model = self.showDetailModel.constructList[indexPath.row];
                    cell.netWorkImageUrlCount = model.construct.count;
                    cell.isShowAddButton = NO;
                    cell.isShowDeleteButton = NO;
                    cell.photoArry = model.construct;
                }
                }
            }else if (self.showDetailModel.childState == 8){
                if (indexPath.row == self.showDetailModel.constructList.count) {
                    cell.isShowAddButton = YES;
                    cell.isShowDeleteButton = YES;
                    cell.netWorkImageUrlCount = 0;
                    cell.photoArry = self.buildPicArray;
                    cell.deleteBlcok = ^(int index, NSArray * _Nonnull array) {
                        if ([weakSelf.buildPicArray[index] isKindOfClass:[NSString class]]) {
                            [ZYHttpManager LoadingHttpRequestDataWithApi:JTOrderConstructDeleteDrawing Aarameters:@{@"orderId":@(weakSelf.showDetailModel.order_id), @"drawing": weakSelf.buildPicArray[index]} httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
                                [weakSelf.buildPicArray removeObjectAtIndex:index];
                                weakSelf.buildUrlPicCount --;
                            } failure:^(NSString * _Nonnull message) {
                                [JGToast showWithText:message];
                            }];
                            
                        }else{
                            [weakSelf.buildPicArray removeObjectAtIndex:index];
                        }
                        [weakSelf.table reloadData];
                    };
//                    cell.deleteBlcok = ^(int index, NSArray * _Nonnull array) {
//                        [weakSelf.buildPicArray removeObjectAtIndex:index];
//                        [weakSelf.table reloadData];
//                    };
                }else{
                    cell.isShowAddButton = NO;
                    cell.isShowDeleteButton = NO;
                    GHShowDetailsConstructListModel * model = self.showDetailModel.constructList[indexPath.row];
                    cell.netWorkImageUrlCount = model.construct.count;
                     cell.netWorkImageUrlCount = model.construct.count;
                    cell.photoArry = model.construct;
                }
            }
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
        //添加按钮的相应方法
        [cell.addpicButton addTarget:self action:@selector(addPicClick:) forControlEvents:UIControlEventTouchDown];
        return cell;
    }else{
        GH_ApprenseJTTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_ApprenseJTTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userEvaluation = [NSString stringWithFormat:@"%@", self.showDetailModel.evaluationBackground];
        
        if (self.showDetailModel.childState == 10) {
            cell.isEdit = YES;
            
        }else{
            cell.isEdit = NO;
            cell.replyString = self.showDetailModel.userEvaluation;
        }
        
        if (self.showDetailModel.evaluationBackground.length == 0) {
            cell.isShowTextView = NO;
        }else{
            cell.isShowTextView = YES;
        }
        cell.black = ^(id data) {
            NSLog(@"%@", data);
            weakSelf.apprienceString= [NSString stringWithFormat:@"%@", data];
//            [weakSelf.table reloadData];
        };
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1 || section == 4 || section == 5) {
        return  [self sectionHeaderViewWithSection: section];
    }else{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 10)];
    view.backgroundColor = JGHexColor(@"#F8F8F8");
    return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 4 || section == 5) {
        return 80;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (self.showDetailModel.childState == 0 || self.showDetailModel.childState == 1 || self.showDetailModel.childState == 2 || self.showDetailModel.childState == 3 || self.showDetailModel.childState == 4 || self.showDetailModel.childState == 5) {
        if (section == 2) {
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 10)];
            view.backgroundColor = JGHexColor(@"#F8F8F8");
            return view;
        }
    }else if (self.showDetailModel.childState == 6 || self.showDetailModel.childState == 7 || self.showDetailModel.childState == 8){
        if (section == 5) {
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 10)];
            view.backgroundColor = JGHexColor(@"#F8F8F8");
            return view;
        }
    }else{
        if (section == 6) {
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 10)];
            view.backgroundColor = JGHexColor(@"#F8F8F8");
            return view;
        }
    }
   
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.showDetailModel.childState == 0 || self.showDetailModel.childState == 1 || self.showDetailModel.childState == 2 || self.showDetailModel.childState == 3 || self.showDetailModel.childState == 4 || self.showDetailModel.childState == 5) {
        if (section == 2) {
          
            return 10;
        }
    }else if (self.showDetailModel.childState == 6 || self.showDetailModel.childState == 7 || self.showDetailModel.childState == 8){
        if (section == 5) {
            
            return 10;
        }
    }else{
        if (section == 6) {
            
            return 10;
        }
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:kDeviceWidth tableView:tableView];
}


- (UIView *)tableFooterView{
    UIView * footerView = [UIView new];
    footerView.frame = CGRectMake(0, 0, kDeviceWidth, kHeightScale(102));
    
    cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.sd_cornerRadius = @(7);
    [footerView addSubview:cancleButton];
    gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)JGHexColor(@"#FE8E33").CGColor,(__bridge id)JGHexColor(@"#FB6D35").CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0,  kWidthScale(288),  kHeightScale(47));
   
    
    if (self.showDetailModel.childState == 0) {
         [cancleButton setTitle:@"我要撤单" forState:UIControlStateNormal];
         [cancleButton.layer addSublayer:gradientLayer];
    }else if (self.showDetailModel.childState == 1){
        [cancleButton setTitle:@"申请施工图" forState:UIControlStateNormal];
         [cancleButton.layer addSublayer:gradientLayer];
//        cancleButton.enabled = NO;
    }else if (self.showDetailModel.childState == 2){
        [cancleButton setTitle:@"申请未通过" forState:UIControlStateNormal];
        cancleButton.enabled = NO;
        [cancleButton setBackgroundColor:JGHexColor(@"#C4C4C4")];
    }else if (self.showDetailModel.childState == 3){
        [cancleButton setTitle:@"撤单中" forState:UIControlStateNormal];
        cancleButton.enabled = NO;
        [cancleButton setBackgroundColor:JGHexColor(@"#C4C4C4")];
    }else if (self.showDetailModel.childState == 4){
        [cancleButton setTitle:@"撤单已完成" forState:UIControlStateNormal];
        cancleButton.enabled = NO;
        [cancleButton setBackgroundColor:JGHexColor(@"#C4C4C4")];
    }else if (self.showDetailModel.childState == 5){
        [cancleButton setTitle:@"正在申请施工图" forState:UIControlStateNormal];
        cancleButton.enabled = NO;
        [cancleButton setBackgroundColor:JGHexColor(@"#C4C4C4")];
    }else if (self.showDetailModel.childState == 6){
       [cancleButton setTitle:@"上传物料与搭建图片" forState:UIControlStateNormal];
         [cancleButton.layer addSublayer:gradientLayer];
    }else if (self.showDetailModel.childState == 7){
        [cancleButton setTitle:@"上传物料与搭建图片" forState:UIControlStateNormal];
         [cancleButton.layer addSublayer:gradientLayer];
    }else if (self.showDetailModel.childState == 8){
        [cancleButton setTitle:@"上传物料与搭建图片" forState:UIControlStateNormal];
         [cancleButton.layer addSublayer:gradientLayer];
    }else if (self.showDetailModel.childState == 9){
        [cancleButton setTitle:@"待评价" forState:UIControlStateNormal];
        cancleButton.enabled = NO;
           [cancleButton setBackgroundColor:JGHexColor(@"#C4C4C4")];
    }else if (self.showDetailModel.childState == 10){
        [cancleButton setTitle:@"已评价" forState:UIControlStateNormal];
       
          [cancleButton.layer addSublayer:gradientLayer];
     
    }else if (self.showDetailModel.childState == 11){
        [cancleButton setTitle:@"评价待查看" forState:UIControlStateNormal];
        cancleButton.enabled = NO;
        [cancleButton setBackgroundColor:JGHexColor(@"#C4C4C4")];
    }else{
        [cancleButton setTitle:@"评价已查看" forState:UIControlStateNormal];
        cancleButton.enabled = NO;
        [cancleButton setBackgroundColor:JGHexColor(@"#C4C4C4")];
    }

    [cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchDown];
    cancleButton.sd_layout
    .centerXIs(footerView.centerX)
    .centerYIs(footerView.centerY)
    .widthIs(kWidthScale(288))
    .heightIs(kHeightScale(47));
    return footerView;
}

- (UIView *)sectionHeaderViewWithSection:(NSInteger)section{
    UIView * backGroundview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 80)];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 10)];
    view.backgroundColor = JGHexColor(@"#F8F8F8");
    [backGroundview addSubview:view];
    
    UILabel * titleLable = [UILabel new];
    [backGroundview addSubview:titleLable];
    if (section == 1) {
        
        titleLable.text = @"展会信息";
    }else if(section == 4){
        titleLable.text = @"物料制作";
    }else if (section == 5){
        titleLable.text = @"搭建图片";
    }
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

/*添加图片的按钮*/
- (void)addPicClick:(UIButton *)sender{
    
    GH_ShowDetailAddPicJTTableViewCell * cell = (GH_ShowDetailAddPicJTTableViewCell *)[[[sender superview] superview]superview];
    NSIndexPath * indexpath = [self.table indexPathForCell:cell];
    self.indexpath = indexpath;
    WPhotoViewController *WphotoVC = [[WPhotoViewController alloc] init];
    if (indexpath.section == 4) {
        WphotoVC.selectPhotoOfMax = 9 - self.materialProductionArray.count;
        [WphotoVC setSelectPhotosBack:^(NSMutableArray *photosArr) {
            for (UIImage * image in photosArr) {
                [self.materialProductionArray addObject:image];
            }
//            weakSelf.materiaPicCount = weakSelf.materiaPicCount + photosArr.count;
            [self.table reloadData];
        }];
         [self presentViewController:WphotoVC animated:YES completion:nil];
    }else{
    
    
    //选择图片的最大数
    WphotoVC.selectPhotoOfMax = 9 - self.buildPicArray.count;
    [WphotoVC setSelectPhotosBack:^(NSMutableArray *phostsArr) {
//        _photosArr = phostsArr;
//        [_tableView reloadData];
//        NSArray * array = self.picArray[self.indexpath.row];
//        NSMutableArray * photoImage = [NSMutableArray new];
//        for (UIImage * image in array) {
//            [photoImage addObject:image];
//        }
//        for (UIImage * image in phostsArr) {
//            [photoImage addObject:image];
//        }
//        array = photoImage;
//        [self.picArray replaceObjectAtIndex:self.indexpath.row withObject:array];
//        //    [self.picArray addObject:array];
//        [self.table reloadData];
        for (UIImage * image in phostsArr) {
            [self.buildPicArray addObject:image];
        }
        [self.table reloadData];
        
    }];
    [self presentViewController:WphotoVC animated:YES completion:nil];
    }
}
/*把展会信息添加到数组里面*/
- (void)addDetaiMessage{
   
    [self.messageArray addObject:@{@"name":@"展会编号", @"value": [NSString stringWithFormat:@"%ld", (long)self.showDetailModel.exhibitionId]}];
    [self.messageArray addObject:@{@"name":@"展会名称", @"value": self.showDetailModel.name}];
    
    [self.messageArray addObject:@{@"name":@"布展日期", @"value": self.showDetailModel.arrangement}];
    [self.messageArray addObject:@{@"name":@"撤展日期", @"value": self.showDetailModel.scattered}];
    [self.messageArray addObject:@{@"name":@"展会面积", @"value": [NSString stringWithFormat:@"%ld ㎡", (long)self.showDetailModel.exhibitionArea]}];
    [self.messageArray addObject:@{@"name":@"联系人", @"value": self.showDetailModel.stylist}];
    [self.messageArray addObject:@{@"name":@"客户名称", @"value": self.showDetailModel.customerName}];
    [self.messageArray addObject:@{@"name":@"联系电话", @"value": self.showDetailModel.customerPhone}];
    [self.messageArray addObject:@{@"name":@"展位号", @"value": [NSString stringWithFormat:@"%@ ", self.showDetailModel.boothNumber]}];
    [self.messageArray addObject:@{@"name":@"展会地点", @"value": [NSString stringWithFormat:@"%@%@%@%@", self.showDetailModel.province, self.showDetailModel.city, self.showDetailModel.area, self.showDetailModel.exhibitionSite]}];
    if (self.showDetailModel.otherRequirements.length == 0) {
        
    }else{
        [self.messageArray addObject:@{@"name": @"其他要求", @"value":self.showDetailModel.otherRequirements}];
    }
    if (self.showDetailModel.childState == 0) {
        
    }else{
    
    if (self.showDetailModel.paymentState == 0) {
//        [self.messageArray addObject:@{@"name":@"付款状态", @"value":@"未付款"}];
    }else if (self.showDetailModel.paymentState == 1){
        [self.messageArray addObject:@{@"name":@"付款状态", @"value":@"已付首款"}];
    }else{
        [self.messageArray addObject:@{@"name":@"付款状态", @"value":@"已付尾款"}];
    }
        
        
        
        
    }
    
    if (self.showDetailModel.childState == 2 || self.showDetailModel.childState == 3 || self.showDetailModel.childState == 4 || self.showDetailModel.childState == 4 || self.showDetailModel.childState == 0) {
        
    }else{
        
        if (self.showDetailModel.paymentState == 0) {
            
        }else{
            
        [self.messageArray addObject:@{@"name":@"付款金额", @"value":[NSString stringWithFormat:@"首款:%.1f",self.showDetailModel.firstPrice]}];
        [self.messageArray addObject:@{@"name":@"", @"value":[NSString stringWithFormat:@"尾款:%.1f", self.showDetailModel.lastPrice]}];
        }
        
        
       
        
//        if (!self.showDetailModel.firstPrice) {
//
//        }else{
//            [self.messageArray addObject:@{@"name":@"已付首款", @"value":[NSString stringWithFormat:@"%.f", self.showDetailModel.firstPrice]}];
//        }
//
//        if (!self.showDetailModel.lastPrice) {
//
//        }else{
//            [self.messageArray addObject:@{@"name":@" 已付尾款", @"value":[NSString stringWithFormat:@"%.f", self.showDetailModel.lastPrice]}];
//        }
        
        if (self.showDetailModel.plusReason.length == 0) {
            
        }else{
             [self.messageArray addObject:@{@"name":@"增项内容", @"value":self.showDetailModel.plusReason}];
        }
        
        if (!self.showDetailModel.plusPrice) {
            
        }else{
            [self.messageArray addObject:@{@"name":@"增项金额", @"value":[NSString stringWithFormat:@"%.1f", self.showDetailModel.plusPrice]}];
        }
        
        if (self.showDetailModel.subtractReason.length == 0) {
            
        }else{
            [self.messageArray addObject:@{@"name":@"扣款内容", @"value":[NSString stringWithFormat:@"%@", self.showDetailModel.subtractReason]}];
        }
        
        if (!self.showDetailModel.subtractPrice) {
            
        }else{
            [self.messageArray addObject:@{@"name":@"扣款金额", @"value":[NSString stringWithFormat:@"%.1f", self.showDetailModel.subtractPrice]}];
        }
        
       
        
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


/*最下方按钮的响应方法*/
- (void)clickButton{
    WEAKSELF;
    if (self.showDetailModel.childState == 6 || self.showDetailModel.childState == 7 || self.showDetailModel.childState == 8) {
        [self getAliYunOSS];
    }else if (self.showDetailModel.childState == 1){
        
        if ([self.timeString isEqualToString:@"选择时间"] || self.timeString.length == 0) {
            [JGToast showWithText:@"请选择时间"];
        }else{
        [ZYHttpManager LoadingHttpRequestDataWithApi:JTOrderDrawingApply Aarameters:@{@"orderId":@(self.showDetailModel.order_id), @"lastTime":self.timeString} httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
            [JGToast showWithText:message];
            [gradientLayer removeFromSuperlayer];
            cancleButton.enabled = NO;
            [cancleButton setBackgroundColor:JGHexColor(@"#C4C4C4")];
            [weakSelf.table reloadData];
            if (weakSelf.changeBlock) {
                weakSelf.changeBlock();
            }
             [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSString * _Nonnull message) {
            [JGToast showWithText:message];
        }];
        }
    }else if (self.showDetailModel.childState == 10){
        [ZYHttpManager LoadingHttpRequestDataWithApi:JTOrderSubEvaluate Aarameters:@{@"orderId":@(self.showDetailModel.order_id), @"evaluate":self.apprienceString} httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
          
            
             [JGToast showWithText:message];
            [gradientLayer removeFromSuperlayer];
            cancleButton.enabled = NO;
            [cancleButton setBackgroundColor:JGHexColor(@"#C4C4C4")];
            
              [weakSelf.table reloadData];
            
            if (weakSelf.changeBlock) {
                weakSelf.changeBlock();
            }
             [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSString * _Nonnull message) {
            [JGToast showWithText:message];
        }];
    }else if (self.showDetailModel.childState == 0){
        [ZYHttpManager LoadingHttpRequestDataWithApi:JTOrderRevokeOrder Aarameters:@{@"orderId": @(self.showDetailModel.order_id)} httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
            [JGToast showWithText:message];
            
            [gradientLayer removeFromSuperlayer];
            cancleButton.enabled = NO;
            [cancleButton setBackgroundColor:JGHexColor(@"#C4C4C4")];
            [weakSelf.table reloadData];
            if (weakSelf.changeBlock) {
                weakSelf.changeBlock();
            }
            
             [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString * _Nonnull message) {
            [JGToast showWithText:message];
        }];
    }
    
   
    
}
#pragma mark ---获取阿里云上传凭证以及获取返回的字符串

- (void)getAliYunOSS{
    WEAKSELF;
    [ZYHttpManager LoadingHttpRequestDataWithApi:JTSTSOSS Aarameters:@{} httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        NSLog(@"%@", data);
        weakSelf.OSSDic = data;
        NSInteger count = weakSelf.showDetailModel.materialProduction.count;
        NSMutableArray * array = [NSMutableArray new];
        for (NSInteger i = weakSelf.materiaPicCount; i < weakSelf.materialProductionArray.count; i++) {
            NSData * data = UIImageJPEGRepresentation(weakSelf.materialProductionArray[i][@"image"], 1);
            [array addObject:data];
            NSLog(@"11111");
        }
        //上传物料信息
        [weakSelf uploadMateriel:array];
      
        
       
        if (weakSelf.picUrlArray.count == 0) {
            
        }else{
            [ZYHttpManager HttpRequestDataWithApi:JTOrderUploadMateriel Aarameters:@{@"orderId": @(weakSelf.showDetailModel.order_id), @"materials": weakSelf.picUrlArray} httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
                NSLog(@"%@", data);
                 [JGToast showWithText:message];
//                [weakSelf.picUrlArray removeAllObjects];
            } failure:^(NSString * _Nonnull message) {
                [JGToast showWithText:message];
            }];
        }
        
        NSMutableArray * drawingArray = [NSMutableArray new];
        //上传搭建图
        if (weakSelf.showDetailModel.childState == 6 || self.showDetailModel.childState == 7) {
            GHShowDetailsConstructListModel * model = self.showDetailModel.constructList.lastObject;
            NSInteger count= model.construct.count;
            for (NSInteger i = weakSelf.buildUrlPicCount; i < weakSelf.buildPicArray.count; i++) {
                NSData * data = UIImageJPEGRepresentation(weakSelf.buildPicArray[i][@"image"], 1);
                [drawingArray addObject:data];
            }
        }else if(self.showDetailModel.childState == 8){
            for (int i = 0; i < weakSelf.buildPicArray.count; i++) {
                NSData * data = UIImageJPEGRepresentation(weakSelf.buildPicArray[i][@"image"], 1);
                [drawingArray addObject:data];
            }
        }
        [weakSelf uploadOrderConstructUploadDrawing:drawingArray];
        
        if (weakSelf.drawingArray.count == 0) {
            
        }else{
        [ZYHttpManager HttpRequestDataWithApi:JTOrderConstructUploadDrawing Aarameters:@{@"orderId":@(weakSelf.showDetailModel.order_id), @"drawings":weakSelf.drawingArray} httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
            NSLog(@"%@", data);
             [JGToast showWithText:message];
        } failure:^(NSString * _Nonnull message) {
             [JGToast showWithText:message];
        }];
        
    }
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString * _Nonnull message) {
         [JGToast showWithText:message];
    }];

   
    
}
/*上传物料图*/
- (void )uploadMateriel:(NSArray *)dataSource{
   __weak typeof(self)weakSelf = self;
    weakSelf.picUrlArray = [NSMutableArray new];
    NSString *endpoint = @"http://oss-cn-hangzhou.aliyuncs.com";
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc]initWithAccessKeyId:weakSelf.OSSDic[@"accessKeyId"] secretKeyId:weakSelf.OSSDic[@"accessKeySecret"] securityToken:weakSelf.OSSDic[@"securityToken"]];
    client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = self.OSSDic[@"bucket"];
    //上传进度
    //    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
//            NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
//        };
    
    for (int i = 0; i<dataSource.count; i++) {
//        put.bucketName = @"cl1000";//后台给的
        NSString * timen =[JGCommonTools currentTimeStr];
        put.objectKey = timen;
//        put.objectKey = [NSString stringWithFormat:@"cIos%@.jpg",[self currentTimeStr]];//这个方法为时间戳加userid命名方式
        
        put.uploadingData = dataSource[i]; // 直接上传NSData字节
        
        put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
            NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
        };
        
        OSSTask * putTask = [client putObject:put];
        
        [putTask continueWithBlock:^id(OSSTask *task) {
            if (!task.error) {
                NSString * picUrlString = [NSString stringWithFormat:@"%@/%@", @"http://yashuzhanlan.oss-cn-hangzhou.aliyuncs.com/",timen];
                [weakSelf.picUrlArray addObject:picUrlString];
//                [weakSelf.picUrlArray addObject:put.objectKey];//多张图片时这里面存放的图片名字的数组在把这些名字弄成json字符串 给服务器
//                if (dataSoure.count > 1) {
//                    if (i == dataSoure.count-1) {
//                        success(array);
//                    }
//                }else{
//                    success(array);
//                }
            } else {
                NSLog(@"upload object failed, error: %@" , task.error);
            }
            return nil;
        }];
        
        [putTask waitUntilFinished];//这个时sdk给的用于多张图片上传时 加上它时只有第一个走了成功或者失败第二个才会走 。相当于等待串行。
    }
}

- (void)uploadOrderConstructUploadDrawing:(NSArray *)dataSource{
    __weak typeof(self)weakSelf = self;
    weakSelf.picUrlArray = [NSMutableArray new];
    NSString *endpoint = @"http://oss-cn-hangzhou.aliyuncs.com";
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc]initWithAccessKeyId:weakSelf.OSSDic[@"accessKeyId"] secretKeyId:weakSelf.OSSDic[@"accessKeySecret"] securityToken:weakSelf.OSSDic[@"securityToken"]];
    client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = self.OSSDic[@"bucket"];
    //上传进度
    //    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
    //            NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    //        };
    
    for (int i = 0; i<dataSource.count; i++) {
        //        put.bucketName = @"cl1000";//后台给的
        NSString * timen =[JGCommonTools currentTimeStr];
        put.objectKey = timen;
        //        put.objectKey = [NSString stringWithFormat:@"cIos%@.jpg",[self currentTimeStr]];//这个方法为时间戳加userid命名方式
        
        put.uploadingData = dataSource[i]; // 直接上传NSData字节
        
        put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
            NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
        };
        
        OSSTask * putTask = [client putObject:put];
        
        [putTask continueWithBlock:^id(OSSTask *task) {
            if (!task.error) {
                NSString * picUrlString = [NSString stringWithFormat:@"%@/%@", @"http://yashuzhanlan.oss-cn-hangzhou.aliyuncs.com/",timen];
                [weakSelf.drawingArray addObject:picUrlString];
                //                [weakSelf.picUrlArray addObject:put.objectKey];//多张图片时这里面存放的图片名字的数组在把这些名字弄成json字符串 给服务器
                //                if (dataSoure.count > 1) {
                //                    if (i == dataSoure.count-1) {
                //                        success(array);
                //                    }
                //                }else{
                //                    success(array);
                //                }
            } else {
                NSLog(@"upload object failed, error: %@" , task.error);
            }
            return nil;
        }];
        
        [putTask waitUntilFinished];//这个时sdk给的用于多张图片上传时 加上它时只有第一个走了成功或者失败第二个才会走 。相当于等待串行。
    }
}


/*选择最晚完成时间*/
- (void)selectTimeButtonClick:(UIButton *)sender{
    DateTimePickerView *pickerView = [[DateTimePickerView alloc] init];
    pickerView.delegate = self;
    pickerView.pickerViewMode = DatePickerViewDateMode;
    WEAKSELF;
    pickerView.block = ^(NSString *date) {
        weakSelf.timeString = date;
        [weakSelf.table reloadData];
    };
    [self.view addSubview:pickerView];
    [pickerView showDateTimePickerView];
}
/*时间选择器的代理---返回选择*/
- (void)didClickFinishDateTimePickerView:(NSString *)date{
    NSLog(@"time ----%@data", date);
}
@end
