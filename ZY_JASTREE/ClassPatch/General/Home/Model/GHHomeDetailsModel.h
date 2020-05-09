//
//  GHHomeDetailsModel.h
//  ZY_JASTREE
//
//  Created by indulgeIn on 2019/07/11.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface GHHomeDetailsAddedFourModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *value;

@end


@interface GHHomeDetailsAddedTwoModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *value;

@end


@interface GHHomeDetailsAddedThreeModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *value;

@end


@interface GHHomeDetailsAddedOneModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *value;

@end


@interface GHHomeDetailsModel : NSObject

@property (nonatomic, strong) GHHomeDetailsAddedFourModel *addedFour;

@property (nonatomic, copy) NSString *surface_plot;

@property (nonatomic, assign) NSInteger exhibitionArea;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *constructionDrawingTime;

@property (nonatomic, copy) NSString *otherRequirements;

@property (nonatomic, assign) NSInteger updateTime;

@property (nonatomic, copy) NSArray<NSString *> *constructionDrawing;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, strong) GHHomeDetailsAddedTwoModel *addedTwo;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *stylist;

@property (nonatomic, copy) NSString *exhibitionSite;

@property (nonatomic, assign) NSInteger order_id;

@property (nonatomic, strong) GHHomeDetailsAddedThreeModel *addedThree;

@property (nonatomic, assign) NSInteger moveInTime;

@property (nonatomic, copy) NSString *customerPhone;

@property (nonatomic, copy) NSArray<NSString *> *entryInformation;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *boothNumber;

@property (nonatomic, copy) NSArray<NSString *> *exhibitionRendering;

@property (nonatomic, strong) GHHomeDetailsAddedOneModel *addedOne;

@property (nonatomic, assign) NSInteger createTime;

@property (nonatomic, copy) NSString *customerName;

@property (nonatomic, assign) NSInteger scatteredShowTime;

@property (nonatomic, assign)NSInteger state;

@property (nonatomic, assign) double quote;

@property (nonatomic, copy)NSString * scattered;

@property (nonatomic, copy)NSString * arrangement;
@end


NS_ASSUME_NONNULL_END
