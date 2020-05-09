//
//  JTLoginModel.h
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/8.
//  Copyright © 2019 JG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JTLoginModel : NSObject
//用户ID
@property (nonatomic, copy) NSString *user_id;
//token
@property (nonatomic, copy) NSString *token;
//昵称
@property (nonatomic, copy) NSString *nickName;
//头像
@property (nonatomic, copy) NSString *head;
//手机号
@property (nonatomic, copy) NSString *phone;

//第一次绑定手机后台需要传回去
@property (nonatomic, strong) NSDictionary *data;



/**
 存储用户信息
 */
- (void)saveUserInfo;


/**************** 辅助字段 ******************/
//微信：wx  QQ: qq
@property (nonatomic, copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
