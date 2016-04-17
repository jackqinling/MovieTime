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
    NSError * error = nil;
    NSArray * models = [SearchPersonModel arrayOfModelsFromDictionaries:object[@"persons"] error:&error];
    if (error) {
        NSLog(@"searchPerson错误======%@", error);
    }
    return @[models];
}
@end
