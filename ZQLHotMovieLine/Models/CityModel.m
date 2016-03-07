//
//  CityModel.m
//  ZQLHotMovieLine
//
//  Created by zhaoqinling on 16/1/28.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"cID"}];
}
+ (NSArray *)arrayOfModelsFromJson:(id)object{
    
    NSArray * models = [self arrayOfModelsFromDictionaries:object[@"p"]];
    return models;
}
@end
