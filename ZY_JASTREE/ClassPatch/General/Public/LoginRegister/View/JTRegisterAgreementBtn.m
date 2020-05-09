//
//  JTRegisterAgreementBtn.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTRegisterAgreementBtn.h"

@implementation JTRegisterAgreementBtn

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
                
        self.titleLabel.font = JGFont(13);
        [self setTitleColor:JG666Color forState:UIControlStateNormal];
        [self setTitle:@"我已阅读并同意" forState:UIControlStateNormal];
        [self setImage:JGImage(@"Login_nor") forState:UIControlStateNormal];
        [self setImage:JGImage(@"Login_sel")  forState:UIControlStateSelected];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    CGFloat y = (h - 14.0) / 2.0;
    
    self.imageView.frame = CGRectMake(0, y, 14, 14);
    self.titleLabel.frame = CGRectMake(20, 0, w - 20, h);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
