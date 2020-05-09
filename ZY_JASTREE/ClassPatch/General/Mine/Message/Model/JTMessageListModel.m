//
//  JTMessageListModel.m
//  ZY_JASTREE
//
//  Created by indulgeIn on 2019/07/11.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import "JTMessageListModel.h"


@implementation JTMessageListListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}


@end


@implementation JTMessageListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":@"JTMessageListListModel"};
}

@end


