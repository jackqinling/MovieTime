//
//  ActorSimpleModel.m
//  ZQLHotMovieLine
//
//  Created by zhaoqinling on 16/1/31.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "ActorSimpleModel.h"

@implementation ActorSimpleModel

+ (JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"aid"}];
}
@end
