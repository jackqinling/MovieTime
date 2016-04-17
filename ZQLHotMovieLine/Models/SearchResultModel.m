//
//  SearchResultModel.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/16/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "SearchResultModel.h"

@implementation SearchResultModel

+ (NSArray *)arrayOfModelsFromJson:(id)object{
    NSError * error = nil;
    SearchResultModel * model = [[self alloc] initWithDictionary:object error:&error];
    if (error) {
        NSLog(@"result错误========%@", error);
    }
    
    return @[model];
}

@end
