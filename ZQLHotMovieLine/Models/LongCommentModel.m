//
//  LongCommentModel.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 3/7/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "LongCommentModel.h"

@implementation LongCommentModel

+ (NSArray *)arrayOfModelsFromJson:(id)object{
    
    LongCommentModel * model = [[self alloc] initWithDictionary:object error:nil];
    return @[model];
}
@end
