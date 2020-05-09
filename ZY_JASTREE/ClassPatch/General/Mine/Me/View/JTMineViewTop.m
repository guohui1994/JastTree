//
//  JTMineViewTop.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/4.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTMineViewTop.h"


@interface JTMineViewTop() 
@property (nonatomic, strong) UILabel *NameLbl;
@property (nonatomic, strong) UILabel *IDLbl;
@property (nonatomic, strong) UIImageView *Icon;

@property (nonatomic, strong) UIButton *LookInfoBtn;

@end




@implementation JTMineViewTop

- (void)configUI {
    
    UIImageView *TopBg = [UIImageView new];
    TopBg.image = JGImage(@"Mine_Bg");
    
    
    _Icon = [UIImageView new];
    _Icon.clipsToBounds = YES;
    _Icon.layer.cornerRadius = 40.0f;
//    _Icon.image = JGImage(@"Mine_Icon");
    NSString *head =  [JGCommonTools getUserDefaultsWithKey:@"head"];
    [_Icon sd_setImageWithURL:[NSURL URLWithString:head] placeholderImage:JGImage(@"Mine_Icon")];
    
    
    
    _NameLbl = [UILabel new];
    _NameLbl.textColor = [UIColor whiteColor];
    _NameLbl.font = JGBoldFont(15);
//    _NameLbl.text = @"杰里冬谷的旅行日记";
    
    NSString *nickName =  [JGCommonTools getUserDefaultsWithKey:@"nickName"];
    NSString *Phone =  [JGCommonTools getUserDefaultsWithKey:@"phone"];
    
    if (!nickName.length) {
        nickName = Phone;
    }
    
    _NameLbl.text = nickName;

    
    _IDLbl = [UILabel new];
    _IDLbl.textColor = [UIColor whiteColor];
    _IDLbl.font = JGFont(12);
    NSString *user_id =  [JGCommonTools getUserDefaultsWithKey:@"user_id"];
    _IDLbl.text = [NSString stringWithFormat:@"ID %@", user_id];
    
    _LookInfoBtn = [UIButton new];
    [_LookInfoBtn addTarget:self action:@selector(LookInfoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:TopBg];
    [self addSubview:_Icon];
    [self addSubview:_NameLbl];
    [self addSubview:_IDLbl];
    [self addSubview:_LookInfoBtn];

    
    
    [TopBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_Icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).mas_offset(-111);
        make.right.equalTo(self.mas_right).mas_offset(-92);
        make.width.height.equalTo(@(80));
    }];

    [_NameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).mas_offset(37);
        make.bottom.equalTo(_Icon.mas_centerY).mas_offset(-5);
    }];
    
    [_IDLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_NameLbl.mas_left);
        make.top.equalTo(_Icon.mas_centerY).mas_offset(5);
    }];
    
    [_LookInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.bottom.equalTo(_Icon);
    }];
}


- (void)LookInfoBtnClick {
    
    if (self.backInfo) {
        self.backInfo(@"查看用户信息");
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
