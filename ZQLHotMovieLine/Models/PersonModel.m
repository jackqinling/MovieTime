//
//  PersonModel.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/17/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"pid"}];
}
@end
