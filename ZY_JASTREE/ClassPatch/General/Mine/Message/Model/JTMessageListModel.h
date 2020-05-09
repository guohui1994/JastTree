//
//  JTMessageListModel.h
//  ZY_JASTREE
//
//  Created by indulgeIn on 2019/07/11.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface JTMessageListListModel : NSObject
//消息ID
@property (nonatomic, assign) NSInteger ID;
//发布时间
@property (nonatomic, assign) NSInteger createTime;
//消息标题
@property (nonatomic, copy) NSString *title;
//是否已读
@property (nonatomic, assign) BOOL read;
//消息内容
@property (nonatomic, copy) NSString *content;

@end


@interface JTMessageListModel : NSObject

@property (nonatomic, assign) NSInteger startRow;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) NSInteger pages;

@property (nonatomic, assign) NSInteger navigateLastPage;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger navigateFirstPage;

@property (nonatomic, assign) NSInteger endRow;

@property (nonatomic, assign) BOOL hasPreviousPage;

@property (nonatomic, assign) NSInteger prePage;

@property (nonatomic, assign) NSInteger lastPage;

@property (nonatomic, assign) NSInteger firstPage;

@property (nonatomic, assign) BOOL isFirstPage;

@property (nonatomic, assign) NSInteger size;

@property (nonatomic, assign) NSInteger navigatePages;

@property (nonatomic, strong) NSArray<JTMessageListListModel *> *list;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, assign) BOOL isLastPage;

@property (nonatomic, assign) NSInteger nextPage;

@property (nonatomic, assign) BOOL hasNextPage;

@property (nonatomic, strong) NSArray *navigatepageNums;

@end


NS_ASSUME_NONNULL_END
