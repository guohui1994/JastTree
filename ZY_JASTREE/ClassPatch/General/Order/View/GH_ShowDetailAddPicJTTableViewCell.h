//
//  GH_ShowDetailAddPicJTTableViewCell.h
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/7/4.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^block)(int index, NSArray * array);
typedef void(^blockDelete)(int index, NSArray * array);
@interface GH_ShowDetailAddPicJTTableViewCell : JTBaseTableViewCell
@property (nonatomic, assign)BOOL isShowAddButton;//状态
@property (nonatomic, strong)NSMutableArray * photoArry;//图片数组
@property (nonatomic, strong)UIButton * addpicButton;
@property (nonatomic, assign)BOOL isShowDay;//是否显示第几天, 区分物料和搭建图片
@property (nonatomic, assign)NSInteger netWorkImageUrlCount;//传过来网络图片链接的个数主要是为了图片显示方法不一样
@property (nonatomic, strong)block blocks;
@property (nonatomic, strong)blockDelete deleteBlcok;
@property (nonatomic, assign)BOOL isShowDeleteButton;
@property (nonatomic, assign)NSInteger day;
@end

NS_ASSUME_NONNULL_END
