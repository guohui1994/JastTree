//
//  GH_ApprenseJTTableViewCell.m
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/7/4.
//  Copyright © 2019 JG. All rights reserved.
//

#import "GH_ApprenseJTTableViewCell.h"

@interface GH_ApprenseJTTableViewCell ()<UITextViewDelegate>
@property (nonatomic, strong)UILabel * titleLable;
@property (nonatomic, strong)UILabel * lineView;
@property (nonatomic, strong)UILabel * shortLineView;

@property (nonatomic, strong)UILabel * apprienceLable;
@property (nonatomic, strong)UILabel * apprienceContentLable;
@property (nonatomic, strong)UILabel * myApprienceLable;
@property (nonatomic, strong)UITextView * textView;
@end

@implementation GH_ApprenseJTTableViewCell

- (void)configUI{
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.shortLineView];
    [self.contentView addSubview:self.apprienceLable];
    [self.contentView addSubview:self.apprienceContentLable];
    [self.contentView addSubview:self.myApprienceLable];
    [self.contentView addSubview:self.textView];
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
    
    self.apprienceLable.sd_layout
    .leftSpaceToView(self.contentView, kWidthScale(26))
    .topSpaceToView(self.lineView, kWidthScale(22))
    .widthIs(kWidthScale(70))
    .heightIs(kHeightScale(13));
    
    self.apprienceContentLable.sd_layout
    .leftEqualToView(self.apprienceLable)
    .topSpaceToView(self.apprienceLable, kHeightScale(11))
    .widthIs(kDeviceWidth - kWidthScale(52))
    .autoHeightRatio(0);
    
    self.myApprienceLable.sd_layout
    .leftEqualToView(self.apprienceLable)
    .topSpaceToView(self.apprienceContentLable, kHeightScale(34))
    .widthIs(kWidthScale(80))
    .heightIs(kHeightScale(13));
    
    self.textView.sd_layout
    .leftSpaceToView(self.contentView, kWidthScale(32))
    .topSpaceToView(self.myApprienceLable, kHeightScale(11))
    .widthIs(kWidthScale(311))
    .heightIs(kHeightScale(48));
    
    [self setupAutoHeightWithBottomView:self.textView bottomMargin:10];
}

- (void)setUserEvaluation:(NSString *)userEvaluation{
    _userEvaluation = userEvaluation;
    _apprienceContentLable.text = userEvaluation;
}

- (void)setIsShowTextView:(BOOL)isShowTextView{
    _isShowTextView = isShowTextView;
    if (isShowTextView) {
        _myApprienceLable.hidden = NO;
        _textView.hidden = NO;
        [self setupAutoHeightWithBottomView:_textView bottomMargin:10];
    }else{
        _myApprienceLable.hidden = YES;
        _textView.hidden = YES;
        [self setupAutoHeightWithBottomView:_apprienceContentLable bottomMargin:10];
    }
}

- (void)setIsEdit:(BOOL)isEdit{
    _isEdit = isEdit;
    if (isEdit) {
        _textView.editable = YES;
    }else{
        _textView.editable = NO;
    }
}

- (void)setReplyString:(NSString *)replyString{
    _replyString = replyString;
    _textView.text = replyString;
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.text = @"评价内容";
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
- (UILabel *)apprienceLable{
    if (!_apprienceLable) {
        _apprienceLable = [UILabel new];
        _apprienceLable.text = @"评价内容:";
        _apprienceLable.font = JGFont(kWidthScale(14));
        _apprienceLable.textColor = JGHexColor(@"#A1A0A0");
    }
    return _apprienceLable;
}

- (UILabel *)apprienceContentLable{
    if (!_apprienceContentLable) {
        _apprienceContentLable = [UILabel new];
        _apprienceContentLable.text = @"内容详细内容详细内容详细内容详细内容详细内容详细内 容详细内容详细内容详细内容详细";
        _apprienceContentLable.font = JGFont(kWidthScale(13));
        _apprienceContentLable.textColor = JGHexColor(@"#4C4C4C");
    }
    return _apprienceContentLable;
}

- (UILabel *)myApprienceLable{
    if (!_myApprienceLable) {
        _myApprienceLable = [UILabel new];
        _myApprienceLable.text = @"我的回复:";
        _myApprienceLable.textColor = JGHexColor(@"#A1A0A0");
        _myApprienceLable.font = JGFont(kWidthScale(14));
    }
    return _myApprienceLable;
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [UITextView new];
        _textView.layer.borderWidth =1.0;
        _textView.delegate =self;
        _textView.sd_cornerRadius = @(kWidthScale(3));
        _textView.layer.borderColor = JGHexColor(@"#CBCACA").CGColor;
    }
    return _textView;
}

- (void)textViewDidChange:(UITextView *)textView{
    if (self.black) {
        self.black(textView.text);
    }
}

@end
