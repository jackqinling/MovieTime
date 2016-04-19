//
//  SeachCinemaModel.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/16/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "SearchCinemaModel.h"

@implementation SearchCinemaModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"cid"}];
}

+ (NSArray *)arrayOfModelsFromJson:(id)object{
   
    NSArray * models = [self arrayOfModelsFromDictionaries:object[@"locationCinemas"] error:nil];
//    NSArray * models = object[@"locationCinemas"];
//    NSMutableArray * resultArray = [NSMutableArray array];
//    for (NSDictionary * dic in models) {
//        SearchCinemaModel * model = [[SearchCinemaModel alloc] init];
//        [model setValuesForKeysWithDictionary:dic];
//        [resultArray addObject:model];
//    }
//    if (error) {
//        NSLog(@"cinemaModel错误=====%@", error);
//    }
    return models;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    NSLog(@"%@", key);
//    if ([key isEqualToString:@"id"]) {
//        key = @"cid";
//    }
//    [super setValue:value forKey:key];
}
@end
