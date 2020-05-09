//
//  GH_HomeTopCarouseView.h
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/9/2.
//  Copyright © 2019 JG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^selectItem)(NSInteger index, NSArray * array);
@interface GH_HomeTopCarouseView : UIView
@property (nonatomic, copy)selectItem block;
@property (nonatomic, strong)NSArray * dataSourceArray;
@end

NS_ASSUME_NONNULL_END
