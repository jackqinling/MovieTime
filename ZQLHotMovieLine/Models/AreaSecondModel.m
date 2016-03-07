//
//  AreaSecondModel.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-13.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "AreaSecondModel.h"

@implementation AreaSecondModel

+ (JSONKeyMapper *)keyMapper{
    return nil;
}

+ (NSArray *)arrayOfModelsFromJson:(id)object{
    
    AreaSecondModel * model = [[self alloc] initWithDictionary:object[@"areaSecond"] error:nil];
    
    NSMutableArray * goods = [NSMutableArray array];
    [goods addObject:model.subFirst];
    [goods addObject:model.subSecond];
    [goods addObject:model.subThird];
    [goods addObject:model.subFifth];
    
    return goods;
}

@end
