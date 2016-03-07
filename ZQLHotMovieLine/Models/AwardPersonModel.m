//
//  AwardPersonModel.m
//  ZQLHotMovieLine
//
//  Created by zhaoqinling on 16/1/31.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "AwardPersonModel.h"

@implementation AwardPersonModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"aid"}];
}
@end
