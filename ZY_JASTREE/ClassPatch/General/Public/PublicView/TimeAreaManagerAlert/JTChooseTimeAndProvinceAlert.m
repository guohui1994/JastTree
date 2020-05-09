//
//  JTChooseTimeAndProvinceAlert.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/8.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTChooseTimeAndProvinceAlert.h"


@interface ZYDropDownBoxAlertCell : UITableViewCell

@property (nonatomic, strong) UILabel *LeftLbl;
@property (nonatomic, strong) UILabel *RightLbl;

@property (nonatomic, strong) UIView *Line;

@end

@implementation ZYDropDownBoxAlertCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        _LeftLbl = [UILabel new];
        _LeftLbl.textAlignment = NSTextAlignmentCenter;
        _LeftLbl.textColor = JG333Color;
        _LeftLbl.font = JGFont(15);
        
        
        _RightLbl = [UILabel new];
        _RightLbl.textColor = JG333Color;
        _RightLbl.font = JGFont(15);
        _RightLbl.textAlignment = NSTextAlignmentCenter;

        
        
        _Line = [UIView new];
        _Line.backgroundColor = JGHexColor(@"#DAD9D9");
        
        [self.contentView addSubview:_LeftLbl];
        [self.contentView addSubview:_RightLbl];
        [self.contentView addSubview:_Line];
        
        CGFloat W = (kDeviceWidth - 30) / 2.0;

        
        [_LeftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).mas_offset(15);
            make.width.equalTo(@(W));
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [_RightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).mas_offset(-15);
            make.width.equalTo(@(W));
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [_Line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).mas_offset(15);
            make.right.equalTo(self.mas_right).mas_offset(-15);
            make.bottom.equalTo(self.mas_bottom);
            make.height.equalTo(@(1));
        }];
    }
    return self;
}
@end


@interface JTChooseTimeAndProvinceAlert () <UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate>

/** 弹窗 */
@property(nonatomic,strong) UIView *alertView;
@property(nonatomic,strong) UIView *bg;

/** 内容 */
@property (nonatomic, strong)UITableView *tableView;

//@property (nonatomic, strong)NSArray *DataArrM;
@property (nonatomic, assign)CGFloat CellHeight;

@end

static NSString * const ZYDropDownBoxAlertCellId = @"ZYDropDownBoxAlertCellId";



@implementation JTChooseTimeAndProvinceAlert



- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ZYDropDownBoxAlertCell class] forCellReuseIdentifier:ZYDropDownBoxAlertCellId];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, SJHeight , kDeviceWidth, kDeviceHight - SJHeight - 44);
        self.backgroundColor = [UIColor clearColor];
        
        //计算尺寸和位置
  
        _bg = [UIView new];
        _bg.backgroundColor = [UIColor colorWithWhite:0.01 alpha:0.1];
        
        
        _alertView = [UIView new];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 4.0;
        _alertView.clipsToBounds = YES;
        
        [self addSubview:_bg];
        [self addSubview:_alertView];
        [_alertView addSubview:self.tableView];
        
        [_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(_alertView.mas_top);
        }];
        
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.mas_top);
            make.height.equalTo(@(210));
        }];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_alertView);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        tap.numberOfTapsRequired = 1;
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        
    }
    return self;
}


#pragma mark - UIGestureRecognizerDelegate
//    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //    JGLog(@"%@", NSStringFromClass([touch.view class]));
    return ![NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"];
}


#pragma mark - 点击其他区域关闭
- (void)tapClick:(UITapGestureRecognizer *)tap {
    
    if( CGRectContainsPoint(_alertView.frame, [tap locationInView:self])) {
        
    }else {
        
        [self remove];
    }
}


- (void)setDataArrM:(NSArray *)DataArrM {
    _DataArrM = DataArrM;
    
    [self.tableView reloadData];
}




#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.DataArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZYDropDownBoxAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:ZYDropDownBoxAlertCellId forIndexPath:indexPath];
    
    cell.LeftLbl.hidden = self.showType == 2;
    cell.RightLbl.hidden = self.showType == 1;

    cell.LeftLbl.text = [self.DataArrM objectAtIndex:indexPath.row];
    cell.RightLbl.text = [self.DataArrM objectAtIndex:indexPath.row];

//    cell.Line.hidden = (indexPath.row == self.DataArrM.count - 1);
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.showType == 1) {

        if (self.backInfo) {

            self.backInfo([NSString stringWithFormat:@"%ld",indexPath.row]);
        }
        
    }else {
        
        if (self.backInfo) {
            self.backInfo(self.DataArrM[indexPath.row]);
        }
    }
    
    [self remove];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}






#pragma mark - 弹出
-(void)show {
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
}


/**
 移除PickerView
 */
- (void)remove
{
    [self removeFromSuperview];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
