//
//  GH_ShowDetailMessageJTTableViewCell.h
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface GH_ShowDetailMessageJTTableViewCell : JTBaseTableViewCell
@property (nonatomic, copy)NSString * titleString;
@property (nonatomic, copy)NSString * contenString;
@property (nonatomic, strong)NSDictionary * messageDic;
@end

NS_ASSUME_NONNULL_END
