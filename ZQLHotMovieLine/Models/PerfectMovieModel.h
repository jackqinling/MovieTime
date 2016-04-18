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

@property (nonatomic, copy) NSString <Optional>* titleCn;

@property (nonatomic, copy) NSString <Optional>* titleEn;

@property (nonatomic, copy) NSString <Optional>* year;

@property (nonatomic, copy) NSString <Optional>* desc;

@property (nonatomic, copy) NSString <Optional>* image;

@end
