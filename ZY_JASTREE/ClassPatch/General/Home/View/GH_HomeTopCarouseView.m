//
//  GH_HomeTopCarouseView.m
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/9/2.
//  Copyright © 2019 JG. All rights reserved.
//

#import "GH_HomeTopCarouseView.h"

@interface GH_HomeTopCarouseView ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong)SDCycleScrollView *cycleView ;
@end

@implementation GH_HomeTopCarouseView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)setDataSourceArray:(NSArray *)dataSourceArray{
    _dataSourceArray = dataSourceArray;
    
    
    
    self.cycleView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kHeightScale(180))];
    self.cycleView.backgroundColor = [UIColor whiteColor];
    self. cycleView.delegate = self;
    self.cycleView.imageURLStringsGroup = dataSourceArray;
    [self addSubview:self.cycleView];
    
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (self.block) {
        self.block(index, self.dataSourceArray);
    }
    NSLog(@"你点击了%ld", index);
}

@end
