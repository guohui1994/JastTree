//
//  JTForgetOrFixPwdController.h
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JTForgetOrFixPwdController : JTBaseViewController


/**
 标记是忘记密码还是修改密码 值为0 忘记密码 值为1 更改密码
 默认 忘记密码
 */
@property (nonatomic, assign) int TypeIndex;


@property (nonatomic, copy) NSString *PhoneStr;


@end

NS_ASSUME_NONNULL_END
