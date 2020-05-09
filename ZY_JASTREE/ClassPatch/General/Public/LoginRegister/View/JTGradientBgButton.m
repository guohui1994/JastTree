//
//  JTGradientBgButton.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTGradientBgButton.h"

@implementation JTGradientBgButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.titleLabel.font = JGFont(17);
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.gradientLayer =  [CAGradientLayer layer];
        self.gradientLayer.startPoint = CGPointMake(0, 0);
        self.gradientLayer.endPoint = CGPointMake(1, 0);
        self.gradientLayer.locations = @[@(0.0),@(1.0)];//渐变点
        [self.gradientLayer setColors:@[(id)JGHexColor(@"#FE8E33").CGColor,(id)JGHexColor(@"#FB6D35").CGColor]];//渐变数组
//        [self.layer addSublayer:self.gradientLayer];
        
        [self.layer insertSublayer:self.gradientLayer atIndex:0];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.gradientLayer.frame = CGRectMake(0, 0, w, h);
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
