//
//  MovieModel.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-13.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "ZQLBaseModel.h"
#import "NeareastModel.h"

@interface MovieModel : ZQLBaseModel

@property (nonatomic, copy) NSString * movieId;

@property (nonatomic, copy) NSString * titleCn;

@property (nonatomic, copy) NSString * titleEn;

@property (nonatomic, copy) NSString * img;

@property (nonatomic, assign) float ratingFinal;

@property (nonatomic, copy) NSString * length;

@property (nonatomic, copy) NSString * directorName;

@property (nonatomic, copy) NSString * actorName1;

@property (nonatomic, copy) NSString * actorName2;

@property (nonatomic, copy) NSString * type;

@property (nonatomic, copy) NSString * rYear;

@property (nonatomic, copy) NSString * rMonth;

@property (nonatomic, copy) NSString * rDay;

@property (nonatomic, assign) NSUInteger isNew;

@property (nonatomic, assign) NSUInteger isHot;

@property (nonatomic, copy) NSString * commonSpecial;

@property (nonatomic, copy) NSString * btnText;

@property (nonatomic, copy) NSString * wantedCount;

@property (nonatomic, assign) NSUInteger isFilter;

@property (nonatomic, assign) NSUInteger is3D;

@property (nonatomic, assign) NSUInteger isIMAX;

@property (nonatomic, assign) NSUInteger isIMAX3D;

@property (nonatomic, assign) NSUInteger isDMAX;

@property (nonatomic, strong) NeareastModel * nearestShowtime;

@end
