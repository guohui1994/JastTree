//
//  GH_ShowDetailAddPicJTTableViewCell.m
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/7/4.
//  Copyright © 2019 JG. All rights reserved.
//

#import "GH_ShowDetailAddPicJTTableViewCell.h"

@interface GH_ShowDetailAddPicJTTableViewCell ()
@property (nonatomic, strong)UILabel * dataLable;
@property (nonatomic, strong)UIView * backgroundImageView;
@property (nonatomic, strong)NSMutableArray * temp;

@end

@implementation GH_ShowDetailAddPicJTTableViewCell



- (void)configUI{
    self.photoArry = [NSMutableArray new];
    [self.contentView addSubview:self.dataLable];
    [self.contentView addSubview:self.backgroundImageView];
    [self layout];
}
- (void)layout{
    
    self.dataLable.sd_layout
    .leftSpaceToView(self.contentView, kWidthScale(23))
    .topSpaceToView(self.contentView, kHeightScale(30))
    .widthIs(100)
    .heightIs(13);
    
    
    self.backgroundImageView.sd_layout
    .leftSpaceToView(self.contentView, 5)
    .topSpaceToView(self.dataLable, 5)
    .widthIs(kDeviceWidth - 10);
    
    [self setupAutoHeightWithBottomView:self.backgroundImageView bottomMargin:10];
}

- (void)setPhotoArry:(NSMutableArray *)photoArry{
    _photoArry = photoArry;
    self.temp = [NSMutableArray new];
    
    if (photoArry.count == 0) {
        [self.backgroundImageView addSubview:self.addpicButton];
        self.addpicButton.sd_layout
        .autoHeightRatio(1);
        if (self.isShowAddButton) {
            
            [self.temp addObject:self.addpicButton];
        }else{
            
        }
    }else{
    
    for (int i = 0; i < photoArry.count; i++) {
        UIImageView * ima = [UIImageView new];
//        [ima sd_setImageWithURL:[NSURL URLWithString:photoArry[i]]];
        ima.userInteractionEnabled = YES;
        [self.backgroundImageView addSubview:ima];
        ima.sd_layout.autoHeightRatio(1);
        ima.sd_cornerRadius = @(kWidthScale(12));
        UIButton * deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backgroundImageView addSubview:deleteButton];
        [deleteButton setImage:[UIImage imageNamed:@"Delete"] forState:UIControlStateNormal];
        deleteButton.sd_layout
        .leftSpaceToView(ima, kWidthScale(-10))
        .topSpaceToView(ima, kWidthScale(-120))
        .widthIs(kWidthScale(20))
        .heightIs(kWidthScale(20));
        deleteButton.tag = 800001 + i;
        [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchDown];
        deleteButton.sd_cornerRadius = @(kWidthScale(10));
        if (_isShowDeleteButton) {
            deleteButton.hidden = NO;
        }else{
            deleteButton.hidden = YES;
        }
        ima.tag = 900001 + i;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [ima addGestureRecognizer:tap];
        if (photoArry.count == 0) {
            
        }else{
        if (i < _netWorkImageUrlCount) {
            [ima sd_setImageWithURL:[NSURL URLWithString:photoArry[i]]];
        }else{
            ima.image = photoArry[i][@"image"];
        }
        }
        [self.temp addObject:ima];
    }
       
        
    if (photoArry.count == 9) {
    }else{
        [self.backgroundImageView addSubview:self.addpicButton];
        self.addpicButton.sd_layout
        .autoHeightRatio(1);
        if (self.isShowAddButton) {
            [self.temp addObject:self.addpicButton];
        }else{
        }
    }
    }
    
    
    
     [self.backgroundImageView setupAutoMarginFlowItems:self.temp withPerRowItemsCount:3 itemWidth:kWidthScale(110) verticalMargin:10 verticalEdgeInset:10 horizontalEdgeInset:10];
    
    [self.backgroundImageView updateLayout];
}

- (void)setIsShowDeleteButton:(BOOL)isShowDeleteButton{
    _isShowDeleteButton = isShowDeleteButton;
}
- (void)setDay:(NSInteger)day{
    _day = day;
    _dataLable.text = [NSString stringWithFormat:@"第%ld天", day];
}
- (void)tap:(UITapGestureRecognizer *)gesture{
    int index =(int) gesture.view.tag - 900001;
    
//    if (_isShowAddButton ) {
//
//    }else{
//    if (self.blocks) {
//        self.blocks(index, _photoArry);
//    }
//    }
    
    if (self.blocks) {
        self.blocks(index, _photoArry);
    }
}



- (void)deleteButtonClick:(UIButton *)sender{
    int index = (int)sender.tag - 800001;
    if (self.deleteBlcok) {
        self.deleteBlcok(index, _photoArry);
    }
}

- (void)setNetWorkImageUrlCount:(int)netWorkImageUrlCount{
    _netWorkImageUrlCount = netWorkImageUrlCount;
}

- (void)setIsShowAddButton:(BOOL)isShowAddButton{
    _isShowAddButton = isShowAddButton;
}

- (void)setIsShowDay:(BOOL)isShowDay{
    _isShowDay = isShowDay;
    if (isShowDay) {
        _dataLable.hidden = NO;
        
    }else{
        _dataLable.hidden = YES;
        self.backgroundImageView.sd_layout
        .topSpaceToView(self.contentView, kHeightScale(10));
        [self.backgroundImageView updateLayout];
    }
}

- (UIButton *)addpicButton{
    if (!_addpicButton) {
        _addpicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addpicButton setImage:[UIImage imageNamed:@"addpic.png"] forState:UIControlStateNormal];
        _addpicButton.sd_cornerRadius = @(kWidthScale(12));;
        _addpicButton.backgroundColor = JGHexColor(@"#E5E5E5");
    }
    return _addpicButton;
}

- (UILabel *)dataLable{
    if (!_dataLable) {
        _dataLable = [UILabel new];
        _dataLable.text = @"第一天";
        _dataLable.font = JGFont(kWidthScale(14));
        _dataLable.textColor = JGHexColor(@"#4C4C4C");
    }
    return _dataLable;
}

- (UIView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView = [UIView new];
    }
    return _backgroundImageView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
