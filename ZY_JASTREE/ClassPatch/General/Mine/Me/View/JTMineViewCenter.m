//
//  JTMineViewCenter.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/4.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTMineViewCenter.h"


@interface JTMineViewCenterCell : UITableViewCell

@property (nonatomic, strong) UIImageView *Icon;

@property (nonatomic, strong) UILabel *TitleLbl;

@property (nonatomic, strong) UIImageView *ArrowIcon;

@end



@implementation JTMineViewCenterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _Icon = [UIImageView new];
        
        _TitleLbl = [UILabel new];
        _TitleLbl.textColor = JGHexColor(@"#4D4D4D");
        _TitleLbl.font = JGFont(16);
        
        _ArrowIcon = [UIImageView new];
        _ArrowIcon.image = JGImage(@"Mine_Arrow");
        
        UIView *Line = [UIView new];
        Line.backgroundColor = JGHexColor(@"#E5E5E5");
        
        
        [self.contentView addSubview:_Icon];
        [self.contentView addSubview:_TitleLbl];
        [self.contentView addSubview:_ArrowIcon];
        [self.contentView addSubview:Line];

        
        [_Icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).mas_offset(-3);
            make.left.equalTo(self.mas_left).mas_offset(25);
            make.width.height.equalTo(@(30));
        }];
        
        [_TitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_Icon.mas_centerY);
            make.left.equalTo(_Icon.mas_right).mas_offset(14);
        }];
        
        [_ArrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).mas_offset(-20);
            make.centerY.equalTo(_Icon.mas_centerY);
            make.width.equalTo(@(7));
            make.height.equalTo(@(13));
        }];
        
        [Line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(_TitleLbl.mas_left);
            make.right.equalTo(_ArrowIcon.mas_right);
            make.height.equalTo(@(1));
        }];
        
    }
    return self;
}




@end



@interface JTMineViewCenter() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *TitleLbl;
@property (nonatomic, strong) UITableView *tableView;

@end


NSString * const JTMineViewCenterCellId = @"JTMineViewCenterCellId";


@implementation JTMineViewCenter


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        _tableView.layer.cornerRadius = 14.0f;
        _tableView.clipsToBounds = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[JTMineViewCenterCell class] forCellReuseIdentifier:JTMineViewCenterCellId];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}



- (void)configUI {
    
//    self.clipsToBounds = YES;
    self.layer.cornerRadius = 14.0f;
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.shadowColor = [UIColor colorWithRed:179/255.0 green:170/255.0 blue:166/255.0 alpha:0.26].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,2);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 16;
    self.layer.cornerRadius = 14;

    
    _TitleLbl = [UILabel new];
    _TitleLbl.textColor = JG333Color;
    _TitleLbl.font = JGFont(16);
    _TitleLbl.text = @"我的";
    
    
    [self addSubview:_TitleLbl];
    [self addSubview:self.tableView];

    [_TitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).mas_offset(25);
        make.top.equalTo(self.mas_top).mas_offset(23);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.mas_top).mas_offset(45);
    }];
    
    
}



#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JTMineViewCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:JTMineViewCenterCellId forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.Icon.image = JGImage(@"Mine_ChangePwd");
        cell.TitleLbl.text = @"更改密码";
    }else if (indexPath.row == 1) {
        cell.Icon.image = JGImage(@"Mine_AboutOur");
        cell.TitleLbl.text = @"关于我们";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.backInfo) {
        self.backInfo(indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
