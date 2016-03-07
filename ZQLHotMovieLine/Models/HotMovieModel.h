//
//  hotMovieModel.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-13.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "ZQLBaseModel.h"
#import "PerfectMovieModel.h"

@interface HotMovieModel : ZQLBaseModel

@property (nonatomic, copy) NSString * newsId;

@property (nonatomic, copy) NSString * topCover;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, strong) PerfectMovieModel<Optional> * movie;

@end
