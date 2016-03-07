//
//  adverGotoModel.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-13.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "ZQLBaseModel.h"
#import "adverParaModel.h"
@interface adverGotoModel : ZQLBaseModel

@property (nonatomic, copy) NSString * gotoType;

@property (nonatomic, copy) NSString * url;

@property (nonatomic, copy) NSString * relatedTypeUrl;

@property (nonatomic, strong) adverParaModel * parameters;

@end
