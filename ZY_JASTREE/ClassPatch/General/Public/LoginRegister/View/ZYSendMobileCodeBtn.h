//
//  ZYSendMobileCodeBtn.h
//  FD
//
//  Created by 郭军 on 2019/6/25.
//  Copyright © 2019 ZhiYuan Network. All rights reserved.
//  获取验证码按钮

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ClickCountDownButtonBlock)(void);

@interface ZYSendMobileCodeBtn : UIButton

@property(nonatomic , assign) int second; //开始时间数
@property(nonatomic , copy) ClickCountDownButtonBlock countDownButtonBlock; //点击按钮

- (void)reSetCodeBtn; //重置按钮显示

- (void)sentCodeBtnClick; //获取验证码

@end

NS_ASSUME_NONNULL_END
