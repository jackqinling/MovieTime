//
//  SearchHintModel.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/19/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "SearchHintModel.h"

@implementation SearchHintModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"hid"}];
}

+ (NSArray *)arrayOfModelsFromJson:(id)object{
    NSError * error = nil;
    NSArray * models = [self arrayOfModelsFromDictionaries:object[@"suggestions"] error:&error];
    if (error) {
        NSLog(@"SearchHintModel请求错误=======%@", error);
    }
    return models;
}
@end
