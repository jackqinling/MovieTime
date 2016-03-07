//
//  hotMovieModel.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-13.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "HotMovieModel.h"

@implementation HotMovieModel

+ (JSONKeyMapper *)keyMapper{
    return nil;
//    return [[JSONKeyMapper alloc] initWithDictionary:@{}];
}
+ (NSArray *)arrayOfModelsFromJson:(id)object{
    NSError * error = nil;
    HotMovieModel * model = [[self alloc] initWithDictionary:object[@"hotMovie"] error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    return @[model];
}
@end
