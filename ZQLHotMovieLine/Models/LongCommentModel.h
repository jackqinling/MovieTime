//
//  LongCommentModel.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 3/7/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ZQLBaseModel.h"
#import "CommentDetailModel.h"

@protocol CommentDetailModel;

@interface LongCommentModel : ZQLBaseModel

@property (nonatomic, copy) NSString * totalCount;

@property (nonatomic, strong) NSArray<Optional, ConvertOnDemand, CommentDetailModel> * comments;

@end
