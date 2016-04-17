//
//  CinemaFeatureModel.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/17/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ZQLBaseModel.h"

@interface CinemaFeatureModel : ZQLBaseModel

@property (nonatomic, copy) NSString * has3D;
@property (nonatomic, copy) NSString * hasIMAX;
@property (nonatomic, copy) NSString * hasVIP;
@property (nonatomic, copy) NSString * hasPark;
@property (nonatomic, copy) NSString * hasServiceTicket;
@property (nonatomic, copy) NSString * hasWifi;

@end
