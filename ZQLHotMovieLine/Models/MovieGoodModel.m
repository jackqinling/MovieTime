//
//  MovieGoodModel.m
//  ZQLHotMovieLine
//
//  Created by zhaoqinling on 16/2/3.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "MovieGoodModel.h"

@implementation MovieGoodModel

+ (NSArray *)arrayOfModelsFromJson:(id)object{
    
    GoodItemModel * model = [[self alloc] initWithDictionary:object error:nil];
    return @[model];
}
@end
