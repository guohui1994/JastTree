//
//  JTUserInfoTCell.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/4.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTUserInfoTCell.h"

@interface JTUserInfoTCell()



@end


@implementation JTUserInfoTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _TitleLbl = [UILabel new];
    _TitleLbl.textColor = JG333Color;
    _TitleLbl.font = JGFont(14);
    _TitleLbl.text = @"昵称";
    
    _InfoLbl = [UILabel new];
    _InfoLbl.textColor = JG666Color;
    _InfoLbl.font = JGFont(14);
    _InfoLbl.text = @"杰里冬谷的旅行日记";
    
    _ArrowIcon = [UIImageView new];
    _ArrowIcon.image = JGImage(@"navigator_btn_back");
    
    UIView *Line = [UIView new];
    Line.backgroundColor = JGHexColor(@"#E5E5E5");
    
    
    [self addSubview:_TitleLbl];
    [self addSubview:_InfoLbl];
    [self addSubview:_ArrowIcon];
    [self addSubview:Line];

    [_TitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).mas_offset(-12);
        make.left.equalTo(self.mas_left).mas_offset(15);
    }];
    
    [_InfoLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_TitleLbl.mas_centerY);
        make.right.equalTo(_ArrowIcon.mas_left);
    }];
    
    [_ArrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).mas_offset(-15);
        make.centerY.equalTo(_TitleLbl.mas_centerY);
    }];
    
    [Line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_TitleLbl.mas_left);
        make.right.equalTo(_ArrowIcon.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@(1));
    }];
    
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
