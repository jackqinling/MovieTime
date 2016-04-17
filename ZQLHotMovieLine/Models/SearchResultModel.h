//
//  SearchResultModel.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/16/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ZQLBaseModel.h"
#import "SearchCinemaModel.h"
#import "SearchPersonModel.h"
#import "TotalGoodsModel.h"
#import "SearchMovieModel.h"

@protocol SearchMovieModel;
@protocol SearchCinemaModel;
@protocol SearchPersonModel;
@protocol TotalGoodsModel;


@interface SearchResultModel : ZQLBaseModel
@property (nonatomic, copy) NSString * fullMatchType;
@property (nonatomic, strong) NSArray <Optional, ConvertOnDemand, SearchMovieModel> * movies;
@property (nonatomic, copy) NSString * moviesCount;
@property (nonatomic, strong) NSArray <Optional, ConvertOnDemand, SearchCinemaModel> * cinemas;
@property (nonatomic, strong) NSString * cinemasCount;
@property (nonatomic, strong) NSArray <Optional, ConvertOnDemand, SearchCinemaModel> * locationCinemas;
@property (nonatomic, copy) NSString * locationCinemasCount;
@property (nonatomic, strong) NSArray <Optional, ConvertOnDemand, SearchPersonModel> * persons;
@property (nonatomic, copy) NSString * personsCount;
@property (nonatomic, strong) TotalGoodsModel * goods;

@end
