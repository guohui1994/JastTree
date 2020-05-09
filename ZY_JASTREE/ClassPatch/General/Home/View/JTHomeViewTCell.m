//
//  JTHomeViewTCell.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/2.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTHomeViewTCell.h"

@interface JTHomeViewTCell()
//图像
@property(nonatomic, strong) UIImageView *Icon;
//标题
@property(nonatomic, strong) UILabel *TitleLbl;
//时间
@property(nonatomic, strong) UILabel *TimeLbl;
//发布
@property(nonatomic, strong) UILabel *PublishLbl;
//展馆地址
@property(nonatomic, strong) UILabel *NOLbl;
//其它要求
@property(nonatomic, strong) UILabel *OtherLbl;
//发布时间标签
@property(nonatomic, strong) UILabel *PTimeL;
//发布时间
@property(nonatomic, strong) UILabel *PTimeLbl;
//面积
@property (nonatomic, strong)UILabel * areaLable;
@end


@implementation JTHomeViewTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _Icon = [UIImageView new];
    
    _TitleLbl = [UILabel new];
    _TitleLbl.font = JGBoldFont(kWidthScale(12));
    _TitleLbl.textColor = JGHexColor(@"#061B28");
    _TitleLbl.numberOfLines = 0;
//    _TitleLbl.text = @"2019国家会展中心";
    
    UIImageView *timeIcon = [UIImageView new];
    timeIcon.image = JGImage(@"Home_time");

    _TimeLbl = [UILabel new];
    _TimeLbl.font = JGFont(kWidthScale(13));
    _TimeLbl.textColor = JGHexColor(@"#FF4400");
//    _TimeLbl.text = @"2019/09/20 - 10/26";
    
    
    _PublishLbl = [UILabel new];
    _PublishLbl.font = JGFont(kWidthScale(14));
    _PublishLbl.textColor = JGHexColor(@"#061B28");
//    _PublishLbl.text = @"发布：上海雅树展览有限公司";
    
    _NOLbl = [UILabel new];
    _NOLbl.font = JGFont(kWidthScale(12));
    _NOLbl.textColor = JG666Color;

    _areaLable = [UILabel new];
    _areaLable.font = JGFont(kWidthScale(12));
    _areaLable.textColor = JG666Color;
    
    
    
    _OtherLbl = [UILabel new];
    _OtherLbl.font = JGFont(kWidthScale(12));
    _OtherLbl.textColor = JG999Color;
//    _OtherLbl.text = @"其他要求：不知道";
    
    _PTimeL = [UILabel new];
    _PTimeL.font = JGFont(kWidthScale(12));
    _PTimeL.textColor = JG999Color;
    _PTimeL.text = @"发布时间:";
    
    _PTimeLbl = [UILabel new];
    _PTimeLbl.font = JGFont(kWidthScale(12));
    _PTimeLbl.textColor = JG999Color;
//    _PTimeLbl.text = @"2019/09/10 14:00";
    
    
    
    
    
    [self.contentView addSubview:_Icon];
    [self.contentView addSubview:_TitleLbl];
    [self.contentView addSubview:timeIcon];
    [self.contentView addSubview:_TimeLbl];
//    [self.contentView addSubview:_PublishLbl];
    [self.contentView addSubview:_NOLbl];
    [self.contentView addSubview:_areaLable];
//    [self.contentView addSubview:_OtherLbl];
    [self.contentView addSubview:_PTimeL];
    [self.contentView addSubview:_PTimeLbl];

    
    
    
    

    _Icon.sd_layout
    .topSpaceToView(self.contentView, kHeightScale(6))
    .leftSpaceToView(self.contentView, kWidthScale(12))
    .widthIs(kWidthScale(91))
    .heightIs(kHeightScale(84));
    
    

    
    _TitleLbl.sd_layout
    .topEqualToView(_Icon)
    .leftSpaceToView(_Icon, kWidthScale(13))
    .rightSpaceToView(self.contentView, kWidthScale(10))
    .autoHeightRatio(0);
    
    
    

    
    timeIcon.sd_layout
    .topSpaceToView(_TitleLbl, kHeightScale(10))
    .leftEqualToView(_TitleLbl)
    .widthIs(kHeightScale(14))
    .heightIs(kHeightScale(13));
    
    

    
    _TimeLbl.sd_layout
    .leftSpaceToView(timeIcon, kWidthScale(6))
    .topEqualToView(timeIcon)
    .rightSpaceToView(self.contentView, kWidthScale(1))
    .heightIs(kHeightScale(12));
    
    



    
    _NOLbl.sd_layout
    .leftEqualToView(_TitleLbl)
    .topSpaceToView(timeIcon, kHeightScale(10))
    .autoWidthRatio(0)
    .heightIs(kHeightScale(14));
    [_NOLbl setSingleLineAutoResizeWithMaxWidth:kWidthScale(160)];
    

    _areaLable.sd_layout
    .leftSpaceToView(_NOLbl, kWidthScale(10))
    .topEqualToView(_NOLbl)
    .heightIs(kHeightScale(14))
    .autoWidthRatio(0);
    [_areaLable setSingleLineAutoResizeWithMaxWidth:kWidthScale(100)];


    
    _PTimeL.sd_layout
    .leftEqualToView(_TitleLbl)
    .topSpaceToView(_NOLbl, kHeightScale(10))
    .widthIs(kWidthScale(53))
    .heightIs(kHeightScale(12));
    

    
    _PTimeLbl.sd_layout
   .topEqualToView(_PTimeL)
    .leftSpaceToView(_PTimeL, kWidthScale(10))
    .rightSpaceToView(self.contentView, kWidthScale(10))
    .heightIs(kHeightScale(12));

    _Icon.sd_cornerRadius = @(5);
    
    NSMutableArray * temp = [[NSMutableArray alloc]init];
    [temp addObject:_Icon];
    [temp addObject:_PTimeL];
    
//    [self setupAutoHeightWithBottomView:_PTimeL bottomMargin:kHeightScale(5)];
    [self setupAutoHeightWithBottomViewsArray:temp bottomMargin:kHeightScale(7)];
}


- (void)setModel:(JTExhibitionSelectListList1Model *)Model {
    _Model = Model;
    
    
    [_Icon sd_setImageWithURL:[NSURL URLWithString:Model.surfacePlot] placeholderImage:JGWhiteImage];
    _Icon.sd_cornerRadius = @(kWidthScale(5));
    _TitleLbl.text = Model.name;
    NSString *beginTime = [JGCommonTools timeWithTimeIntervalString:Model.moveInTime dateFormatter:@"yyyy/MM/dd"];
    NSString *endTime = [JGCommonTools timeWithTimeIntervalString:Model.scatteredShowTime dateFormatter:@"yyyy/MM/dd"];
    _TimeLbl.text = [NSString stringWithFormat:@"%@ - %@", beginTime, endTime];
    
    _PublishLbl.text = [NSString stringWithFormat:@"发布：%@", Model.companyName];

    //@"项目编号：SE2775   展位面积: 888㎡";
    _NOLbl.text = [NSString stringWithFormat:@"展馆地址: %@%@%@%@",Model.province,Model.city,Model.area,Model.exhibitionSite];

    _areaLable.text = [NSString stringWithFormat:@"面积: %ld㎡", Model.exhibitionArea];
    _OtherLbl.text = [NSString stringWithFormat:@"其他要求：%@", Model.otherRequirements];

    
    _PTimeLbl.text =  [JGCommonTools timeWithTimeIntervalString:Model.createTime dateFormatter:@"yyyy/MM/dd HH:mm"];
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
