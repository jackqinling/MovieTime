//
//  adverModel.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-13.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "adverModel.h"

@implementation adverModel

+ (JSONKeyMapper *)keyMapper{
    return nil;
}

+ (NSArray *)arrayOfModelsFromJson:(id)object{
    
//    NSLog(@"%@", object[@"advList"]);
    NSArray * models = [self arrayOfModelsFromDictionaries:object[@"advList"]];
    
    return models;
}
@end
