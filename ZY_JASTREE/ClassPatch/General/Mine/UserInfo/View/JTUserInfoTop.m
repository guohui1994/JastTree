//
//  JTUserInfoTop.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/4.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTUserInfoTop.h"


@interface JTUserInfoTop()
//头像
@property (nonatomic, strong) UIImageView *Icon;
@end


@implementation JTUserInfoTop


- (void)configUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    _Icon = [UIImageView new];
    _Icon.backgroundColor = [UIColor cyanColor];
    _Icon.clipsToBounds = YES;
    _Icon.layer.cornerRadius = 30.0f;
    NSString *head =  [JGCommonTools getUserDefaultsWithKey:@"head"];
    [_Icon sd_setImageWithURL:[NSURL URLWithString:head] placeholderImage:JGImage(@"Mine_Icon")];
    
    
    [self addSubview:_Icon];
    
    [_Icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom);
        make.width.height.equalTo(@(60));
    }];
    
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
