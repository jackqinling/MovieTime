//
//  ZQLBaseModel.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-11.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "ZQLBaseModel.h"

@implementation ZQLBaseModel

+ (NSArray *)arrayOfModelsFromJson:(id)object{
    //通过网络请求的结果直接返回models数组
    NSLog(@"%@", object);

    NSArray * models = [self arrayOfModelsFromDictionaries:object[@"advList"]];
    return models;
}


@end
