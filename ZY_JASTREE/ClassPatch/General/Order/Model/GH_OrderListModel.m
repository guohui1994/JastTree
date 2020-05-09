//
//  GH_OrderListModel.m
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/7/8.
//  Copyright © 2019 JG. All rights reserved.
//

#import "GH_OrderListModel.h"
@implementation GHOrderListListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"order_id" : @"id"};
}
@end


@implementation GH_OrderListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"order_id" : @"id"};
}
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":@"GHOrderListListModel"};
}

@end
