//
//  GH_HomeCarouselCell.m
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/8/23.
//  Copyright © 2019 JG. All rights reserved.
//

#import "GH_HomeCarouselCell.h"

@interface GH_HomeCarouselCell ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong)SDCycleScrollView *cycleView ;
@end

@implementation GH_HomeCarouselCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{

  
}


- (void)setDataSourceArray:(NSArray *)dataSourceArray{
    _dataSourceArray = dataSourceArray;
    
        
    
    self.cycleView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kHeightScale(180))];
    self.cycleView.backgroundColor = [UIColor whiteColor];
    self. cycleView.delegate = self;
    self.cycleView.imageURLStringsGroup = dataSourceArray;
    [self.contentView addSubview:self.cycleView];
    
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (self.block) {
        self.block(index, self.dataSourceArray);
    }
    NSLog(@"你点击了%ld", index);
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
