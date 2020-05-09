//
//  JTMessageTCell.h
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/4.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTBaseTableViewCell.h"
#import "JTMessageListModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface JTMessageTCell : JTBaseTableViewCell

@property (nonatomic, strong) JTMessageListListModel *Model;

@end

NS_ASSUME_NONNULL_END
