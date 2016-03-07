//
//  MovieDetailModel.h
//  ZQLHotMovieLine
//
//  Created by zhaoqinling on 16/1/27.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "ZQLBaseModel.h"
#import "DirectorModel.h"
#import "MovieStyleModel.h"
#import "MovieReleaseModel.h"
#import "VideoModel.h"
#import "FestivalModel.h"
#import "AwardModel.h"
#import "ActorSimpleModel.h"
#import "MovieImageModel.h"
#import "ActorModel.h"

@protocol ActorModel;

@protocol VideoModel;

@protocol FestivalModel;

@protocol AwardModel;

@protocol ActorSimpleModel;

@protocol MovieImageModel;

@interface MovieDetailModel : ZQLBaseModel

@property (nonatomic, strong) NSString * image;

@property (nonatomic, strong) NSString * titleCn;

@property (nonatomic, strong) NSString * titleEn;

@property (nonatomic, strong) NSString * rating;

@property (nonatomic, strong) NSString * year;

@property (nonatomic, strong) NSString * content;
//电影类型数组
@property (nonatomic, strong) NSArray * type;

@property (nonatomic, strong) NSString * runTime;

@property (nonatomic, strong) NSString * url;

@property (nonatomic, strong) NSString * wapUrl;

@property (nonatomic, assign) BOOL isEggHunt;

@property (nonatomic, strong) NSString * commonSpecial;
//排名  元数据为integer
@property (nonatomic, strong) NSString * hotRanking;

@property (nonatomic, strong) NSString * weekBoxOffice;

@property (nonatomic, strong) NSString * totalBoxOffice;

@property (nonatomic, strong) NSString * weekBoxOfficeUnit;

@property (nonatomic, strong) NSString * totalBoxOfficeUnit;

@property (nonatomic, strong) DirectorModel * director;

@property (nonatomic, strong) NSArray<Optional, ConvertOnDemand, ActorModel> * actorList;

@property (nonatomic, strong) NSString<Optional> * totalWinAward;

@property (nonatomic, strong) NSString<Optional> * totalNominateAward;

@property (nonatomic, assign) BOOL isTicket;

@property (nonatomic, strong) NSString * showCinemaCount;

@property (nonatomic, strong) NSString * showtimeCount;

@property (nonatomic, assign) NSInteger showDay;

@property (nonatomic, strong) MovieStyleModel * style;

@property (nonatomic, assign) BOOL is3D;

@property (nonatomic, assign) BOOL isIMAX;

@property (nonatomic, assign) BOOL isIMAX3D;

@property (nonatomic, assign) BOOL isDMAX;

@property (nonatomic, strong) NSArray<Optional> * directors;
//只是单纯的数组 NSString
@property (nonatomic, strong) NSArray * actors;

@property (nonatomic, strong) MovieReleaseModel * movieRelease;

@property (nonatomic, strong) NSString * imageCount;
//单纯数组 NSString
@property (nonatomic, strong) NSArray * images;

@property (nonatomic, strong) NSString<Optional> * video;

@property (nonatomic, strong) NSString<Optional> * videoId;

@property (nonatomic, strong) NSString<Optional> * videoCount;

@property (nonatomic, strong) NSArray<VideoModel, ConvertOnDemand, Optional> * videos;

@property (nonatomic, strong) NSString * personCount;

@property (nonatomic, strong) NSArray<FestivalModel,ConvertOnDemand, Optional> * festivals;

@property (nonatomic, strong) NSArray<AwardModel, ConvertOnDemand, Optional> * awards;

@property (nonatomic, strong) NSArray<ActorSimpleModel, ConvertOnDemand, Optional> * actorimg;

@property (nonatomic, strong) NSArray<MovieImageModel, ConvertOnDemand, Optional> * movieimg;

@end
