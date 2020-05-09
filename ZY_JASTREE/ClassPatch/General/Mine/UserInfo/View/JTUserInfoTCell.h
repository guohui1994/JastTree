//
//  JTUserInfoTCell.h
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/4.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface JTUserInfoTCell : JTBaseTableViewCell

//标题
@property (nonatomic, strong) UILabel *TitleLbl;
//信息
@property (nonatomic, strong) UILabel *InfoLbl;
//箭头
@property (nonatomic, strong) UIImageView *ArrowIcon;
@end

NS_ASSUME_NONNULL_END
