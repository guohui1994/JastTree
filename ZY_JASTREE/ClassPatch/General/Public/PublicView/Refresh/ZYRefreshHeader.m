//
//  ZYRefreshHeader.m
//  FD_Rider
//
//  Created by 郭军 on 2019/3/18.
//  Copyright © 2019年 zhiyuan. All rights reserved.
//

#import "ZYRefreshHeader.h"

@interface ZYRefreshHeader ()

/** logo */
@property (nonatomic, weak) UIImageView *logo;

@end


@implementation ZYRefreshHeader


/**
 *  初始化
 */
- (void)prepare
{
    [super prepare];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    //    self.automaticallyChangeAlpha = YES;
    
    // 设置控件的高度
    self.mj_h = 50;
    
//    // 隐藏时间
//    self.lastUpdatedTimeLabel.hidden = YES;
//
//    // 隐藏状态
//    self.stateLabel.hidden = YES;
    
        self.automaticallyChangeAlpha = YES;
//        self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
//        self.stateLabel.textColor = [UIColor orangeColor];
        [self setTitle:@"赶紧下拉吧" forState:MJRefreshStateIdle];
        [self setTitle:@"赶紧松开吧" forState:MJRefreshStatePulling];
        [self setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];
        //    self.lastUpdatedTimeLabel.hidden = YES;
        //    self.stateLabel.hidden = YES;
    //    [self addSubview:[[UISwitch alloc] init]];
    //
    //    UIImageView *logo = [[UIImageView alloc] init];
    //    logo.image = [UIImage imageNamed:@"bd_logo1"];
    //    [self addSubview:logo];
    //    self.logo = logo;
}

/**
 *  摆放子控件
 */
//- (void)placeSubviews
//{
//    [super placeSubviews];
//
//    self.logo.width = self.width;
//    self.logo.height = 50;
//    self.logo.x = 0;
//    self.logo.y = - 50;
//}



@end
