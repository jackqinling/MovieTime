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
    NSError * error = nil;
    NSArray * models = [SearchCinemaModel arrayOfModelsFromDictionaries:object[@"cinemas"] error:&error];
    if (error) {
        NSLog(@"cinemaModel错误=====%@", error);
    }
    return @[models];
}
@end
