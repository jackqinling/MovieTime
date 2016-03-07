//
//  TopPosterModel.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-13.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "TopPosterModel.h"

@implementation TopPosterModel

+ (JSONKeyMapper *)keyMapper{
    return nil;
}

+ (NSArray *)arrayOfModelsFromJson:(id)object{
    
    NSArray * models = [self arrayOfModelsFromDictionaries:object[@"topPosters"]];
    
    return models;
}
@end
