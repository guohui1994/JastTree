//
//  GH_OrderListModel.h
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/7/8.
//  Copyright © 2019 JG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface GHOrderListListModel : NSObject

@property (nonatomic, assign) NSInteger order_id;

@property (nonatomic, assign) NSInteger quoteTime;

@property (nonatomic, assign) NSInteger childState;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, assign) NSInteger pushTime;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *exhibitionSite;

@property (nonatomic, assign) double quote;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, assign) NSInteger parentState;

@property (nonatomic, copy) NSString *surfacePlot;

@property (nonatomic, copy) NSString *name;

@end
@interface GH_OrderListModel : NSObject

//@property (nonatomic, assign)int  order_id;
//@property(nonatomic, copy)NSString * name;//展会名称
//@property (nonatomic, copy)NSString *surfacePlot;//封面
//@property (nonatomic, copy)NSString * exhibitionSite;//详细地址
//@property (nonatomic, copy)NSString *
@property (nonatomic, assign) NSInteger order_id;

@property (nonatomic, assign) NSInteger quoteTime;

@property (nonatomic, assign) NSInteger childState;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, assign) NSInteger pushTime;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *exhibitionSite;

@property (nonatomic, assign) double quote;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, assign) NSInteger parentState;

@property (nonatomic, copy) NSString *surfacePlot;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign)BOOL isLastPage;

@property (nonatomic, copy) NSArray<GHOrderListListModel *> *list;

@end

NS_ASSUME_NONNULL_END
