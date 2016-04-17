//
//  SearchMovieModel.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/16/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ZQLBaseModel.h"

@interface SearchMovieModel : ZQLBaseModel

@property (nonatomic, copy) NSString * mid;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * nameEn;
@property (nonatomic, copy) NSString * movieType;
@property (nonatomic, copy) NSString * img;
//titleOhersCn arry
@property (nonatomic, strong) NSArray * titleOthersCn;
@property (nonatomic, copy) NSString * realTime;
@property (nonatomic, copy) NSString * rYear;
@property (nonatomic, copy) NSString * rMonth;
@property (nonatomic, copy) NSString * rDay;
@property (nonatomic, copy) NSString * year;
@property (nonatomic, copy) NSString * rLocation;
@property (nonatomic, copy) NSString * locationName;
@property (nonatomic, copy) NSString * rating;
@property (nonatomic, copy) NSString * releaseStatus;
@property (nonatomic, assign) BOOL isTicket;
@property (nonatomic, assign) BOOL isFilter;
//字符串数组
@property (nonatomic, strong) NSArray * directors;
@property (nonatomic, strong) NSArray * actors;

@end
