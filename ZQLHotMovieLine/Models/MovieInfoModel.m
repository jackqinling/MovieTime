//
//  MovieInfoModel.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-15.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "MovieInfoModel.h"

@implementation MovieInfoModel

+ (JSONKeyMapper *)keyMapper{
    
//    return [[JSONKeyMapper alloc] initWithDictionary:@{}];
    return nil;
}

+ (NSArray *)arrayOfModelsFromJson:(id)object{
    
    MovieInfoModel * model = [[MovieInfoModel alloc] initWithDictionary:object error:nil];
    return @[model];
}

- (void)setMovies:(NSArray<Optional,ConvertOnDemand,MovieModel> *)movies{
    _hasMovies = @(1);
    _movies = movies;
}

@end
