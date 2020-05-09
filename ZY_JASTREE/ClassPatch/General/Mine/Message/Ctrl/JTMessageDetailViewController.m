//
//  JTMessageDetailViewController.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/4.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTMessageDetailViewController.h"

@interface JTMessageDetailViewController ()

@end

@implementation JTMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息详情";
    
    [self LoadData];
}


- (void)LoadData {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"userId"] = @([USER_ID intValue]);
    parameters[@"messageId"] = @(self.Model.ID);

    
    [ZYHttpManager HttpRequestDataWithApi:JTMessageRead Aarameters:parameters httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        
    } failure:^(NSString * _Nonnull message) {
        [JGToast showWithText:message];
    }];
    
}


- (void)configUI {
    
    UIView *TopLine = [[UIView alloc] initWithFrame:CGRectMake(0, SJHeight, kDeviceWidth, 10)];
    TopLine.backgroundColor = JGHexColor(@"#F8F8F8");
    [self.view addSubview:TopLine];
    
    
    UILabel  *TitleLbl = [UILabel new];
    TitleLbl.textColor = JG333Color;
    TitleLbl.font = JGFont(18);
    TitleLbl.text = self.Model.title;
    
    UILabel  *TimeLbl = [UILabel new];
    TimeLbl.textColor = JG999Color;
    TimeLbl.font = JGFont(11);
    TimeLbl.text = [JGCommonTools timeWithTimeIntervalString:self.Model.createTime dateFormatter:@"yyyy/MM/dd HH:mm"];

    
    
    UILabel  *DescLbl = [UILabel new];
    DescLbl.numberOfLines = 0;
    DescLbl.textColor = JGHexColor(@"#888888");
    DescLbl.font = JGFont(15);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.Model.content];
    
    //段落样式
    NSMutableParagraphStyle *myStyle = [[NSMutableParagraphStyle alloc]init];
    //行间距
    myStyle.lineSpacing = 5;
    //段落间距
    //    myStyle.paragraphSpacing = 20;
    //对齐方式
    //    myStyle.alignment = NSTextAlignmentLeft;
    //指定段落开始的缩进像素
    myStyle.firstLineHeadIndent = 20;
    //调整全部文字的缩进像素
    //    myStyle.headIndent = 20;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:myStyle range:NSMakeRange(0, attributedString.length)];
    
    DescLbl.attributedText = attributedString;
    
    
    
    [self.view addSubview:TitleLbl];
    [self.view addSubview:TimeLbl];
    [self.view addSubview:DescLbl];
    
    [TitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopLine.mas_bottom).mas_offset(39);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [TimeLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(TitleLbl.mas_bottom).mas_offset(10);
    }];
    
    [DescLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).mas_offset(38);
        make.right.equalTo(self.view.mas_right).mas_offset(-38);
        make.top.equalTo(TimeLbl.mas_bottom).mas_offset(20);
    }];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
