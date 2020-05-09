//
//  JTMessageTCell.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/4.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTMessageTCell.h"


@interface JTMessageTCell()
//整体视图
@property (nonatomic, strong) UIView *TotalView;
//小红点
@property (nonatomic, strong) UIImageView *DotIcon;
//标题
@property (nonatomic, strong) UILabel *TitleLbl;
//时间
@property (nonatomic, strong) UILabel *TimeLbl;


@end


@implementation JTMessageTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)configUI {
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    _TotalView = [UIView new];
    _TotalView.clipsToBounds = YES;
    _TotalView.layer.cornerRadius = 5;
    _TotalView.backgroundColor = [UIColor whiteColor];
    
    
    
    _DotIcon = [UIImageView new];
    _DotIcon.backgroundColor = [UIColor redColor];
    _DotIcon.clipsToBounds = YES;
    _DotIcon.layer.cornerRadius = 2.5;
    
    
    _TitleLbl = [UILabel new];
    _TitleLbl.textColor = JG333Color;
    _TitleLbl.font = JGFont(14);
    _TitleLbl.text = @"您有一张50元优惠券待使用！";
    
    _TimeLbl = [UILabel new];
    _TimeLbl.textColor = JGHexColor(@"#888888");
    _TimeLbl.font = JGFont(11);
    _TimeLbl.text = @"2018/9/10 14:00";
    
    [self.contentView addSubview:_TotalView];
    [_TotalView addSubview:_DotIcon];
    [_TotalView addSubview:_TitleLbl];
    [_TotalView addSubview:_TimeLbl];

    [_TotalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).mas_offset(15);
        make.right.equalTo(self.mas_right).mas_offset(-15);
        make.height.equalTo(@(45));
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [_DotIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_TotalView.mas_centerY);
        make.left.equalTo(_TotalView.mas_left).mas_offset(7);
        make.width.height.equalTo(@(5));
    }];
    
    [_TitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_DotIcon.mas_right).mas_offset(5);
        make.centerY.equalTo(_TotalView.mas_centerY);
    }];
    
    [_TimeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_TotalView.mas_right).mas_offset(-7);
        make.centerY.equalTo(_TotalView.mas_centerY);
    }];
}




- (void)setModel:(JTMessageListListModel *)Model {
    _Model = Model;
    
    
    _TitleLbl.text = Model.title;
    
    _TimeLbl.text = [JGCommonTools timeWithTimeIntervalString:Model.createTime dateFormatter:@"yyyy/MM/dd HH:mm"];
        
    
    if (Model.read) {
        
        [_DotIcon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_TotalView.mas_left).mas_offset(2);
            make.width.equalTo(@(0));
        }];
    }else {
        
        [_DotIcon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_TotalView.mas_left).mas_offset(7);
            make.width.equalTo(@(5));
        }];
    }
    
    
    
    
    
    
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
