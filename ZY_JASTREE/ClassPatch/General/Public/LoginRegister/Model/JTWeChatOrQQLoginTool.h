//
//  JTWeChatOrQQLoginTool.h
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/11.
//  Copyright © 2019 JG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JTLoginModel.h"  //登录模型

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoginSuccess)(JTLoginModel *Model);
typedef void(^LoginFailure)(NSString *message);




@interface JTWeChatOrQQLoginTool : NSObject

/**
 *  获取单例
 */
+ (instancetype)shared;


/**
 QQ登录

 @param successBlock 成功回调
 @param failBlock 失败回调
 */
- (void)QQ_LoginSuccess:(LoginSuccess)successBlock
                Failure:(LoginFailure)failBlock;

/**
 微信登录
 
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
- (void)WX_LoginSuccess:(LoginSuccess)successBlock
               Failure:(LoginFailure)failBlock;




/************* 回调入口 *****************/
- (BOOL) handleOpenURL:(NSURL *) url;

- (BOOL) sourceApplicationOpenURL:(NSURL *) url;

- (BOOL) OpenURL:(NSURL *) url;


@end

NS_ASSUME_NONNULL_END
