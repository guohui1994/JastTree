//
//  GHShowDetailsModelModel.h
//  ZY_JASTREE
//
//  Created by indulgeIn on 2019/07/09.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface GHShowDetailsAddedFourModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *value;

@end


@interface GHShowDetailsAddedTwoModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *value;

@end


@interface GHShowDetailsAddedThreeModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *value;

@end


@interface GHShowDetailsConstructListModel : NSObject

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, copy) NSMutableArray<NSString *> *construct;

@property (nonatomic, assign) NSInteger orderConstructId;

@property (nonatomic, assign) NSInteger day;

@end


@interface GHShowDetailsAddedOneModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *value;

@end


@interface GHShowDetailsModelModel : NSObject

@property (nonatomic, assign) NSInteger parentState;

@property (nonatomic, strong) GHShowDetailsAddedFourModel *addedFour;

@property (nonatomic, assign) NSInteger exhibitionArea;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *constructionDrawingTime;

@property (nonatomic, copy) NSString *otherRequirements;

@property (nonatomic, copy) NSString *surfacePlot;

@property (nonatomic, copy) NSArray<NSString *> *constructionDrawing;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, assign) NSInteger exhibitionId;

@property (nonatomic, strong) GHShowDetailsAddedTwoModel *addedTwo;

@property (nonatomic, assign) NSInteger childState;

@property (nonatomic, copy) NSString *stylist;

@property (nonatomic, copy) NSString *exhibitionSite;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger order_id;

@property (nonatomic, strong) GHShowDetailsAddedThreeModel *addedThree;

@property (nonatomic, assign) NSInteger lastFinshTime;

@property (nonatomic, copy) NSArray<GHShowDetailsConstructListModel *> *constructList;

@property (nonatomic, copy) NSString *customerPhone;

@property (nonatomic, assign) NSInteger pushTime;

@property (nonatomic, assign)NSInteger scatteredShowTime;

@property (nonatomic, copy) NSArray<NSString *> *entryInformation;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *boothNumber;

@property (nonatomic, copy) NSArray<NSString *> *exhibitionRendering;

@property (nonatomic, assign) double quote;

@property (nonatomic, strong) GHShowDetailsAddedOneModel *addedOne;

@property (nonatomic, assign) NSInteger quoteTime;

@property (nonatomic, copy) NSString *customerName;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSArray<NSString *> *materialProduction;

@property (nonatomic, copy)NSString * userEvaluation;

@property (nonatomic, copy)NSString * evaluationBackground;

@property (nonatomic, assign) NSInteger paymentState;

@property (nonatomic, copy)NSString * scattered;

@property (nonatomic, copy)NSString * arrangement;

@property (nonatomic, copy)NSString * plusReason;

@property (nonatomic, assign)double plusPrice;

@property (nonatomic, copy)NSString * subtractReason;

@property (nonatomic, assign)double subtractPrice;

@property (nonatomic, assign)double firstPrice;

@property (nonatomic, assign)double lastPrice;


@end


NS_ASSUME_NONNULL_END
