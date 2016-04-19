//
//  SearchMovieModel.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/16/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "SearchMovieModel.h"

@implementation SearchMovieModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"mid"}];
}

+ (NSArray *)arrayOfModelsFromJson:(id)object{
    
    NSError * error = nil;
    NSArray * models = [SearchMovieModel arrayOfModelsFromDictionaries:object[@"movies"]];
    if (error) {
        NSLog(@"movieModel错误=======%@", error);
    }
    return models;
}
@end
