//
//  ShortCommentModel.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 3/7/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ShortCommentModel.h"

@implementation ShortCommentModel

+ (NSArray *)arrayOfModelsFromJson:(id)object{
    
    ShortCommentModel * model = [[self alloc] initWithDictionary:object error:nil];
    return @[model];
}
@end
