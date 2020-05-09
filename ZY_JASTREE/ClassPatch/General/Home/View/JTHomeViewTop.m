//
//  JTHomeViewTop.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTHomeViewTop.h"

@interface JTHomeViewTopBtn: UIButton
@end


@implementation JTHomeViewTopBtn

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.font = JGFont(14);
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        [self setTitleColor:JGHexColor(@"#5A5A5A") forState:UIControlStateNormal];
        
        [self setImage:JGImage(@"Home_down") forState:UIControlStateNormal];        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat h = self.frame.size.height;
    CGFloat y = (h - 7) / 2.0;
    
//    CGFloat X = self.titleLabel.x;
    self.titleLabel.x -=  20;
    
    self.imageView.frame = CGRectMake(self.titleLabel.right + 9, y, 11, 7);
}
@end

@interface JTHomeViewTop()

@property (nonatomic, strong) JTHomeViewTopBtn *TimeBtn;

@property (nonatomic, strong) JTHomeViewTopBtn *AreaBtn;

@end


@implementation JTHomeViewTop


- (void)configUI {

    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5.0f;
    self.backgroundColor = JGHexColor(@"#F5F5F5");
    
    _TimeBtn = [JTHomeViewTopBtn new];
    _TimeBtn.tag = 10;
    [_TimeBtn setTitle:@"时间筛选" forState:UIControlStateNormal];
    [_TimeBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _AreaBtn = [JTHomeViewTopBtn new];
    _AreaBtn.tag = 20;
    [_AreaBtn setTitle:@"选择地区" forState:UIControlStateNormal];
    [_AreaBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_TimeBtn];
    [self addSubview:_AreaBtn];

    CGFloat btnW = (kDeviceWidth - 30) / 2.0;
    
    [_TimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(@(btnW));
    }];
    
    [_AreaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.width.equalTo(@(btnW));
    }];
}


- (void)BtnClick:(UIButton *)btn {
    
    if (self.backInfo) {
        self.backInfo(btn);
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
