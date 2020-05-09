//
//  GH_ShowDetailMessageJTTableViewCell.m
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "GH_ShowDetailMessageJTTableViewCell.h"
@interface GH_ShowDetailMessageJTTableViewCell ()
@property (nonatomic, strong)UILabel * titleLable;

@property (nonatomic, strong)UILabel * contentLable;
@end
@implementation GH_ShowDetailMessageJTTableViewCell

- (void)configUI{
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.contentLable];
    
    [self layout];
}
- (void)layout{
   self.titleLable.sd_layout
    .leftSpaceToView(self.contentView, kWidthScale(34))
    .topSpaceToView(self.contentView, kHeightScale(8))
    .widthIs(kWidthScale(75))
    .heightIs(kHeightScale(15));


    self.contentLable.sd_layout
    .leftSpaceToView(self.titleLable, kWidthScale(30))
    .topEqualToView(self.titleLable)
    .widthIs(kWidthScale(230))
    .autoHeightRatio(0);
    [self setupAutoHeightWithBottomView:self.contentLable bottomMargin:10];
}

- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _titleLable.text = titleString;
}
- (void)setContenString:(NSString *)contenString{
    
}

- (void)setMessageDic:(NSDictionary *)messageDic{
    _messageDic = messageDic;
    _titleLable.text = messageDic[@"name"];
    _contentLable.text = messageDic[@"value"];
}


- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.text = @"展会编号";
        _titleLable.font = JGFont(kWidthScale(14));
        _titleLable.textColor = JGHexColor(@"#A1A0A0");
    }
    return  _titleLable;
}

- (UILabel *)contentLable{
    if (!_contentLable) {
        _contentLable = [UILabel new];
        _contentLable = [UILabel new];
        _contentLable.text = @"";
        _contentLable.font = JGFont(kWidthScale(14));
        _contentLable.textColor = JGHexColor(@"#4C4C4C");
    }
    return _contentLable;
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
