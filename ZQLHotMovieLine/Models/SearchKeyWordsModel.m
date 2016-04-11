//
//  SearchKeyWordsModel.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/9/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "SearchKeyWordsModel.h"

@implementation SearchKeyWordsModel

+ (NSArray *)arrayOfModelsFromJson:(id)object{
    
    return @[[[SearchKeyWordsModel alloc] initWithDictionary:object error:nil]];
}

@end
