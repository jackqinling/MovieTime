//
//  SeachCinemaModel.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/16/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ZQLBaseModel.h"

@interface SearchCinemaModel : ZQLBaseModel

@property (nonatomic, copy) NSString * cid;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSString * cityId;
@property (nonatomic, copy) NSString * latitude;
@property (nonatomic, copy) NSString * baiduLatitude;
@property (nonatomic, copy) NSString * baiduLongitude;
@property (nonatomic, strong) NSArray * feature;
@property (nonatomic, copy) NSString * loveDeep;

@end
