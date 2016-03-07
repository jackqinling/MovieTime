//
//  HotMovieDetailModel.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-13.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "ZQLBaseModel.h"

@interface PerfectMovieModel : ZQLBaseModel

@property (nonatomic, copy) NSString * movieId;

@property (nonatomic, copy) NSString * titleCn;

@property (nonatomic, copy) NSString * titleEn;

@property (nonatomic, copy) NSString * year;

@property (nonatomic, copy) NSString * desc;

@property (nonatomic, copy) NSString * image;

@end
