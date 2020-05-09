//
//  GH_OrderTableViewCell.m
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "GH_OrderTableViewCell.h"

@interface GH_OrderTableViewCell ()
@property (nonatomic, strong)UIImageView * headerImageView;//图片
@property (nonatomic, strong)UILabel * statuteLable;//状态
@property (nonatomic, strong)UILabel * titleLable;//标题
@property (nonatomic, strong)UILabel * adressLable;// 地址
@property (nonatomic, strong)UILabel * publishDataLable;//发布时间
@property (nonatomic, strong)UILabel * offerDataLable;// 报价时间
@property (nonatomic, strong)UILabel * offerMoneyLable;// 报价
@property (nonatomic, strong)UIView * lineView;
@end


@implementation GH_OrderTableViewCell


- (void)configUI{
    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.statuteLable];
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.adressLable];
    [self.contentView addSubview:self.publishDataLable];
    [self.contentView addSubview:self.offerDataLable];
    [self.contentView addSubview:self.offerMoneyLable];
    [self.contentView addSubview:self.clickButton];
    [self.contentView addSubview:self.lineView];
    [self layout];
}

- (void)layout{
    self.headerImageView.sd_layout
    .leftSpaceToView(self.contentView, kWidthScale(12))
    .topSpaceToView(self.contentView, kWidthScale(15))
    .widthIs(kWidthScale(79))
    .heightIs(kWidthScale(75));
    
    self.statuteLable.sd_layout
   .centerXEqualToView(self.headerImageView)
    .topSpaceToView(self.headerImageView, kWidthScale(14))
    .widthIs(self.headerImageView.width)
    .autoHeightRatio(0);
    
    self.titleLable.sd_layout
    .leftSpaceToView(self.headerImageView, 16)
    .topSpaceToView(self.contentView, kWidthScale(19))
    .widthIs(kWidthScale(251))
    .autoHeightRatio(0);
    
    self.adressLable.sd_layout
    .leftEqualToView(self.titleLable)
    .topSpaceToView(self.titleLable, kWidthScale(7))
    .widthIs(self.titleLable.width)
    .autoHeightRatio(0);
    
    self.publishDataLable.sd_layout
    .leftEqualToView(self.titleLable)
    .topSpaceToView(self.adressLable, 7)
    .heightIs(kHeightScale(11))
    .autoWidthRatio(0);
    [self.publishDataLable setSingleLineAutoResizeWithMaxWidth:(kDeviceWidth - kWidthScale(123))/2];
    
    self.offerDataLable.sd_layout
    .leftSpaceToView(self.publishDataLable, kWidthScale(16))
    .topEqualToView(self.publishDataLable)
    .heightIs(kHeightScale(11))
    .autoWidthRatio(0);
    [self.offerDataLable setSingleLineAutoResizeWithMaxWidth:(kDeviceWidth - kWidthScale(123))/2];
    
    
    self.offerMoneyLable.sd_layout
    .leftEqualToView(self.titleLable)
    .topSpaceToView(self.publishDataLable, 14)
    .heightIs(kHeightScale(12))
    .autoWidthRatio(0);
    [self.offerMoneyLable setSingleLineAutoResizeWithMaxWidth:kWidthScale(200)];
    
    self.clickButton.sd_layout
    .topSpaceToView(self.offerDataLable, 7)
    .rightSpaceToView(self.contentView, kWidthScale(16))
    .widthIs(kWidthScale(66))
    .heightIs(kHeightScale(24));
// self.lineView.sd_layout
//    .leftEqualToView(self.contentView)
//    .topSpaceToView(self.clickButton, kHeightScale(11))
//    .widthIs(kDeviceWidth)
//    .heightIs(1);
    self.lineView.sd_layout
    .leftEqualToView(self.contentView)
    .bottomSpaceToView(self.contentView, kHeightScale(-1))
    .widthIs(kDeviceWidth)
    .heightIs(1);
    NSMutableArray * array = [NSMutableArray new];
    [array addObject:self.clickButton];
    [array addObject:self.statuteLable];
//    [self setupAutoHeightWithBottomView:self.clickButton bottomMargin:6];
    [self setupAutoHeightWithBottomViewsArray:array bottomMargin:6];
}

- (void)setModel:(GHOrderListListModel *)model{
    _model = model;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.surfacePlot]];
    NSString * addressString = [NSString stringWithFormat:@"%@%@%@%@", model.province, model.city, model.area, model.exhibitionSite];
    _titleLable.text = model.name;
    _adressLable.text = addressString;
    if (model.childState == 0) {
        _statuteLable.text = @"申请待通过 ";
    }else if (model.childState == 1){
        _statuteLable.text = @"申请已通过";
    }else if (model.childState == 2){
        _statuteLable.text = @"申请未通过 ";
    }else if (model.childState == 3){
        _statuteLable.text = @"撤单待审核 ";
    }else if (model.childState == 4){
         _statuteLable.text = @"撤单已完成  ";
    }else if (model.childState == 5){
        _statuteLable.text = @"申请施工图 ";
    }else if (model.childState == 6){
         _statuteLable.text = @"申请施工图已处理  ";
    }else if (model.childState == 7){
        _statuteLable.text = @"进度待处理 ";
    }else if (model.childState == 8){
         _statuteLable.text = @"进度已处理 ";
    }else if (model.childState == 9){
        _statuteLable.text = @"待评价 ";
    }else if (model.childState == 10){
         _statuteLable.text = @"已评价 ";
    }else if (model.childState == 11){
        _statuteLable.text = @"评价待查看";
    }else if (model.childState ==12){
          _statuteLable.text = @"评价已查看";
    }
    _offerMoneyLable.text = [NSString stringWithFormat:@"报价:%.2f元", model.quote];
    _publishDataLable.text = [NSString stringWithFormat:@"发布时间:%@", [JGCommonTools timeWithTimeIntervalString:model.pushTime dateFormatter:@"yyyy/MM/dd"]];
    _offerDataLable.text = [NSString stringWithFormat:@"报价时间:%@", [JGCommonTools timeWithTimeIntervalString:model.quoteTime dateFormatter:@"yyyy/MM/dd"]];
    
    if (model.parentState == 3 || model.parentState == 4) {
        [_clickButton setTitle:@"删除订单" forState:UIControlStateNormal];
         _clickButton.hidden = NO;
    }else{
    if (model.childState == 0) {
        [_clickButton setTitle:@"我要撤单" forState:UIControlStateNormal];
    }else if (model.childState == 3){
        [_clickButton setTitle:@"撤单中" forState:UIControlStateNormal];
        [_clickButton setTitleColor:JGHexColor(@"#838D94") forState:UIControlStateNormal];
        _clickButton.layer.borderColor = JGHexColor(@"#CECECE").CGColor;
        _clickButton.layer.borderWidth = 1;
        _clickButton.enabled = NO;
         _clickButton.hidden = NO;
    }else{
        _clickButton.hidden = YES;
    }
    }
}

- (UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [UIImageView new];
//        _headerImageView.backgroundColor=[UIColor redColor];
        _headerImageView.sd_cornerRadius = @(kWidthScale(5));
        _headerImageView.clipsToBounds = YES;
    }
    return _headerImageView;
}

- (UILabel *)statuteLable{
    if (!_statuteLable) {
        _statuteLable = [UILabel new];
        _statuteLable.text = @"未通过";
        _statuteLable.textColor = JGHexColor(@"#4c4c4c");
        _statuteLable.textAlignment = NSTextAlignmentCenter;
        _statuteLable.font = [UIFont systemFontOfSize:kWidthScale(12)];
    }
    return _statuteLable;
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.text = @"2019第二届中国VR大会暨展览会上海 展馆";
        _titleLable.textColor = JGHexColor(@"#3A4044");
        _titleLable.font =  JGBoldFont(kWidthScale(15));
    }
    return _titleLable;
}

- (UILabel *)adressLable{
    if (!_adressLable) {
        _adressLable = [UILabel new];
        _adressLable.text = @"浙江省杭州市江干区佰富时代中心1幢905";
        _adressLable.font = [UIFont systemFontOfSize:kWidthScale(12)];
        _adressLable.textColor = JGHexColor(@"#666666");
    }
    return _adressLable;
}

- (UILabel *)publishDataLable{
    if (!_publishDataLable) {
        _publishDataLable = [UILabel new];
        _publishDataLable.text = @"发布时间：";
        _publishDataLable.textColor = JGHexColor(@"#808080");
        _publishDataLable.font = [UIFont systemFontOfSize:kWidthScale(11)];
    }
    return _publishDataLable;
}

- (UILabel *)offerDataLable{
    if (!_offerDataLable) {
        _offerDataLable = [UILabel new];
        _offerDataLable.text = @"报价时间：2019/09/10";
        _offerDataLable.textColor = JGHexColor(@"#808080");
        _offerDataLable.font = JGFont(kWidthScale(11));
    }
    return _offerDataLable;
}

- (UILabel *)offerMoneyLable{
    if (!_offerMoneyLable) {
        _offerMoneyLable = [UILabel new];
        _offerMoneyLable.text = @"报价: 6800.00元";
        _offerMoneyLable.textColor = JGHexColor(@"#FB6D35");
        _offerMoneyLable.font = JGFont(kWidthScale(12));
    }
    return _offerMoneyLable;
}

- (UIButton *)clickButton{
    if (!_clickButton) {
        _clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clickButton setTitle:@"我要撤单" forState:UIControlStateNormal];
        _clickButton.titleLabel.font = JGFont(kWidthScale(12));
        [_clickButton setTitleColor:JGHexColor(@"#FE8D33") forState:UIControlStateNormal];
        _clickButton.layer.borderColor = JGHexColor(@"#FE8D33").CGColor;
        _clickButton.layer.borderWidth = 1.0f;
        _clickButton.sd_cornerRadius = @(kWidthScale(3));
    }
    return _clickButton;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = JGHexColor(@"#E5E5E5");
    }
    return _lineView;
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
