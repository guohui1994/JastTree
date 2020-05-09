//
//  JTChooseTimeAndProvinceAlert.h
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/8.
//  Copyright © 2019 JG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JTChooseTimeAndProvinceAlert : UIView

@property (nonatomic, copy) ReturnBackInfo backInfo;
// showType 1 显示左侧  2 显示右侧
@property (nonatomic, assign) NSInteger showType;

@property (nonatomic, strong)NSArray *DataArrM;



/**
 移除BoxAlert
 */
- (void)remove;

/**
 显示BoxAlert
 */
- (void)show;


@end

NS_ASSUME_NONNULL_END
