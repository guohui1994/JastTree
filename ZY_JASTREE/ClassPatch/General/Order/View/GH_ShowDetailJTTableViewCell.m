
//
//  GH_ShowDetailJTTableViewCell.m
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "GH_ShowDetailJTTableViewCell.h"

@interface GH_ShowDetailJTTableViewCell ()<UITextFieldDelegate>
@property (nonatomic, strong)UILabel * titleLable;
@property (nonatomic, strong)UILabel * lineView;
@property (nonatomic, strong)UILabel * shortLineView;
@property (nonatomic, strong)UIView * backgroundCollectionView;

@property (nonatomic, strong)UILabel * quoteLable;//报价lable

@property (nonatomic, strong)UILabel * timeLable;

@property (nonatomic, strong)UILabel * myQuoteLable;
@property (nonatomic, strong)UITextField * quoteTextfield;//报价输入框

@end


@implementation GH_ShowDetailJTTableViewCell
- (void)configUI{
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.shortLineView];
    [self.contentView addSubview:self.backgroundCollectionView];
    [self.contentView addSubview:self.quoteLable];
    [self.contentView addSubview:self.timeLable];
    [self.contentView addSubview:self.selectTimeButton];
    [self.contentView addSubview:self.quoteTextfield];
    [self.contentView addSubview:self.myQuoteLable];
    [self layout];
}

- (void)layout{
    self.titleLable.sd_layout
    .leftEqualToView(self.contentView)
    .topSpaceToView(self.contentView, kHeightScale(17))
    .widthIs(kDeviceWidth)
    .heightIs(kHeightScale(16));
    
    self.shortLineView.sd_layout
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.titleLable, kHeightScale(19))
    .widthIs(kWidthScale(21))
    .heightIs(kHeightScale(3));
    
    self.lineView.sd_layout
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.titleLable, kHeightScale(22.5))
    .widthIs(kWidthScale(330))
    .heightIs(1);
    
    self.backgroundCollectionView.sd_layout
    .leftSpaceToView(self.contentView, 5)
    .topSpaceToView(self.shortLineView, 10)
    .rightSpaceToView(self.contentView, 5);
    
    self.quoteLable.sd_layout
    .leftSpaceToView(self.contentView, kWidthScale(44))
    .topSpaceToView(self.backgroundCollectionView, kHeightScale(31))
    .widthIs(kDeviceWidth - 100)
    .autoHeightRatio(0);
    
    self.timeLable.sd_layout
    .leftSpaceToView(self.contentView, kWidthScale(44))
    .topSpaceToView(self.backgroundCollectionView, kHeightScale(30))
    .widthIs(kWidthScale(95))
    .heightIs(kHeightScale(13));
    
    self.selectTimeButton.sd_layout
    .leftSpaceToView(self.timeLable, kWidthScale(23))
    .topSpaceToView(self.backgroundCollectionView, kHeightScale(21))
    .autoWidthRatio(0)
    .heightIs(kHeightScale(30));
    [self.selectTimeButton setupAutoSizeWithHorizontalPadding:10 buttonHeight:kHeightScale(30)];
    
    self.myQuoteLable.sd_layout
    .leftSpaceToView(self.contentView, kWidthScale(44))
    .topSpaceToView(self.backgroundCollectionView, kHeightScale(30))
    .widthIs(kWidthScale(69))
    .heightIs(kHeightScale(13));
    
    self.quoteTextfield.sd_layout
    .leftSpaceToView(self.myQuoteLable, kWidthScale(7))
    .topSpaceToView(self.backgroundCollectionView, kHeightScale(21))
    .widthIs(kWidthScale(223))
    .heightIs(kHeightScale(30));
}

- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _titleLable.text = titleString;
}

- (void)setIsShowQuteLable:(BOOL)isShowQuteLable{
    _isShowQuteLable = isShowQuteLable;
    if (isShowQuteLable == YES) {
        [self setupAutoHeightWithBottomView:self.quoteLable bottomMargin:10];
        self.quoteLable.hidden = NO;
    }else{
        [self setupAutoHeightWithBottomView:self.backgroundCollectionView bottomMargin:10];
        self.quoteLable.hidden = YES;
    }
}

//- (void)setModelCount:(int)modelCount{
//    _modelCount = modelCount;
//    NSMutableArray * temp = [NSMutableArray new];
//    for (int i = 0; i < modelCount; i++) {
//        UIImageView * image = [[UIImageView alloc]init];
//        image.backgroundColor = [UIColor blueColor];
//        [self.backgroundCollectionView addSubview:image];
//        image.sd_cornerRadius = @(kWidthScale(12));
//        image.sd_layout
//        .autoHeightRatio(1);
//        [image sd_setImageWithURL:[NSURL URLWithString:@"http://pic37.nipic.com/20140113/8800276_184927469000_2.png"]];
//        [temp addObject:image];
//    }
//
//    [self.backgroundCollectionView setupAutoMarginFlowItems:temp withPerRowItemsCount:3 itemWidth:kWidthScale(110) verticalMargin:8 verticalEdgeInset:8 horizontalEdgeInset:8];
//    [self updateLayout];
//}

- (void)setPhotoArray:(NSArray *)photoArray{
    _photoArray = photoArray;
    NSMutableArray * temp = [NSMutableArray new];
    for (int i = 0; i < photoArray.count; i++) {
        UIImageView * image = [[UIImageView alloc]init];
        image.userInteractionEnabled = YES;
//        image.backgroundColor = [UIColor blueColor];
        [self.backgroundCollectionView addSubview:image];
        image.sd_cornerRadius = @(kWidthScale(12));
        image.sd_layout
        .autoHeightRatio(1);
        image.tag = 100000+ i;
        [image sd_setImageWithURL:[NSURL URLWithString:photoArray[i]]];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [image addGestureRecognizer:tap];
        [temp addObject:image];
    }
    [self.backgroundCollectionView setupAutoMarginFlowItems:temp withPerRowItemsCount:3 itemWidth:kWidthScale(110) verticalMargin:8 verticalEdgeInset:8 horizontalEdgeInset:8];
    [self updateLayout];
}

- (void)setQuteMoney:(NSString *)quteMoney{
    _quteMoney = quteMoney;
    _quoteLable.text = [NSString stringWithFormat:@"我的报价:%@元", quteMoney];
}

- (void)setIsShowTimeButton:(BOOL)isShowTimeButton{
    _isShowTimeButton = isShowTimeButton;
    if (isShowTimeButton) {
        _timeLable.hidden = NO;
        _selectTimeButton.hidden = NO;
         [self setupAutoHeightWithBottomView:self.selectTimeButton bottomMargin:10];
    }else{
        if (self.isShowQuteLable) {
            [self setupAutoHeightWithBottomView:self.quoteLable bottomMargin:10];
        }else{
            [self setupAutoHeightWithBottomView:self.backgroundCollectionView bottomMargin:10];
        }
    }
}
- (void)setTimeString:(NSString *)timeString{
    _timeString = timeString;
    [_selectTimeButton setTitle:timeString forState:UIControlStateNormal];
}

- (void)setIsShowTextField:(BOOL)isShowTextField{
    _isShowTextField = isShowTextField;
    if (isShowTextField) {
        _myQuoteLable.hidden = NO;
        _quoteTextfield.hidden = NO;
         [self setupAutoHeightWithBottomView:self.quoteTextfield bottomMargin:10];
    }else{
        if (self.isShowQuteLable) {
            [self setupAutoHeightWithBottomView:self.quoteLable bottomMargin:10];
        }else if (self.isShowTimeButton){
             [self setupAutoHeightWithBottomView:self.selectTimeButton bottomMargin:10];
        }else{
             [self setupAutoHeightWithBottomView:self.backgroundCollectionView bottomMargin:10];
        }
    }
}

- (void)tap:(UITapGestureRecognizer *)gesture{
    int index =(int) gesture.view.tag - 100000;
    
    if (self.blocks) {
         self.blocks(index, _photoArray);
    }
}


- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.text = @"效果图";
        _titleLable.textColor = JGHexColor(@"#3A4044");
        _titleLable.font = JGFont(kWidthScale(16));
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}

- (UILabel *)shortLineView{
    if (!_shortLineView) {
        _shortLineView = [UILabel new];
        _shortLineView.sd_cornerRadius = @(2);
        _shortLineView.backgroundColor = JGHexColor(@"#FE8D33");
    }
    return _shortLineView;
}

-(UILabel *)lineView{
    if (!_lineView) {
        _lineView = [UILabel new];
        _lineView.sd_cornerRadius = @(2);
        _lineView.backgroundColor = JGHexColor(@"#FFB478");
    }
    return _lineView;
}

- (UIView *)backgroundCollectionView{
    if (!_backgroundCollectionView) {
        _backgroundCollectionView = [UIView new];
    }
    return _backgroundCollectionView;
}

- (UILabel *)quoteLable{
    if (!_quoteLable) {
        _quoteLable = [UILabel new];
        _quoteLable.text = @"我的报价: 80000.000元";
        _quoteLable.font = JGFont(kWidthScale(14));
        _quoteLable.textColor = JGHexColor(@"#3A4044");
        _quoteLable.hidden = YES;
    }
    return _quoteLable;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UILabel *)timeLable{
    if (!_timeLable) {
        _timeLable = [UILabel new];
        _timeLable.text = @"最晚完成时间:";
        _timeLable.font = JGFont(kWidthScale(14));
        _timeLable.textColor = JGHexColor(@"#3A4044");
        _timeLable.hidden = YES;
    }
    return _timeLable;
}

- (UIButton *)selectTimeButton{
    if (!_selectTimeButton) {
        _selectTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectTimeButton.layer.borderColor = JGHexColor(@"#CBCACA").CGColor;
        _selectTimeButton.layer.borderWidth = 1;
        [_selectTimeButton setTitle:@"选择时间" forState:UIControlStateNormal];
        _selectTimeButton.hidden = YES;
        _selectTimeButton.titleLabel.font = JGFont(kWidthScale(14));
        _selectTimeButton.sd_cornerRadius =@(3);
        [_selectTimeButton setTitleColor:JGHexColor(@"#999999") forState:UIControlStateNormal];
    }
    return _selectTimeButton;
}

- (UILabel *)myQuoteLable{
    if (!_myQuoteLable) {
        _myQuoteLable = [UILabel new];
        _myQuoteLable.text = @"我的报价:";
        _myQuoteLable.font = JGFont(kWidthScale(14));
        _myQuoteLable.textColor = JGHexColor(@"#3A4044");
        _myQuoteLable.hidden = YES;
    }
    return _myQuoteLable;
}

- (UITextField *)quoteTextfield{
    if (!_quoteTextfield) {
        _quoteTextfield = [UITextField new];
        _quoteTextfield.layer.borderColor = JGHexColor(@"#CBCACA").CGColor;
        _quoteTextfield.layer.borderWidth = 0.5;
        _quoteTextfield.placeholder = @"请输入您的报价金额";
        _quoteTextfield.sd_cornerRadius = @(3);
        _quoteTextfield.hidden = YES;
        _quoteTextfield.delegate = self;
        
    }
    return _quoteTextfield;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"%@", textField);
    if (self.qouteMoneyBlock) {
        self.qouteMoneyBlock(textField.text);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
