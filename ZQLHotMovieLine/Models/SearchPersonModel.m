//
//  SeachPersonModel.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/16/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "SearchPersonModel.h"

@implementation SearchPersonModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"pid"}];
}

+ (NSArray *)arrayOfModelsFromJson:(id)object{
    
    NSArray * models = [self arrayOfModelsFromDictionaries:object[@"persons"] error:nil];
//    NSArray * models = object[@"persons"];
//    NSMutableArray * resultArray = [NSMutableArray array];
//    for (NSDictionary * dic in models) {
//        SearchPersonModel * model = [[SearchPersonModel alloc] init];
//        [model setValuesForKeysWithDictionary:dic];
//        [resultArray addObject:model];
//    }
    return @[models];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@", key);
    if ([key isEqualToString:@"id"]) {
        key = @"pid";
        [super setValue:value forKey:key];
    }
}
@end
