//
//  VideoListModel.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 3/19/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "VideoListModel.h"

@implementation VideoListModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"vid"}];
}

+ (NSArray *)arrayOfModelsFromJson:(id)object{
    
    NSArray * models = [VideoListModel arrayOfModelsFromDictionaries:object[@"videoList"]];
    return @[models];
}
@end
