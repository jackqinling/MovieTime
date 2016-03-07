//
//  MovieDetailModel.m
//  ZQLHotMovieLine
//
//  Created by zhaoqinling on 16/1/27.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "MovieDetailModel.h"

@implementation MovieDetailModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"release":@"movieRelease"}];
}

+ (NSArray *)arrayOfModelsFromJson:(id)object{
    
    MovieDetailModel * model = [[self alloc] initWithDictionary:object error:nil];
    return @[model];
}

@end
