//
//  GH_ShowDetailJTTableViewCell.h
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^block)(int index, NSArray * array);
typedef void(^blockQuteMoney)(NSString* qouteMoney);
@interface GH_ShowDetailJTTableViewCell : JTBaseTableViewCell

//@property (nonatomic, assign)int  modelCount;

@property (nonatomic, copy)NSString * titleString;
@property (nonatomic, assign)BOOL isShowQuteLable;//是否展示我的报价
@property (nonatomic, copy)NSString * quteMoney;
@property (nonatomic, strong)NSArray * photoArray;
@property (nonatomic, strong)block blocks;
@property (nonatomic, assign)BOOL isShowTimeButton;//是否展示时间选择按钮
@property (nonatomic, strong)UIButton * selectTimeButton;
@property(nonatomic, copy)NSString * timeString;
@property (nonatomic, assign)BOOL isShowTextField;//是否显示我的报价输入框
@property (nonatomic, strong)blockQuteMoney qouteMoneyBlock;
@end

NS_ASSUME_NONNULL_END
