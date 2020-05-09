//
//  GH_OrderListTopView.m
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "GH_OrderListTopView.h"

@interface GH_OrderListTopView ()
@property (nonatomic, strong)UILabel * lineLable;
@end

@implementation GH_OrderListTopView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    NSArray * titleArray = @[@"全部", @"已报价", @"进行中", @"已完成"];
    
    for (int i = 0; i < 4; i++) {
        UIButton * titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.frame = CGRectMake((kDeviceWidth - kWidthScale(30))/4 * i, 0, (kDeviceWidth - kWidthScale(30))/4, kHeightScale(40));
        [titleButton setTitleColor:JGHexColor(@"#5A5A5A") forState:UIControlStateNormal];
        [titleButton setTitle:titleArray[i] forState:UIControlStateNormal];
        titleButton.titleLabel.font = JGFont(kWidthScale(14));
        titleButton.tag = 9528 + i;
       
        
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:titleButton];
        if (i == 0) {
            [self titleButtonClick:titleButton];
        }
    }
}


- (void)titleButtonClick:(UIButton *)sender{
    int index = (int)(sender.tag - 9527);
   
    if (self.lineLable) {
        [self.lineLable removeFromSuperview];
    }
  
    UILabel * lineLable = [UILabel new];
  lineLable.backgroundColor = JGHexColor(@"#FB6D35");
    lineLable.sd_cornerRadius = @(kWidthScale(2));
    [self addSubview:lineLable];
    lineLable.sd_layout
    .leftSpaceToView(self, ((kDeviceWidth - kWidthScale(30))/4 - kWidthScale(16))/2 + sender.left)
    .bottomSpaceToView(self, kHeightScale(4))
    .widthIs(kWidthScale(16))
    .heightIs(kWidthScale(3));
    self.lineLable = lineLable;
////    __weak typeof(self)strongSelf = self;
////      strongSelf.block(index);
//      self.block(index);
    if (self.block) {
        self.block(index);
    }
    
}
@end
