//
//  ShortCommentModel.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 3/7/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ZQLBaseModel.h"
#import "SCommentModel.h"

@protocol SCommentModel;

@interface ShortCommentModel : ZQLBaseModel

@property (nonatomic, copy) NSString * tpc;

@property (nonatomic, copy) NSString * totalCount;

@property (nonatomic, copy) NSString * totalCommentCount;

@property (nonatomic, strong) NSArray<Optional, ConvertOnDemand, SCommentModel> * cts;

@end
