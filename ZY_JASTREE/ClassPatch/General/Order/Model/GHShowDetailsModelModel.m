//
//  GHShowDetailsModelModel.m
//  ZY_JASTREE
//
//  Created by indulgeIn on 2019/07/09.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import "GHShowDetailsModelModel.h"


@implementation GHShowDetailsAddedFourModel

@end


@implementation GHShowDetailsAddedTwoModel

@end


@implementation GHShowDetailsAddedThreeModel

@end


@implementation GHShowDetailsConstructListModel

@end


@implementation GHShowDetailsAddedOneModel

@end


@implementation GHShowDetailsModelModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"constructList":@"GHShowDetailsConstructListModel"};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"order_id" : @"id"};
}
@end


