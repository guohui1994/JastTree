//
//  GH_OrderTableViewCell.h
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTBaseTableViewCell.h"
#import "GH_OrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GH_OrderTableViewCell : JTBaseTableViewCell
@property (nonatomic, strong)UIButton * clickButton;
@property (nonatomic, strong)GHOrderListListModel * model;
@end

NS_ASSUME_NONNULL_END
