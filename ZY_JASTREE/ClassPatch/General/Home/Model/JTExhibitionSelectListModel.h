//
//  JTExhibitionSelectListModel.h
//  ZY_JASTREE
//
//  Created by indulgeIn on 2019/07/08.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface JTExhibitionSelectListList1Model : NSObject
//展会ID
@property (nonatomic, assign) NSInteger ID;
//展会面积
@property (nonatomic, assign) NSInteger exhibitionArea;
//散展时间
@property (nonatomic, assign) NSInteger scatteredShowTime;
//展位号
@property (nonatomic, copy) NSString *boothNumber;
//省
@property (nonatomic, copy) NSString *province;
//区
@property (nonatomic, copy) NSString *area;
//展会详细地址
@property (nonatomic, copy) NSString *exhibitionSite;
//展会创建时间
@property (nonatomic, assign) NSInteger createTime;
//其他要求
@property (nonatomic, copy) NSString *otherRequirements;
//市
@property (nonatomic, copy) NSString *city;
//布展时间
@property (nonatomic, assign) NSInteger moveInTime;
//展会封面
@property (nonatomic, copy) NSString *surfacePlot;
//展会名称
@property (nonatomic, copy) NSString *name;
//公司名称
@property (nonatomic, copy) NSString *companyName;

@end


@interface JTExhibitionSelectListModel : NSObject

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

@property (nonatomic, strong) NSMutableArray<JTExhibitionSelectListList1Model *> *list;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, assign) BOOL isLastPage;

@property (nonatomic, assign) NSInteger nextPage;

@property (nonatomic, assign) BOOL hasNextPage;

@property (nonatomic, strong) NSArray *navigatepageNums;

@end


NS_ASSUME_NONNULL_END
