//
//  ZYSendMobileCodeBtn.m
//  FD
//
//  Created by 郭军 on 2019/6/25.
//  Copyright © 2019 ZhiYuan Network. All rights reserved.
//

#import "ZYSendMobileCodeBtn.h"

#define KTime   60   //设置重新发送的时间  自己可以改

@interface ZYSendMobileCodeBtn () {
    NSTimer *_myTimer;//定时器
}
@property (nonatomic,assign) NSInteger timer;

@end

@implementation ZYSendMobileCodeBtn

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _timer = KTime;
        self.titleLabel.font = JGBoldFont(13);
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self setTitleColor:JGHexColor(@"#AFAEAE") forState:UIControlStateNormal];
        [self setTitleColor:JGHexColor(@"#AFAEAE") forState:UIControlStateDisabled];
        [self addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.enabled = YES;
    }
    return self;
}

-(void)setSecond:(int)second{
    _second = second;
    _timer = _second;
}

- (void)BtnClick {
    
    
    if (self.countDownButtonBlock) {
        //获取验证码
        _countDownButtonBlock();
    }
    
    
}


- (void)sentCodeBtnClick {

    self.enabled = NO;
    
    [self setTitle:[NSString stringWithFormat:@"%zis秒后重发", _timer] forState:UIControlStateNormal];
    
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(myTimer) userInfo:nil repeats:YES];

}


//重置按钮显示
- (void)reSetCodeBtn {
    
    [self setTitle:@"重新获取" forState:UIControlStateNormal];
    self.enabled = YES;
    [_myTimer invalidate];
    _myTimer = nil;
    _timer = KTime;
}


- (void)myTimer{
    [self setTitle:[NSString stringWithFormat:@"%zis秒后重发", _timer] forState:UIControlStateNormal];
    if (_timer == 0) {
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.enabled = YES;
        [_myTimer invalidate];
        _myTimer = nil;
        _timer = KTime;
    }else{
        _timer --;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
