//
//  GH_ApprenseJTTableViewCell.h
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/7/4.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTBaseTableViewCell.h"



@interface GH_ApprenseJTTableViewCell : JTBaseTableViewCell

@property (nonatomic, copy)ReturnBackInfo black;

@property (nonatomic, copy)NSString * userEvaluation;//评价内容

@property (nonatomic, assign)BOOL isShowTextView;

@property (nonatomic, assign)BOOL isEdit;//是否可编辑

@property (nonatomic, assign)NSString * replyString;//回复的字符串;
@end

