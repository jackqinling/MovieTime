//
//  hotPointModel.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-13.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "hotPointModel.h"

@implementation hotPointModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"hid"}];
}

+ (NSArray *)arrayOfModelsFromJson:(id)object{
    
    NSArray * models = [self arrayOfModelsFromDictionaries:object[@"hotPoints"]];
    return models;
}

- (void)setImages:(NSArray<Optional,ConvertOnDemand,ImageModel> *)images{
    
    _images = images;
    
    _hasThreeImages = @(1);
}
@end
