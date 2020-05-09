//
//  JTExhibitionSelectListModel.m
//  ZY_JASTREE
//
//  Created by indulgeIn on 2019/07/08.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import "JTExhibitionSelectListModel.h"


@implementation JTExhibitionSelectListList1Model

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}


@end


@implementation JTExhibitionSelectListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":@"JTExhibitionSelectListList1Model"};
}

@end


