//
//  GH_HomeCarouselCell.h
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/8/23.
//  Copyright © 2019 JG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^selectItem)(NSInteger index, NSArray * array);
@interface GH_HomeCarouselCell : UITableViewCell
@property (nonatomic, copy)selectItem block;
@property (nonatomic, strong)NSArray * dataSourceArray;
@end

NS_ASSUME_NONNULL_END
