//
//  MovieInfoModel.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-15.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "ZQLBaseModel.h"
#import "MovieModel.h"

@protocol MovieModel;

@interface MovieInfoModel : ZQLBaseModel

@property (nonatomic, copy) NSString * totalHotMovie;

@property (nonatomic, copy) NSString * totalComingMovie;

@property (nonatomic, copy) NSString * totalCinemaCount;

@property (nonatomic, copy) NSString * count;

@property (nonatomic, assign) NSValue<Optional> *hasMovies;

@property (nonatomic, strong) NSArray <Optional, ConvertOnDemand, MovieModel> * movies;

@end
