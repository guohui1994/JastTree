//
//  JTBaseView.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/2.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTBaseView.h"

@implementation JTBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self configUI];
    }
    return self;
}


- (void)configUI {};

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
