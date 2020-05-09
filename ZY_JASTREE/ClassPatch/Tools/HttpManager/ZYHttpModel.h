//
//  ZYHttpModel.h
//  FD_Rider
//
//  Created by 郭军 on 2019/3/18.
//  Copyright © 2019年 zhiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYHttpModel : NSObject

/**
 SUCCESS：业务处理成功
 ERROR：业务处理失败，此时客户端需将describe字段toast处理
 EXCEPTION：业务处理异常，此时客户端需记录请求相关的日志信息
 其它：客户端需按照特定逻辑进行处理
 */
@property (copy, nonatomic) NSString *event;

/**
 附加数据，默认：空数组
 */
@property (copy, nonatomic) NSString *describe;

/**
 描述信息，默认：空字符串
 */
@property (strong, nonatomic) id data;

- (instancetype)initWithObject:(id)object;


@end

NS_ASSUME_NONNULL_END
