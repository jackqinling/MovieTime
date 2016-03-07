//
//  NeareastModel.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-13.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "ZQLBaseModel.h"

@interface NeareastModel : ZQLBaseModel

@property (nonatomic, copy) NSString * nearestCinemaCount;

@property (nonatomic, copy) NSString * nearestShowtimeCount;

@property (nonatomic, copy) NSString * nearestShowDay;

@property (nonatomic, assign) BOOL isTicket;

@end
